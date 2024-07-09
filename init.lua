vim.loader.enable()

-- TODO: Script to delete lsp.log every so often
-- TODO: Watch https://github.com/neovim/neovim/issues/8587

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
require("utils.lazy")
require("globals")
require("onam.remap")
require("onam.utils")
require("onam.set")
require("onam.plug_opts")
require("onam.autocmds")

---@diagnostic disable-next-line: different-requires
require("lazy").setup({
	spec = {
		{ import = "plugins.coding" },
		{ import = "plugins.editor" },
		{ import = "plugins.lsp" },
		{ import = "plugins.writing" },
		{ import = "plugins.mini" },
		{ import = "plugins.dev" },
	},
	defaults = {
		lazy = true,
	},
	install = {
		colorscheme = { "tokyonight-night" },
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

-- LIGHT:
-- vim.cmd.colorscheme("newpaper-light")
-- vim.cmd.colorscheme("light-ambition")
-- vim.cmd.colorscheme("lighter")
-- vim.cmd.colorscheme("lovefox")

-- DARK:
-- vim.cmd.colorscheme("ambition")
-- vim.cmd.colorscheme("brown_ambition")
-- vim.cmd.colorscheme("retrobox")
vim.cmd.colorscheme("catppuccin-mocha")
-- vim.cmd.colorscheme("minimal")
-- vim.cmd.colorscheme("kopicat")
-- vim.cmd.colorscheme("ice-cave")
-- vim.cmd.colorscheme("sunbather")
-- vim.cmd.colorscheme("seoul256-sharp")
-- vim.cmd.colorscheme("seoul256-dull")
-- vim.cmd.colorscheme("pink-moon-dark")
-- vim.cmd.colorscheme("sierra")
-- vim.cmd.colorscheme("blie")
-- vim.cmd.colorscheme("lavi")
-- vim.cmd.colorscheme("grei")

if vim.g.neovide then
	require("onam.gui")
end
