return {
	{
		"RRethy/base16-nvim",
		lazy = true,
	},
	{
		"mcchrish/zenbones.nvim",
		lazy = true,
		config = function()
			vim.g.zenbones_compat = 1
		end,
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
				-- variant = "",
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
		"ellisonleao/gruvbox.nvim",
		lazy = true,
		opts = {
			overrides = {
				-- THIS BLOCK
				SignColumn = { bg = "#282828" },
				NvimTreeCutHL = { fg = "#fb4934", bg = "#282828" },
				NvimTreeCopiedHL = { fg = "#b8bb26", bg = "#282828" },
				DiagnosticSignError = { fg = "#fb4934", bg = "#282828" },
				DiagnosticSignWarn = { fg = "#fabd2f", bg = "#282828" },
				DiagnosticSignHint = { fg = "#8ec07c", bg = "#282828" },
				DiagnosticSignInfo = { fg = "#d3869b", bg = "#282828" },

				-- Normal = { bg = "#171717", fg = "#d4be98" },
			},
			-- transparent_mode = true,
			contrast = "hard",
			bold = true,
		},
		config = function(_, opts)
			require("gruvbox").setup(opts)
		end,
	},
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
