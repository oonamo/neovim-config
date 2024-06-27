local base = {
	red = "#ff657a",
	maroon = "#F29BA7",
	peach = "#ff9b5e",
	yellow = "#eccc81",
	green = "#a8be81",
	teal = "#9cd1bb",
	sky = "#A6C9E5",
	sapphire = "#86AACC",
	blue = "#5d81ab",
	lavender = "#66729C",
	mauve = "#b18eab",
}

local extend_base = function(value)
	return vim.tbl_extend("force", base, value)
end

require("catppuccin").setup({
	background = {
		dark = "frappe",
		light = "latte",
	},
	default_integrations = true,
	color_overrides = {
		latte = extend_base({
			text = "#202027",
			subtext1 = "#263168",
			subtext0 = "#4c4f69",
			overlay2 = "#737994",
			overlay1 = "#838ba7",
			base = "#fcfcfa",
			mantle = "#EAEDF3",
			crust = "#DCE0E8",
			pink = "#EA7A95",
			mauve = "#986794",
			red = "#EC5E66",
			peach = "#FF8459",
			yellow = "#CAA75E",
			green = "#87A35E",
		}),
		frappe = extend_base({
			text = "#fcfcfa",
			surface2 = "#535763",
			surface1 = "#3a3d4b",
			surface0 = "#30303b",
			base = "#202027",
			mantle = "#1c1d22",
			crust = "#171719",
		}),
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
-- vim.cmd.colorscheme("catppuccin-latte")

-- require("mini.colors")
-- 	.get_colorscheme("catppuccin-frappe", {
-- 		new_name = "kopicat",
-- 	})
-- 	:compress()
-- 	:resolve_links()
-- 	:write()
