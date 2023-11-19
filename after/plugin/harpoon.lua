local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
local wk = require("which-key")
--vim.keymap.set("n", "<leader>ha", mark.add_file)
--vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

--vim.keymap.set("n", "<leader>h1", function()
--	ui.nav_file(1)
--end)
--vim.keymap.set("n", "<leader>h2", function()
--	ui.nav_file(2)
--end)
--vim.keymap.set("n", "<leader>h3", function()
--	ui.nav_file(3)
--end)
--vim.keymap.set("n", "<leader>h4", function()
--	ui.nav_file(4)
--end)
wk.register({
	name = "+harpoon",
	["<leader>ha"] = { mark.add_file(), "Mark current file" },
	["<C-h>"] = { ui.nav_file(1), "Go to first marked file" },
	["<C-t>"] = { ui.nav_file(2), "Go to second marked file" },
	["<C-n>"] = { ui.nav_file(3), "Go to third marked file" },
	["<C-s>"] = { ui.nav_file(4), "Go to marked file" },
})
