return {
	"stevearc/oil.nvim",
	opts = {},
	-- Optional dependencies
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("oil").setup()
		-- vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
		vim.keymap.set("n", "<leader>e", "<cmd>Oil<cr>", { desc = "Open oil" })
	end,
}
