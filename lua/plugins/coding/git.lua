return {
	{
		"tpope/vim-fugitive",
		keys = {
			{ "<leader>gs", vim.cmd.Git, desc = "[g]it [s]tatus" },
			{ "<leader>ga", "<cmd>Git add %<cr>", desc = "[g]it [a]dd current file" },
			{ "<leader>gc", "<cmd>Git commit<cr>", desc = "[g]it [c]ommit" },
			{ "<leader>gp", "<cmd>Git push<cr>", desc = "[g]it [p]ush" },
			-- { "<leader>gd", "<cmd>Gdiffsplit<cr>", desc = "[g]it [d]iff split" },
		},
		lazy = true,
	},
	{
		"sindrets/diffview.nvim",
		lazy = true,
		keys = { "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "open diffview" },
	},
}
