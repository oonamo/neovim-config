return {
	{
		"christoomey/vim-tmux-navigator",
		keys = {
			{ "n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>", desc = "window left" },
			{ "n", "<C-j>", "<cmd> TmuxNavigateDown<CR>", desc = "window down" },
			{ "n", "<C-k>", "<cmd> TmuxNavigateUp<CR>", desc = "window up" },
			{ "n", "<C-l>", "<cmd> TmuxNavigateRight<CR>", desc = "window right" },
		},
		lazy = false,
	},
}
