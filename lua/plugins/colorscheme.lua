return {
	{
		"folke/tokyonight.nvim",
		-- lazy = false,
		priority = 1000,
		opts = {
			style = "night",
			day_brightness = 0.3,
			on_highlights = function(hl, c)
				local prompt = "#2d3149"
				hl.TelescopeNormal = {
					bg = c.bg_dark,
					fg = c.fg_dark,
				}
				hl.TelescopeBorder = {
					bg = c.bg_dark,
					fg = c.bg_dark,
				}
				hl.TelescopePromptNormal = {
					bg = prompt,
				}
				hl.TelescopePromptBorder = {
					bg = prompt,
					fg = prompt,
				}
				hl.TelescopePromptTitle = {
					bg = prompt,
					fg = prompt,
				}
				hl.TelescopePreviewTitle = {
					bg = c.bg_dark,
					fg = c.bg_dark,
				}
				hl.TelescopeResultsTitle = {
					bg = c.bg_dark,
					fg = c.bg_dark,
				}
			end,
		},
		config = function(_, opts)
			require("tokyonight").setup(opts)
			vim.cmd.colorscheme("tokyonight")
		end,
	},
	{
		-- "catppuccin/nvim",
		-- name = "catppuccin",
		-- -- lazy = false,
		-- -- priority = 1000,
		-- init = function()
		-- 	vim.o.background = "dark"
		-- end,
		-- config = function()
		-- 	require("catppuccin").setup({
		-- 		default_integrations = true,
		-- 		flavour = "auto",
		-- 		background = {
		-- 			light = "latte",
		-- 			dark = "macchiato",
		-- 			-- dark = "mocha",
		-- 		},
		-- 		integrations = {
		-- 			mini = {
		-- 				enabled = true,
		-- 				indentscope_color = "mauve",
		-- 			},
		-- 		},
		-- 		custom_highlights = function(colors)
		-- 			return {
		-- 				TelescopePreviewBorder = { bg = colors.crust, fg = colors.crust },
		-- 				TelescopePreviewNormal = { bg = colors.crust },
		-- 				TelescopePreviewTitle = { fg = colors.crust, bg = colors.crust },
		-- 				TelescopePromptBorder = { bg = colors.surface0, fg = colors.surface0 },
		-- 				TelescopePromptCounter = { fg = colors.mauve, style = { "bold" } },
		-- 				TelescopePromptNormal = { bg = colors.surface0 },
		-- 				TelescopePromptPrefix = { bg = colors.surface0 },
		-- 				TelescopePromptTitle = { fg = colors.surface0, bg = colors.surface0 },
		-- 				TelescopeResultsBorder = { bg = colors.mantle, fg = colors.mantle },
		-- 				TelescopeResultsNormal = { bg = colors.mantle },
		-- 				TelescopeResultsTitle = { fg = colors.mantle, bg = colors.mantle },
		-- 				TelescopeSelection = { bg = colors.surface0 },
		-- 			}
		-- 		end,
		-- 	})
		-- 	vim.cmd.colorscheme("catppuccin")
		-- end,
	},
}
