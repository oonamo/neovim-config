return {
	"folke/twilight.nvim",
	opts = {
		context = 0,
		treesitter = true,
		expand = {
			"function",
			"method",
			"table",
			"if_statement",
			-- markdown
			"paragraph",
			"fenced_code_block",
			"list",
		},
	},
}
