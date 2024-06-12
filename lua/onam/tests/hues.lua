local opts = {
	background = "#faf4ed",
	foreground = "#575279",
	accent = "bg",
	saturation = "high",
}

require("mini.hues").setup(opts)
require("onam.helpers.colors.mini_hues").apply_custom_highlights(opts)
-- local setup = require("mini.hues").setup
-- -- setup({ background = "#2f1c22", foreground = "#cdc4c6" }) -- red
-- -- setup({ background = "#2f1c22", foreground = "#cdc4c6" }) -- red
-- -- setup({ background = '#2f1e16', foreground = '#cdc5c1' }) -- orange
-- -- setup({ background = '#282211', foreground = '#c9c6c0' }) -- yellow
-- -- setup({ background = '#1c2617', foreground = '#c4c8c2' }) -- green
-- -- setup({ background = '#112723', foreground = '#c0c9c7' }) -- cyan
-- -- setup({ background = '#11262d', foreground = '#c0c8cc' }) -- azure
-- -- setup({ background = '#1d2231', foreground = '#c4c6cd' }) -- blue
-- -- setup({ background = '#281e2c', foreground = '#c9c5cb' }) -- purple
