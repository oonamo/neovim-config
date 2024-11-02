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
		opts = {
			color_overrides = {
				macchiato = {
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
				-- everforest
			},
			highlight_overrides = {
				macchiato = function(colors)
					return {
						CurSearch = { bg = colors.sky },
						IncSearch = { bg = colors.sky },
						-- DashboardFooter = { fg = colors.overlay0 },
						-- TreesitterContextBottom = { style = {} },
						-- ["@markup.italic"] = { fg = colors.blue, style = { "italic" } },
						-- ["@markup.strong"] = { fg = colors.blue, style = { "bold" } },
						-- Headline = { style = { "bold" } },
						-- Headline1 = { fg = colors.blue, style = { "bold" } },
						-- Headline2 = { fg = colors.pink, style = { "bold" } },
						-- Headline3 = { fg = colors.lavender, style = { "bold" } },
						-- Headline4 = { fg = colors.green, style = { "bold" } },
						-- Headline5 = { fg = colors.peach, style = { "bold" } },
						-- Headline6 = { fg = colors.flamingo, style = { "bold" } },
						-- rainbow1 = { fg = colors.blue, style = { "bold" } },
						-- rainbow2 = { fg = colors.pink, style = { "bold" } },
						-- rainbow3 = { fg = colors.lavender, style = { "bold" } },
						-- rainbow4 = { fg = colors.green, style = { "bold" } },
						-- rainbow5 = { fg = colors.peach, style = { "bold" } },
						-- rainbow6 = { fg = colors.flamingo, style = { "bold" } },
						--
						-- NormalFloat = { bg = colors.base },
						-- Pmenu = { bg = colors.mantle, fg = "" },
						-- PmenuSel = { bg = colors.surface0, fg = "" },
						-- CursorLineNr = { fg = colors.red },
						-- LineNr = { fg = colors.yellow },
						-- LineNrAbove = { fg = colors.surface1 },
						-- LineNrBelow = { fg = colors.surface1 },
						-- FloatBorder = { bg = colors.base, fg = colors.surface0 },
						-- VertSplit = { bg = colors.base, fg = colors.surface0 },
						-- WinSeparator = { bg = colors.base, fg = colors.surface0 },
						-- LspInfoBorder = { link = "FloatBorder" },
						-- YankHighlight = { bg = colors.surface2 },
						-- CmpItemMenu = { fg = colors.surface2 },
						--
						-- GitSignsChange = { fg = colors.peach },
						--
						-- NeoTreeDirectoryIcon = { fg = colors.subtext1 },
						-- NeoTreeDirectoryName = { fg = colors.subtext1 },
						-- NeoTreeFloatBorder = { link = "TelescopeResultsBorder" },
						-- NeoTreeGitConflict = { fg = colors.red },
						-- NeoTreeGitDeleted = { fg = colors.red },
						-- NeoTreeGitIgnored = { fg = colors.overlay0 },
						-- NeoTreeGitModified = { fg = colors.peach },
						-- NeoTreeGitStaged = { fg = colors.green },
						-- NeoTreeGitUnstaged = { fg = colors.red },
						-- NeoTreeGitUntracked = { fg = colors.green },
						-- NeoTreeIndent = { link = "IblIndent" },
						-- NeoTreeNormal = { bg = colors.mantle },
						-- NeoTreeNormalNC = { bg = colors.mantle },
						-- NeoTreeRootName = { fg = colors.subtext1, style = { "bold" } },
						-- NeoTreeTabActive = { fg = colors.text, bg = colors.mantle },
						-- NeoTreeTabInactive = { fg = colors.surface2, bg = colors.crust },
						-- NeoTreeTabSeparatorActive = { fg = colors.mantle, bg = colors.mantle },
						-- NeoTreeTabSeparatorInactive = { fg = colors.crust, bg = colors.crust },
						-- NeoTreeWinSeparator = { fg = colors.base, bg = colors.base },
						--
						-- TelescopePreviewBorder = { bg = colors.crust, fg = colors.crust },
						-- TelescopePreviewNormal = { bg = colors.crust },
						-- TelescopePreviewTitle = { fg = colors.crust, bg = colors.crust },
						-- TelescopePromptBorder = { bg = colors.surface0, fg = colors.surface0 },
						-- TelescopePromptCounter = { fg = colors.mauve, style = { "bold" } },
						-- TelescopePromptNormal = { bg = colors.surface0 },
						-- TelescopePromptPrefix = { bg = colors.surface0 },
						-- TelescopePromptTitle = { fg = colors.surface0, bg = colors.surface0 },
						-- TelescopeResultsBorder = { bg = colors.mantle, fg = colors.mantle },
						-- TelescopeResultsNormal = { bg = colors.mantle },
						-- TelescopeResultsTitle = { fg = colors.mantle, bg = colors.mantle },
						-- TelescopeSelection = { bg = colors.surface0 },
						--
						-- WhichKeyFloat = { bg = colors.mantle },
						--
						-- IblIndent = { fg = colors.surface0 },
						-- IblScope = { fg = colors.overlay0 },
						--
						-- MasonNormal = { bg = colors.mantle },
						-- MasonMutedBlock = { link = "CursorLine" },
						--
						-- LazyNormal = { bg = colors.mantle },
					}
				end,
			},
			custom_highlights = function(c)
				return {
					CmpItemKindSnippet = { fg = c.mauve },
					CmpItemKindKeyword = { fg = c.red },
					CmpItemKindText = { fg = c.teal },
					CmpItemKindMethod = { fg = c.blue },
					CmpItemKindConstructor = { fg = c.blue },
					CmpItemKindFunction = { fg = c.blue },
					CmpItemKindFolder = { fg = c.blue },
					CmpItemKindModule = { fg = c.blue },
					CmpItemKindConstant = { fg = c.peach },
					CmpItemKindField = { fg = c.green },
					CmpItemKindProperty = { fg = c.green },
					CmpItemKindEnum = { fg = c.green },
					CmpItemKindUnit = { fg = c.green },
					CmpItemKindClass = { fg = c.yellow },
					CmpItemKindVariable = { fg = c.flamingo },
					CmpItemKindFile = { fg = c.blue },
					CmpItemKindInterface = { fg = c.yellow },
					CmpItemKindColor = { fg = c.red },
					CmpItemKindReference = { fg = c.red },
					CmpItemKindEnumMember = { fg = c.red },
					CmpItemKindStruct = { fg = c.blue },
					CmpItemKindValue = { fg = c.peach },
					CmpItemKindEvent = { fg = c.blue },
					CmpItemKindOperator = { fg = c.blue },
					CmpItemKindTypeParameter = { fg = c.blue },
					CmpItemKindCopilot = { fg = c.teal },
					PmenuSel = { bg = c.green, fg = c.base },
					CmpItemAbbr = { fg = c.text },
					CmpItemAbbrMatch = { fg = c.blue, bold = true },
					CmpSel = { bg = c.surface0 },
					Pmenu = { bg = c.mantle },
					CmpBorder = { fg = c.mantle, bg = c.mantle },
					CmpDoc = {
						bg = c.crust,
					},
					CmpDocBorder = {
						fg = c.crust,
						bg = c.crust,
					},
				}
			end,
		},
		config = function(_, opts)
			require("catppuccin").setup(opts)
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
		-- lazy = false,
		-- priority = 1000, -- make sure to load this before all the other start plugins
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
  {
    "Mofiqul/vscode.nvim",
    -- lazy = false,
    -- priority = 1000,
    opts = {},
    config = function(_, opts)
      require("vscode").setup(opts)
      vim.cmd.colorscheme("vscode")
    end
  },
}
