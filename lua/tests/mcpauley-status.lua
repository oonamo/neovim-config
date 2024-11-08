local get_opt = vim.api.nvim_get_option_value

---@param hl string Highlight
---@param str string String to Highlight
local function hl_str(hl, str)
	return "%#" .. hl .. "#" .. str .. "%*"
end

local function group_number(num, sep)
	if num < 999 then
		return tostring(num)
	else
		local tmp = tostring(num) --[[@as string]]
		return tmp:reverse():gsub("(%d%d%d)", "%1" .. sep):reverse():gsub("^,", "")
	end
end

---@param in_str string
---@param width number
---@param align string
local function pad_str(in_str, width, align)
	local num_spaces = width - #in_str
	if num_spaces < 1 then
		num_spaces = 1
	end

	local spaces = string.rep(" ", num_spaces)

	if align == "left" then
		return table.concat({ in_str, spaces })
	end

	return table.concat({ spaces, in_str })
end

---@alias hl_items { [1]: string, [2]: string }

---@param items hl_items
local function setup_hls(items)
	local syms = {}
	for name, list in pairs(items) do
		syms[name] = hl_str(list[1], list[2])
	end
	return syms
end

local icons = {
	branch = "",
	bullet = "•",
	o_bullet = "○",
	check = "✔",
	d_chev = "∨",
	ellipses = "…",
	file = "╼ ",
	hamburger = "≡",
	lock = "",
	r_chev = ">",
	location = "⌘",
	square = "⏹ ",
	ballot_x = "x",
	up_tri = "▲",
	info_i = "¡",
}

local ui_icons = {
	["branch"] = { "DiagnosticOk", icons["branch"] },
	["file"] = { "NonText", icons["file"] },
	["fileinfo"] = { "DiagnosticInfo", icons["hamburger"] },
	["nomodifiable"] = { "DiagnosticWarn", icons["bullet"] },
	["modified"] = { "DiagnosticError", icons["bullet"] },
	["readonly"] = { "DiagnosticWarn", icons["lock"] },
	["searchcount"] = { "DiagnosticInfo", icons["location"] },
	["error"] = { "DiagnosticError", icons["ballot_x"] },
	["warn"] = { "DiagnosticWarn", icons["up_tri"] },
}

local hl_ui_icons = setup_hls(ui_icons)

---@param fname string Filename
---@param icon_tbl table icon table
---@return string: Path Info
local function get_path_info(fname, icon_tbl)
	local file_name = vim.fn.fnamemodify(fname, ":t")

	local file_icon, icon_hl = require("mini.icons").get("file", file_name)
	file_icon = file_name ~= "" and hl_str(icon_hl, file_icon)

	local file_name_icon = " " .. file_icon .. " " .. file_name
	if vim.bo.buftype == "help" then
		return icon_tbl["file"] .. file_name_icon
	end

	local dir_path = vim.fn.fnamemodify(fname, ":h"):gsub("\\", "/") .. "/"
	local dir_threshold_width = 15

	local win_width = vim.api.nvim_win_get_width(0)

	dir_path = win_width >= dir_threshold_width + #file_name_icon and dir_path or ""

	return icon_tbl["file"] .. dir_path .. file_name_icon
end

---@return string: Diagnostics string
local function diagnostics()
	if #vim.diagnostic.get(0, {}) == 0 then
		return ""
	end

	local diag_tbl = {}
	local total = vim.diagnostic.count()

	local err_total = total[1] or 0
	local warn_total = total[2] or 0

	vim.list_extend(diag_tbl, { hl_ui_icons["error"], " ", pad_str(tostring(err_total), 3, "left"), " " })
	vim.list_extend(diag_tbl, { hl_ui_icons["warn"], " ", pad_str(tostring(warn_total), 3, "left"), " " })
	return table.concat(diag_tbl)
end

---@return string: File size string
local function get_filesize()
	local suffix = { "b", "k", "M", "G", "T", "P", "E" }
	local fsize = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))

	-- Handle invalid file size
	if fsize < 0 then
		return "0b"
	end

	local i = math.floor(math.log(fsize) / math.log(1024))
	-- Ensure index is within suffix range
	i = math.min(i, #suffix - 1)

	return string.format("%.1f%s", fsize / 1024 ^ i, suffix[i + 1])
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

local function file_info(icon_tbl)
	if vim.v.hlsearch == 1 and not is_in_search() then
		local sinfo = vim.fn.searchcount()
		local search_stat = sinfo.incomplete > 0 and "press enter"
			or sinfo.total > 0 and ("%s/%s"):format(sinfo.current, sinfo.total)
			or nil

		if search_stat ~= nil then
			vim.print(icon_tbl)
			return table.concat({ icon_tbl.searchcount, " ", search_stat, " " })
		end
	end

	local ft = get_opt("filetype", {})
	local raw_lines = vim.api.nvim_buf_line_count(0)
	local lines
	if raw_lines < 999 then
		lines = tostring(raw_lines)
	else
		local raw_lines_str = tostring(raw_lines) --[[@as string]]
		lines = raw_lines_str:reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
	end

	if not non_programming_modes[ft] then
		return table.concat({ icon_tbl.fileinfo, " ", lines, " lines" })
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
		return table.concat({
			icon_tbl.fileinfo,
			" ",
			get_filesize(),
			"  ",
			lines,
			" lines  ",
			raw_word_count,
			" words ",
		})
	else
		return table.concat({
			hl_str("DiagnosticInfo", "‹›"),
			" ",
			vline_count(),
			" lines  ",
			group_number(wc_table.visual_words, ","),
			" words  ",
			group_number(wc_table.visual_chars, ","),
			" chars",
		})
	end
end

local function scrollbar()
	local sbar_chars = {
		"▔",
		"🮂",
		"🬂",
		"🮃",
		"▀",
		"🮑",
		"🮒",
		"▄",
		"▃",
		"🬭",
		"▂",
		"▁",
	}

	local cur_line = vim.api.nvim_win_get_cursor(0)[1]
	local lines = vim.api.nvim_buf_line_count(0)

	local i = math.floor((cur_line - 1) / lines * #sbar_chars) + 1
	local sbar = string.rep(sbar_chars[i], 2)

	return hl_str("Substitute", sbar)
end

local M = {}

function M.render()
	local fname = vim.api.nvim_buf_get_name(0)
	local bt = vim.bo.buftype
	if bt == "terminal" or bt == "nofile" or bt == "prompt" then
		fname = bt
	end

	local buf_num = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
	local str = ""

	str = str .. get_path_info(fname, hl_ui_icons)
	if not get_opt("modifiable", { buf = buf_num }) then
		str = str .. hl_ui_icons["nomodifiable"]
	elseif get_opt("modified", { buf = buf_num }) then
		str = str .. hl_ui_icons["modified"]
	end
	str = str .. " " .. (get_opt("readonly", { buf = buf_num }) and hl_ui_icons["readonly"] or "") .. " "
	str = str .. "%= " .. diagnostics() .. " " .. file_info(hl_ui_icons) .. " " .. scrollbar()

	return str
end

vim.o.statusline = "%!v:lua.require('tests.mcpauley-status').render()"

return M
