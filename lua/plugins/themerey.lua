return {
	{
		"haystackandroid/rusticated",
		lazy = true,
		config = function()
			O = { colorscheme = "rusticated", fn = "rusticated" }
		end,
	},
	{ "Yazeed1s/oh-lucy.nvim", lazy = true, enabled = false },
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
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			O = {
				colorscheme = "rose-pine",
				fn = "prime-pine",
			}
			require("rose-pine").setup({
				extend_background_behind_borders = true,
				styles = {
					bold = true,
					italic = true,
					transparency = true,
				},
				highlight_groups = {
					TelescopeBorder = { fg = "highlight_high", bg = "none" },
					TelescopeNormal = { bg = "none" },
					TelescopePromptNormal = { bg = "base" },
					TelescopeResultsNormal = { fg = "subtle", bg = "none" },
					TelescopeSelection = { fg = "text", bg = "base" },
					TelescopeSelectionCaret = { fg = "rose", bg = "rose" },

					StatusLineNC = { fg = "#ffffff", bg = "#ffffff" },
					-- StatusLineExtra = { fg = "#698282", bg = "#27272a" },
					StatuslineAccent = { bg = "surface", fg = "love" },
					StatuslineInsertAccent = { bg = "love", fg = "surface" },
					CursorLine = { bg = "foam", blend = 10 },
					ColorColumn = { bg = "_experimental_nc" },
				},
				disable_background = true,
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
	{ "nordtheme/vim", name = "nord", lazy = true },
	{ "nyoom-engineering/oxocarbon.nvim", lazy = true },
	{ "neanias/everforest-nvim", lazy = true },
	{
		"olivercederborg/poimandres.nvim",
		config = function()
			require("poimandres").setup()
		end,
		lazy = true,
	},
}
