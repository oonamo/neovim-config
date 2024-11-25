local is_dark = vim.o.background == "dark"
local bg = is_dark and "#101624" or "#cbd5e9"
local fg = is_dark and "#c3c7ce" or "#202227"

require("mini.hues").setup({
	background = bg,
	foreground = fg,
	-- Make it "gloomy"
	saturation = is_dark and "lowmedium" or "mediumhigh",
	accent = "azure",
})

vim.g.colors_name = "miniwinter"
