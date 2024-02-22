return {
	{
		"RRethy/base16-nvim",
		lazy = true,
	},
	{
		"kvrohit/mellow.nvim",
		lazy = true,
		config = function()
			O = {
				colorscheme = "mellow",
				fn = "mellow",
			}
		end,
	},
	{
		"oonamo/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				-- extend_background_behind_borders = true,
				styles = {
					bold = true,
					italic = true,
					transparency = true,
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
		"yorik1984/newpaper.nvim",
		lazy = true,
		config = function()
			O = {
				colorscheme = "newpaper",
				fn = "newpaper",
			}
		end,
	},
	{
		"olivercederborg/poimandres.nvim",
		config = true,
		lazy = true,
	},
	{ "sainnhe/gruvbox-material", lazy = true },
	{
		"rebelot/kanagawa.nvim",
		lazy = true,
		opts = {
			transparent = false,
			colors = {
				theme = {
					all = {
						ui = {
							bg_gutter = "none",
						},
					},
				},
			},
		},
	},
	{
		"chrsm/paramount-ng.nvim",
		dependencies = { "rktjmp/lush.nvim" },
		lazy = true,
	},
}
