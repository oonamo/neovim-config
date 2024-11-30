local is_dark = vim.o.background == "dark"
-- local bg = is_dark and "#352d1d" or "#ece2cd"
-- local fg = is_dark and "#e6e2db" or "#302e29"
local bg = is_dark and '#2b1f1a' or '#efdfd8'
local fg = is_dark and '#ded2c7' or '#352c24'

require("mini.hues").setup({
	background = bg,
	foreground = fg,
	saturation = is_dark and "medium" or "high",
	accent = "orange",
})

vim.g.colors_name = "minisummer"
