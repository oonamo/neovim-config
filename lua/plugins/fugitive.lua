return {
	"tpope/vim-fugitive",
	keys = {
		{ "<leader>gs", vim.cmd.Git, { desc = "git status" } },
		{ "<leader>ga", "<cmd>Git add %<cr>", { desc = "git add current file" } },
		{ "<leader>gc", "<cmd>Git commit<cr>", { desc = "git commit" } },
		{ "<leader>gp", "<cmd>Git push<cr>", { desc = "git push" } },
		{ "<leader>gd", "<cmd>Gdiffsplit<cr>", { desc = "git diff split" } },
	},
}
