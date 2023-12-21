return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>pf", "<cmd>Telescope find_files<CR>", desc = "find files" },
			{ "<C-p>", "<cmd>Telescope git_files", desc = "find git_files" },
			{ "<leader>ps", "<cmd>Telescope live_grep<CR>", desc = "search for a string" },
		},
	},
}
