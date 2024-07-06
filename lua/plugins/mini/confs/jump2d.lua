local jump2d = require("mini.jump2d")

jump2d.setup({
	view = {
		dim = true,
	},
	mappings = {
		start_jumping = "",
	},
	-- hook = {
	-- 	after_jump = function() end,
	-- },
})

local jump_after = MiniJump2d.builtin_opts.single_character
-- MiniJump2d.builtin_opts.jump_after = MiniJump2d.builtin_opts.single_character

jump_after.hooks.after_jump = function()
	local win = vim.api.nvim_get_current_win()
	local cursor = vim.api.nvim_win_get_cursor(win)
	local maxwidth = vim.api.nvim_win_get_width(win)
	local new_pos = cursor[2] + 1 <= maxwidth and cursor[2] + 1 or cursor[2]
	vim.api.nvim_win_set_cursor(win, { cursor[1], new_pos })
end
-- MiniJump2d.builtin_opts.single_character.hooks.after_jump = nil

vim.keymap.set("i", "<C-o>", function()
	MiniJump2d.start(jump_after)
end, { desc = "jump2d" })
vim.keymap.set("n", "<leader>r", function()
	MiniJump2d.start(MiniJump2d.builtin_opts.single_character)
end, { desc = "jump2d" })
vim.keymap.set("i", "<C-r>", function()
	MiniJump2d.start(jump_after)
end, { desc = "jump2d" })
vim.keymap.set("n", "s", function()
	MiniJump2d.start(jump_after)
end, { desc = "jump2d" })
