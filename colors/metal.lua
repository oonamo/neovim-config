require("mini.base16").setup({
	palette = {
		base00 = "#080808", -- default bg
		base01 = "#121212", -- line number bg
		base02 = "#444444", -- statusline bg, selection bg
		base03 = "#767676", -- line number fg, comments
		base04 = "#eeeeee", -- statusline fg
		base05 = "#eeeeee", -- default fg
		base06 = "#eeeeee", -- light fg (not often used)
		base07 = "#eeeeee", -- light bg (not often used)
		base08 = "#ffd7ff", -- statements, identifiers
		base09 = "#d7afff", -- integers, booleans, constants
		base0A = "#ffffd7", -- classes, search highlights
		base0B = "#afd787", -- strings
		base0C = "#afd7ff", -- builtins
		base0D = "#d7ffff", -- functions
		base0E = "#afffaf", -- keywords
		base0F = "#8a8a8a", -- punctuation, regex, indentscope
	},
})
