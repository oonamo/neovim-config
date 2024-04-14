vim.loader.enable()
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)
vim.g.MUtils = {}
require("globals")
require("onam.remap")
require("onam.utils")
require("onam.set")
require("onam.plug_opts")

require("lazy").setup({
	spec = {
		{ import = "plugins.ui" },
		{ import = "plugins.writing" },
		{ import = "plugins.coding" },
		{ import = "plugins.editor" },
		{ import = "plugins.lsp" },
	},
	change_detection = {
		notify = false,
	},
	ui = {
		backdrop = 80,
		border = tools.ui.cur_border,
		icons = tools.ui.bullet,
	},
})

require("onam.autocmds").set_qol()
require("onam.theme_switcher").init()

if not O.ui.tree.oil and not O.ui.tree.neotree then
	vim.keymap.set("n", "<leader>e", "<cmd>Ex<CR>", { desc = "explorer" })
end
utils:create_hl()
