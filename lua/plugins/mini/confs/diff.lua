require("mini.diff").setup()

vim.keymap.set("n", "<leader>gdo", MiniDiff.toggle_overlay, { desc = "MiniDiff toggle overlay" })
vim.keymap.set("n", "<leader>gdf", MiniDiff.toggle_overlay, { desc = "MiniDiff show overlay" })
