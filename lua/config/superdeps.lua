local M = {}

function M.use(name, opts)
  local add_fn = function()
    local ok, pack = pcall(require, name)
    if not ok then
      return vim.notify("Error loading " .. tostring(name) .. ":\n" .. tostring(pack), vim.log.levels.WARN)
    end
    if pack.setup then pack.setup(opts) end

    return true
  end

  local data = {
    add_fn = add_fn,
    next_fns = {},
  }

  setmetatable(data, {
    __index = M,
    __call = function() data:on_call() end,
  })

  return data
end

function M.add(spec, opts)
  local add_fn = function()
    MiniDeps.add(spec, opts)
    return true
  end

  local data = {
    add_fn = add_fn,
    next_fns = {},
  }

  setmetatable(data, {
    __index = M,
    __call = function() data:on_call() end,
  })

  return data
end

function M:on_call()
  local ok = self.add_fn()
  if not ok then return end

  for _, v in ipairs(self.next_fns) do
    v()
  end
end

function M:next(do_op)
  if type(do_op) == "table" then
    -- PERF: Slightly increase perfomance by just setting this to be all the next_fns
    --       Would override previous fns
    self.next_fns = do_op
  else
    table.insert(self.next_fns, do_op)
  end
  return self
end

return M
