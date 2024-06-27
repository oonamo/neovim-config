vim.g.colors_name = "lighter"
local opts = {
	background = "#f9f5d7",
	foreground = "#2c2e33",
	plugins = {
		default = true,
		-- ["echasnovski/mini.nvim"] = true,
		-- ["hrsh7th/nvim-cmp"] = true,
	},
	n_hues = 8,
	accent = "red",
	saturation = "high",
}

require("mini.hues").setup(opts)
require("onam.helpers.colors.mini_hues").apply_custom_highlights(opts)
