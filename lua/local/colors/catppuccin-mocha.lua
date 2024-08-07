require("catppuccin").setup({
	default_integrations = true,
	flavour = "auto",
	background = {
		light = "latte",
		dark = "mocha",
	},
	integrations = {
		mini = {
			enabled = true,
			indentscope_color = "mauve",
		},
	},
	custom_highlights = function(colors)
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
})
-- vim.cmd.colorscheme("catppuccin")

require("mini.colors")
	.get_colorscheme("catppuccin", {
		new_name = "catppuccin-mocha",
	})
	:write()
