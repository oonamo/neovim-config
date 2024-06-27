require("catppuccin").setup({
	color_overrides = {
		mocha = {
			rosewater = "#ffffff",
			flamingo = "#ffffff",
			red = "#ffdd33",
			maroon = "#ffffff",
			pink = "#ffdd33",
			mauve = "#ffdd33",
			peach = "#96a6c8",
			yellow = "#899b92",
			green = "#73c936",
			teal = "#88b992",
			sky = "#cc8c3c",
			sapphire = "#96a6c8",
			blue = "#778899",
			lavender = "#778899",
			text = "#eae3d5",
			subtext1 = "#d5c9b7",
			subtext0 = "#bfb3a5",
			overlay2 = "#aca195",
			overlay1 = "#958b7e",
			overlay0 = "#6f6660",
			surface2 = "#585858",
			surface1 = "#4b4b4b",
			surface0 = "#353535",
			base = "#181818",
			mantle = "#1d2021",
			crust = "#1d2021",
		},
	},

	highlight_overrides = {
		all = function(colors)
			return {
				TelescopePreviewBorder = { bg = colors.crust, fg = colors.crust },
				TelescopePreviewNormal = { bg = colors.crust },
				TelescopePreviewTitle = { fg = colors.crust, bg = colors.crust },
				TelescopePromptBorder = { bg = colors.surface0, fg = colors.surface0 },
				TelescopePromptCounter = { fg = colors.mauve, style = { "bold" } },
				TelescopePromptNormal = { bg = colors.surface0 },
				TelescopePromptPrefix = { bg = colors.surface0 },
				TelescopePromptTitle = { fg = colors.surface0, bg = colors.surface0 },
				TelescopeResultsBorder = { bg = colors.mantle, fg = colors.mantle },
				TelescopeResultsNormal = { bg = colors.mantle },
				TelescopeResultsTitle = { fg = colors.mantle, bg = colors.mantle },
				TelescopeSelection = { bg = colors.surface0 },
			}
		end,
	},
})

-- vim.cmd.colorscheme("catppuccin-mocha")
require("mini.colors")
	.get_colorscheme("catppuccin-mocha", {
		new_name = "gruber-dark",
	})
	:compress()
	:resolve_links()
	:write()
