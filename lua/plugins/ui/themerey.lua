return {
	{
		"AstroNvim/astrotheme",
		lazy = true,
		opts = {
			background = { -- :h background, palettes to use when using the core vim background colors
				light = "astrolight",
				dark = "astrodark",
			},
			palettes = {
				astrolight = {
					ui = {
						base = "#feeeee",
					},
				},
			},
			highlights = {
				astrolight = {
					CursorLineNr = { fg = "#ead0dd" },
					CursorLine = { bg = "#E8E9EA" },
				},
			},
			style = {
				transparent = false, -- Bool value, toggles transparency.
				inactive = false, -- Bool value, toggles inactive window color.
				float = true, -- Bool value, toggles floating windows background colors.
				neotree = false, -- Bool value, toggles neo-trees background color.
				border = true, -- Bool value, toggles borders.
				title_invert = true, -- Bool value, swaps text and background colors.
				italic_comments = true, -- Bool value, toggles italic comments.
				simple_syntax_colors = true, -- Bool value, simplifies the amounts of colors used for syntax highlighting.
			},
		},
	},
	{
		"sainttttt/flesh-and-blood",
		lazy = true,
	},
	{
		"oonamo/neovim",
		name = "rose-pine",
		lazy = true,
		config = function()
			require("rose-pine").setup({
				-- variant = "",
				styles = {
					bold = true,
					italic = true,
					transparency = false,
				},
				highlight_groups = {
					-- _nc = "#16141f",
					-- base = "#191724",
					-- surface = "#1f1d2e",
					-- overlay = "#26233a",
					-- muted = "#6e6a86",
					-- subtle = "#908caa",
					-- text = "#e0def4",
					-- love = "#eb6f92",
					-- gold = "#f9bd98",
					-- rose = "#ebbcba",
					-- pine = "#7f9f9f",
					-- foam = "#bedfe0",
					-- iris = "#debee2",
					-- highlight_low = "#21202e",
					-- highlight_med = "#403d52",
					-- highlight_high = "#524f67",
					-- none = "NONE",
					TreesitterContext = { bg = "highlight_low" },
					TreesitterContextBottom = { sp = "rose", underline = true },
					TreesitterContextNumberBottom = { sp = "rose", underline = true },
					TelescopeTitle = { fg = "base", bg = "love" },
					TelescopePromptTitle = { fg = "base", bg = "pine" },
					TelescopePreviewTitle = { fg = "base", bg = "iris" },
					BufferVisible = { bg = "none", fg = "text", bold = true, italic = true },
					NoiceCmdlinePopupBorder = { fg = "subtle", bg = "subtle" },
				},
			})
		end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		lazy = true,
	},
	{
		"rebelot/kanagawa.nvim",
		lazy = true,
	},
	{
		"comfysage/evergarden",
		lazy = true,
	},
	{
		"EdenEast/nightfox.nvim",
		lazy = true,
	},
	{
		"catppuccin/nvim",
		lazy = true,
	},
	{
		"mcauley-penney/ice-cave.nvim",
		lazy = true,
	},
}
