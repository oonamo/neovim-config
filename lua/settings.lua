if vim.fn.exists("syntax_on") ~= 1 then vim.cmd("syntax enable") end

if vim.fn.has("win32") then
  _G.platform_specific = { lineending = "\r\n" }
else
  _G.platform_specific = { lineending = "\n" }
end

vim.o.shada        = "'100,<50,s10,:1000,/100,@100,h" -- Limit what is stored in ShaDa file

-- vim.o.shell = "pwsh"
-- vim.o.shellcmdflag =
-- 	"-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8; $PSStyle.OutputRendering = [System.Management.Automation.OutputRendering]::PlainText;"
-- vim.o.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait"
-- vim.o.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
-- vim.o.shellquote = ""
-- vim.o.shellxquote = ""

vim.g.mapleader = " "
vim.g.maplocalleader = ";"
local o, opt = vim.o, vim.opt

vim.opt.colorcolumn = "+1"
vim.opt.cursorline = true
vim.opt.helpheight = 10
vim.opt.showmode = false
vim.opt.ruler = true
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = "yes:1"
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.smoothscroll = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.completeopt = "menuone"
vim.opt.jumpoptions = "stack,view,clean"
vim.opt.title = true
vim.opt.titlestring = "nvim"
vim.opt.background = "dark"
vim.opt.guicursor = {
  -- Cursor shape
  "i-c-ci-ve:ver25-blinkoff500-blinkon500-TermCursor",
  "n-v:block-Curosr/lCursor",
  "o:hor50-Curosr/lCursor",
  "r-cr:hor20-Curosr/lCursor",
}
-- vim.o.guicursor = ""
vim.opt.cmdheight = 1

-- o.completeopt = "menu,menuone,noselect,popup"
-- o.completeslash = "slash"

vim.g.bigfile_size = 1024 * 1024 * 1.5 -- 1.5 MB
vim.o.lazyredraw = true

-- Relative line numbers
opt.nu = true
opt.rnu = true

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
o.list = true
o.listchars = table.concat({ "extends:…", "nbsp:␣", "precedes:…", "tab:> " }, ",")
o.fillchars = [[eob: ,vert:▕,vertleft:🭿,vertright:▕,verthoriz:🭿,horiz:▁,horizdown:▁,horizup:▔]]
o.virtualedit = "block"
o.shortmess = "tacstFOSWCo"
vim.opt.formatoptions:append("n")
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

vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- Disable builtin plugins
vim.g.loaded_2html_plugin = 0
vim.g.loaded_gzip = 0
vim.g.loaded_matchit = 0
vim.g.loaded_spellfile_plugin = 0
vim.g.loaded_tar = 0
vim.g.loaded_tarPlugin = 0
vim.g.loaded_tutor_mode_plugin = 0
vim.g.loaded_zip = 0
vim.g.loaded_zipPlugin = 0
