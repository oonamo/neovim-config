vim.keymap.set("n", "<leader>lh", "<cmd>ClangdSwitchSourceHeader<cr>", {
	desc = "go to header file",
})

vim.keymap.set("n", "<leader>ls", function()
	vim.cmd.vsplit()
  vim.cmd.ClangdSwitchSourceHeader()
end)

vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.opt_local.shiftwidth = 2
