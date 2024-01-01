-- ----------------------------------------------
-- GUI
vim.opt.guicursor = ""
vim.opt.termguicolors = true
vim.opt.background = "dark"
if vim.g.neovide then
	vim.g.neovide_scale_factor = 1
	vim.g.neovide_transparency = 1
	vim.g.neovide_hide_mouse_when_typing = true
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
vim.opt.statuscolumn = "%r"
vim.opt.signcolumn = "yes"
vim.opt.laststatus = 3 -- Or 3 for global statusline
vim.opt.cmdheight = 0
-- vim.opt.statusline = " %f %m %= %l:%c ♥ "
-- ----------------------------------------------
-- ----------------------------------------------
-- Popup Menu

vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.pumblend = 30
vim.opt.winblend = 30

vim.g.clipboard = {
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

vim.g.use_custom_statusline = false
O = {}

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		require("highlights")
	end,
})

-- vim.api.nvim_create_autocmd("ColorScheme", {
-- 	pattern = "mellow",
-- 	callback = function()
-- 		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#27272a", blend = 15 })
-- 		vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#ea83a5", blend = 15, fg = "#dda0dd" })
-- 		vim.api.nvim_set_hl(0, "Pmenu", { bg = "#27272a" })
-- 		vim.api.nvim_set_hl(0, "PmenuSel", { bold = true, fg = "#dda0dd", bg = "#353539" })
-- 	end,
-- })

-- vim.api.nvim_create_autocmd("ColorScheme", {
-- 	pattern = "rose-pine",
-- 	callback = function()
-- 		-- vim.opt.statusline = " %f %m %= %l:%c ♥ "
--
-- 		utils.hl = {
-- 			opts = {
-- 				{ "@keyword", { fg = "#698282" } },
-- 				{ "Statement", { fg = "#698282" } },
--
-- 				{ "Function", { fg = "#ffc2c6" } },
-- 				{ "String", { fg = "#d3a38d" } },
-- 				{ "@property", { fg = "#b3c3c4" } },
-- 				{ "NormalFloat", { blend = 15 } },
-- 				{ "FloatBorder", { blend = 15 } },
-- 				{ "PmenuSel", { bold = true, fg = "#ffc2c6" } },
-- 				{ "Title", { bold = true, fg = "#698282" } },
-- 				{ "Directory", { bold = true, fg = "#698282" } },
-- 				{ "StatusLineExtra", { fg = "#28272a", bg = "#ea83a5" } },
-- 				{ "StatuslineAccent", { bg = "#ffc2c6", fg = "#27272a" } },
-- 				{ "StatuslineInsertAccent", { link = "CurSearch" } },
-- 				{ "StatuslineVisualAccent", { bg = "#b3c3c4", fg = "#27272a" } },
-- 				{ "StatuslineCmdLineAccent", { bg = "#dda0dd", fg = "#27272a" } },
-- 				{ "StatusCmdLine", { bg = "#dda0dd", fg = "#27272a" } },
-- 				{ "StatuslineReplaceAccent", { bold = true, fg = "#698282" } },
-- 				{ "StatusEmpty", { bg = "#28272a", blend = 10 } },
-- 				{ "StatusBarLong", { bg = "#28272a", blend = 10, fg = "#ffffff" } },
-- 				{ "HarpoonActive", { bg = "#dda0dd", blend = 10, fg = "#000000" } },
-- 				{ "HarpoonInactive", { bg = "#698282", blend = 10, fg = "#000000" } },
-- 			},
-- 		}
--
-- 		-- vim.api.nvim_set_hl(0, "@keyword", { fg = "#698282" })
-- 		-- vim.api.nvim_set_hl(0, "Statement", { fg = "#698282" })
-- 		-- vim.api.nvim_set_hl(0, "Function", { fg = "#ffc2c6" })
-- 		-- vim.api.nvim_set_hl(0, "String", { fg = "#d3a38d" })
-- 		-- vim.api.nvim_set_hl(0, "@property", { fg = "#b3c3c4" })
-- 		-- vim.api.nvim_set_hl(0, "NormalFloat", { blend = 15 })
-- 		-- vim.api.nvim_set_hl(0, "FloatBorder", { blend = 15 })
-- 		-- vim.api.nvim_set_hl(0, "PmenuSel", { bold = true, fg = "#ffc2c6" })
-- 		-- vim.api.nvim_set_hl(0, "Title", { bold = true, fg = "#698282" })
-- 		-- vim.api.nvim_set_hl(0, "Directory", { bold = true, fg = "#698282" })
-- 		-- vim.api.nvim_set_hl(0, "CursorLine", { bg = "#b3c3c4" })
--
-- 		-- StatusLine
-- 		-- {"StatusLineExtra", { fg = "#28272a", bg = "#ea83a5" }},
-- 		-- -- vim.api.nvim_set_hl(0, "StatuslineAccent", { bg = "#ffc2c6", fg = "#27272a" })
-- 		-- {"StatuslineAccent", { bg = "#ffc2c6", fg = "#27272a" }},
-- 		-- {"StatuslineInsertAccent", { link = "CurSearch" }},
-- 		-- {"StatuslineVisualAccent", { bg = "#b3c3c4", fg = "#27272a" }},
-- 		-- {"StatuslineCmdLineAccent", { bg = "#dda0dd", fg = "#27272a" }},
-- 		-- {"StatusCmdLine", { bg = "#dda0dd", fg = "#27272a" }},
-- 		-- {"StatuslineReplaceAccent", { bold = true, fg = "#698282" }},
-- 		-- {"StatusEmpty", { bg = "#28272a", blend = 10 }},
-- 		-- {"StatusBarLong", { bg = "#28272a", blend = 10, fg = "#ffffff" }},
-- 		-- {"HarpoonActive", { bg = "#dda0dd", blend = 10, fg = "#000000" }},
-- 		-- {"HarpoonInactive", { bg = "#698282", blend = 10, fg = "#000000" }},
-- 	end,
-- })

-- vim.api.nvim_create_autocmd("ColorScheme", {
-- 	pattern = "nord",
-- 	callback = function()
-- 		vim.api.nvim_set_hl(0, "NormalFloat", { blend = 25 })
-- 		vim.api.nvim_set_hl(0, "FloatBorder", { blend = 15 })
-- 	end,
-- })
--
vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ timeout = 500 })
	end,
})
