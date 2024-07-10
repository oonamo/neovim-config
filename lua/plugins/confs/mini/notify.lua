require("mini.notify").setup({
	window = {
		config = { border = "double" },
	},
})

vim.api.nvim_create_user_command("Notifications", function()
	local win_id = vim.api.nvim_open_win(0, true, {
		split = "below",
		vertical = false,
		anchor = "SE",
		win = -1,
	})
	MiniNotify.show_history()
	vim.keymap.set("n", "q", function()
		vim.api.nvim_win_close(win_id, false)
	end, { buffer = 0 })
end, {})
