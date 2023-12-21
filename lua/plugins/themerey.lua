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
				},
				themeConfigFile = "~/.config/nvim/lua/onam/theme.lua",
				livePreview = true,
			})
		end,
	},
	{ "Yazeed1s/oh-lucy.nvim" },
	{ "kvrohit/mellow.nvim", lazy = false, priority = 1000 },
	{ "rose-pine/neovim", name = "rose-pine" },
	{ "EdenEast/nightfox.nvim" },
}
