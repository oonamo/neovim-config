local M = {}

local active_timer = vim.uv.new_timer()
local active_linenr = nil

local hl_id = vim.api.nvim_create_namespace("hl-inline")

local function hl_line(buf, line)
  vim.api.nvim_buf_clear_namespace(buf, hl_id, 0, -1)
  local opts = { end_row = line, end_col = 0, hl_eol = true, hl_group = "IncSearch", priority = 201 }
  vim.api.nvim_buf_set_extmark(buf, hl_id, line - 1, 0, opts)
end

local function clear_timer()
  pcall(function()
    active_timer:stop()
    active_timer:close()
  end)
end

local function hl_line_debounce(buf, line)
  if active_linenr and active_linenr == line then return end
  active_linenr = line

  clear_timer()
  active_timer = vim.uv.new_timer()

  active_timer:start(M.timeout, 0, function()
    clear_timer()
    vim.schedule(function() hl_line(buf, line) end)
  end)
end

local ns_digit_prefix = vim.api.nvim_create_namespace("cur-buf-pick-show")
local show_cur_buf_lines = function(buf_id, items, query, opts)
  if items == nil or #items == 0 then return end

  -- Move prefix line numbers into inline extmarks
  local lines = vim.api.nvim_buf_get_lines(buf_id, 0, -1, false)
  local digit_prefixes = {}
  for i, l in ipairs(lines) do
    local _, prefix_end, prefix = l:find("^(%s*%d+│)")
    if prefix_end ~= nil then
      digit_prefixes[i], lines[i] = prefix, l:sub(prefix_end + 1)
    end
  end

  vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, lines)
  for i, pref in pairs(digit_prefixes) do
    local opts = { virt_text = { { pref, "MiniPickNormal" } }, virt_text_pos = "inline" }
    vim.api.nvim_buf_set_extmark(buf_id, ns_digit_prefix, i - 1, 0, opts)
  end

  -- Set highlighting based on the curent filetype
  local ft = vim.bo[items[1].bufnr].filetype
  local has_lang, lang = pcall(vim.treesitter.language.get_lang, ft)
  local has_ts, _ = pcall(vim.treesitter.start, buf_id, has_lang and lang or ft)
  if not has_ts and ft then vim.bo[buf_id].syntax = ft end

  -- Show as usual
  MiniPick.default_show(buf_id, items, query, opts)

  local matches = MiniPick.get_picker_matches()
  if not matches then return end

  M.current = matches.current or matches.all[1]
  if not M.current then return end
  hl_line(M.pre.buf, M.current.lnum)
end

MiniPick.registry.buffer_lines_current = function(local_opts, opts)
  local_opts = local_opts or {}
  M.pre = { win = vim.api.nvim_get_current_win(), buf = vim.api.nvim_get_current_buf() }
  M.pre.position = vim.api.nvim_win_get_cursor(M.pre.win)

  local_opts = vim.tbl_deep_extend("force", { scope = "current", preserve_order = true }, local_opts)
  opts = vim.tbl_deep_extend("force", { source = { show = show_cur_buf_lines } }, opts or {})

  local result = MiniExtra.pickers.buf_lines(local_opts, opts)
  vim.api.nvim_buf_clear_namespace(M.pre.buf, hl_id, 0, -1)

  -- No item was selected
  if not result then pcall(vim.api.nvim_win_set_cursor, M.pre.win, M.pre.position) end
  return result
end
