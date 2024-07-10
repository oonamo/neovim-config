require("mini.bufremove").setup()

vim.keymap.set("n", "<leader>bd", MiniBufremove.delete, { desc = "delete buffer" })
