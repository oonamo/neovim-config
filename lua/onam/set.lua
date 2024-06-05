local o, opt = vim.o, vim.opt

-- o.cursorline = true
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
opt.isfname:append("@-@")
o.updatetime = 300
o.timeoutlen = 500
o.ttimeoutlen = 10
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.incsearch = true
opt.wildmenu = true
-- opt.signcolumn = "no"
opt.signcolumn = "yes:1"
-- opt.signcolumn = "number"
opt.laststatus = 2 -- Or 3 for global statusline
opt.showmode = false
opt.completeopt = "menuone,noinsert,noselect"
o.grepprg = [[rg --glob "!.git" --hidden --smart-case  --vimgrep]]
o.helpheight = 10
o.ignorecase = true
o.foldcolumn = "0"
opt.foldlevel = 99
opt.foldmethod = "indent"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
o.list = false
o.virtualedit = "block"

o.shortmess = "acstFOSW"
o.splitkeep = "screen"

o.formatoptions = "rqnl1j"

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

if vim.fn.executable("rg") == 1 then
	-- credit: https://github.com/nicknisi/dotfiles/blob/1360edda1bbb39168637d0dff13dd12c2a23d095/config/nvim/init.lua#L73
	-- if ripgrep installed, use that as a grepper
	o.grepprg = "rg --vimgrep --color=never --with-filename --line-number --no-heading --smart-case --"
	o.grepformat = "%f:%l:%c:%m,%f:%l:%m"
end
