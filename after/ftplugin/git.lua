vim.cmd('setlocal foldmethod=expr foldexpr=v:lua.MiniGit.diff_foldexpr() foldlevel=-1 nornu nonu')

vim.keymap.set("n", "q", "<cmd>close<cr>", { desc = "Close window", buffer = true })
vim.keymap.set("n", "<esc>", "<cmd>close<cr>", { desc = "Close window", buffer = true })
