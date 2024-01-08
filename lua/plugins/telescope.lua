return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>pf", "<cmd>Telescope find_files<CR>", { desc = "find files", silent = true } },
			{ "<C-p>", "<cmd>Telescope git_files", { desc = "git files", silent = true } },
			{ "<leader>ps", "<cmd>Telescope live_grep<CR>", desc = "search for a string" },
		},
	},
}
