return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		priority = 1000,
		lazy = true,
		opts = {
			highlight_groups = {
				String = { fg = "iris", italic = true },
				GrappleTitle = { bg = "muted", fg = "base" },
				GrappleBorder = { bg = "surface", fg = "surface" },
				GrappleFooter = { bg = "love", fg = "base" },
			},
		},
	},
	{
		"folke/tokyonight.nvim",
		lazy = true,
		opts = {
			sidebars = {
				"qf",
				"vista_kind",
				-- "terminal",
				"spectre_panel",
				"startuptime",
				"Outline",
			},
			-- on_highlights = function(hl, c)
			-- 	-- hl.Normal = { fg = c.normal, bg = "#1c1c1c" }
			-- 	hl.Normal = { fg = c.normal, bg = "#000000" }
			-- 	hl.NormalNC = {}
			-- end,
		},
	},
	{
		"mcauley-penney/ice-cave.nvim",
		lazy = true,
	},
}
