require("mini.jump2d").setup({
	view = {
		dim = true,
	},
})

vim.keymap.set({ "o", "x", "n", "v" }, "<CR>", function()
	MiniJump2d.start(MiniJump2d.builtin_opts.single_character)
end, { desc = "jump2d" })
vim.keymap.set("i", "<C-o>", function()
	MiniJump2d.start(MiniJump2d.builtin_opts.single_character)
end, { desc = "jump2d" })
