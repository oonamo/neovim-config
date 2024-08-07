require("catppuccin").setup({
	term_colors = true,
	flavour = "frappe", -- latte, frappe, macchiato, mocha
	transparent_background = true,
	styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
		comments = { "italic" }, -- Change the style of comments
		conditionals = { "italic" },
		loops = { "italic" },
		functions = {},
		keywords = { "italic" },
		strings = {},
		variables = {},
		numbers = {},
		booleans = {},
		properties = {},
		types = {},
		operators = {},
	},
	color_overrides = {
		all = {
			-- green = '#81c8be',
			-- red = '#eb6f92',
			-- blue = '#a3b8ef',

			-- mauve = '#ADD7FF',
			-- yellow = '#A6ACCD',
			-- maroon = '#9398cf',
			-- peach = '#ebbcba',
			-- overlay2 = '#89DDFF'
		},
	},
	custom_highlights = function(colors)
		return {
			["@text"] = { fg = colors.surface0 },
			-- ['@punctuation.bracket'] = { italic = true },
			MiniCursorword = { underline = false, link = "Visual" },
			MiniCursorwordCurrent = { link = "MiniCursorword" },
			NormalFloat = { bg = "NONE" },
			FloatBorder = { fg = colors.surface0, bg = "NONE" },
			FzfLuaNormal = { link = "NormalFloat" },
			FzfLuaBorder = { link = "FloatBorder" },
			NoiceCmdlinePopupBorder = { link = "FloatBorder" },
			IndentBlanklineChar = { fg = colors.surface0 },
			FzfLuaTitle = { bg = colors.green, fg = colors.base, bold = false },
			FzfLuaHeaderText = { fg = colors.sky },
			TreeSitterContext = { underline = false, bg = colors.surface0 },
			TreeSitterContextBottom = { underline = false, bg = colors.surface0 },

			["@lsp.typemod.selfKeyword"] = { fg = colors.red },
			["@lsp.type.selfTypeKeyword"] = { fg = colors.red },
			["@lsp.typemod.decorator"] = { link = "special" },
			["@namespace"] = { style = { "nocombine" } },
			["@module"] = { style = { "nocombine" } },
			TreesitterContextLineNumber = { fg = "#494D64", bg = "#1e2030" },
			CursorLine = { bg = "#292D3F" },
			Comment = { link = "NvimTreeFolderIcon" },
			WinbarFolder = { fg = "#8F98B8" },
			WinbarFileName = { fg = "#B6BDFD" },
			["@function.builtin"] = { link = "Function" },
			["@punctuation.bracket"] = { link = "Comment", italic = true },
			["@punctuation.special.rust"] = { link = "Comment" },
			String = { fg = "#92be83" },
			GlancePreviewMatch = { fg = "#ffffff", bg = "#304E75" },
			GlanceWinbarFileName = { link = "NvimTreeRootFolder" },
			GlanceListMatch = { fg = "#8AADF4" },
			CmpItemAbbrMatch = { fg = "none", style = { "bold" } },
			CmpItemAbbrMatchFuzzy = { link = "CmpItemAbbrMatch" },
			GlanceWinbarFolderName = { link = "Comment" },
			GlanceListCursorLine = { bg = "#212635" },
			-- GlanceListNormal = { fg = "#8F98B8", bg = "#15182A" },
			-- GlancePreviewNormal = { bg = "#1A1E30" },
			LspInlayHint = { fg = "#8D98BB", bg = colors.none },
			NvimTreeOpenedFile = { fg = "#cad3f5" },
			NvimTreeRootFolder = { fg = "#B6BDFD", style = { "nocombine" } },
			NvimTreeFolderName = { link = "Directory" },
			NvimTreeOpenedFolderName = { link = "NvimTreeOpenedFile" },
			NvimTreeFolderIcon = { link = "Directory" },
			NvimTreeFileIcon = { fg = "#CAD3F5" },
			NvimTreeCursorLine = { bg = "#24273A" },
			NvimTreeNormal = { bg = "#1e2030", fg = "#8F98B8" },
			Folded = { link = "CursorLine" },
			Directory = { fg = "#8F98B8" },
			ArrowCurrentFile = { link = "Comment" },
			TermCursor = { fg = "#000000", bg = "#B7BDF8" },
			Visual = { bg = "#304E75", style = { "nocombine" } },
			NvimTreeWinSeparator = { link = "WinSeparator" },
			CmpGhostText = { fg = "#6C7086", style = { "italic" } },
			CmpItemMenu = { link = "Comment" },
			TelescopeMatching = { style = { "bold" } },
			TelescopeNormal = { bg = "#1E2031", style = { "nocombine" } },
			TelescopeBorder = { bg = "#1E2031", style = { "nocombine" } },
			TelescopeSelection = { style = { "nocombine" } },
			MyNormalFloat = { bg = "#1e2030" },
			MyCursorLine = { bg = "#283E5B" },
			MatchParen = { fg = "#F0C6C6", style = { "nocombine" }, bg = colors.none },
			LualineCursorLine = { bg = "#2A2B3C" },
			Unvisited = { bg = "#34344F" },
			MiniIndentscopeSymbol = { fg = "#6C7086" },
			illuminatedwordwrite = { bg = "#253C59" },
			illuminatedwordread = { bg = "#32354A" },
			illuminatedWordText = { bg = "#32354A" },
		}
	end,
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
})

vim.cmd.colorscheme("catppuccin")

require("mini.colors")
	.get_colorscheme("catppuccin-frappe", {
		new_name = "catppuccin-super",
	})
	:resolve_links()
	:compress()
	:write()
