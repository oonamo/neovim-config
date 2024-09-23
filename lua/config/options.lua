local o, opt = vim.o, vim.opt
vim.o.shada = "'100,<50,s10,:1000,/100,@100,h"

-- Allows for easy telling if pane is a nvim proccess
o.title = true
o.titlestring = "nvim"
opt.completeopt = "menu,menuone,noselect"

o.cmdheight = 1

vim.g.bigfile_size = 1024 * 1024 * 1.5 -- 1.5 MB
vim.o.lazyredraw = true

-- Relative line numbers
opt.nu = true
opt.rnu = true

-- Show mode in statusline
opt.showmode = false
opt.showcmdloc = "statusline"

-- set tab stop at 4
opt.tabstop = 4
opt.softtabstop = 4
opt.expandtab = true

-- autoindent
opt.smartindent = true
opt.shiftwidth = 4

-- smarter breaking
o.breakindent = true

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
opt.completeopt = { "menu", "menuone", "noselect" }

-- set signcolumn
opt.signcolumn = "yes"

-- o.guicursor = ""
opt.guicursor = {
	"n-v-c:block", -- Normal, visual, command-line: block cursor
	"i-ci-ve:ver25", -- Insert, command-line insert, visual-exclude: vertical bar cursor with 25% width
	"r-cr:hor20", -- Replace, command-line replace: horizontal bar cursor with 20% height
	"o:hor50", -- Operator-pending: horizontal bar cursor with 50% height
	"a:blinkwait700-blinkoff400-blinkon250", -- All modes: blinking settings
	"sm:block-blinkwait175-blinkoff150-blinkon175", -- Showmatch: block cursor with specific blinking settings
}

-- o.cursorline = true
-- o.cursorlineopt = "number"
o.emoji = true

-- Editor
opt.scrolloff = 8
o.updatetime = 300
o.timeoutlen = 500
o.ttimeoutlen = 10
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.wildmenu = true

-- opt.signcolumn = "number"
opt.laststatus = 3 -- Or 3 for global statusline
-- opt.fillchars = "fold:~"
-- opt.fillchars = {
-- 	fold = "~",
-- 	stl = "─",
-- 	stlnc = "─",
-- }
opt.foldlevel = 99
-- opt.foldmethod = "indent"
-- opt.foldmethod = "marker"
o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldtext = ""
o.list = true
opt.listchars = "trail:∘,nbsp:‼,tab:  ,multispace: "
-- o.fillchars = [[eob:~,vert:▕,vertleft:🭿,vertright:▕,verthoriz:🭿,horiz:▁,horizdown:▁,horizup:▔,stl:─]]
o.fillchars = [[eob:~,vert:▕,vertleft:🭿,vertright:▕,verthoriz:🭿,horiz:▁,horizdown:▁,horizup:▔]]
o.virtualedit = "block"

o.shortmess = "acstFOSW"

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

o.cursorline = true

vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

require("onam.float_term").setup("pwsh")
