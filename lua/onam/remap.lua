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
-- Quickfix list
vim.keymap.set("n", "<leader>q", ":cnext<CR>", opts)
vim.keymap.set("n", "<leader>Q", ":cprev<CR>", opts)

--Set Copy and Paste
--Copy to Keyboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', opts)
vim.keymap.set({ "n", "v" }, "<leader>yy", '"+yy', opts)

--Paste from Keyboard
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', opts)
vim.keymap.set({ "n", "v" }, "<leader>P", '"+P', opts)

-- buffers
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", opts)
vim.keymap.set("n", "<leader>bp", ":bprev<CR>", opts)
vim.keymap.set("n", "<leader>bc", ":bdelete<CR>", opts)

-- Search and Replace
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set("n", "<leader>cp", function()
	require("onam.theme_switcher").open_plenary_popup()
end, { desc = "color switcher" })

vim.keymap.set("n", "<leader>cf", function()
	require("onam.theme_switcher").toggle_flavour()
end, { desc = "color switcher" })

vim.keymap.set("n", "<leader>cb", function()
	require("onam.color_switcher").show_plenary_popup(true)
end, { desc = "color switcher" })

vim.keymap.set("n", "<leader>cl", function()
	require("onam.color_switcher").show_plenary_popup(false, true)
end, { desc = "color switcher light" })

vim.keymap.set("n", "z=", function()
	local word = vim.fn.expand("<cword>")
	local suggestions = vim.fn.spellsuggest(word)
	vim.ui.select(
		suggestions,
		{},
		vim.schedule_wrap(function(selected)
			if selected then
				vim.api.nvim_feedkeys("ciw" .. selected, "n", true)
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, true, true), "n", true)
			end
		end)
	)
end)
-- vim.keymap.set("n", "<leader>ct", function()
-- 	require("onam.theme_switcher").next_theme()
-- end, { desc = "theme switcher" })
-- vim.keymap.set("n", "<leader>cT", function()
-- 	require("onam.theme_switcher").previous_theme()
-- end, { desc = "theme switcher" })
--
-- vim.keymap.set("n", "<leader>ca", function()
-- 	require("onam.theme_switcher").add_candidate()
-- end, { desc = "theme switcher" })
--
-- vim.keymap.set("n", "<leader>cc", function()
-- 	require("onam.theme_switcher").get_canidates()
-- end, { desc = "theme switcher" })

-- ARDUINO
vim.keymap.set("n", "<leader>ip", function()
	require("onam.helpers.arduino_helper").arduino_compile()
end, { desc = "arduino compile" })
vim.keymap.set("n", "<leader>ii", function()
	require("onam.helpers.arduino_helper").init_arduino()
end, { desc = "arduino init" })
vim.keymap.set("n", "<leader>ih", function()
	require("onam.helpers.arduino_helper").hydra()
end, { desc = "arduino hydra" })
