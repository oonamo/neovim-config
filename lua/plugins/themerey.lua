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
				},
				disable_background = true,
			})
		end,
	},
	{ "EdenEast/nightfox.nvim", lazy = true },
	{ "nordtheme/vim", name = "nord", lazy = true },
}
