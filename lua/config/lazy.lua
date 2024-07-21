vim.g.mapleader = " "
vim.g.maplocalleader = ";"
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

local function load(name)
	local function _load(mod)
		if require("lazy.core.cache").find(mod)[1] then
			local ok, _ = pcall(require, mod)
			if not ok then
				vim.notify("error loading " .. mod)
			end
		end
	end
	_load("config." .. name)
end

local load_augroups = vim.fn.argc(-1) == 0
if load_augroups then
	load("autocommands")
end

_G.O = {
	lsp = {
		cmp = true,
		mini = false,
	},
	ui = {
		transparency = {
			enable = false,
			exclude_list = {
				"patana",
			},
		},
		indent = {
			mini = true,
		},
		signature = "custom",
		clues = true,
		saturate = true,
		show_open_folds = false,
		use_githl = false,
		debug = false,
		colorscheme = { "nightfox", "dusk" },
		-- colorscheme = vim.schedule_wrap(function()
		-- 	vim.cmd.colorscheme("duskfox")
		-- end),
		select = "mini.pick",
	},
}

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
		require("onam.statuscolumn")
		if O.ui.colorscheme ~= nil then
			if type(O.ui.colorscheme) == "table" then
				-- vim.cmd.colorscheme(O.ui.colorscheme)
				vim.schedule(function()
					Colors.get_color(O.ui.colorscheme[1]):apply(O.ui.colorscheme[2])
				end)
			elseif type(O.ui.colorscheme) == "string" then
				vim.schedule(function()
					-- vim.cmd.colorscheme(O.ui.colorscheme)
					Colors.get_color(O.ui.colorscheme):apply()
				end)
			else
				O.ui.colorscheme()
			end
		else
			vim.schedule(function()
				vim.cmd.colorscheme("tokyonight")
			end)
		end

		if O.ui.select == "dropbar" then
			vim.ui.select = require("dropbar.utils.menu").select
		else
			vim.ui.select = require("mini.pick").ui_select
		end

		if vim.g.neovide then
			load("gui")
		end
	end,
})

require("lazy").setup({
	spec = {
		{ import = "plugins" },
		{ import = "plugins.lsp" },
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
