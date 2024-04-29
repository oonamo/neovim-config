local utils = require("onam.utils")
local M = {}
function M.setup(flavour)
	vim.cmd.hi("clear")
	vim.opt.cursorline = true
	if flavour == "astrolight" then
		vim.o.background = "light"
	else
		vim.o.background = "dark"
	end
	-- require("astrotheme").setup({
	-- 	palette = flavour,
	-- 	background = { -- :h background, palettes to use when using the core vim background colors
	-- 		light = "astrolight",
	-- 		dark = "astrodark",
	-- 	},
	-- 	palettes = {
	-- 		astrolight = {
	-- 			ui = {
	-- 				base = "#feeeee",
	-- 			},
	-- 		},
	-- 	},
	--
	-- 	style = {
	-- 		transparent = false, -- Bool value, toggles transparency.
	-- 		inactive = true, -- Bool value, toggles inactive window color.
	-- 		float = true, -- Bool value, toggles floating windows background colors.
	-- 		neotree = false, -- Bool value, toggles neo-trees background color.
	-- 		border = true, -- Bool value, toggles borders.
	-- 		title_invert = true, -- Bool value, swaps text and background colors.
	-- 		italic_comments = true, -- Bool value, toggles italic comments.
	-- 		simple_syntax_colors = true, -- Bool value, simplifies the amounts of colors used for syntax highlighting.
	-- 	},
	-- })
	-- utils.hl = {
	-- 	opts = {
	-- 		{ "Normal", { bg = "#F7F8F8" } },
	-- 	},
	-- }
	vim.api.nvim_set_hl(0, "CursorLine", {})
	vim.cmd.colorscheme(flavour)
	utils:create_hl()
end
return M
