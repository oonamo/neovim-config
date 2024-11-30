local is_dark = vim.o.background == "dark"
-- local bg = is_dark and "#101624" or "#cbd5e9"
-- local fg = is_dark and "#c3c7ce" or "#202227"

local bg = is_dark and '#051920' or '#c7d8df'
local fg = is_dark and '#c1c6d4' or '#1e222c'

require("mini.hues").setup({
	background = bg,
	foreground = fg,
	-- Make it "gloomy"
	saturation = is_dark and "lowmedium" or "mediumhigh",
	accent = "azure",
})

vim.g.colors_name = "miniwinter"
