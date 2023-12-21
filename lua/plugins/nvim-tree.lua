return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		keys = { "<leader>pt", "<cmd>Neotree toggle<CR>", desc = "Launch NeoTree" },
	},
}
-- vim.keymap.set("n", "<leader>pt", vim.cmd.Neotree, {
-- 	desc = "Launch NeoTree",
-- })
