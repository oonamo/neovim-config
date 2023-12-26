return {
	{
		"zaldih/themery.nvim",
		config = function()
			require("themery").setup({
				themes = {
					"rose-pine",
					"rose-pine-dawn",
					"rose-pine-main",
					"mellow",
					"oh-lucy",
					"oh-lucy-evening",
					"nordfox",
					"carbonfox",
					"duskfox",
					"nord",
				},
				themeConfigFile = "~/.config/nvim/lua/onam/theme.lua",
				livePreview = true,
			})
		end,
		keys = {
			{ "<leader>th", "<cmd>Themery<CR>", { desc = "open themery" } },
		},
	},
	{ "Yazeed1s/oh-lucy.nvim", lazy = true },
	{ "kvrohit/mellow.nvim", lazy = false, priority = 1000 },
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				highlight_groups = {
					TelescopeBorder = { fg = "highlight_high", bg = "none" },
					TelescopeNormal = { bg = "none" },
					TelescopePromptNormal = { bg = "base" },
					TelescopeResultsNormal = { fg = "subtle", bg = "none" },
					TelescopeSelection = { fg = "text", bg = "base" },
					TelescopeSelectionCaret = { fg = "rose", bg = "rose" },

					StatusLine = { fg = "love", bg = "love", blend = 10 },
					StatusLineNC = { fg = "subtle", bg = "surface" },
					-- StatuslineAccent = { bg = "surface", fg = "love" },
					-- StatuslineInsertAccent = { bg = "love", fg = "surface" },
					-- StatuslineVisualAccent = { bg = "#b3c3c4", fg = "#27272a" },
					-- StatuslineCmdAccent = { bg = "#dda0dd", fg = "#27272a" },
					-- StatuslineReplaceAccent = { bold = true, fg = "#698282" },
				},
				disable_background = true,
			})
		end,
	},
	{ "EdenEast/nightfox.nvim", lazy = true },
	{ "nordtheme/vim", name = "nord", lazy = true },
}
