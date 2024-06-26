local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.notify("Downloading lazy...")
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.o.background = "dark"
vim.opt.rtp:prepend(lazypath)

require("globals")
require("onam.remap")
require("onam.utils")
require("onam.set")
require("onam.plug_opts")
require("onam.autocmds")
require("lazy").setup({
	spec = {
		{ import = "plugins.coding" },
		{ import = "plugins.editor" },
		{ import = "plugins.lsp" },
		{ import = "plugins.writing" },
		{ import = "plugins.mini" },
	},
	defaults = {
		lazy = true,
	},
	install = {
		colorscheme = { "ambition" },
	},
	change_detection = {
		notify = false,
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"2html_plugin",
				"getscript",
				"getscriptPlugin",
				"gzip",
				"logipat",
				"netrw",
				"netrwPlugin",
				"netrwSettings",
				"netrwFileHandlers",
				"matchit",
				"man",
				"matchparen",
				"tar",
				"tarPlugin",
				"rrhelper",
				"vimball",
				-- "health",
				"shada",
				-- "spellfile",
				"tohtml",
				"tutor",
				"vimballPlugin",
				"zip",
				"zipPlugin",
				"rplugin",
			},
		},
	},
})

-- LIGHT:
-- vim.cmd.colorscheme("newpaper-light")
-- vim.cmd.colorscheme("light-ambition")
-- vim.cmd.colorscheme("lighter")
-- vim.cmd.colorscheme("lovefox")

-- DARK:
-- vim.cmd.colorscheme("ambition")
-- vim.cmd.colorscheme("brown_ambition")
-- vim.cmd.colorscheme("retrobox")
-- vim.cmd.colorscheme("catppuccin-mocha")

if vim.g.neovide then
	require("onam.gui")
end
