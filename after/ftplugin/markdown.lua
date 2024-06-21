vim.opt_local.conceallevel = 2
if not vim.g.neovide then
	vim.opt_local.smoothscroll = true
end
vim.keymap.set({ "n", "v" }, "j", "gj", { buffer = true, silent = true })
vim.keymap.set({ "n", "v" }, "k", "gk", { buffer = true, silent = true })
vim.opt_local.nu = false
vim.opt_local.signcolumn = "no"
vim.opt_local.rnu = false
vim.opt_local.spell = true
vim.opt_local.conceallevel = 2
vim.opt_local.breakindent = true
vim.opt_local.breakindentopt = "list:-1"
vim.b.miniindentscope_disable = true
