local hues = require("mini.hues")
vim.g.colors_name = "minihues-charcoal"
local opts = {
	accent = "azure",
	background = "#181A1F",
	foreground = "#A9B2C3",
}
hues.setup(opts)
require("onam.helpers.colors.mini_hues").apply_custom_highlights(opts)
