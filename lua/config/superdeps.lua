local M = {}

function M.add(spec, opts)
  local add_fn = function() MiniDeps.add(spec, opts) end

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
  self.add_fn()
  for _, v in ipairs(self.next_fns) do
    v()
  end
end

function M:next(do_op)
  table.insert(self.next_fns, do_op)
  return self
end

return M
