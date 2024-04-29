return {
	"j-hui/fidget.nvim",
	event = "LspAttach",
	cond = not vim.g.use_noice,
	opts = {
		progress = {
			suppress_on_insert = true,
			display = {
				done_ttl = 2,
				progress_icon = { pattern = "grow_horizontal", period = 0.75 },
			},
		},
		notification = {
			window = {
				border = tools.ui.cur_border,
			},
		},
	},
}
