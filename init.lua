-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= -1 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end

if vim.fn.exists('syntax_on') ~= 1 then vim.cmd('syntax enable') end
require("functions")

if vim.fn.has("win32") then
  _G.platform_specific = { lineending = "\r\n" }
else
	_G.platform_specific = { lineending = "\n" }
end

-- vim.o.shell = "pwsh"
-- vim.o.shellcmdflag =
-- 	"-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8; $PSStyle.OutputRendering = [System.Management.Automation.OutputRendering]::PlainText;"
-- vim.o.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait"
-- vim.o.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
-- vim.o.shellquote = ""
-- vim.o.shellxquote = ""

vim.opt.rtp:prepend(lazypath)
-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = ";"
local o, opt = vim.o, vim.opt
vim.o.shada = "'100,<50,s10,:1000,/100,@100,h"

o.background = "dark"
o.guicursor = ""

o.title = true
o.titlestring = "nvim"
o.completeopt = "menu,menuone,noselect,popup"
o.completeslash = "slash"
o.cmdheight = 1

vim.g.bigfile_size = 1024 * 1024 * 1.5 -- 1.5 MB
vim.o.lazyredraw = true

-- Relative line numbers
opt.nu = true
opt.rnu = false

-- set tab stop at 4
opt.tabstop = 2
opt.softtabstop = 2
opt.expandtab = true

-- autoindent
opt.smartindent = true
opt.shiftwidth = 2

-- smarter breaking
-- o.breakindent = true

-- better searching
o.inccommand = "split"
o.incsearch = true
o.hlsearch = true
o.ignorecase = true
o.smartcase = true

-- disable wrap
opt.wrap = false

-- better splitting
o.splitkeep = "screen"
o.splitbelow = true
o.splitright = true

-- set completion options
-- opt.completeopt = { "menu", "menuone", "noselect" }

-- set signcolumn
opt.signcolumn = "yes"

o.emoji = true

-- Editor
o.showmode = false
opt.scrolloff = 8
o.updatetime = 1000
o.timeoutlen = 500
o.ttimeoutlen = 10
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.wildoptions = "tagfile"
opt.wildmenu = true
o.makeprg = "just"
opt.laststatus = 2 -- Or 3 for global statusline
opt.foldlevel = 99
o.foldmethod = "expr"
o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
o.foldtext = ""
o.list = false
-- o.listchars = table.concat({ "extends:…", "nbsp:␣", "precedes:…", "tab:> " }, ",")
o.fillchars = [[eob: ,vert:▕,vertleft:🭿,vertright:▕,verthoriz:🭿,horiz:▁,horizdown:▁,horizup:▔]]
o.virtualedit = "block"
o.shortmess = "tacstFOSWCo"
o.formatoptions = "rqnl1j"
o.cmdwinheight = 4
opt.iskeyword:append("-")
opt.complete:append("kspell")
o.spelloptions = "camel"
-- credit: https://github.com/nicknisi/dotfiles/blob/1360edda1bbb39168637d0dff13dd12c2a23d095/config/nvim/init.lua#L73
-- if ripgrep installed, use that as a grepper
-- o.grepprg = "rg --vimgrep --color=never --with-filename --line-number --no-heading --smart-case --"
o.grepprg = [[rg --glob !.git --no-heading --with-filename --line-number --vimgrep --follow $*]]
o.grepformat = "%f:%l:%c:%m,%f:%l:%m"

vim.g.netrw_banner = 0
vim.g.netrw_mouse = 2

o.cursorline = true
o.cursorlineopt = "screenline,number"
o.winblend = 0
o.pumblend = 0
o.jumpoptions = "stack,clean"

vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

vim.api.nvim_create_autocmd("User", {
	group = vim.api.nvim_create_augroup("Config", { clear = true }),
	pattern = "VeryLazy",
	callback = function()
		require("config.autocommands")
		require("config.statuscolumn")
		require("config.keymaps")
		-- require("moody")
		vim.o.statuscolumn = "%!v:lua.require('config.statuscolumn').statuscolumn()"
		_G.Compile_mode = require("tests.compile_mode")
		if vim.g.neovide or vim.g.goneovim then
			require("config.gui")
		end
	end,
})

-- Setup lazy.nvim
require("lazy").setup({
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "catppuccin" } },
	spec = { import = "plugins" },
	-- automatically check for plugin updates
	checker = { notify = false },
	defaults = {
		lazy = true,
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
				-- "matchit",
				"man",
				-- "matchparen",
				"tar",
				"tarPlugin",
				"rrhelper",
				"vimball",
				"netrw",
				"netrwPlugin",
				"netrwSettings",
				"netrwFileHandlers",
				"health",
				"shada",
				"spellfile",
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

if not vim.g.colors_name or vim.g.colors_name == "" then
	-- vim.cmd.colorscheme("ef-arbutus")
	-- vim.cmd.colorscheme("ef-winter")
	vim.cmd.colorscheme("ef-dream")
	if vim.o.bg == "light" then
		vim.cmd.colorscheme("ef-spring")
	else
		-- vim.cmd.colorscheme("catppuccin")
		-- vim.cmd.colorscheme("ef-dream")
	end
	-- vim.cmd.colorscheme("metal")
	-- vim.cmd.colorscheme("oxocarbon")
	-- vim.cmd.colorscheme("tokyonight-moon")
	-- vim.cmd.colorscheme("minispring")
	-- vim.cmd.colorscheme("tokyonight")
	-- vim.cmd.colorscheme("solarized_osaka")
	-- vim.cmd.colorscheme("chadracula-evondev")
	-- vim.cmd.colorscheme("chadracula")
	-- vim.cmd.colorscheme("chad-gruvbox")
	-- vim.cmd.colorscheme("gruvbox")
	-- vim.cmd.colorscheme("pinkcat")
	-- vim.cmd.colorscheme("neovim_dark")
	-- vim.cmd.colorscheme("onenord")
	-- vim.cmd.colorscheme("kanagawa")
end
