vim.g.colors_name = "test"
local opts = {}
if vim.o.background == "dark" then
	opts = {
		background = "#24273a",
		foreground = "#cad3f5",
		plugins = {
			default = false,
			["echasnovski/mini.nvim"] = true,
			["hrsh7th/nvim-cmp"] = true,
		},
		accent = "bg",
		saturation = "medium",
	}
else
	opts = {
		background = "#eff1f5",
		foreground = "#2c2e33",
		plugins = {
			default = false,
			["echasnovski/mini.nvim"] = true,
			["hrsh7th/nvim-cmp"] = true,
		},
		accent = "bg",
		saturation = "high",
	}
end

require("mini.hues").setup(opts)
require("onam.helpers.colors.mini_hues").apply_custom_highlights(opts)
