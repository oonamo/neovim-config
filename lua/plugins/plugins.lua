return {
	{
		"echasnovski/mini.base16",
		lazy = true,
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		lazy = true,
		opts = {
			enable_autocmd = false,
		},
	},
	{
		"numToStr/Comment.nvim",
		dependencies = {},
		opts = {},
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
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
