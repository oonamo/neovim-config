local M = {}
M.type = "base16"

function M.setup()
	O.fn = "cafe"
	O.type = "base16"
	O.colorscheme = "cafe"
	-- local palette = require("mini.base16").mini_palette("#ece4dc", "#514c47", 100)
	-- M.colors = palette
	-- require("mini.base16").setup({
	-- 	palette = palette,
	-- })
	require("mini.base16").setup({
		palette = {
			base00 = "#ece4dc",
			base01 = "#cbc3bb",
			base02 = "#aba49c",
			base03 = "#8d857d",
			base04 = "#9c968f",
			base05 = "#514c47",
			base06 = "#9c968f",
			base07 = "#685c56",
			base08 = "#a4bdc2",
			base09 = "#afbf9a",
			base0A = "#5b528d",
			base0B = "#b56277",
			base0C = "#87858c",
			base0D = "#8e9f8c",
			base0E = "#fac20b",
			base0F = "#f56300",
		},
		plugins = {
			default = true,
		},
	})

	-- utils.hl = {
	-- 	opts = {
	-- 		{ "TabLineSel", { bg = "#e9e4e2", fg = "#26363c" } },
	-- 		{ "TabLineNorm", { bg = "#F0EDEC", fg = "#948985" } },
	-- 		{ "TabLineFill", { bg = "#F0EDEC" } },
	-- 		{ "TelescopeBorder", { fg = "#e9e4e2" } },
	-- 		{ "TelescopeTitle", { fg = "#948985" } },
	-- 		{ "TSPunctBracket", { fg = "#685c56" } },
	--
	-- 		{ "TSConstructor", { fg = "#685c56" } },
	-- 		{ "MatchParen", { bg = "#e5d9d7" } },
	-- 		{ "TSKeyword", { italic = true } },
	-- 		{ "TSConditional", { italic = true } },
	-- 		{ "TSString", { italic = true } },
	-- 	},
	-- }
	--
	-- vim.g.colors_name = "cafe"
	-- utils:create_hl()
	vim.g.colors_name = "offwhite"
end

M.colors = {
	base00 = "#ece4dc",
	base01 = "#cbc3bb",
	base02 = "#aba49c",
	base03 = "#8d857d",
	base04 = "#9c968f",
	base05 = "#514c47",
	base06 = "#9c968f",
	base07 = "#685c56",
	base08 = "#a4bdc2",
	base09 = "#afbf9a",
	base0A = "#5b528d",
	base0B = "#b56277",
	base0C = "#87858c",
	base0D = "#8e9f8c",
	base0E = "#fac20b",
	base0F = "#f56300",
}
-- function M.setup_status()
-- utils.statuscolors = {
-- 	opts = {
-- 		{ "StatuslineAccent", { fg = M.colors.bg, bg = M.colors.accent or M.colors.magenta } },
-- 		{ "StatuslineInsertAccent", { fg = M.colors.bg, bg = M.colors.red } },
-- 		{ "StatuslineVisualAccent", { fg = M.colors.bg, bg = M.colors.green } },
-- 		{ "StatuslineReplaceAccent", { fg = M.colors.bg, bg = M.colors.red } },
-- 		{ "StatuslineCmdLineAccent", { fg = M.colors.bg, bg = M.colors.yellow } },
-- 		{ "StatuslineTerminalAccent", { fg = M.colors.bg, bg = M.colors.yellow } },
-- 		{ "StatusLineExtra", { fg = M.colors.fgfaded } },
-- 		{ "StatusLineNC", { bg = "none" } },
-- 		--Start Custom
-- 		-- { "StatusLineExtra", { link = "MatchParen" } },
-- 		-- { "StatuslineAccent", { link = "DiffAdd" } },
-- 		-- { "StatuslineInsertAccent", { link = "StorageClass" } },
-- 		-- { "StatuslineVisualAccent", { link = "Define" } },
-- 		-- { "StatuslineReplaceAccent", { link = "Define" } },
-- 		-- { "StatuslineCmdLineAccent", { link = "Define" } },
-- 		-- { "StatuslineTerminalAccent", { link = "Define" } },
-- 		{ "StatusEmpty", { link = "StatusLineExtra" } },
-- 		{ "StatusBarLong", { link = "StatusLineExtra" } },
-- 		{ "HarpoonInactive", { link = "StatusBarLong" } },
-- 	},
-- }
--
-- 	utils:create_statusline()
-- end

return M
