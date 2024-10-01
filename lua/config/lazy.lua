vim.g.mapleader = " "
vim.g.maplocalleader = ";"
vim.loader.enable()

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

---@diagnostic disable-next-line: undefined-field
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

local function load(name, not_config)
	local function _load(mod)
		if require("lazy.core.cache").find(mod)[1] then
			local ok, _ = pcall(require, mod)
			if not ok then
				vim.notify("error loading " .. mod)
			end
		end
	end
	if not_config then
		_load(name)
	else
		_load("config." .. name)
	end
end

local load_augroups = vim.fn.argc(-1) == 0
if load_augroups then
	load("autocommands", true)
end

require("onam.utils")
require("utils.lazy_file")

vim.api.nvim_create_autocmd("User", {
	group = vim.api.nvim_create_augroup("Config", { clear = true }),
	pattern = "VeryLazy",
	callback = function()
		if load_augroups then
			load("autocommands")
		end
		load("globals")
		load("keymaps")
		load("options")
		-- require("onam.statuscolumn")
		-- require("onam.statusline")

		if O.ui.select == "dropbar" then
			vim.ui.select = require("dropbar.utils.menu").select
		else
			-- vim.ui.select = require("mini.pick").ui_select
		end

		if vim.g.neovide then
			load("gui")
		end
	end,
})

require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
	defaults = {
		lazy = true,
	},
	install = {
		colorscheme = { "melange" },
	},
	change_detection = {
		notify = false,
	},
	git = {
		timeout = 1000,
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
				-- "shada",
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
