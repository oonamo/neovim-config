-- GUI
--
--
-- vim.opt.guicursor = ""
vim.opt.guicursor:append("a:blinkwait900-blinkon900-blinkoff900")
vim.opt.termguicolors = true
vim.opt.background = "dark"

if vim.g.neovide then
	vim.g.neovide_scale_factor = 1.0
	vim.g.neovide_hide_mouse_when_typing = true
	vim.o.guifont = "BlexMono Nerd Font Mono:h14"
	vim.g.neovide_scroll_animation_length = 0
	vim.g.neovide_transparency = 1.0
end

-- Editor
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.scrolloff = 8

vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.incsearch = true
vim.opt.hlsearch = false
vim.opt.wildmenu = true
vim.opt.signcolumn = "yes"
vim.opt.laststatus = 3 -- Or 3 for global statusline
vim.opt.colorcolumn = "80"
vim.opt.conceallevel = 2
-- vim.opt.statusline = " %f %m %= %l:%c ♥ "
-- Popup Menu
vim.opt.completeopt = "menuone,noinsert,noselect"

-- Custom
vim.g.use_custom_snippets = true
vim.g.use_lualine = true
vim.g.use_custom_statusline = false
vim.g.use_custom_winbar = true
vim.g.use_FZF = true

vim.opt.foldlevel = 99
-- vim.opt.foldmethod = "expr"
vim.opt.clipboard = {
	name = "WslClipboard",
	copy = {
		["+"] = "clip.exe",
		["*"] = "clip.exe",
	},
	paste = {
		["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
		["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
	},
	cache_enabled = 0,
}

O = {}

utils.augroup("QOL", {
	{
		events = { "ColorScheme" },
		targets = { "*" },
		command = function()
			require("highlights")
		end,
	},
	{
		events = { "TextYankPost" },
		targets = { "*" },
		command = function()
			vim.highlight.on_yank({ timeout = 500 })
		end,
	},
	{
		events = { "BufReadPost" },
		targets = { "*.c", "*.h", "*.cpp", "*.hpp" },
		command = function()
			vim.opt.tabstop = 2
			vim.opt.shiftwidth = 2
		end,
	},
})
