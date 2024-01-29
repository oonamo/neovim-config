-- GUI
--
vim.opt.guicursor = ""
vim.opt.termguicolors = true
vim.opt.background = "dark"

if vim.g.neovide then
	vim.g.neovide_scale_factor = 0.8
	vim.g.neovide_transparency = 1
	vim.g.neovide_hide_mouse_when_typing = true
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
-- vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.incsearch = true
vim.opt.hlsearch = false
vim.opt.wildmenu = true
vim.opt.statuscolumn = "%r"
vim.opt.signcolumn = "yes"
vim.opt.laststatus = 3 -- Or 3 for global statusline
vim.opt.cmdheight = 0
vim.opt.colorcolumn = "80"
vim.opt.conceallevel = 2
-- vim.opt.statusline = " %f %m %= %l:%c ♥ "
-- Popup Menu

vim.opt.completeopt = "menuone,noinsert,noselect"
vim.g.use_custom_snippets = false
vim.g.use_lualine = false

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
vim.g.use_custom_winbar = true

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
	-- {
	-- 	events = { "BufWritePost" },
	-- 	targets = { "*" },
	-- 	command = function()
	-- 		if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
	-- 			vim.fn.setpos(".", vim.fn.getpos("'\""))
	-- 			-- vim.cmd('normal zz') -- how do I center the buffer in a sane way??
	-- 			vim.cmd("silent! foldopen")
	-- 		end
	-- 	end,
	-- },
})

-- vim.api.nvim_create_autocmd("ColorScheme", {
-- 	pattern = "*",
-- 	callback = function()
-- 		require("highlights")
-- 	end,
-- })
--
-- vim.api.nvim_create_autocmd("TextYankPost", {
-- 	pattern = "*",
-- 	callback = function()
-- 		vim.highlight.on_yank({ timeout = 500 })
-- 	end,
-- })
-- -- Return to last edit position when opening files
-- vim.api.nvim_create_autocmd("BufReadPost", {
-- 	pattern = "*",
-- 	callback = function()
-- 		if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
-- 			vim.fn.setpos(".", vim.fn.getpos("'\""))
-- 			-- vim.cmd('normal zz') -- how do I center the buffer in a sane way??
-- 			vim.cmd("silent! foldopen")
-- 		end
-- 	end,
-- })
