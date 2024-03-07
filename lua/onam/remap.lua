vim.g.mapleader = " "
vim.g.maplocalleader = ";"

local opts = { silent = true }

vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)
vim.keymap.set("n", "n", "nzzzv", opts)

vim.keymap.set("n", "N", "Nzzzv", opts)
vim.api.nvim_set_keymap("i", "<C-c>", "<Esc>", { desc = "esc" })
--Move Command with J and K
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })

--Move directories
-- vim.keymap.set({ "n", "t" }, "<C-h>", "<CMD>NavigatorLeft<CR>")
-- vim.keymap.set({ "n", "t" }, "<C-l>", "<CMD>NavigatorRight<CR>")
-- vim.keymap.set({ "n", "t" }, "<C-k>", "<CMD>NavigatorUp<CR>")
-- vim.keymap.set({ "n", "t" }, "<C-j>", "<CMD>NavigatorDown<CR>")
-- vim.keymap.set({ "n", "t" }, "<C-p>", "<CMD>NavigatorPrevious<CR>")
-- keymap_del({ "n", "t" }, "<C-h>")
-- keymap_del({ "n", "t" }, "<C-l>")
-- keymap_del({ "n", "t" }, "<C-j>")
-- keymap_del({ "n", "t" }, "<C-k>")

-- vim.keymap.set("n", "<C-h>", "<cmd> NavigatorLeft<CR>", { desc = "window left" })
-- vim.keymap.set("n", "<C-j>", "<cmd> NavigatorDown<CR>", { desc = "window down" })
-- vim.keymap.set("n", "<C-k>", "<cmd> NavigatorUp<CR>", { desc = "window up" })
-- vim.keymap.set("n", "<C-l>", "<cmd> NavigatorRight<CR>", { desc = "window right" })
--

vim.keymap.set({ "n", "t" }, "<C-h>", "<CMD>NavigatorLeft<CR>", { desc = "window left" })
vim.keymap.set({ "n", "t" }, "<C-l>", "<CMD>NavigatorRight<CR>", { desc = "window right" })
vim.keymap.set({ "n", "t" }, "<C-k>", "<CMD>NavigatorUp<CR>", { desc = "window up" })
vim.keymap.set({ "n", "t" }, "<C-j>", "<CMD>NavigatorDown<CR>", { desc = "window down" })
--Set Copy and Paste
--Copy to Keyboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', opts)
vim.keymap.set({ "n", "v" }, "<leader>yy", '"+yy', opts)
--Paste from Keyboard
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', opts)
vim.keymap.set({ "n", "v" }, "<leader>P", '"+P', opts)

-- Search and Replace
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set("n", "<leader>cp", function()
	require("onam.color_switcher").show_plenary_popup()
end, { desc = "color switcher" })

vim.keymap.set("n", "<leader>cb", function()
	require("onam.color_switcher").show_plenary_popup(true)
end, { desc = "color switcher" })

vim.keymap.set("n", "<leader>cl", function()
	require("onam.color_switcher").show_plenary_popup(false, true)
end, { desc = "color switcher light" })
