require("mini.diff").setup({
	-- view = {
	-- 	style = "sign",
	-- 	signs = { add = [[┃]], change = [[┃]], delete = [[┃]] },
	-- },
})

vim.keymap.set("n", "<leader>gdo", MiniDiff.toggle_overlay, { desc = "MiniDiff toggle overlay" })
vim.keymap.set("n", "<leader>gdf", MiniDiff.toggle_overlay, { desc = "MiniDiff show overlay" })
