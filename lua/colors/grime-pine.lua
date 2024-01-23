local M = {}

M.colors = {
	green = "#6f8787", -- functions, @keyword
	l_green = "#5487af", -- conditionals, Keyword
	string = "#d7af87", -- Strings
	orange = "#ffaf87", -- Constant
	l_greens = "#afd7d7", -- Special
	red = "#ffafd7", -- function names
	l_red = "#d7afd7", -- Macros
	text = "#d7d7ff", -- variables
	bg = "#1c1c1c",
}
function M.setup()
	require("mini.base16").setup({
		palette = {
			base00 = M.colors.bg, -- background
			base01 = M.colors.l_green, -- ligher background
			base02 = M.colors.blue, -- selection bg
			base03 = M.colors.cyan, -- comments, non-code
			base04 = M.colors.bg, -- dark foreground
			base05 = M.colors.gray, -- foreground
			base06 = M.colors.gray, -- light foreground
			base07 = M.colors.gray, -- light foreground
			base08 = M.colors.magenta, -- variables
			base09 = M.colors.green, -- int, bool, constants

			base0A = M.colors.gray, -- classes
			base0B = M.colors.red, -- strings
			base0C = M.colors.yellow, -- support, regex, links
			base0D = M.colors.blue, -- functions
			base0E = M.colors.magenta, -- keywords
			base0F = M.colors.red, -- tags, deprecated
		},
	})
end

return M
