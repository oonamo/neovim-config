return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local prime_pine = require("lualine.themes.rose-pine")
			local harpoon_list_ext = require("onam.harpoon_list_ext")
			local autocmds = require("onam.autocmds")

			autocmds.setup_status_cmds()
			harpoon_list_ext.setup_autocmds()
			prime_pine.normal.c.bg = "#d4a38d"

			require("lualine").setup({
				options = {
					theme = "auto",
					globalstatus = true,
					section_separators = "",
					component_separators = "",
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "filename" },
					lualine_c = { "diagnostics" },
					lualine_x = { harpoon_list_ext.harpoon_list_as_statusline },
					lualine_y = {},
				},
			})
		end,
		enabled = not vim.g.use_custom_statusline,
	},
}
