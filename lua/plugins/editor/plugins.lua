return {
	{
		"numToStr/Comment.nvim",
		dependencies = {},
		opts = {},
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		keys = { "gcc" },
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
