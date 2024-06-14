local jump2d = require("mini.jump2d")
local sc = jump2d.builtin_opts.single_character

jump2d.setup({
	view = {
		dim = true,
	},
})

vim.keymap.set("n", "<CR>", function()
	MiniJump2d.start(MiniJump2d.builtin_opts.single_character)
end, { desc = "jump2d", noremap = true })

vim.keymap.set("i", "<C-o>", function()
	MiniJump2d.start(MiniJump2d.builtin_opts.single_character)
end, { desc = "jump2d" })
