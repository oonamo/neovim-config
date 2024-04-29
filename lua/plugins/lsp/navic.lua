return {
	"SmiteshP/nvim-navic",
	lazy = true,
	enabled = false,
	cond = not vim.g.use_noice,
	opts = {
		icons = tools.ui.icons.kind,
		highlight = true,
		lsp = {
			auto_attach = true,
		},
		click = false,
		separator = " " .. tools.ui.icons.ChevronRight .. " ",
		depth_limit = 0,
		depth_limit_indicator = "..",
	},
	config = function(_, opts)
		vim.o.winbar = 2
		vim.o.tabline = 2
		require("nvim-navic").setup(opts)
	end,
}
