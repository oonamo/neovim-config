local H = {
  ns_id = {
    ranges = vim.api.nvim_create_namespace("buffer-range-picker"),
    treesitter = vim.api.nvim_create_namespace("buffer-preview-treesitter"),
  },
}
local M = {}

H.seq_along = function(arr)
  if arr == nil then return nil end
  local res = {}
  for i = 1, #arr do
    table.insert(res, i)
  end
  return res
end

H.expand_callable = function(x, ...)
  if vim.is_callable(x) then return x(...) end
  return x
end

H.item_to_string = function(item)
  item = H.expand_callable(item)
  if type(item) == "string" then return item end
  if type(item) == "table" and type(item.text) == "string" then return item.text end
  return vim.inspect(item, { newline = " ", indent = "" })
end

H.set_buflines = function(buf_id, lines) pcall(vim.api.nvim_buf_set_lines, buf_id, 0, -1, false, lines) end
H.clear_namespace = function(buf_id, ns_id) pcall(vim.api.nvim_buf_clear_namespace, buf_id, ns_id, 0, -1) end
H.set_extmark = function(...) pcall(vim.api.nvim_buf_set_extmark, ...) end

H.query_is_ignorecase = function(query)
  if not vim.o.ignorecase then return false end
  if not vim.o.smartcase then return true end
  local prompt = table.concat(query)
  return prompt == vim.fn.tolower(prompt)
end

H.tolower = (function()
  -- Cache `tolower` for speed
  local tolower = vim.fn.tolower
  return function(x)
    -- `vim.fn.tolower` can throw errors on bad string (like with '\0')
    local ok, res = pcall(tolower, x)
    return ok and res or string.lower(x)
  end
end)()

H.match_query_group = function(query)
  local parts = { {} }
  for _, x in ipairs(query) do
    local is_whitespace = x:find("^%s+$") ~= nil
    if is_whitespace then table.insert(parts, {}) end
    if not is_whitespace then table.insert(parts[#parts], x) end
  end
  return #parts > 1, vim.tbl_map(table.concat, parts)
end

H.match_filter = function(inds, stritems, query)
  -- 'abc' and '*abc' - fuzzy; "'abc" and 'a' - exact substring;
  -- 'ab c' - grouped fuzzy; '^abc' and 'abc$' - exact substring at start/end.
  local is_fuzzy_forced, is_exact_plain, is_exact_start, is_exact_end =
    query[1] == "*", query[1] == "'", query[1] == "^", query[#query] == "$"
  local is_grouped, grouped_parts = H.match_query_group(query)

  if is_fuzzy_forced or is_exact_plain or is_exact_start or is_exact_end then
    local start_offset = (is_fuzzy_forced or is_exact_plain or is_exact_start) and 2 or 1
    local end_offset = #query - ((not is_fuzzy_forced and not is_exact_plain and is_exact_end) and 1 or 0)
    query = vim.list_slice(query, start_offset, end_offset)
  elseif is_grouped then
    query = grouped_parts
  end

  if #query == 0 then return {}, "useall", query end

  local is_fuzzy_plain = not (is_exact_plain or is_exact_start or is_exact_end) and #query > 1
  if is_fuzzy_forced or is_fuzzy_plain then return H.match_filter_fuzzy(inds, stritems, query), "fuzzy", query end

  local prefix = is_exact_start and "^" or ""
  local suffix = is_exact_end and "$" or ""
  local pattern = prefix .. vim.pesc(table.concat(query)) .. suffix

  return H.match_filter_exact(inds, stritems, query, pattern), "exact", query
end

H.match_filter_fuzzy = function(inds, stritems, query)
  local match_single, find_query = H.match_filter_fuzzy_single, H.match_find_query
  local poke_picker = H.poke_picker_throttle(H.querytick)
  local match_data = {}
  for _, ind in ipairs(inds) do
    if not poke_picker() then return nil end
    local data = match_single(stritems[ind], ind, query, find_query)
    if data ~= nil then table.insert(match_data, data) end
  end
  return match_data
end

H.poke_picker_throttle = function(querytick_ref)
  -- Allow calling this even if no picker is active
  if not MiniPick.is_picker_active() then return function() return true end end

  local latest_time, dont_check_querytick = vim.loop.hrtime(), querytick_ref == nil
  local threshold = 1000000 * MiniPick.config.delay.async
  local hrtime = vim.loop.hrtime
  local poke_is_picker_active = MiniPick.poke_is_picker_active
  return function()
    local now = hrtime()
    if (now - latest_time) < threshold then return true end
    latest_time = now
    -- Return positive if picker is active and no query updates (if asked)
    return poke_is_picker_active() and (dont_check_querytick or querytick_ref == H.querytick)
  end
end

H.match_filter_exact_single = function(candidate, index, pattern)
  local start = string.find(candidate[1], pattern)
  if start == nil then return nil end

  return { 0, start, index, candidate[2] }
end

H.match_filter_exact = function(inds, stritems, query, pattern)
  local match_single = H.match_filter_exact_single
  local poke_picker = H.poke_picker_throttle(H.querytick)
  local match_data = {}
  for _, ind in ipairs(inds) do
    if not poke_picker() then return nil end
    local data = match_single(stritems[ind], ind, pattern)
    if data ~= nil then table.insert(match_data, data) end
  end

  return match_data
end

H.match_filter_fuzzy_single = function(candidate, index, query, find_query)
  -- Search for query chars match positions with the following properties:
  -- - All are present in `candidate` in the same order.
  -- - Has smallest width among all such match positions.
  -- - Among same width has smallest first match.

  -- Search forward to find matching positions with left-most last char match
  local first, last = find_query(candidate, query, 1)
  if first == nil then return nil end
  if first == last then return { 0, first, index, { first }, candidate[2] } end

  -- NOTE: This approach doesn't iterate **all** query matches. It is fine for
  -- width optimization but maybe not for more (like contiguous groups number).
  -- Example: for query {'a', 'b', 'c'} candidate 'aaxbbbc' will be matched as
  -- having 3 groups (indexes 2, 4, 7) but correct one is 2 groups (2, 6, 7).

  -- Iteratively try to find better matches by advancing last match
  local best_first, best_last, best_width = first, last, last - first
  while last do
    local width = last - first
    if width < best_width then
      best_first, best_last, best_width = first, last, width
    end

    first, last = find_query(candidate, query, first + 1)
  end

  -- NOTE: No field names is not clear code, but consistently better performant
  return { best_last - best_first, best_first, index, candidate[2] }
end

H.match_ranges_fuzzy = function(match_data, query, stritems)
  local res, n_query, query_lens = {}, #query, vim.tbl_map(string.len, query)
  for i_match, data in ipairs(match_data) do
    local s, from, to = stritems[data[3]][1], data[2], data[2] + query_lens[1] - 1
    local ranges = { { from, to } }
    for j_query = 2, n_query do
      from, to = string.find(s, query[j_query], to + 1, true)
      ranges[j_query] = { from, to }
    end
    res[i_match] = ranges
  end
  return res
end

H.match_find_query = function(s, query, init)
  local first, to = string.find(s[1], query[1], init, true)
  if first == nil then return nil, nil end

  -- Both `first` and `last` indicate the start byte of first and last match
  local last = first
  for i = 2, #query do
    last, to = string.find(s[1], query[i], to + 1, true)
    if not last then return nil, nil end
  end
  return first, last
end

H.match_ranges_exact = function(match_data, query)
  -- All matches have same match ranges relative to match start
  local cur_start, rel_ranges = 0, {}
  for i = 1, #query do
    rel_ranges[i] = { cur_start, cur_start + query[i]:len() - 1 }
    cur_start = rel_ranges[i][2] + 1
  end

  local res = {}
  for i = 1, #match_data do
    local start = match_data[i][2]
    res[i] = vim.tbl_map(function(x) return { start + x[1], start + x[2] } end, rel_ranges)
  end

  return res
end

local show_in_buffer = function(buf_id, items, query, opts)
  local default_icons = { directory = " ", file = " ", none = "  " }
  opts = vim.tbl_deep_extend("force", { show_icons = false, icons = default_icons }, opts or {})

  -- Compute and set lines. Compute prefix based on the whole items to allow
  -- separate `text` and `path` table fields (preferring second one).
  local get_prefix_data = function() return { text = "" } end
  -- local get_prefix_data = opts.show_icons and function(item) return H.get_icon(item, opts.icons) end
  --   or function() return { text = '' } end
  local prefix_data = vim.tbl_map(get_prefix_data, items)

  local lines = vim.tbl_map(function(l) return { l.text, l.lnum } end, items)
  local tab_spaces = string.rep(" ", vim.o.tabstop)

  lines = vim.tbl_map(
    function(l) return { l[1]:gsub("%z", "│"):gsub("[\r\n]", " "):gsub("\t", tab_spaces), l[2] } end,
    lines
  )

  local lines_to_show = {}
  for i, l in ipairs(lines) do
    lines_to_show[i] = prefix_data[i].text .. l[1]
  end

  H.set_buflines(buf_id, lines_to_show)

  -- Extract match ranges
  local ns_id = H.ns_id.ranges
  H.clear_namespace(buf_id, ns_id)
  H.clear_namespace(M.pre.buf, ns_id)

  if H.query_is_ignorecase(query) then
    lines, query = vim.tbl_map(function(l) return { H.tolower(l[1]), l[2] } end, lines), vim.tbl_map(H.tolower, query)
  end
  local match_data, match_type, query_adjusted = H.match_filter(H.seq_along(lines), lines, query)
  if match_data == nil then return end

  local match_ranges_fun = match_type == "fuzzy" and H.match_ranges_fuzzy or H.match_ranges_exact
  local match_ranges = match_ranges_fun(match_data, query_adjusted, lines)

  local preview_prefix_len = 0
  if lines and lines[1] then
    if lines[1][1] then preview_prefix_len = #lines[1][1]:match(".*│") end
  end

  -- Place range highlights accounting for possible shift due to prefixes
  local extmark_opts = { hl_group = "MiniPickMatchRanges", hl_mode = "combine", priority = 200 }
  for i = 1, #match_data do
    local line, row, ranges = match_data[i][4], match_data[i][3], match_ranges[i]

    -- Occurs when fuzzy matching is forced
    if type(line) == "table" then line = match_data[i][5] end

    local start_offset = prefix_data[row].text:len()
    for _, range in ipairs(ranges) do
      extmark_opts.end_row, extmark_opts.end_col = row - 1, start_offset + range[2]
      H.set_extmark(buf_id, ns_id, row - 1, start_offset + range[1] - 1, extmark_opts)
      H.set_extmark(M.pre.buf, ns_id, line - 1, range[1] - 1 - preview_prefix_len, {
        hl_group = "IncSearch",
        virt_text_pos = "overlay",
        -- hl_mode = "overlay",
        priority = 1000,
        end_row = line - 1,
        end_col = range[2] - preview_prefix_len,
      })
    end
  end

  vim.schedule(function()
    local matches = MiniPick.get_picker_matches()
    if not matches then return end

    M.current = matches.current
    -- or matches.all[1]
    if not M.current then return end

    pcall(vim.api.nvim_win_set_cursor, M.pre.win, { M.current.lnum, 0 })
    pcall(vim.api.nvim_buf_call, M.pre.buf, function() vim.cmd("norm! zz") end)
  end)

  -- Highlight prefixes
  if not opts.show_icons then return end
  local icon_extmark_opts = { hl_mode = "combine", priority = 200 }
  for i = 1, #prefix_data do
    icon_extmark_opts.hl_group = prefix_data[i].hl
    icon_extmark_opts.end_row, icon_extmark_opts.end_col = i - 1, prefix_data[i].text:len()
    H.set_extmark(buf_id, ns_id, i - 1, 0, icon_extmark_opts)
  end
end

local show_in_buffer_with_treesitter = function(buf_id, items, query, opts)
  if items == nil or #items == 0 then return end

  show_in_buffer(buf_id, items, query, opts)

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
    vim.api.nvim_buf_set_extmark(buf_id, H.ns_id.treesitter, i - 1, 0, opts)
  end

  -- Set highlighting based on the curent filetype
  local ft = vim.bo[items[1].bufnr].filetype
  local has_lang, lang = pcall(vim.treesitter.language.get_lang, ft)
  local has_ts, _ = pcall(vim.treesitter.start, buf_id, has_lang and lang or ft)
  if not has_ts and ft then vim.bo[buf_id].syntax = ft end
end

MiniPick.registry.buffer_inline = function(local_opts, opts)
  local_opts = local_opts or {}
  M.pre = { win = vim.api.nvim_get_current_win(), buf = vim.api.nvim_get_current_buf() }
  M.pre.position = vim.api.nvim_win_get_cursor(M.pre.win)

  local_opts = vim.tbl_deep_extend("force", { scope = "current", preserve_order = true }, local_opts)
  opts = vim.tbl_deep_extend("force", { source = { show = show_in_buffer_with_treesitter } }, opts or {})
  local retval = MiniExtra.pickers.buf_lines(local_opts, opts)
  H.clear_namespace(M.pre.buf, H.ns_id.ranges)

  return retval
end
