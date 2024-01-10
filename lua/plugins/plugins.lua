return {
	"ThePrimeagen/vim-be-good",

	{
		"echasnovski/mini.base16",
		lazy = true,
	},
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
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
		"NvChad/nvim-colorizer.lua",
		event = { "BufReadPre", "BufNewFile" },
	},
	{

		"xiyaowong/transparent.nvim",
		config = function()
			require("transparent").setup({
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
			})
		end,
	},
}
