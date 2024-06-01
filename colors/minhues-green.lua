local hues = require("mini.hues")
local opts = {
	background = "#12252e",
	foreground = "#c0c8cc",
	accent = "azure",
}
hues.setup(opts)
require("onam.helpers.colors.mini_hues").apply_custom_highlights(opts)
vim.g.colors_name = "minihues-green"
