return {
	"2giosangmitom/nightfall.nvim",
	-- priority = 1000,
	-- lazy = false,
	opts = {},
	config = function(_, opts)
		require("nightfall").setup(opts)
		vim.cmd.colorscheme("nightfall")
	end,
}
