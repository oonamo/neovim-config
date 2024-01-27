return {
	{
		"echasnovski/mini.base16",
		lazy = true,
	},
	{
		"numToStr/Comment.nvim",
		config = true,
		event = { "BufReadPre", "BufNewFile" },
	},
	{

		"xiyaowong/transparent.nvim",
		config = true,
		lazy = true,
		cmd = { "TransparentEnable", "TransparentDisable" },
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
