local utils = require("onam.utils")
local M = {}

-- c.ui.red = "#E72F1F"
-- c.ui.blue = "#3F8CEA"
-- c.ui.green = "#42AD17"
-- c.ui.yellow = "#E69400"
-- c.ui.purple = "#671FF0"
-- c.ui.cyan = "#21B386"
-- c.ui.orange = "#F0740A"
--
-- c.ui.accent = c.ui.purple
--
-- c.ui.tabline = "#E1E2E4"
-- c.ui.winbar = "#999FA3"
-- c.ui.tool = "#F0F0F1"
-- c.ui.base = "#F7F8F8"
-- c.ui.inactive_base = "#EAEBEB"
-- c.ui.statusline = "#E1E2E4"
-- c.ui.split = "#E8E9EA"
-- c.ui.float = "#E1E2E3"
-- c.ui.title = c.ui.accent
-- c.ui.border = c.ui.accent
-- c.ui.current_line = "#EAEBEB"
-- c.ui.scrollbar = c.ui.accent
-- c.ui.selection = "#E7E9EB"
-- -- TODO: combine menu_selection and selection
-- c.ui.menu_selection = c.ui.selection
-- c.ui.highlight = "#DADBDD"
-- c.ui.none_text = "#B5B9BD"
-- c.ui.text = "#737474"
-- c.ui.text_active = "#424446"
-- c.ui.text_inactive = "#AEB3B6"
-- c.ui.text_match = "#17191C"
-- c.ui.prompt = "#F0F0F1"
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
