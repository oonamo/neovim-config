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
	integrations = {
		alpha = false,
		cmp = true,
		dap = true,
		dap_ui = true,
		dashboard = false,
		diffview = false,
		flash = false,
		gitsigns = false,
		harpoon = true,
		markdown = true,
		neogit = false,
		neotree = false,
		nvimtree = false,
		ufo = false,
		rainbow_delimiters = false,
		semantic_tokens = true,
		telescope = { enabled = true },
		treesitter = true,
		treesitter_context = true,
		barbecue = {
			dim_dirname = true,
			bold_basename = true,
			dim_context = false,
			alt_background = false,
		},
		illuminate = {
			enabled = false,
			lsp = false,
		},
		indent_blankline = {
			enabled = false,
			scope_color = "",
			colored_indent_levels = false,
		},
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
		navic = {
			enabled = false,
			custom_bg = "NONE",
		},
		dropbar = {
			enabled = true,
			color_mode = false,
		},
		colorful_winsep = {
			enabled = false,
			color = "red",
		},
		mini = {
			enabled = true,
			indentscope_color = "text",
		},
	},
	highlight_overrides = {
		all = function(colors)
			return {
				CurSearch = { bg = colors.sky },
				IncSearch = { bg = colors.sky },
				DashboardFooter = { fg = colors.overlay0 },
				TreesitterContextBottom = { style = {} },
				-- ["@markup.italic"] = { fg = colors.blue, style = { "italic" } },
				["@markup.strong"] = { fg = colors.blue, style = { "bold" } },
				Headline = { style = { "bold" } },
				Headline1 = { fg = colors.blue, style = { "bold" } },
				Headline2 = { fg = colors.pink, style = { "bold" } },
				Headline3 = { fg = colors.lavender, style = { "bold" } },
				Headline4 = { fg = colors.green, style = { "bold" } },
				Headline5 = { fg = colors.peach, style = { "bold" } },
				Headline6 = { fg = colors.flamingo, style = { "bold" } },
				rainbow1 = { fg = colors.blue, style = { "bold" } },
				rainbow2 = { fg = colors.pink, style = { "bold" } },
				rainbow3 = { fg = colors.lavender, style = { "bold" } },
				rainbow4 = { fg = colors.green, style = { "bold" } },
				rainbow5 = { fg = colors.peach, style = { "bold" } },
				rainbow6 = { fg = colors.flamingo, style = { "bold" } },

				NormalFloat = { bg = colors.base },
				Pmenu = { bg = colors.mantle, fg = "" },
				PmenuSel = { bg = colors.surface0, fg = "" },
				CursorLineNr = { fg = colors.red },
				LineNr = { fg = colors.yellow },
				LineNrAbove = { fg = colors.surface1 },
				LineNrBelow = { fg = colors.surface1 },
				FloatBorder = { bg = colors.base, fg = colors.surface0 },
				VertSplit = { bg = colors.base, fg = colors.surface0 },
				WinSeparator = { bg = colors.base, fg = colors.surface0 },
				LspInfoBorder = { link = "FloatBorder" },
				YankHighlight = { bg = colors.surface2 },
				CmpItemMenu = { fg = colors.surface2 },

				GitSignsChange = { fg = colors.peach },

				NeoTreeDirectoryIcon = { fg = colors.subtext1 },
				NeoTreeDirectoryName = { fg = colors.subtext1 },
				NeoTreeFloatBorder = { link = "TelescopeResultsBorder" },
				NeoTreeGitConflict = { fg = colors.red },
				NeoTreeGitDeleted = { fg = colors.red },
				NeoTreeGitIgnored = { fg = colors.overlay0 },
				NeoTreeGitModified = { fg = colors.peach },
				NeoTreeGitStaged = { fg = colors.green },
				NeoTreeGitUnstaged = { fg = colors.red },
				NeoTreeGitUntracked = { fg = colors.green },
				NeoTreeIndent = { link = "IblIndent" },
				NeoTreeNormal = { bg = colors.mantle },
				NeoTreeNormalNC = { bg = colors.mantle },
				NeoTreeRootName = { fg = colors.subtext1, style = { "bold" } },
				NeoTreeTabActive = { fg = colors.text, bg = colors.mantle },
				NeoTreeTabInactive = { fg = colors.surface2, bg = colors.crust },
				NeoTreeTabSeparatorActive = { fg = colors.mantle, bg = colors.mantle },
				NeoTreeTabSeparatorInactive = { fg = colors.crust, bg = colors.crust },
				NeoTreeWinSeparator = { fg = colors.base, bg = colors.base },

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

				WhichKeyFloat = { bg = colors.mantle },

				IblIndent = { fg = colors.surface0 },
				IblScope = { fg = colors.overlay0 },

				MasonNormal = { bg = colors.mantle },
				MasonMutedBlock = { link = "CursorLine" },

				LazyNormal = { bg = colors.mantle },
			}
		end,
	},
})

local function something()
	print("something")
end

vim.cmd.colorscheme("catppuccin-mocha")
require("mini.colors")
	.get_colorscheme("catppuccin-mocha", {
		new_name = "gruber-dark",
	})
	:compress()
	:resolve_links()
	:write()
