local M = {}

M.colors = {
	-- Special
	green = "#afd7d7",
	-- String
	yellow = "#d7af87",
	-- function
	red = "#ffafd7",
	-- Keyword
	dark_green = "#5f8787",
	-- Constant
	orange = "#ffaf87",
	-- Variable
	text = "#d7d7ff",
	-- Propertu
	light_green = "#bcbcbc",
	-- Keyword Operator
	gray = "#8787af",
	-- Conditional
	blue = "#5f87af",
}

function M.setup()
	O.colorscheme = "rose-pine"
	O.fn = "grim-pine"
	utils.hl = {
		opts = {
			{ "@keyword", { fg = M.colors.dark_green, italic = true } },
			{ "@property", { fg = M.colors.light_green, italic = true } },
			{ "Function", { fg = M.colors.red, italic = true } },
			{ "@function.builtin", { fg = M.colors.red, italic = true } },
			{ "String", { fg = M.colors.yellow } },
			{ "Special", { fg = M.colors.green } },
			{ "Macro", { fg = M.colors.green, bg = "#262626" } },
			{ "Constant", { fg = M.colors.orange } },
			{ "@variable", { fg = M.colors.text } },
			{ "Directory", { fg = M.colors.blue } },
			{ "OilFile", { fg = M.colors.text } },
			{ "CursorLine", { bg = "#262626", fg = "#d7d7ff" } },
			{ "StatusLine", { bg = "#262626", fg = "#d7d7ff" } },
			{ "@attribute", { fg = M.colors.blue } },
			{ "@text.uri", { fg = M.colors.blue, underline = true } },
			{ "@neorg.headings.1.title.norg", { fg = M.colors.blue } },
			{ "@neorg", { fg = M.colors.red } },
			{ "Float", { fg = M.colors.orange } },
			{ "ModeMsg", { fg = M.colors.green } },
			{ "TelescopeBorder", { fg = "#262626", bg = "none" } },
			{ "TelescopeNormal", { bg = "none" } },
			{ "TelescopePromptNormal", { bg = "#262626" } },
			{ "TelescopeResultsNormal", { fg = M.colors.text, bg = M.colors.bg } },
			{ "TelescopeTitle", { fg = M.colors.bg, bg = M.colors.red } },
			{ "TelescopeSelection", { fg = M.colors.text, bg = M.colors.bg } },
			{ "TelescopeSelectionCaret", { fg = M.colors.red, bg = M.colors.red } },
			{ "BufferVisible", { bg = "none", fg = M.colors.text, bold = true, italic = true } },
		},
	}
	if vim.g.neovide then
		table.insert(utils.hl.opts, { "Normal", { fg = "#e0def4", bg = "#0e0b00" } })
	end
	vim.cmd("colorscheme " .. O.colorscheme)
	utils:create_hl()
end

function M.setup_pmenu()
	utils.pmenu = {
		opts = {
			{ "Pmenu", { bold = true, fg = M.colors.text, bg = "#262626" } },
			{ "PmenuSel", { bold = true, fg = M.colors.yellow } },
			{ "PmenuExtra", { fg = M.colors.bg, bg = M.colors.green, bold = true } },
			{ "PmenuSel", { bg = "#282C34", fg = "NONE" } },
		},
	}
	utils:create_pmenu()
end

function M.preview()
	vim.cmd("colorscheme " .. O.colorscheme)
end

return M
