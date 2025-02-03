local get_opt = vim.api.nvim_get_option_value

local M = {}
M.hl = {}

---@class status.Data
---@field buf number
---@field fname string

---@param hl string
---@param v table
---@return string
local function get_hl(hl, v)
  if M.hl[hl] then return M.hl[hl] end
  local new_hl = v
  if v.fg then
    if type(v.fg) == "table" then
      local key = v.fg.key
      local hi = v.fg.hi
      local tmp = vim.api.nvim_get_hl(0, {
        name = hi,
      })
      new_hl.fg = tmp[key]
    elseif v.fg:sub(1, 1) ~= "#" then
      local fg = vim.api.nvim_get_hl(0, {
        name = v.fg,
      })
      new_hl.fg = fg.fg
    end
  end
  if v.bg then
    if type(v.bg) == "table" then
      local key = v.bg.key
      local hi = v.bg.hi
      local tmp = vim.api.nvim_get_hl(0, {
        name = hi,
      })
      new_hl.bg = tmp[key]
    elseif v.bg:sub(1, 1) ~= "#" then
      local bg = vim.api.nvim_get_hl(0, {
        name = v.bg,
      })
      new_hl.bg = bg.bg
    end
  end
  vim.api.nvim_set_hl(0, "status" .. hl, new_hl)
  M.hl[hl] = "status" .. hl
  return M.hl[hl]
end

---@param hl string
---@param value any
---@param hl_keys table
---@param reset boolean?
---@return string
local function stl_format(hl, value, hl_keys, reset)
  local mod_hl = get_hl(hl, hl_keys)
  return string.format("%%#%s#%s%s", mod_hl, value, reset and "%#Statusline#" or "")
end

function M.make_his(hl_list)
  for k, v in pairs(hl_list) do
    vim.api.nvim_set_hl(0, "status" .. k, v)
  end
end

M.modes = {
  ["n"] = "NOR",
  ["no"] = "OPE",
  ["nov"] = "OPE",
  ["noV"] = "OPE",
  ["no\x16"] = "OPE",
  ["niI"] = "NOR",
  ["niR"] = "NOR",
  ["niV"] = "NOR",
  ["nt"] = "NOR",
  ["ntT"] = "NOR",
  ["v"] = "VIS",
  ["vs"] = "VIS",
  ["V"] = "V-LIN",
  ["Vs"] = "V-LIN",
  ["\x16"] = "V-BlO",
  ["\x16s"] = "V-BLO",
  ["s"] = "SEL",
  ["S"] = "S-LIN",
  ["\x13"] = "S-BLO",
  ["i"] = "INS",
  ["ic"] = "INS",
  ["ix"] = "INS",
  ["R"] = "REP",
  ["Rc"] = "REP",
  ["Rx"] = "REP",
  ["Rv"] = "V-REP",
  ["Rvc"] = "V-REP",
  ["Rvx"] = "V-REP",
  ["c"] = "CMD",
  ["cv"] = "EX",
  ["ce"] = "EX",
  ["r"] = "REP",
  ["rm"] = "MOR",
  ["r?"] = "CONF",
  ["!"] = "SHELL",
  ["t"] = "TER",
}

---@param data status.Data
function M.mode(data)
  local vim_mode = vim.api.nvim_get_mode().mode
  local mode = M.modes[vim_mode] or M.modes[vim_mode:sub(1, 1)] or "UNK"
  return mode
end

---@param data status.Data
function M.diagnostic(data)
  if #vim.diagnostic.get(0) > 0 then
    local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    local error_format = stl_format("error", "x ", {
      fg = "DiagnosticError",
      bg = "StatusLine",
    }, true) .. errors

    local err = errors > 0 and error_format .. " " or ""

    local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    local warn_format = stl_format("warn", "▲ ", {
      fg = "DiagnosticWarn",
      bg = "StatusLine",
    }, true) .. warnings
    local warn = warnings > 0 and warn_format .. " " or ""

    -- local hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    -- local hint_format = stl_format("hint", "H " .. hints, {
    -- 	fg = "DiagnosticHint",
    -- 	bg = "StatusLine",
    -- })
    -- local hint = hints > 0 and hint_format .. " " or ""
    --
    -- local infos = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
    -- local info_format = stl_format("info", "I " .. infos, {
    -- 	fg = "DiagnosticInfo",
    -- 	bg = "StatusLine",
    -- })
    -- local info = infos > 0 and info_format .. " " or ""
    -- return err .. warn .. hint .. info .. "%#StatusLine# "
    return err .. warn .. "%#StatusLine# "
  end
  return ""
end

---@param data status.Data
function M.diff(data)
  local summary = vim.b.minidiff_summary
  if not summary or not summary.source_name then return "" end
  local add = summary.add
  local change = summary.change
  local delete = summary.delete

  local add_format = ""
  local delete_format = ""
  local change_format = ""

  if add and add > 0 then
    add_format = stl_format("add", "+" .. add, {
      fg = "diffAdded",
      bg = "StatusLine",
      bold = true,
    })
  end
  if delete and delete > 0 then
    delete_format = stl_format("delete", "-" .. delete, {
      fg = "diffRemoved",
      bg = "StatusLine",
      bold = true,
    })
  end
  if change and change > 0 then
    change_format = stl_format("change", "~" .. change, {
      fg = "diffChanged",
      bg = "StatusLine",
    })
  end
  return add_format .. " " .. change_format .. " " .. delete_format .. " %#StatusLine# "
end

---@param data status.Data
function M.treesitter(data)
  local ok, ts = pcall(require, "nvim-treesitter")
  if not ok then return end
  return ts.statusline() or ""
end

---@param data status.Data
function M.file(data)
  local file_name = vim.fn.fnamemodify(data.fname, ":t"):gsub("\\", "/")
  local file_icon, icon_hl = require("mini.icons").get("file", file_name)

  local file_icon_name = stl_format(icon_hl, file_icon, {
    fg = icon_hl,
    bg = "Statusline",
  }, true) .. " " .. stl_format("statusfile_name", file_name, {
    fg = {
      hi = "Statusline",
      key = "fg",
    },
    -- fg = "Normal",
    bg = "Statusline",
    bold = true,
  })

  if vim.bo.filetype == "help" then
    -- return table.concat({ file_icon, file_icon_name })
    return file_icon_name
  end

  local dir_path = vim.fn.fnamemodify(data.fname, ":h:~"):gsub("\\", "/") .. "/"
  local win_width = vim.api.nvim_win_get_width(0)
  local dir_threshold_width = 10

  dir_path = win_width >= dir_threshold_width + #dir_path + #file_icon_name and dir_path or ""
  -- return stl_format("file", "╼ " .. dir_path, {
  -- 	fg = "NonText",
  --    bg = "Statusline",
  -- }) .. file_icon_name
  return stl_format("file", "╼ ", {
    fg = "DiffAdd",
    bg = "Statusline",
  }) .. stl_format("dir", dir_path, {
    fg = "NonText",
    bg = "Statusline",
  }) .. file_icon_name
end

---@return string, nil|integer: Vline count
local function vline_count()
  local raw_count = vim.fn.line(".") - vim.fn.line("v")
  raw_count = raw_count < 0 and raw_count - 1 or raw_count + 1

  if raw_count < 999 then
    return tostring(raw_count)
  else
    local raw_count_str = tostring(raw_count) --[[@as string]]
    return raw_count_str:reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
  end
end

---@return boolean
local function is_in_search()
  local cmd_type = vim.fn.getcmdtype()
  return cmd_type == "/" or cmd_type == "?"
end

local non_programming_modes = {
  markdown = {},
  org = {},
  neorg = {},
  latex = {},
}

local function group_number(num, sep)
  if num < 999 then
    return tostring(num)
  else
    local tmp = tostring(num) --[[@as string]]
    return tmp:reverse():gsub("(%d%d%d)", "%1" .. sep):reverse():gsub("^,", "")
  end
end

---@param data status.Data
function M.file_info(data)
  if vim.v.hlsearch == 1 and not is_in_search() then
    local sinfo = vim.fn.searchcount()
    if vim.tbl_isempty(sinfo) then return "" end
    local search_stat = sinfo.incomplete > 0 and "press enter"
      or sinfo.total > 0 and ("%s/%s"):format(sinfo.current, sinfo.total)
      or nil

    if search_stat ~= nil then
      -- return table.concat({ icon_tbl.searchcount, " ", search_stat, " " })
      return stl_format("searchcount", "⌘", {
        fg = "DiagnosticInfo",
        bg = "Statusline",
      }) .. " " .. search_stat
    end
  end
  local ft = get_opt("filetype", {})
  local raw_lines = vim.api.nvim_buf_line_count(0)
  local lines = group_number(raw_lines, ",")

  if not non_programming_modes[ft] then
    return stl_format("fileinfo", "≡", {
      fg = "DiagnosticInfo",
      bg = "Statusline",
    }, true) .. " " .. lines .. " lines"
  end
  local wc_table = vim.fn.wordcount()
  if not wc_table.visual_words or not wc_table.visual_chars then
    local raw_word_count
    if raw_lines < 999 then
      raw_word_count = tostring(wc_table.words)
    else
      local wc_table_words_str = tostring(wc_table.words) --[[@as string]]
      raw_word_count = wc_table.words_str:reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
    end
    return stl_format("fileinfo", "≡", {
      fg = "DiagnosticInfo",
      bg = "Statusline",
    }, true) .. " " .. lines .. " lines  " .. raw_word_count .. " words "
  else
    return stl_format("fileinfo", "‹›", {
      fg = "DiagnosticInfo",
      bg = "Statusline",
    }, true) .. " " .. vline_count() .. " lines  ",
      group_number(wc_table.visual_words, ",") .. " words  ",
      group_number(wc_table.visual_chars, ",") .. " chars"
  end
end

---@param data status.Data
local function build(data)
  return {
    -- "%=",
    M.file(data),
    "%=",
    -- "%=%f%=",
    M.diff(data),
    M.diagnostic(data),
    M.file_info(data),
    " %l|%c",
  }
end

local function buildwinbar(data)
  return {
    M.treesitter(data),
  }
end

function M.statusline()
  ---@type status.Data
  local data = {
    buf = vim.api.nvim_get_current_buf(),
    fname = vim.api.nvim_buf_get_name(0),
  }
  local components = build(data)
  local statusline = ""
  for _, component in ipairs(components) do
    statusline = statusline .. component
  end
  return statusline
end

-- function M.winbar()
-- 	local data = {
--     buf = vim.api.nvim_get_current_buf()
--   }
-- 	local components = buildwinbar(data)
-- 	local winbar = ""
-- 	for _, component in ipairs(components) do
-- 		winbar = winbar .. component
-- 	end
-- 	return winbar
-- end

vim.api.nvim_create_autocmd("Colorscheme", {
  group = vim.api.nvim_create_augroup("Statusline", { clear = true }),
  callback = function() M.hl = {} end,
})

vim.opt.statusline = "%!v:lua.require('statusline').statusline()"

return M
