return {
	{
		"jesseleite/nvim-noirbuddy",
		dependencies = {
			{ "tjdevries/colorbuddy.nvim" },
		},
		lazy = true,
		priority = 1000,
		opts = {
			-- All of your `setup(opts)` will go here
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
				Headline = { bg = "#282828", fg = "#d4be98" },
				Headline2 = { bg = "#3e4934", fg = "#d4be98" },
				Headline3 = { bg = "#722529", fg = "#d4be98" },
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
		opts = {
			overrides = function(colors)
				return {
					Headline = { bg = colors.waveRed, fg = colors.sumiInk6 },
					Headline2 = { bg = colors.autumnGreen, fg = colors.sumiInk6 },
					Headline3 = { bg = colors.lightBlue, fg = colors.sumiInk6 },
				}
			end,
		},
		lazy = true,
	},
}
