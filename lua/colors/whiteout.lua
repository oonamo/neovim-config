local M = {}
local cmd = vim.cmd

-- setup colors
function M.setup()
	O.colorscheme = "whiteout"
	O.fn = "whiteout"
	O.type = "base16"

	require("mini.base16").setup({
		palette = {
			base00 = "#f7f7f7",
			base01 = "#e3e3e3",
			base02 = "#cccccc",
			base03 = "#ababab",

			base04 = "#525252",
			base05 = "#4c4c4c",
			base06 = "#252525",
			base07 = "#cccccc",
			base08 = "#7c7c7c",
			base09 = "#999999",
			base0A = "#666666",
			base0B = "#8e8e8e",
			base0C = "#868686",

			base0D = "#686868",
			base0E = "#747474",
			base0F = "#5e5e5e",
		},
		plugins = {
			default = true,
		},
	})

	utils.hl = {
		opts = {

			{ "TabLineNorm", { bg = "none", fg = "#999999" } },
			{ "TabLineSel", { bg = "#e3e3e3", fg = "#555555" } },
			{ "TabLineFill", { bg = "none" } },
			{ "LspReferenceText", { bg = "#e5e5e5" } },
			{ "LspReferenceWrite", { bg = "#e5e5e5" } },
			{ "LspReferenceRead", { bg = "#e5e5e5" } },
			{ "TSKeyword", { italic = true } },
			{ "TSKeywordFunction", { italic = true } },
			{ "TSRepeat", { italic = true } },
			{ "TSKeywordOperator", { italic = true } },
			{ "TSConditional", { italic = true } },
			{ "TSProperty", { italic = true } },
			{ "MatchParen", { bg = "#cccccc" } },
			{ "TelescopeBorder", { fg = "#ababab" } },
			{ "TelescopeTitle", { fg = "#4c4c4c" } },
		},
	}

	vim.g.colors_name = "whiteout"
end

M.colors = {
	fg = "#000000",
	bg = "#4c4c4c",
	accent = "#cccccc",
	lightbg = "#cccccc",

	fgfaded = "#999999",
	grey = "#000000",
	light_grey = "#000000",
	dark_grey = "#000000",
	bright = "#000000",
	red = "#cccccc",
	green = "#cccccc",
	blue = "#cccccc",
	yellow = "#cccccc",
	magenta = "#cccccc",
	orange = "#cccccc",
	cyan = "#cccccc",
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
			{ "StatusEmpty", { link = "StatusLine" } },
			{ "StatusBarLong", { link = "StatusLine" } },
			{ "HarpoonInactive", { link = "StatusBarLong" } },
		},
	}

	utils:create_statusline()
end

return M
