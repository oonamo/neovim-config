require("catppuccin").setup({
	default_integrations = false,
	integrations = {
		cmp = true,
		fidget = false,
		gitsigns = false,
		harpoon = false,
		indent_blankline = {
			enabled = false,
			scope_color = "sapphire",
			colored_indent_levels = false,
		},
		mason = true,
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
		notify = true,
		symbols_outline = false,
		telescope = false,
		treesitter = true,
		treesitter_context = false,
		mini = {
			enabled = true,
			indentscope_color = "mauve",
		},
	},
	custom_highlights = function(colors)
		return {
			MiniTablineCurrent = { link = "Normal" },
		}
	end,
})

vim.o.background = "dark"
vim.cmd.colorscheme("catppuccin-macchiato")
