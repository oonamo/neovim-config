-- ----------------------------------------------
-- GUI
vim.opt.guicursor = ""
vim.opt.termguicolors = true
vim.opt.background = "dark"
if vim.g.neovide then
	vim.g.neovide_scale_factor = 1
end
-- ----------------------------------------------
-- ----------------------------------------------
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
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.incsearch = true
vim.opt.hlsearch = false
vim.opt.wildmenu = true
vim.opt.cursorline = false
vim.opt.statuscolumn = "%l %r"
vim.opt.signcolumn = "yes"
-- ----------------------------------------------
-- ----------------------------------------------
-- Popup Menu

vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.pumblend = 15
vim.opt.winblend = 30

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "mellow",
	callback = function()
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#27272a", blend = 15 })
		vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#ea83a5", blend = 15, fg = "#dda0dd" })
		vim.api.nvim_set_hl(0, "Pmenu", { bg = "#27272a" })
		vim.api.nvim_set_hl(0, "PmenuSel", { bold = true, fg = "#dda0dd", bg = "#353539" })
	end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "rose-pine",
	callback = function()
		vim.api.nvim_set_hl(0, "@keyword", { fg = "#698282" })
		vim.api.nvim_set_hl(0, "Statement", { fg = "#698282" })
		vim.api.nvim_set_hl(0, "Function", { fg = "#ffc2c6" })
		vim.api.nvim_set_hl(0, "String", { fg = "#d3a38d" })
		vim.api.nvim_set_hl(0, "@property", { fg = "#b3c3c4" })
		vim.api.nvim_set_hl(0, "NormalFloat", { blend = 15 })
		vim.api.nvim_set_hl(0, "FloatBorder", { blend = 15 })
		vim.api.nvim_set_hl(0, "PmenuSel", { bold = true, fg = "#ffc2c6" })
		vim.api.nvim_set_hl(0, "Title", { bold = true, fg = "#698282" })
		vim.api.nvim_set_hl(0, "Directory", { bold = true, fg = "#698282" })
		vim.api.nvim_set_hl(0, "CursorLine", { bg = "#b3c3c4" })
	end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "nord",
	callback = function()
		vim.api.nvim_set_hl(0, "NormalFloat", { blend = 25 })
		vim.api.nvim_set_hl(0, "FloatBorder", { blend = 15 })
	end,
})
