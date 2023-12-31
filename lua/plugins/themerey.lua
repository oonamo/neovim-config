return {
	{
		"zaldih/themery.nvim",
		config = function()
			require("themery").setup({
				themes = {
					"rose-pine",
					-- "rose-pine-dawn",
					-- "rose-pine-main",
					"mellow",
					-- "oh-lucy",
					-- "oh-lucy-evening",
					-- "nordfox",
					-- "carbonfox",
					-- "duskfox",
					"rusticated",
					"nord",
					"newpaper",
				},
				themeConfigFile = "~/.config/nvim/lua/onam/theme.lua",
				livePreview = true,
			})
		end,
		keys = {
			{ "<leader>th", "<cmd>Themery<CR>", { desc = "open themery" } },
		},
	},
	{
		"haystackandroid/rusticated",
		lazy = false,
		config = function()
			O = { colorscheme = "rusticated", fn = "rusticated" }
		end,
	},
	{ "Yazeed1s/oh-lucy.nvim", lazy = true, enabled = false },
	{
		"kvrohit/mellow.nvim",
		lazy = false,
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
				highlight_groups = {
					TelescopeBorder = { fg = "highlight_high", bg = "none" },
					TelescopeNormal = { bg = "none" },
					TelescopePromptNormal = { bg = "base" },
					TelescopeResultsNormal = { fg = "subtle", bg = "none" },
					TelescopeSelection = { fg = "text", bg = "base" },
					TelescopeSelectionCaret = { fg = "rose", bg = "rose" },

					StatusLineNC = { fg = "#ffffff", bg = "#ffffff" },
					--TODO: Cool color combination
					-- StatusLineExtra = { fg = "#698282", bg = "#27272a" },
					StatuslineAccent = { bg = "surface", fg = "love" },
					StatuslineInsertAccent = { bg = "love", fg = "surface" },
					-- StatuslineAccent = { bg = "surface", fg = "love" },
					-- StatuslineInsertAccent = { bg = "love", fg = "surface" },
					-- StatuslineVisualAccent = { bg = "#b3c3c4", fg = "#27272a" },
					-- StatuslineCmdAccent = { bg = "#dda0dd", fg = "#27272a" },
					-- StatuslineReplaceAccent = { bold = true, fg = "#698282" },
				},
				disable_background = true,
			})
		end,
	},
	{
		"yorik1984/newpaper.nvim",
		lazy = false,
		config = function()
			O = {
				colorscheme = "newpaper",
				fn = "newpaper",
			}
		end,
	},
	{ "EdenEast/nightfox.nvim", lazy = true, enabled = false },
	{ "nordtheme/vim", name = "nord", lazy = true },
}
