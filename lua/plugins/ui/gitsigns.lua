return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			signs = {
				add = {
					hl = "GitSignsAdd",
					text = tools.ui.icons.BoldLineMiddle,
					numhl = "GitSignsAddNr",
					linehl = "GitSignsAddLn",
				},
				change = {
					hl = "GitSignsChange",
					text = tools.ui.icons.BoldLineDashedMiddle,
					numhl = "GitSignsChangeNr",
					linehl = "GitSignsChangeLn",
				},
				delete = {
					hl = "GitSignsDelete",
					text = tools.ui.icons.TriangleShortArrowRight,
					numhl = "GitSignsDeleteNr",
					linehl = "GitSignsDeleteLn",
				},
				topdelete = {
					hl = "GitSignsDelete",
					text = tools.ui.icons.TriangleShortArrowRight,
					numhl = "GitSignsDeleteNr",
					linehl = "GitSignsDeleteLn",
				},
				changedelete = {
					hl = "GitSignsChange",
					text = tools.ui.icons.BoldLineMiddle,
					numhl = "GitSignsChangeNr",
					linehl = "GitSignsChangeLn",
				},
			},
			watch_gitdir = {
				interval = 1000,
				follow_files = true,
			},
		},
	},
}
