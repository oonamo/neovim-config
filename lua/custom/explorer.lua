local M = {
  _cache = {},
  ids = {
    perm = vim.api.nvim_create_namespace("FS_stat"),
    size = vim.api.nvim_create_namespace("FS_size"),
    date = vim.api.nvim_create_namespace("FS_date"),
  },
  mappings = {},
}

M.mappings.go_up_level = {
  char = "<C-h>",
  func = function()
    local query = MiniPick.get_picker_query()
    if not query[1] or query[1] == "" then
      vim.schedule(function() vim.api.nvim_input("<CR>") end)
    else
      MiniPick.set_picker_query({ "" })
    end
  end,
}

M.mappings.go_up_level_neovide = {
  char = "<c-bs>", -- Same as C BKSP, emacs lol
  func = function()
    local query = MiniPick.get_picker_query()
    if not query[1] or query[1] == "" then
      vim.schedule(function() vim.api.nvim_input("<CR>") end)
    else
      MiniPick.set_picker_query({ "" })
    end
  end,
}

local PERM_SIZE = 9

local hi = function(...) vim.api.nvim_set_hl(0, ...) end
hi("ReadBit", { link = "MiniIconsYellow", default = true })
hi("ExeMod", { link = "DiagnosticError", default = true })
hi("WriteBit", { link = "DiagnosticInfo", default = true })
hi("SepBit", { link = "NonText", default = true })
hi("MiniPickExplorerSize", { link = "Constant", default = true })
hi("MiniPickExplorerDate", { link = "Character", default = true })

local defaults = {
  ivy = {
    enable = true,
  },
  items = {
    { width = 0.2 }, -- 20% is dedicated to file names
    { width = 10 }, -- Length of permssion string is 9
    { width = 7 }, -- 7 is dedicated to size
    { width = 10, remaining = true },
  },
  order = {
    "text",
    "permissions",
    "size",
    "time",
  },
}

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
  table.insert(tbl, (bit.band(num, 4) ~= 0 and { "r", "ReadBit" } or { "-", "SepBit" }))
  table.insert(tbl, (bit.band(num, 2) ~= 0 and { "w", "WriteBit" } or { "-", "SepBit" }))
  if exe_modifier then
    if bit.band(num, 1) ~= 0 then
      table.insert(tbl, { exe_modifier, "ExeMod" })
    else
      table.insert(tbl, { exe_modifier:upper(), "ExeMod" })
    end
  else
    table.insert(tbl, (bit.band(num, 1) ~= 0 and { "x", "ExeBit" } or { "-", "SepBit" }))
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
  if year ~= current_year then
    ret = vim.fn.strftime("%b %d %y", time.sec)
  else
    ret = vim.fn.strftime("%b %d %H:%M", time.sec)
  end

  return ret
end

function M.size_str(size)
  if size == 0 then return "D" end
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
  local widths = M._cache.compiled_width
  vim.api.nvim_buf_clear_namespace(buf_id, M.ids.perm, 0, -1)
  vim.api.nvim_buf_clear_namespace(buf_id, M.ids.date, 0, -1)
  vim.api.nvim_buf_clear_namespace(buf_id, M.ids.size, 0, -1)
  require("mini.pick").default_show(buf_id, items, query)

  for line, item in ipairs(items) do
    local stat = vim.uv.fs_stat(item.path)
    -- local width = M._cache.compiled_width[1]
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

function M.explorer(local_opts)
  local opts = { source = { show = M.explorer_show } }
  opts = vim.tbl_deep_extend("force", opts, local_opts or {})
  local picker_opts = {}
  if M.opts.ivy and M.opts.ivy.enable then picker_opts = ivy_opts end
  opts.window = picker_opts.window
  require("mini.extra").pickers.explorer(picker_opts, opts)
end

return M
