return {
	{
		"MeanderingProgrammer/markdown.nvim",
		name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		ft = { "markdown" },
		opts = {
			headings = { "❯", "❯", "❯", "❯", "❯", "❯" },
			bullet = "",
		},
	},
	{
		"dhruvasagar/vim-table-mode",
		ft = { "markdown" },
		keys = { "<leader>tm" },
	},
	{
		"jbyuki/nabla.nvim",
		ft = { "markdown" },
		config = function()
			local nabla_float_grp = vim.api.nvim_create_augroup("nabla_float", { clear = true })
			vim.api.nvim_create_autocmd("CursorHold", {
				callback = function()
					require("nabla").popup()
				end,
				group = nabla_float_grp,
			})
		end,
		keys = {
			{
				"<leader>nt",
				function()
					require("nabla").popup()
				end,
				desc = "nabla",
			},
			{
				"<leader>nv",
				function()
					require("nabla").toggle_virt({ align_center = true })
				end,
				desc = "nabla",
			},
		},
	},
}
