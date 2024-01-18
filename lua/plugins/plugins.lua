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
		"windwp/nvim-ts-autotag",
		ft = {
			"html",
			"javascript",
			"typescript",
			"javascriptreact",
			"typescriptreact",
			"svelte",
			"vue",
			"tsx",
			"jsx",
			"rescript",
			"xml",
		},
	},
	{

		"xiyaowong/transparent.nvim",
		config = true,
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
