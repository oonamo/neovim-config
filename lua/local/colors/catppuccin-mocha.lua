require("catppuccin").setup({
	default_integrations = false,
	flavour = "auto",
	background = {
		light = "latte",
		dark = "macchiato",
		-- dark = "mocha",
	},
	integrations = {
		cmp = true,
		fidget = false,
		gitsigns = false,
		harpoon = true,
		indent_blankline = {
			enabled = false,
			scope_color = "sapphire",
			colored_indent_levels = false,
		},
		mason = false,
		native_lsp = {
			enabled = true,
			virtual_text = {
				errors = { "italic" },
				hints = { "italic" },
				warnings = { "italic" },
				information = { "italic" },
				ok = { "italic" },
			},
			underlines = {
				errors = { "underline" },
				hints = { "underline" },
				warnings = { "underline" },
				information = { "underline" },
				ok = { "underline" },
			},
			inlay_hints = {
				background = true,
			},
		},
		noice = false,
		notify = false,
		symbols_outline = false,
		telescope = true,
		treesitter = true,
		treesitter_context = false,
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
		new_name = "catppuccin-macchiato",
	})
	:write()
