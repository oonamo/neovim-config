vim.g.mapleader = " "
vim.g.maplocalleader = ";"

-- local opts = { silent = true }
local function opts(desc, silent, options)
	silent = silent or false
	options = options or {}
	options.desc = desc or ""
	options.silent = silent
	return options
end

-- center screen
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts("smooth scroll down", true, { noremap = true }))
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts("smooth scroll up", true, { noremap = true }))
vim.keymap.set("n", "n", "nzzzv", opts("smooth search down", true, { noremap = true }))
vim.keymap.set("n", "N", "Nzzzv", opts("smooth search up", true, { noremap = true }))
vim.keymap.set("n", "%", "%zz", opts("smooth match", true, { noremap = true }))
vim.keymap.set("n", "*", "*zz", opts("smooth search up", true, { noremap = true }))
vim.keymap.set("n", "N", "#zz", opts("smooth search up", true, { noremap = true }))

vim.api.nvim_set_keymap("i", "<C-c>", "<Esc>", opts("escape insert mode", true, { noremap = true }))

--Move Command with J and K
-- vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts("move line up", true)) -- Move line up { silent = true })
-- vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts("move line down", true)) -- Move line down { silent = true })

-- Quickfix list
vim.keymap.set("n", "<leader>q", ":cnext<CR>", opts("quickfix next", true))
vim.keymap.set("n", "<leader>Q", ":cprev<CR>", opts("quickfix prev", true))

--Set Copy and Paste
--Copy to Keyboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', opts("copy to clipboard", true))
vim.keymap.set({ "n", "v" }, "<leader>yy", '"+yy', opts("copy to clipboard", true))

--Paste from Keyboard
vim.keymap.set({ "n", "v" }, "<leader>ps", '"+p', opts("paste from clipboard", true))
vim.keymap.set({ "n", "v" }, "<leader>P", '"+P', opts("paste from clipboard", true))
-- Search and Replace
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], opts("search and replace"))

-- window options
vim.keymap.set("n", "<leader>vs", "<CMD>vsplit<CR>", opts("vertical split", true))
vim.keymap.set("n", "<leader>vh", "<CMD>split<CR>", opts("horizontal split", true))
vim.keymap.set("n", "<leader>vn", "<CMD>vnew<CR>", opts("horizontal split", true))

vim.keymap.set("n", "<leader>nh", "<CMD>noh<CR>", opts("remove highlights", true))

-- move in wezterm
vim.keymap.set("n", "<C-;>", function()
	local command = { "wezterm", "cli", "activate-pane-direction", "Down" }
	return vim.fn.system(command)
end, opts("open wezterm split", true))
