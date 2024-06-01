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

require("globals")
vim.opt.rtp:prepend(lazypath)
require("onam.remap")
require("onam.utils")
require("onam.set")
require("onam.plug_opts")
require("lazy").setup({
	spec = {
		{ import = "plugins.coding" },
		{ import = "plugins.ui" },
		{ import = "plugins.editor" },
		{ import = "plugins.lsp" },
		{ import = "plugins.dap" },
		{ import = "plugins.writing" },
	},
	change_detection = {
		notify = false,
	},
	ui = {
		backdrop = 80,
		border = tools.ui.cur_border,
		icons = tools.ui.bullet,
	},

	performance = {
		rtp = {
			disabled_plugins = {
				"2html_plugin",
				"getscript",
				"getscriptPlugin",
				"gzip",
				"logipat",
				-- "netrw",
				-- "netrwPlugin",
				-- "netrwSettings",
				-- "netrwFileHandlers",
				"matchit",
				"man",
				--"matchparen",
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

require("onam.autocmds").set_qol()

if vim.g.neovide then
	require("onam.gui")
end

if not O.ui.tree.oil and not O.ui.tree.neotree and not O.ui.tree.mini then
	vim.keymap.set("n", "<leader>e", "<cmd>Ex<CR>", { desc = "explorer" })
end

utils:create_hl()
