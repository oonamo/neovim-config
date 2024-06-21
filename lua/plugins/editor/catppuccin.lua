-- TODO: SO SLOWWWWWWWWWWWW
return {
	"catppuccin/nvim",
	name = "catppuccin",
	-- lazy = false,
	-- priority = 1000,
	-- init = function()
	-- 	vim.o.background = "dark"
	-- end,
	config = function()
		require("catppuccin").setup({
			default_integrations = false,
			flavour = "auto",
			background = {
				light = "latte",
				-- dark = "macchiato",
				dark = "mocha",
			},
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
					String = { fg = colors.pink },
				}
			end,
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}
