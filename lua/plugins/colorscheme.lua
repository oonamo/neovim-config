return {
	{
		"EdenEast/nightfox.nvim",
		-- lazy = false,
		-- priority = 1000,
		opts = {},
		config = function(_, opts)
			require("nightfox").setup(opts)
			vim.cmd.colorscheme("nordfox")
		end,
	},
	{
		"catppuccin/nvim",
		-- lazy = false, -- make sure we load this during startup if it is your main colorscheme
		-- priority = 1000, -- make sure to load this before all the other start plugins
		name = "catppuccin",
		config = function()
			vim.cmd.colorscheme("catppuccin")
		end,
	},
	{
		"navarasu/onedark.nvim",
		-- lazy = false, -- make sure we load this during startup if it is your main colorscheme
		-- priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			vim.cmd.colorscheme("onedark")
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		-- lazy = false,
		-- priority = 1000,
	},
	{
		"zenbones-theme/zenbones.nvim",
		init = function()
			vim.g.zenbones_compat = 1
			vim.g.bones_compat = 1
		end,
		config = function()
			vim.g.forestbones_lightness = "dim"
			vim.cmd.colorscheme("forestbones")
			local normal = vim.api.nvim_get_hl(0, {
				name = "Normal",
			})
			vim.api.nvim_set_hl(0, "Normal", { fg = normal.fg, bg = "#1c2225" })
		end,
	},
	-- {
	-- 	"sainnhe/everforest",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.g.everforest_enable_italic = 1
	-- 		vim.g.everforest_background = "hard"
	-- 		vim.g.everforest_dim_inactive_windows = 0
	-- 		vim.g.everforest_ui_contrast = "high"
	-- 		vim.g.everforest_float_style = "dim"
	-- 		vim.g.everforest_diagnostic_text_highlight = 1
	-- 		vim.g.everforest_diagnostic_virtual_text = "highlighted"
	-- 		vim.g.everforest_spell_foreground = "colored"
	-- 		vim.g.everforest_diagnostic_line_highlight = 1
	-- 		vim.g.everforest_better_performance = 1
	-- 		vim.cmd.colorscheme("everforest")
	-- 	end,
	-- },
	{
		"neanias/everforest-nvim",
		lazy = false,
		priority = 1000, -- make sure to load this before all the other start plugins
		-- Optional; default configuration will be used if setup isn't called.
		config = function()
			require("everforest").setup({
				---Controls the "hardness" of the background. Options are "soft", "medium" or "hard".
				---Default is "medium".
				background = "hard",
				---How much of the background should be transparent. 2 will have more UI
				---components be transparent (e.g. status line background)
				transparent_background_level = 0,
				---Whether italics should be used for keywords and more.
				italics = true,
				---Disable italic fonts for comments. Comments are in italics by default, set
				---this to `true` to make them _not_ italic!
				disable_italic_comments = false,
				---By default, the colour of the sign column background is the same as the as normal text
				---background, but you can use a grey background by setting this to `"grey"`.
				sign_column_background = "none",
				---The contrast of line numbers, indent lines, etc. Options are `"high"` or
				---`"low"` (default).
				ui_contrast = "high",
				---Dim inactive windows. Only works in Neovim. Can look a bit weird with Telescope.
				---
				---When this option is used in conjunction with show_eob set to `false`, the
				---end of the buffer will only be hidden inside the active window. Inside
				---inactive windows, the end of buffer filler characters will be visible in
				---dimmed symbols. This is due to the way Vim and Neovim handle `EndOfBuffer`.
				dim_inactive_windows = false,
				---Some plugins support highlighting error/warning/info/hint texts, by
				---default these texts are only underlined, but you can use this option to
				---also highlight the background of them.
				diagnostic_text_highlight = true,
				---Which colour the diagnostic text should be. Options are `"grey"` or `"coloured"` (default)
				diagnostic_virtual_text = "coloured",
				---Some plugins support highlighting error/warning/info/hint lines, but this
				---feature is disabled by default in this colour scheme.
				diagnostic_line_highlight = false,
				---By default, this color scheme won't colour the foreground of |spell|, instead
				---colored under curls will be used. If you also want to colour the foreground,
				---set this option to `true`.
				spell_foreground = false,
				---Whether to show the EndOfBuffer highlight.
				show_eob = true,
				---Style used to make floating windows stand out from other windows. `"bright"`
				---makes the background of these windows lighter than |hl-Normal|, whereas
				---`"dim"` makes it darker.
				---
				---Floating windows include for instance diagnostic pop-ups, scrollable
				---documentation windows from completion engines, overlay windows from
				---installers, etc.
				---
				---NB: This is only significant for dark backgrounds as the light palettes
				---have the same colour for both values in the switch.
				float_style = "dim",
				---Inlay hints are special markers that are displayed inline with the code to
				---provide you with additional information. You can use this option to customize
				---the background color of inlay hints.
				---
				---Options are `"none"` or `"dimmed"`.
				inlay_hints_background = "none",
				on_highlights = function(h, p)
					-- bg_dim = "#1e2326",
					-- bg0 = "#272e33",
					-- bg1 = "#2e383c",
					-- bg2 = "#374145",
					-- bg3 = "#414b50",
					-- bg4 = "#495156",
					-- bg5 = "#4f5b58",
					-- bg_visual = "#4c3743",
					-- bg_red = "#493b40",
					-- bg_green = "#3c4841",
					-- bg_blue = "#384b55",
					-- bg_yellow = "#45443c",
					h.MiniCursorword = { underline = true, sp = p.bg_yellow }
					h.MiniCursorwordCurrent = { underline = true, sp = p.bg_visual }
				end,
			})
			vim.cmd.colorscheme("everforest")
		end,
	},
	{
		"comfysage/evergarden",
		config = function()
			require("evergarden").setup({
				contrast_dark = "hard", -- 'hard'|'medium'|'soft'
			})
			vim.cmd.colorscheme("evergarden")
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		-- lazy = false,
		-- priority = 1000,
		opts = {
			styles = {
				italic = false,
			},
			highlight_groups = {
				["@namespace.builtin"] = { fg = "love" },
			},
		},
		config = function(_, opts)
			require("rose-pine").setup(opts)
			vim.cmd.colorscheme("rose-pine")
		end,
	},
}
