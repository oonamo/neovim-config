-- TODO: Handle depends

---@param target table
---@param spec MiniDeps.Package
local function expand_source(target, spec)
  if type(spec) == "string" then
    local field = string.find(spec, '/') ~= nil and 'source' or 'name'
    spec = { [field] = spec }
  end

  spec = vim.deepcopy(spec)

  if spec.source and type(spec.source) ~= 'string' then H.error('`source` in plugin spec should be string.') end
  local is_user_repo = type(spec.source) == 'string' and spec.source:find('^[%w-]+/[%w-_.]+$') ~= nil
  if is_user_repo then spec.source = 'https://github.com/' .. spec.source end

  spec.name = spec.name or vim.fn.fnamemodify(spec.source, ':t')
  if type(spec.name) ~= 'string' then H.error('`name` in plugin spec should be string.') end
  if string.find(spec.name, '/') ~= nil then H.error('`name` in plugin spec should not contain "/".') end
  if spec.name == '' then error('`name` in plugin spec should not be empty.') end

  if spec.checkout and type(spec.checkout) ~= 'string' then H.error('`checkout` in plugin spec should be string.') end
  if spec.monitor and type(spec.monitor) ~= 'string' then H.error('`monitor` in plugin spec should be string.') end

  spec.hooks = vim.deepcopy(spec.hooks) or {}
  if type(spec.hooks) ~= 'table' then H.error('`hooks` in plugin spec should be table.') end
  local hook_names = { 'pre_install', 'post_install', 'pre_checkout', 'post_checkout' }
  for _, hook_name in ipairs(hook_names) do
    local is_not_hook = spec.hooks[hook_name] and not vim.is_callable(spec.hooks[hook_name])
    if is_not_hook then error('`hooks.' .. hook_name .. '` in plugin spec should be callable.') end
  end

  -- Expand dependencies recursively before adding current spec to target
  spec.depends = vim.deepcopy(spec.depends) or {}
  for _, dep_spec in ipairs(spec.depends) do
    expand_source(target, dep_spec)
  end

  table.insert(target, spec)
end

local function full_path(path)
  return (vim.fn.fnamemodify(path, ':p'):gsub('\\', '/'):gsub('/+', '/'):gsub('(.)/$', '%1'))
end

local function get_plugin_path(name)
  local package_path = full_path()
end

---@param pkg string
local function get_name(pkg)
  local name = pkg:sub(-4) == ".git" and pkg:sub(1, -5) or pkg
  name = name:sub(-1) == "/" and name:sub(1, -2) or name
  local slash = name:reverse():find("/", 1, true) --[[@as number?]]
  return slash and name:sub(#name - slash + 2) or pkg:gsub("%W+", "_")
end

---@param name string
---@return string
local function normname(name)
  local ret = name:lower():gsub("^n?vim%-", ""):gsub("%.n?vim$", ""):gsub("[%.%-]lua", ""):gsub("[^a-z]+", "")
  return ret
end

local function normname_alt(name)
  local ret = name:gsub("^n?vim%", "")
end

---@class Package
local Package = {}
Package.group = vim.api.nvim_create_augroup("package_loader", { clear = true })
Package.path = vim.fn.stdpath("data") .. "/use-package/"

function Package.get_plugin_path(plugin)
  local pack_path = full_path(Package.path)
  local path = string.format("%s/%s", pack_path, plugin.name)
  return path, vim.loop.fs_stat(path) ~= nil
end

---@param plugin MiniDeps.Package
function Package.add_package(plugin)
  local spec = {}
  local plugs = {}
  expand_source(plugs, plugin)

  local install_needed = {}
  for i, p in ipairs(plugs) do
    local path, exists = Package.get_plugin_path(plugin)
    p.path = path
    if not exists then
      table.insert(install_needed, vim.deepcopy(p))
    end
  end

  if #install_needed > 0 then
    for _, v in ipairs(install_needed) do
      Package.install(v)
    end
  end
end

local threads = 8

function Package.install(plugin)
  local on_exit = function(obj)
    print(obj.code)
    print(obj.signal)
    print(obj.stdout)
    print(obj.stderr)
  end
  vim.system({ "git", "-c", "gc.auto=0", "clone", "--quiet", "--filter=blob:none", "--recurse-submodules"
  , "--also-filter-submodules", "--origin", "origin", plugin.source, plugin.path
  }, {text = true}, on_exit)
end

---@class MiniDeps.Manager
---@field keys MiniDeps.KeySpec[]
---@field events MiniDeps.Autocommands[]
local Manager = {}

function Manager.new()
  local data = { keys = {}, events = {}, cmd = {} }
  setmetatable(data, { __index = Manager })
  return data
end

---@param plugin MiniDeps.Package
---@param events MiniDeps.Autocommands|MiniDeps.Autocommands[]
function Manager:add_events(plugin, events)
  local id
  if vim.isarray(events) then
    for _, event in ipairs(events) do
      id = Package.add_event_handler(plugin, event)
      table.insert(self.events, id)
    end
  else
    id = Package.add_event_handler(plugin, events)
    table.insert(self.events, id)
  end
end

---@param plugin MiniDeps.Package
---@param keys MiniDeps.KeySpec|MiniDeps.KeySpec[]
function Manager:add_keys(plugin, keys)
  local lhs
  if vim.isarray(keys) then
    for _, key in ipairs(keys) do
      vim.keymap.set(key.mode, key.lhs, function()
        vim.keymap.del(key.mode, key.lhs)
        Package.load_package(plugin)
        vim.keymap.set(key.mode, key.lhs, key.rhs, key.opts)
        vim.api.nvim_input(key.lhs)
      end, key.opts)
      table.insert(self.keys, key)
    end
  else
    vim.keymap.set(keys.mode, keys.lhs, function()
      vim.keymap.del(keys.mode, keys.lhs)
      Package.load_package(plugin)

      vim.keymap.set(keys.mode, keys.lhs, keys.rhs, keys.opts)
      vim.api.nvim_input(keys.lhs)
    end, keys.opts)
    table.insert(self.events, keys)
  end
end

function Manager:clear(plugin)
  for _, v in self.events do
    vim.api.nvim_del_autocmd(v)
  end
  for _, v in self.keys do
    pcall(vim.keymap.del, v.lhs)
    vim.keymap.set(v.mode, v.lhs, v.rhs, v.opts)
  end
end

---@param plugin MiniDeps.Package
---@return string|nil
function Package.get_main(plugin)
  if plugin.main then
    return plugin.main
  end
  if plugin.name ~= "mini.nvim" and plugin.name:match("^mini%..*$") then
    return plugin.name
  end
  if Package.try_main(plugin.name) then
    return plugin.name
  end
  local name = plugin.name:gsub("^n?vim$", "")
  if Package.try_main(name) then
    return name
  end
  name = name:gsub("%.n?vim$", "")
  if Package.try_main(name) then
    return name
  end
  name = name:gsub("[%.%-]lua", "")
  if Package.try_main(name) then
    return name
  end
  return nil
end

function Package.try_main(name)
  local ok, _ = pcall(name)
  return ok
end

---@param plugin MiniDeps.Package
---@param event MiniDeps.Autocommands
---@return number
function Package.add_event_handler(plugin, event)
  local done = false
  if type(event) == "string" then
    local tmp = {}
    tmp.event = event
    event = tmp
  end
  return vim.api.nvim_create_autocmd(event.event, {
    group = Package.group,
    once = true,
    pattern = event.pattern,
    callback = function(ev)
      if done then
        return
      end

      done = true
      plugin:load()
    end
  })
end

---@param plugin MiniDeps.Package
function Package.load_package(plugin)
  if plugin.loaded then
    return
  end
  local path, exists = Package.get_plugin_path(plugin)
  if exists then
    vim.opt.rtp:append(path)
    plugin:handle(plugin.opts)
    plugin.loaded = true
  end
end

---@class MiniDeps.Autocommands
---@field event string
---@field group? string
---@field exclude? string[]
---@field data? any
---@field buffer? number
---@field pattern? string|string[]

---@class MiniDeps.KeySpec
---@field mode string|string[]
---@field lhs string
---@field rhs string|fun()
---@field opts table

---@class MiniDeps.Hooks
---@field post_install? fun(path: string, source: string, name: string)
---@field pre_install? fun(path: string, source: string, name: string)

---@class MiniDeps.PluginSpec
---@field hooks? MiniDeps.Hooks
---@field source? string
---@field name? string
---@field checkout? string
---@field monitor? string
---@field depends? string

---@class MiniDeps.Package : MiniDeps.PluginSpec
---@field add_hooks? MiniDeps.Hooks
---@field plugin_name? string
---@field main? string
---@field opts? table
---@field loaded boolean
---@field manager MiniDeps.Manager

---@class MiniDeps.Package
local M = {}

M.default_handle = function(self, opts)
  self.manager:clear(self)
  local main = Package.get_main(self)
  if not main then
    vim.notify("Could not resolve '" .. self.source .. "''s require path. Please specifiy it with main!",
      vim.log.levels.ERROR)
    return
  end
  local plug_ok, plugin = pcall(require, main)
  if not plug_ok then
    -- vim.notify("Error loading plugin '" .. self.name .. "':\n" .. vim.inspect(plugin), vim.log.levels.ERROR)
    return
  end
  plugin.setup(opts)
end

---@param source string
---@param handle? fun(self: MiniDeps.Package, opts: table)
function M.use_package(source, handle)
  assert(source, "Source should be set")
  handle = handle or function(self, opts)
    M.default_handle(self, opts)
  end

  local package = {}
  package.source = source
  local name
  local count = 0
  for str in string.gmatch(package.source, "([^/]+)") do
    if count == 1 then
      name = str
      break
    end
    count = count + 1
  end
  if name then
    package.name = name
  end
  package.loaded = false
  package.manager = Manager.new()
  package.handle = handle

  setmetatable(package, {
    __index = M
  })

  return package
end

function M:main(main)
  self.main = main
  return self
end

---@param hooks MiniDeps.Hooks
function M:add_hooks(hooks)
  self.hooks = hooks
  return self
end

function M:config(handle)
  self.handle = handle
  return self
end

function M:opts(opts)
  self.opts = opts
  return self
end

---@param events MiniDeps.Autocommands[]
function M:events(events)
  self.manager:add_events(self, events)
  return self
end

---@param keys MiniDeps.KeySpec[]
function M:keys(keys)
  self.manager:add_keys(self, keys)
  return self
end

function M:load()
  Package.add_package(self)
  Package.load_package(self)
  self.loaded = true
end

return M
