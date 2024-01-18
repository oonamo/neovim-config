return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files theme=dropdown<CR>", { desc = "find files", silent = true } },
			{ "<C-p>", "<cmd>Telescope git_files theme=dropdown<CR>", { desc = "git files", silent = true } },
			{ "<leader>fs", "<cmd>Telescope live_grep<CR>", desc = "search for a string" },
		},
	},
}
