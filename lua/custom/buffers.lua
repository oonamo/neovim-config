local M = {}

local show_with_preview = function(buf_id, items, query, opts)
  opts = opts or {}
  opts.show_icons = true
  MiniPick.default_show(buf_id, items, query, opts)

  -- TODO: This can be slow, but it doesn't feel slow :)
  vim.schedule(function()
    local matches = MiniPick.get_picker_matches()
    if not matches or not matches.current or not matches.all[1] then return end

    M.current = matches.current or matches.all[1]
    if not M.current then return end
    pcall(vim.api.nvim_win_set_buf, M.pre.win, M.current.bufnr)
  end)
end

MiniPick.registry.buffer_preview = function(local_opts, opts)
  M.pre = { buf = vim.api.nvim_get_current_buf(), win = vim.api.nvim_get_current_win() }
  opts = vim.tbl_deep_extend("force", { source = { show = show_with_preview } }, opts or {})
  local result = MiniPick.builtin.buffers(local_opts, opts)
  if result == nil then pcall(vim.api.nvim_win_set_buf, M.pre.win, M.pre.buf) end
  return result
end
