local hues = require("mini.hues")
vim.g.colors_name = "minihues-maroon"
local opts = {
	accent = "azure",
	background = "#2c1d28",
	foreground = "#cbc4c9",
}
hues.setup(opts)
require("onam.helpers.colors.mini_hues").apply_custom_highlights(opts)
