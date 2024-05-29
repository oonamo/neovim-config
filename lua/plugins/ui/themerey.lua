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
		"miikanissi/modus-themes.nvim",
		lazy = true,
		opts = {
			styles = {
				functions = { bold = true, italic = true },
			},
			-- variant = "tinted",
			on_highlights = function(highlight, color)
				highlight.Normal = { fg = color.fg_main, bg = color.bg_dim }
				highlight.LineNr = { fg = color.fg_main, bg = color.bg_main }
				highlight.LineNrAbove = { fg = color.fg_main, bg = color.bg_main }
				highlight.LineNrBelow = { fg = color.fg_main, bg = color.bg_main }
				highlight.MatchParen = { fg = color.green, bg = "NONE" }
				highlight.LspInlayHint = { fg = color.green, bg = color.gray }
				highlight.SignColumn = { fg = highlight.LineNr.fg, bg = highlight.LineNr.bg }
			end,
		},
	},
	{
		"savq/melange-nvim",
	},
}
