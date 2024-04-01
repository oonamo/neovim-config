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
G = {}

require("onam.remap")
require("onam.utils")
require("onam.set")

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
})

require("onam.theme_switcher").init()
utils:create_hl()
