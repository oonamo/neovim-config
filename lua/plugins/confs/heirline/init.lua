local utils = require("heirline.utils")

local function get_hl(name, property)
	local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
	if hl[property] then
		return hl[property]
	elseif hl.fg then
		return hl.fg
	elseif hl.bg then
		return hl.bg
	else
		return get_hl("StatusLine", "fg")
	end
	-- return vim.tbl_isempty(hl) == false and hl
	-- 	or (function()
	-- 		local hl = get_hl("StatusLine")
	-- 		if not hl then
	-- 			error("recursive normal")
	-- 		end
	-- 		return hl
	-- 	end)()
end

local function set_colors()
	local colors = {
		fg = get_hl("StatusLine", "fg"),
		bg = get_hl("StatusLine", "bg"),
		bright_bg = get_hl("Folded", "bg"),
		bright_fg = get_hl("Folded", "fg"),
		red = get_hl("DiagnosticError", "fg"),
		dark_red = get_hl("DiffDelete", "bg"),
		green = get_hl("String", "fg"),
		blue = get_hl("Function", "fg"),
		gray = get_hl("NonText", "fg"),
		orange = get_hl("Constant", "fg"),
		purple = get_hl("Statement", "fg"),
		cyan = get_hl("Special", "fg"),
		warn = get_hl("DiagnosticWarn", "fg"),
		error = get_hl("DiagnosticError", "fg"),
		hint = get_hl("DiagnosticHint", "fg"),
		info = get_hl("DiagnosticInfo", "fg"),
		del = get_hl("MiniDiffSignDelete", "fg"),
		add = get_hl("MiniDiffSignAdd", "fg"),
		change = get_hl("MiniDiffSignChange", "fg"),
	}
	require("heirline").load_colors(colors)
	return colors
end

vim.api.nvim_create_augroup("Heirline", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		utils.on_colorscheme(set_colors)
	end,
	group = "Heirline",
})

local opts = {
	statusline = require("plugins.confs.heirline.statusline"),
	statuscolumn = require("plugins.confs.heirline.statuscolumn"),
	colors = set_colors(),
}

return opts
