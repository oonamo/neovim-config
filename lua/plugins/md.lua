local utils = require("onam.utils")
return {
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && npm install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	{
		"lukas-reineke/headlines.nvim",
		dependencies = "nvim-treesitter/nvim-treesitter",
		ft = { "norg", "md" },
		opts = {
			headline_highlights = { "Headline", "Headline2", "Headline3" },
			norg = {
				-- headline_highlights = { "Headline", "Headline2" },
				-- fat_headlines = false,
			},
			markdown = {},
			org = {},
			rmd = {},
		},
		config = function(_, opts)
			for i, v in ipairs(opts.headline_highlights) do
				-- local md_hl = vim.api.nvim_get_hl_by_name("markdownH" .. i, true)
				local hl = "markdownH" .. i
				local md_hl = {}
				md_hl.bg = utils.brighten(hl, -80)
				vim.api.nvim_set_hl(0, v, { bg = md_hl.bg, fg = "NONE" })
			end

			opts.norg.headline_highlights = opts.headline_highlights
			opts.rmd.headline_highlights = opts.headline_highlights
			opts.markdown.headline_highlights = opts.headline_highlights
			opts.org.headline_highlights = opts.headline_highlights

			require("headlines").setup(opts)
		end,
	},
	{
		"dhruvasagar/vim-table-mode",
		ft = { "markdown", "norg" },
		keymap = { "<leader>tm", ":TableModeToggle<CR>", desc = "Toggle Table Mode" },
	},
	{
		"Myzel394/easytables.nvim",
		opts = {},
		cmd = { "EasyTablesCreateNew" },
	},
	{
		"jbyuki/venn.nvim",
		opts = {},
		cmd = { "VBox" },
	},
}
