local M = {}
M.type = "base16"

function M.setup()
	O.fn = "cafe"
	O.type = "base16"
	O.colorscheme = "cafe"
	require("mini.base16").setup({
		palette = {
			base00 = "#F0EDEC",
			base01 = "#e9e4e2",
			base02 = "#cbd9e3",
			base03 = "#948985",
			base04 = "#8e817b",
			base05 = "#685c56",
			base06 = "#ffffff",
			base07 = "#e9e4e2",
			base08 = "#685c56",

			base09 = "#88507d",
			base0A = "#A8334C",
			base0B = "#597a37",
			base0C = "#685c56",
			base0D = "#a8623e",
			base0E = "#A8334C",
			base0F = "#4f5e68",
		},
		plugins = {
			default = true,
		},
	})

	utils.hl = {
		opts = {
			{ "TabLineSel", { bg = "#e9e4e2", fg = "#26363c" } },
			{ "TabLineNorm", { bg = "#F0EDEC", fg = "#948985" } },
			{ "TabLineFill", { bg = "#F0EDEC" } },
			{ "TelescopeBorder", { fg = "#e9e4e2" } },
			{ "TelescopeTitle", { fg = "#948985" } },
			{ "TSPunctBracket", { fg = "#685c56" } },

			{ "TSConstructor", { fg = "#685c56" } },
			{ "MatchParen", { bg = "#e5d9d7" } },
			{ "TSKeyword", { italic = true } },
			{ "TSConditional", { italic = true } },
			{ "TSString", { italic = true } },
		},
	}

	vim.g.colors_name = "cafe"
	utils:create_hl()
end

M.colors = {
	fg = "#685c56",
	bg = "#F0EDEC",
	accent = "#685c56",

	lightbg = "#e9e4e2",
	fgfaded = "#948985",

	grey = "#948985",
	light_grey = "#948985",
	dark_grey = "#383432",

	bright = "#ffffff",
	red = "#A8334C",
	green = "#597a37",
	blue = "#286486",

	yellow = "#a8623e",
	magenta = "#88507D",

	orange = "#944927",
	cyan = "#3B8992",
	ViMode = {
		Normal = "#26363c",
	},
}

function M.setup_status()
	utils.statuscolors = {
		opts = {
			{ "StatuslineAccent", { fg = M.colors.bg, bg = M.colors.accent or M.colors.magenta } },
			{ "StatuslineInsertAccent", { fg = M.colors.bg, bg = M.colors.red } },
			{ "StatuslineVisualAccent", { fg = M.colors.bg, bg = M.colors.green } },
			{ "StatuslineReplaceAccent", { fg = M.colors.bg, bg = M.colors.red } },
			{ "StatuslineCmdLineAccent", { fg = M.colors.bg, bg = M.colors.yellow } },
			{ "StatuslineTerminalAccent", { fg = M.colors.bg, bg = M.colors.yellow } },
			{ "StatusLineExtra", { fg = M.colors.fgfaded } },
			{ "StatusLineNC", { bg = "none" } },
			--Start Custom
			-- { "StatusLineExtra", { link = "MatchParen" } },
			-- { "StatuslineAccent", { link = "DiffAdd" } },
			-- { "StatuslineInsertAccent", { link = "StorageClass" } },
			-- { "StatuslineVisualAccent", { link = "Define" } },
			-- { "StatuslineReplaceAccent", { link = "Define" } },
			-- { "StatuslineCmdLineAccent", { link = "Define" } },
			-- { "StatuslineTerminalAccent", { link = "Define" } },
			{ "StatusEmpty", { link = "StatusLineExtra" } },
			{ "StatusBarLong", { link = "StatusLineExtra" } },
			{ "HarpoonInactive", { link = "StatusBarLong" } },
		},
	}

	utils:create_statusline()
end

return M
