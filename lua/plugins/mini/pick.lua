require("mini.pick").setup({
	window = {
		config = {
			border = "single",
		},
	},
})

vim.ui.select = MiniPick.ui_select

MiniPick.registry.config = function()
	return MiniPick.builtin.files(nil, { source = { cwd = vim.fn.stdpath("config") } })
end

MiniPick.registry.colorschemes = function()
	local colorschemes = vim.fn.getcompletion("", "color")
	return MiniPick.start({
		source = {
			items = colorschemes,
			choose = function(item)
				vim.cmd("colorscheme " .. item)
			end,
		},
	})
end

vim.keymap.set("n", "<C-P>", "<CMD>Pick files<CR>", { desc = "pick files" })
vim.keymap.set("n", "<C-f>", "<CMD>Pick grep_live<CR>", { desc = "pick files" })
vim.keymap.set("n", "z=", MiniExtra.pickers.spellsuggest, { desc = "spellsuggest" })
vim.keymap.set("n", "<leader>fh", "<CMD>Pick help<CR>", { desc = "pick help" })
vim.keymap.set("n", "<leader>fi", "<CMD>Pick hl_groups<CR>")
