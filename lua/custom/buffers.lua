local M = {}
local active_timer = vim.uv.new_timer()
local active_buffer_timer = nil

M.timeout = 500

local function clear_timer()
  pcall(function()
    active_timer:stop()
    active_timer:close()
  end)
end

local function change_to_buffer_with_debounce(win_id, buf_id)
  -- Don't create a new timer if the current callback is for the same buffer
  if active_buffer_timer and active_buffer_timer == buf_id then return end
  active_buffer_timer = buf_id

  clear_timer()
  active_timer = vim.uv.new_timer()

  active_timer:start(M.timeout, 0, function()
    clear_timer()
    vim.schedule(function()
      local ok, err = pcall(vim.api.nvim_win_set_buf, win_id, buf_id)
      if not ok then vim.notify(tostring(err)) end
    end)
  end)
end

local show_with_preview = function(buf_id, items, query, opts)
  opts = opts or {}
  opts.show_icons = true
  MiniPick.default_show(buf_id, items, query, opts)

  local matches = MiniPick.get_picker_matches()
  if not matches or not matches.current or not matches.all[1] then return end

  M.current = matches.current or matches.all[1]
  if not M.current then return end
  change_to_buffer_with_debounce(M.pre.win, M.current.bufnr)
end

local choose = function(item)
  -- picker_choose internally verifies window
  local target = MiniPick.get_picker_state().windows.target

  -- Check if target is the same as the old window
  -- A new target is created on `mappings.choose_in_*` events
  if target ~= M.pre.win then pcall(vim.api.nvim_win_set_buf, M.pre.win, M.pre.buf) end

  return MiniPick.default_choose(item)
end

MiniPick.registry.buffer_preview = function(local_opts, opts)
  M.pre =
    { buf = vim.api.nvim_get_current_buf(), win = vim.api.nvim_get_current_win(), wins = vim.api.nvim_list_wins() }
  opts = vim.tbl_deep_extend("force", { source = { show = show_with_preview, choose = choose } }, opts or {})

  local_opts = local_opts or {}
  M.timeout = local_opts.timer or 100

  -- HACK: Just in case
  local_opts.timer = nil

  local result = MiniPick.builtin.buffers(local_opts, opts)
  if result == nil then pcall(vim.api.nvim_win_set_buf, M.pre.win, M.pre.buf) end

  clear_timer()
  active_buffer_timer = nil
  return result
end
