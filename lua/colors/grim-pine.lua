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
			{ "String", { fg = M.colors.yellow } },
			{ "Special", { fg = M.colors.green } },
			{ "Macro", { fg = M.colors.green, bg = "#262626" } },
			{ "Constant", { fg = M.colors.orange } },
			{ "@variable", { fg = M.colors.text } },
			{ "Directory", { fg = M.colors.blue } },
			{ "OilFile", { fg = M.colors.text } },
		},
	}
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
			-- { "Pmenu", { fg = "#C5CDD9", bg = "#22252A" } },
			--
		},
	}

	utils:create_pmenu()
end

return M
