-- GUI
--
--
vim.opt.guicursor = "c-ci-ve:ver25,r-cr:hor20,o:hor20,a:blinkwait900-blinkon900-blinkoff900"
vim.opt.termguicolors = true
vim.opt.background = "dark"
if vim.g.neovide then
	vim.g.neovide_scale_factor = 1.0
	vim.g.neovide_hide_mouse_when_typing = true
	vim.o.guifont = "BlexMono Nerd Font:h16"
	vim.g.neovide_scroll_animation_length = 0
	vim.keymap.set("n", "<leader>nt", function()
		if vim.g.neovide_transparency ~= 1.0 then
			vim.g.neovide_transparency = 1.0
		else
			vim.g.neovide_transparency = 0.9
		end
	end)
	vim.g.neovide_transparency = 0.9
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
-- vim.opt.shortmess:append("C")
-- vim.opt.shortmess:append("S")
-- vim.opt.shortmess:append("c")
-- vim.opt.shortmess:append("s")
-- vim.opt.shortmess:append("W")
-- vim.opt.shortmess:append("o")
-- vim.opt.shortmess = {
-- 	C = true,
-- 	S = true,
-- 	c = true,
-- 	s = true,
-- 	W = true,
-- 	o = true,
-- 	a = true,
-- }
-- vim.opt.statusline = " %f %m %= %l:%c ♥ "
-- Popup Menu
vim.opt.completeopt = "menuone,noinsert,noselect"

-- Custom
vim.g.use_custom_snippets = true
vim.g.use_lualine = false
vim.g.heirline_enabled = true
vim.g.use_custom_statusline = false
vim.g.use_custom_winbar = false
vim.g.use_FZF = true
vim.g.use_noice = true
vim.g.no_cmd_height = true

vim.opt.foldlevel = 99
-- vim.opt.foldmethod = "expr"
if not vim.fn.has("win32") then
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
end

-- better spell

O = {}

utils.augroup("QOL", {
	-- {
	-- 	events = { "ColorScheme" },
	-- 	targets = { "*" },
	-- 	command = function()
	-- 		require("highlights")
	-- 	end,
	-- },
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
