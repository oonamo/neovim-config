return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local prime_pine = require("lualine.themes.rose-pine")

			prime_pine.normal.c.bg = "#d4a38d"

			require("lualine").setup({
				options = {
					theme = "auto",
					globalstatus = true,
				},
				sections = {
					lualine_a = { "mode" },
				},
			})
		end,
		enabled = false,
	},
}
