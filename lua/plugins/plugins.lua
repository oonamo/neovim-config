return {
	"NvChad/nvim-colorizer.lua",
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},
	"xiyaowong/transparent.nvim",
	"windwp/nvim-ts-autotag",
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},
}
