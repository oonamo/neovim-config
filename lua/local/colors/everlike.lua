require("catppuccin").setup({
	color_overrides = {
		mocha = {
			-- custom everforest dark hard port
			rosewater = "#fed1cb",
			flamingo = "#ff9185",
			pink = "#d699b6",
			mauve = "#cb7ec8",
			red = "#e06062",
			maroon = "#e67e80",
			peach = "#e69875",
			yellow = "#d3ad63",
			green = "#b0cc76",
			teal = "#6db57f",
			sky = "#7fbbb3",
			sapphire = "#60aaa0",
			blue = "#59a6c3",
			lavender = "#e0d3d4",
			text = "#e8e1bf",
			subtext1 = "#e0d7c3",
			subtext0 = "#d3c6aa",
			overlay2 = "#9da9a0",
			overlay1 = "#859289",
			overlay0 = "#6d6649",
			surface2 = "#585c4a",
			surface1 = "#414b50",
			surface0 = "#374145",
			base = "#1f2428",
			mantle = "#161b1d",
			crust = "#14181a",
		},
		latte = {
			-- custom everforest light hard port
			rosewater = "#a43b35",
			flamingo = "#da3537",
			pink = "#d332a1",
			mauve = "#aa3685",
			red = "#ff3532",
			maroon = "#de3631",
			peach = "#f36c0b",
			yellow = "#bd8800",
			green = "#596600",
			teal = "#287e5e",
			sky = "#52b1c7",
			sapphire = "#3fb4b8",
			blue = "#317da7",
			lavender = "#474155",
			text = "#4d4742",
			subtext1 = "#5b5549",
			subtext0 = "#6d6655",
			overlay2 = "#786d5a",
			overlay1 = "#8c7c62",
			overlay0 = "#a18d66",
			surface2 = "#c9bea5",
			surface1 = "#d8d3ba",
			surface0 = "#e8e2c8",
			base = "#ebe4c8",
			mantle = "#e1dab5",
			crust = "#bdc0a0",
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

local color_gen = require("mini.colors")
color_gen
	.get_colorscheme("catppuccin-mocha", {
		new_name = "everlike-dark",
	})
	:compress()
	:resolve_links()
	:write()
color_gen
	.get_colorscheme("catppuccin-latte", {
		new_name = "everlike-light",
	})
	:compress()
	:resolve_links()
	:write()
