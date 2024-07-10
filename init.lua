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
vim.opt.rtp:prepend(lazypath)

vim.o.background = "dark"
require("globals")
require("onam.remap")
require("onam.utils")
require("onam.set")
require("onam.plug_opts")
require("onam.autocmds")

require("utils.lazy_file")

---@diagnostic disable-next-line: different-requires
require("lazy").setup({
	spec = {
		{ import = "plugins" },
		{ import = "plugins.lsp" },
		-- { import = "plugins.mini" },
	},
	defaults = {
		lazy = true,
	},
	install = {
		colorscheme = { "tokyonight-moon" },
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
require("onam.statuscolumn")

vim.cmd.colorscheme("catppuccin-mocha")

if vim.g.neovide then
	require("onam.gui")
end
