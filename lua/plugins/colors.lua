return {
	-- {
	-- 	"genchad",
	-- 	dir = "~/projects/nvim/chadschemes/",
	-- 	dev = true,
	-- 	lazy = false,
	-- 	opts = {
	-- 		themes = {
	-- 			flexoki = {
	-- 				new_name = "chad-flexoki",
	-- 			},
	-- 			gruvbox = {
	-- 				new_name = "chad-gruvbox",
	-- 			},
	-- 		},
	-- 		disabled_integrations = {
	-- 			"minipick",
	-- 		},
	-- 	},
	-- },
	{
		"craftzdog/solarized-osaka.nvim",
		-- lazy = false,
		-- priority = 1000,
		opts = {
			transparent = false,
		},
		config = function(_, opts)
			require("solarized-osaka").setup(opts)
			vim.cmd.colorscheme("solarized-osaka")
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		-- lazy = false,
		-- priority = 1000,
		opts = {
			dark_variant = "moon",
			highlight_groups = {
				diffAdded = { fg = "foam" },
				diffChanged = { fg = "rose" },
				diffRemoved = { fg = "love" },
			},
			styles = {
				italic = true,
			},
		},
		config = function(_, opts)
			require("rose-pine").setup(opts)
			vim.cmd.colorscheme("rose-pine")
		end,
	},
	{
		"AstroNvim/astrotheme",
		-- lazy = false,
		-- priority = 1000,
		opts = {},
		config = function(_, opts)
			require("astrotheme").setup(opts)
			vim.cmd.colorscheme("astrotheme")
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		-- lazy = false,
		opts = {
			integrations = { blink_cmp = true },
			custom_highlights = function(c)
				return {
					BlinkCmpLabelMatch = { fg = c.pink },
					Pmenu = {},
				}
			end,
		},
		config = function(_, opts)
			require("catppuccin").setup(opts)
			vim.cmd.colorscheme("catppuccin-mocha")
		end,
	},
	"folke/tokyonight.nvim",
	"rebelot/kanagawa.nvim",
	{
		"EdenEast/nightfox.nvim",
		priority = 1000,
		-- lazy = false,
		opts = {
			options = {
				terminal_colors = true,
				inverse = {
					match_paren = true,
				},
				styles = {
					functions = "bold",
				},
			},
			groups = {
				all = {
					BlinkCmpGhostText = { link = "Comment" },
					MiniStatuslineModeInsert = { bg = "palette.pink", fg = "palette.bg0" },
				},
			},
			specs = {
				carbonfox = {
					syntax = {
						-- variable = "pink",
						string = "magenta",
						field = "pink",
						const = "magenta",
						func = "pink",
						conditional = "blue",
						keyword = "cyan",
						operator = "cyan",
					},
				},
			},
		},
		config = function(_, opts)
			require("nightfox").setup(opts)
			vim.cmd.colorscheme("carbonfox")
		end,
	},
	"nyoom-engineering/oxocarbon.nvim",
}
