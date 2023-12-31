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

require("onam.remap")
require("onam.utils")
require("onam.set") -- Set before theme and stausline
require("lazy").setup("plugins")
require("onam.color_switcher").setup_persistence()
require("onam.statusline")
-- require("highlights") -- Set after theme and statusline

utils:create_hl()
