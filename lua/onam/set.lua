local o, opt = vim.o, vim.opt

opt.guicursor = {
	"n-sm:block",
	"v:hor50",
	"c-ci-cr-i-ve:ver10",
	"o-r:hor10",
	"a:Cursor/Cursor-blinkwait1-blinkon1-blinkoff1",
}
opt.termguicolors = true
opt.background = "dark"
if vim.g.neovide then
	opt.guicursor = "c-ci-ve:ver25,r-cr:hor20,o:hor20,a:blinkwait900-blinkon900-blinkoff900"
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
o.cursorline = true
-- o.cursorlineopt = "number"
o.emoji = true

-- Editor
opt.nu = true
opt.relativenumber = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.wrap = false
opt.scrolloff = 8
opt.fillchars = {
	eob = " ",
	diff = "╱",
	fold = " ",
	-- eol = "⏎ ",
	foldclose = tools.ui.icons.r_chev,
	foldopen = tools.ui.icons.d_chev,
	foldsep = " ",
	msgsep = "━",
	horiz = "━",
	horizup = "┻",
	horizdown = "┳",
	vert = "┃",
	vertleft = "┫",
	vertright = "┣",
	verthoriz = "╋",
}
opt.isfname:append("@-@")
opt.updatetime = 50
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.incsearch = true
opt.hlsearch = false
opt.wildmenu = true
opt.signcolumn = "yes"
opt.laststatus = 3 -- Or 3 for global statusline
opt.colorcolumn = "80"
opt.conceallevel = 2
opt.showmode = false
opt.completeopt = "menuone,noinsert,noselect"
o.grepprg = [[rg --glob "!.git" --hidden --smart-case  --vimgrep]]
o.helpheight = 70
o.ignorecase = true
o.foldcolumn = "1"
opt.foldlevel = 99
opt.foldmethod = "indent"
o.list = true

opt.listchars = {
	nbsp = "▬",
	tab = "  ",
	trail = "·",
	-- eol = "⏎",
}
o.shortmess = "acstFOSW"
o.splitkeep = "screen"

opt.formatoptions:remove("o")

vim.g.netrw_banner = 0
vim.g.netrw_mouse = 2

if not vim.fn.has("win32") then
	opt.clipboard = {
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

O = {}

-- utils.augroup("QOL", {
-- 	{
-- 		events = { "TextYankPost" },
-- 		targets = { "*" },
-- 		command = function()
-- 			vim.highlight.on_yank({ timeout = 500 })
-- 		end,
-- 	},
-- })
