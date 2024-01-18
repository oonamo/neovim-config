return {
	{
		"mbbill/undotree",
		config = function()
			vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<CR>", { desc = "toggle undotree UI" })
		end,
		keys = { { "<leader>u" } },
	},
}
