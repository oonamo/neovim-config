vim.g.mapleader = " "
vim.g.maplocalleader = ","

local opts = { silent = true }

vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)

vim.keymap.set("", "<C-c>", "<Esc>", { desc = "esc" }, opts)
vim.keymap.set("", "<C-]>", "<Esc>", { desc = "esc" }, opts)

--Move Command with J and K
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })

--Move directories
vim.keymap.set("n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>", { desc = "window left" })
vim.keymap.set("n", "<C-j>", "<cmd> TmuxNavigateDown<CR>", { desc = "window down" })
vim.keymap.set("n", "<C-k>", "<cmd> TmuxNavigateUp<CR>", { desc = "window up" })
vim.keymap.set("n", "<C-l>", "<cmd> TmuxNavigateRight<CR>", { desc = "window right" })

--Set Copy and Paste
--Copy to Keyboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', opts)
vim.keymap.set({ "n", "v" }, "<leader>yy", '"+yy', opts)
--Paste from Keyboard
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', opts)
vim.keymap.set({ "n", "v" }, "<leader>P", '"+P', opts)

-- Search and Replace
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set("n", "<leader>cs", function()
	require("onam.color_switcher").show_popup()
end, { desc = "color switcher" })

vim.keymap.set("n", "<leader>cp", function()
	require("onam.color_switcher").show_plenary_popup()
end, { desc = "color switcher" })
