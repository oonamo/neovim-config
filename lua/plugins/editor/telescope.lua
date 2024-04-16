return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		cmd = "Telescope",
		lazy = true,
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			pickers = {
				find_files = {
					theme = "dropdown",
					previewer = true,
					hidden = true,
				},
				live_grep = {
					theme = "dropdown",
					previewer = false,
				},
				buffers = {
					theme = "dropdown",
					previewer = false,
				},
			},
		},
		-- cond = not vim.g.use_FZF,
		-- keys = {
		-- 	{ "<leader>ff", "<cmd>Telescope find_files <CR>", { desc = "find files", silent = true } },
		-- 	{ "<C-p>", "<cmd>Telescope git_files <CR>", { desc = "git files", silent = true } },
		-- 	{ "<leader>fs", "<cmd>Telescope live_grep<CR>", desc = "search for a string" },
		-- 	{ "<leader>g?", "<cmd>Telescope help_tags<CR>", desc = "help" },
		-- },
	},
}
