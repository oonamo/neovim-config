return {
	{
		"numToStr/Comment.nvim",
		opts = {},
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		keys = { "gcc", "gbc" },
	},
	{
		"xiyaowong/transparent.nvim",
		lazy = false,
		cmd = { "TransparentEnable", "TransparentDisable" },
		cond = vim.g.neovide == nil,
		opts = {
			exclude_groups = {
				"CursorLine",
				"StatusLine",
				"StatusLineNC",
				"StatusLineExtra",
				"StatuslineAccent",
				"StatuslineInsertAccent",
				"StatuslineVisualAccent",
				"StatuslineCmdLineAccent",
				"StatusCmdLine",
				"StatuslineReplaceAccent",
				"StatusEmpty",
				"StatusBarLong",
				"HarpoonActive",
				"HarpoonInactive",
			},
		},
	},
}
