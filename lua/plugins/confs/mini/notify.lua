local filterout_lua_diagnosing = function(notif_arr)
	local not_diagnosing = function(notif)
		return not vim.startswith(notif.msg, "lua_ls: Diagnosing")
	end
	notif_arr = vim.tbl_filter(not_diagnosing, notif_arr)
	return MiniNotify.default_sort(notif_arr)
end

require("mini.notify").setup({
	content = { sort = filterout_lua_diagnosing },
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
