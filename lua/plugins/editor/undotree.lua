return {
	{
		"mbbill/undotree",
		config = function()
			vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<CR>", { desc = "[u]ndotree UI" })
		end,
		keys = { { "<leader>u" } },
	},
}
