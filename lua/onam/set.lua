local o, opt = vim.o, vim.opt

opt.guicursor = ""
opt.termguicolors = true
opt.background = "dark"
if vim.g.neovide then
	opt.guicursor =
		"i:ver20,n-v-sm:block,c-ci-ve:ver20,r-cr-o:hor20,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor"
	vim.g.neovide_scale_factor = 1.0
	vim.g.neovide_hide_mouse_when_typing = true
	vim.g.neovide_theme = "auto"
	vim.g.neovide_scroll_animation_length = 0
	vim.opt.linespace = 0
	vim.g.neovide_transparency_point = 0.8
	vim.g.neovide_underline_stroke_scale = 1.5
	vim.g.neovide_transparency = 0.9
	vim.keymap.set("n", "<leader>nt", function()
		if vim.g.neovide_transparency ~= 1.0 then
			vim.g.neovide_transparency = 1.0
		else
			vim.g.neovide_transparency = 0.9
		end
	end)
	local change_scale_factor = function(delta)
		vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
	end
	vim.keymap.set("n", "<C-=>", function()
		change_scale_factor(1.25)
	end)
	vim.keymap.set("n", "<C-->", function()
		change_scale_factor(1 / 1.25)
	end)
end

o.cursorline = true
o.cursorlineopt = "number"
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
opt.signcolumn = "yes:1"
opt.laststatus = 2 -- Or 3 for global statusline
opt.conceallevel = 2
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
opt.listchars = { space = "⋅", trail = "⋅", tab = "  ↦" }
opt.fillchars = {
	eob = " ",
	fold = " ",
	foldclose = tools.ui.icons.right,
	foldopen = tools.ui.icons.down,
	foldsep = " ",
	msgsep = "─",
}

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
O = {}

if vim.fn.executable("rg") == 1 then
	-- credit: https://github.com/nicknisi/dotfiles/blob/1360edda1bbb39168637d0dff13dd12c2a23d095/config/nvim/init.lua#L73
	-- if ripgrep installed, use that as a grepper
	o.grepprg = "rg --vimgrep --color=never --with-filename --line-number --no-heading --smart-case --"
	o.grepformat = "%f:%l:%c:%m,%f:%l:%m"
end
