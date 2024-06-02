local hues = require("mini.hues")
local opts = {
	background = "#1a1b25",
	foreground = "#c0c8cb",
	accent = "blue",
	saturation = "high",
}
hues.setup(opts)
require("onam.helpers.colors.mini_hues").apply_custom_highlights(opts)
