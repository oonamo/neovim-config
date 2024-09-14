vim.g.mapleader = " "
vim.g.maplocalleader = ";"
vim.o.background = "dark"
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

require("colors")
require("config.colors")

_G.O = {
	harpoon = false,
	arrow = true,
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
		noice = false,
		signature = "lsp_signature",
		clues = true,
		saturate = true,
		show_open_folds = false,
		use_githl = false,
		debug = false,
		-- colorscheme = "rose-pine",
		colorscheme = { "cat-colors", "everlike-mocha" },
		select = "telescope",
	},
}

vim.o.background = O.ui.background or "dark"

if O.ui.colorscheme ~= nil then
	if type(O.ui.colorscheme) == "table" then
		Colors.set_active(O.ui.colorscheme[1], O.ui.colorscheme[2])
	elseif type(O.ui.colorscheme) == "string" then
		if O.ui.colorscheme == "default" then
			vim.cmd.colorscheme("default")
		end
		Colors.set_active(O.ui.colorscheme)
	else
		vim.schedule(function()
			O.ui.colorscheme()
		end)
	end
else
	vim.schedule(function()
		vim.cmd.colorscheme("tokyonight")
	end)
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
		{ import = "plugins.lsp" },
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
				-- "matchparen",
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
