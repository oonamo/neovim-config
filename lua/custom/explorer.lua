local M = {
  _cache = {},
  ids = {
    perm = vim.api.nvim_create_namespace("FS_stat"),
    size = vim.api.nvim_create_namespace("FS_size"),
    date = vim.api.nvim_create_namespace("FS_date"),
  },
  mappings = {},
}

--- Deletes whole query if non empty
--- If query is empty, go up a level
---
--- Mimics Emac's vertico behavior
---@param char string
M.mappings.go_up_level = function(char)
  return {
    char = char,
    func = function()
      local query = MiniPick.get_picker_query()
      if not query[1] or query[1] == "" then
        vim.schedule(function() vim.api.nvim_input("<CR>") end)
      else
        MiniPick.set_picker_query({ "" })
      end
    end,
  }
end

---Calls the directory_fn on a path
---@param char string
---@param directory_fn fun(path: string)
M.mappings.explorer = function(char, directory_fn)
  return {
    char = char,
    func = function()
      local current = MiniPick.get_picker_matches().current
      if not current or current == "" then
        vim.notify("No file or Directory is selected")
        return
      end
      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniPickStop",
        once = true,
        callback = vim.schedule_wrap(function()
          local ok, _ = pcall(directory_fn, current.path)
          if not ok then vim.notify(string.format("Could not use directory_fn on path '%s'", current.path)) end
        end),
      })

      return true
    end,
  }
end

---If the current match is a directory, that item is selected
---Otherwise, the item is completed
---
---This ehavior mimics Emac's `vertico.el`
---@param char string
M.mappings.complete_or_enter = function(char)
  return {
    char = char,
    func = function()
      local matches = MiniPick.get_picker_matches()
      if not matches then return end
      local current = matches.current or matches.all[1]

      if current.fs_type == "directory" then
        MiniPick.get_picker_opts().source.choose(current)
      else
        MiniPick.set_picker_query(vim.split(current.text or "", ""))
      end
    end,
  }
end

M.mappings.create_file = function(char)
  return {
    char = char,
    func = function()
      local query = MiniPick.get_picker_query()
      if not query or #query < 1 then return end
      query = table.concat(query, "")
      local cwd = MiniPick.get_picker_opts().source.cwd
      local file = cwd .. "/" .. query
      file = file:gsub("\\", "/")

      vim.schedule(function() vim.cmd.edit(file) end)
      return true
    end,
  }
end

local PERM_SIZE = 10

local hi = function(...) vim.api.nvim_set_hl(0, ...) end
hi("ReadBit", { link = "MiniIconsYellow", default = true })
hi("ExeBit", { link = "MiniIconsRed", default = true })
hi("WriteBit", { link = "MiniIconsAzure", default = true })
hi("SepBit", { link = "NonText", default = true })
hi("MiniPickExplorerSize", { link = "Constant", default = true })
hi("MiniPickExplorerDate", { link = "Character", default = true })
hi("MiniPickExplorerDirectory", { link = "MiniPickExplorerDate", default = true })

local defaults = {
  show_icons = true,
  ivy = {
    enable = true,
  },
  items = {
    { width = 0.2 }, -- 20% is dedicated to file names
    { width = PERM_SIZE + 1 }, -- Length of permssion string is 9
    { width = 7 }, -- 7 is dedicated to size
    { width = 10, remaining = true },
  },
  order = {
    "text",
    "permissions",
    "size",
    "time",
  },
  time = {
    max_hours = 24,
    max_secs = 60,
    max_mins = 60,
    max_days = 30,
  },
  prompt_prefix = function(cwd)
    cwd = cwd:gsub("\\", "/")
    cwd = cwd:gsub("^" .. vim.fn.expand("~"):gsub("\\", "/"), "~")
    return "Find Files: " .. cwd .. "/"
  end,
}

-- Taken from mini.extra
-- https://github.com/echasnovski/mini.nvim/blob/2011aff270bcd3e1f3ad088253ace2d574967bed/lua/mini/extra.lua#L1965-L1975
M.explorer_make_items = function(path, filter, sort)
  if vim.fn.isdirectory(path) == 0 then return {} end
  local res = { { fs_type = "directory", path = vim.fn.fnamemodify(path, ":h"), text = ".." } }
  for _, basename in ipairs(vim.fn.readdir(path)) do
    local subpath = string.format("%s/%s", path, basename)
    local fs_type = vim.fn.isdirectory(subpath) == 1 and "directory" or "file"
    table.insert(res, { fs_type = fs_type, path = subpath, text = basename .. (fs_type == "directory" and "/" or "") })
  end

  return sort(vim.tbl_filter(filter, res))
end

-- Taken from mini.extra
-- https://github.com/echasnovski/mini.nvim/blob/2011aff270bcd3e1f3ad088253ace2d574967bed/lua/mini/extra.lua#L1977-L1985
M.explorer_default_sort = function(items)
  -- Sort ignoring case
  local res = vim.tbl_map(function(x)
      --stylua: ignore
      return {
        fs_type = x.fs_type, path = x.path, text = x.text,
        is_dir = x.fs_type == 'directory', lower_name = x.text:lower(),
      }
  end, items)

  local compare = function(a, b)
    -- Put directory first
    if a.is_dir and not b.is_dir then return true end
    if not a.is_dir and b.is_dir then return false end

    -- Otherwise order alphabetically ignoring case
    return a.lower_name < b.lower_name
  end

  table.sort(res, compare)

  return vim.tbl_map(function(x) return { fs_type = x.fs_type, path = x.path, text = x.text } end, res)
end

function M._compile_widths(opts)
  if not opts then error("opts cannot be non nil to compile width") end

  local width = 0
  if opts.ivy then
    width = vim.o.columns
  else
    width = MiniPick.config.window.width or math.floor(vim.o.columns * 0.618)
  end

  local total = 0
  local compiled_width = {}

  for i, v in ipairs(opts.items) do
    if v.width < 1 then
      local result = math.floor(v.width * width)
      total = total + result
      compiled_width[i] = result
    else
      local result = math.floor(v.width)
      total = total + result
      compiled_width[i] = result
    end
  end

  if opts.items[#opts.items].remaining then compiled_width[#compiled_width] = (width or vim.o.columns) - total end
  return compiled_width
end

function M.setup(opts)
  M.opts = vim.tbl_deep_extend("force", defaults, opts or {})
  M._seperator = package.config:sub(1, 1)
  for i, v in ipairs(M.opts.order) do
    if v == "text" then
      M.text_place = i
      break
    end
  end
  if M.text_place == nil then error("text must be an item") end

  M._cache.compiled_width = M._compile_widths(M.opts)
  vim.api.nvim_create_autocmd("VimResized", {
    callback = function() M._cache.compiled_width = M._compile_widths(M.opts) end,
  })
end

---@param exe_modifier false|string
---@param num integer
local function perm_to_table_str(exe_modifier, num, tbl)
  table.insert(tbl, (bit.band(num, 0x4) ~= 0 and { "r", "ReadBit" } or { "-", "SepBit" }))
  table.insert(tbl, (bit.band(num, 0x2) ~= 0 and { "w", "WriteBit" } or { "-", "SepBit" }))
  if exe_modifier then
    if bit.band(num, 0x1) ~= 0 then
      table.insert(tbl, { exe_modifier, "ExeBit" })
    else
      table.insert(tbl, { exe_modifier:upper(), "ExeBit" })
    end
  else
    table.insert(tbl, (bit.band(num, 0x1) ~= 0 and { "x", "ExeBit" } or { "-", "SepBit" }))
  end
end

---@return table[]
function M.permssion_tuple_array(mode)
  local extra = bit.rshift(mode, 9)
  local tbl = {}
  perm_to_table_str(bit.band(extra, 4) ~= 0 and "s", bit.rshift(mode, 6), tbl)
  perm_to_table_str(bit.band(extra, 2) ~= 0 and "s", bit.rshift(mode, 3), tbl)
  perm_to_table_str(bit.band(extra, 1) ~= 0 and "t", mode, tbl)
  return tbl
end

local current_year
function M.time_str(time)
  vim.schedule(function() current_year = vim.fn.strftime("%y") end)
  local ret
  local year = vim.fn.strftime("%y", time.sec)
  local diff_secs = os.difftime(os.time(), time.sec)

  local diff_mins = diff_secs / 60
  local diff_hours = diff_mins / 60
  local diff_days = diff_hours / 24

  local add_named_time = function(name, value)
    local val = math.floor(value + 0.5)
    ret = val .. " " .. name .. (val ~= 1 and "s" or "") .. " ago"
  end

  if diff_secs <= M.opts.time.max_secs then
    add_named_time("second", diff_secs)
  elseif diff_mins <= M.opts.time.max_secs then
    add_named_time("minute", diff_secs)
  elseif diff_hours <= M.opts.time.max_hours then
    add_named_time("hour", diff_secs)
  elseif diff_days <= M.opts.time.max_days then
    add_named_time("day", diff_secs)
  elseif year ~= current_year then
    ret = vim.fn.strftime("%b %d %y", time.sec)
  else
    ret = vim.fn.strftime("%b %d %H:%M", time.sec)
  end

  return ret
end

function M.size_str(size)
  if size == 0 then return "" end
  if size >= 1e9 then
    return string.format("%.1fG", size / 1e9)
  elseif size >= 1e6 then
    return string.format("%.1fM", size / 1e6)
  elseif size >= 1e3 then
    return string.format("%.1fk", size / 1e3)
  else
    return string.format("%d", size)
  end
end

function M.permissions(buf_id, items, query, stat, pos, line, i)
  if stat and stat.mode then
    local tbl = M.permssion_tuple_array(stat.mode)
    if items and items[line] then
      table.insert(
        tbl,
        1,
        vim.fn.isdirectory(items[line].path) == 1 and { "d", "MiniPickExplorerDirectory" } or { "-", "SepBit" }
      )
    end
    if i < M.text_place then table.insert(tbl, { string.rep(" ", M._cache.compiled_width[i] - PERM_SIZE), "None" }) end
    vim.api.nvim_buf_set_extmark(buf_id, M.ids.perm, line - 1, 0, {
      virt_text = tbl,
      virt_text_win_col = i > M.text_place and 1 and pos or nil,
      virt_text_pos = i <= M.text_place and "inline" or nil,
      hl_mode = "combine",
    })
  end
end

function M.size(buf_id, items, query, stat, pos, line, i)
  if stat and stat.size then
    local tbl = { { M.size_str(stat.size), "MiniPickExplorerSize" } }
    if i < M.text_place then table.insert(tbl, { string.rep(" ", M._cache.compiled_width[i] - #tbl[1][1]), "None" }) end

    vim.api.nvim_buf_set_extmark(buf_id, M.ids.size, line - 1, 0, {
      virt_text = tbl,
      virt_text_win_col = i > M.text_place and 1 and pos or nil,
      virt_text_pos = i <= M.text_place and "inline" or nil,
      hl_mode = "combine",
    })
  end
end

function M.time(buf_id, items, query, stat, pos, line, i)
  if stat and stat.mtime then
    local tbl = { { M.time_str(stat.mtime), "MiniPickExplorerDate" } }
    if i < M.text_place then table.insert(tbl, { string.rep(" ", M._cache.compiled_width[i] - #tbl[1][1]), "None" }) end

    vim.api.nvim_buf_set_extmark(buf_id, M.ids.date, line - 1, 0, {
      virt_text = tbl,
      virt_text_win_col = i > M.text_place and 1 and pos or nil,
      virt_text_pos = i <= M.text_place and "inline" or nil,
      hl_mode = "combine",
    })
  end
end

function M.explorer_show(buf_id, items, query)
  vim.api.nvim_buf_clear_namespace(buf_id, M.ids.perm, 0, -1)
  vim.api.nvim_buf_clear_namespace(buf_id, M.ids.date, 0, -1)
  vim.api.nvim_buf_clear_namespace(buf_id, M.ids.size, 0, -1)
  require("mini.pick").default_show(buf_id, items, query, { show_icons = true })

  for line, item in ipairs(items) do
    -- HACK: Compute's fs_stat every iteration to update any changes
    -- PERF: This is very expensive, but it might not be that important
    local stat = vim.uv.fs_stat(item.path)
    local width = 0
    for i = 1, #M.opts.items do
      width = width + (M._cache.compiled_width[i - 1] or 0)
      if i ~= M.text_place then
        if M[M.opts.order[i]] then M[M.opts.order[i]](buf_id, items, query, stat, width, line, i) end
      end
    end
  end
end

local ivy_opts = {
  window = {
    config = function()
      return {
        width = vim.o.columns,
        height = math.floor(vim.o.lines * 0.3),
        border = "solid",
      }
    end,
  },
}

-- Mostly from:
-- https://github.com/echasnovski/mini.nvim/blob/2011aff270bcd3e1f3ad088253ace2d574967bed/lua/mini/extra.lua#L517
function M.explorer(local_opts)
  if not M.opts then M.setup() end
  local_opts = vim.tbl_deep_extend("force", { cwd = nil, filter = nil, sort = nil }, local_opts or {})

  local filter = local_opts.filter or function() return true end
  local sort = local_opts.sort or M.explorer_default_sort

  local cwd = local_opts.cwd or vim.fn.getcwd()

  local choose = function(item)
    local path = item.path
    if vim.fn.filereadable(path) == 1 then return MiniPick.default_choose(path) end
    if vim.fn.isdirectory(path) == 0 then return false end

    MiniPick.set_picker_items(M.explorer_make_items(path, filter, sort))
    MiniPick.set_picker_opts({
      source = { cwd = path },
      window = {
        prompt_prefix = M.opts.prompt_prefix(path),
      },
    })
    MiniPick.set_picker_query({})
    return true
  end

  local opts = { source = { show = M.explorer_show, choose = choose } }
  opts = vim.tbl_deep_extend("force", opts, local_opts or {})

  local picker_opts = {}
  if M.opts.ivy and M.opts.ivy.enable then picker_opts = ivy_opts end
  opts.window = opts.window or picker_opts.window
  local show = MiniPick.config.source.show
  local items = M.explorer_make_items(cwd, filter, sort)
  local source = { items = items, name = "File explorer", cwd = cwd, show = show, choose = choose }

  opts = vim.tbl_deep_extend("force", {
    source = source,
    window = {
      prompt_prefix = M.opts.prompt_prefix(cwd),
    },
  }, opts or {})

  return MiniPick.start(opts)
end

return M
