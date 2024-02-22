vim.loader.enable()
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
print("hello from neovim")

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
-- require("lazy").setup("plugins")
require("lazy").setup({
	{ import = "plugins" },
})
require("onam.color_switcher").setup_persistence()
require("onam.statusline")
require("onam.winbar")

utils:create_hl()
