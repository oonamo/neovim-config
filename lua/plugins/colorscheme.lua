require("colors")
Colors.register("tokyonight"):add_flavours({
	"night",
	"moon",
})
-- :apply("moon")
Colors.register("everforest"):add_flavours({
	"dark",
	"light",
}, function(_, flavour)
	vim.o.bg = flavour or "dark"
	vim.cmd.colorscheme("everforest")
end)

Colors.register("gruvbox-material")
Colors.register("rose-pine")
Colors.register("nightfox"):add_flavours({
	"night",
	"dusk",
	"tera",
	"nord",
	"day",
	"dawn",
}, function(_, flavour)
	if flavour then
		vim.cmd.colorscheme(flavour .. "fox")
	else
		vim.cmd.colorscheme("duskfox")
	end
end)

return {
	{
		"folke/tokyonight.nvim",
		-- lazy = false,
		priority = 1000,
		opts = {
			style = "moon",
			day_brightness = 0.3,
		},
		config = function(_, opts)
			require("tokyonight").setup(opts)
			vim.cmd.colorscheme("tokyonight")
		end,
	},
	{
		"catppuccin/nvim",
	},
	{
		"sainnhe/everforest",
		config = function()
			vim.g.everforest_better_performance = 1
			vim.g.everforest_enable_italic = true
			vim.g.everforest_background = "hard"
			vim.g.everforest_dim_inactive_windows = 1
			vim.g.everforest_sign_column_background = 1
			vim.cmd.colorscheme("everforest")
		end,
	},
	{
		"sainnhe/gruvbox-material",
		config = function()
			vim.g.gruvbox_material_better_performance = 1
			vim.g.gruvbox_material_background = "soft"
			vim.g.gruvbox_material_enable_italic = 1
			vim.g.gruvbox_material_enable_bold = 1
			vim.g.gruvbox_material_dim_inactive_windows = 1
			vim.g.gruvbox_material_diagnostic_virtual_test = "highlighted"
			vim.g.gruvbox_material_ui_contrast = "high"
			vim.cmd.colorscheme("gruvbox-material")
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				variant = "auto",
				dim_inactive_windows = true,
				extend_background_behind_borders = false,
				styles = {
					bold = true,
					italic = false,
					transparency = false,
				},
				highlight_groups = {
					-- Normal = { fg = "#908caa" },
					-- Normal = { fg = "#908caa", bg = "base" },
					-- NormalNC = { link = "Normal" },
					GitSignsAdd = { bg = "none" },
					GitSignsChange = { bg = "none" },
					GitSignsDelete = { bg = "none" },
					MiniCursorword = { underline = false, bg = "foam", blend = 30 },
					LocalHighlight = { underline = false, bg = "foam", blend = 30 },
					HopNextKey1 = { fg = "love" },
					HopNextKey2 = { fg = "pine" },
					Keyword = { bold = true, italic = true },
					VertSplit = { fg = "#405879" },
					-- TreesitterContext = { bg = "muted", blend = 15 },
					-- TreesitterContextSeparator = { fg = "rose" },
					-- CmpItemKindCodeium = { fg = "iris" },
					-- IndentBlanklineChar = { fg = "overlay" },
					-- IndentBlanklineContextChar = { fg = "overlay" },
					-- NoiceCmdlinePopupBorder = { link = "NormalFloat" },
					-- ["@variable"] = { italic = false, fg = "#c4c6e7" },
					-- ["@lsp.type.property.typescript"] = { italic = false, fg = "#7a8bb1" },
					-- ["@property.typescript"] = { italic = false, fg = "#7a8bb1" },
					["@attribute"] = { fg = "iris" },
					-- ["@neorg.headings.1.title"] = { fg = "iris" },
					-- ["@neorg.lists.unordered.prefix.norg"] = { fg = "iris" },
					-- ["@neorg.todo_items.done.norg"] = { fg = "foam" },
					-- ["@markup.raw.markdown_inline"] = { fg = "rose" },
					["@punctuation"] = { fg = "#486892", italic = false },
					["@punctuation.bracket"] = { fg = "#486892" },
					["@punctuation.special"] = { fg = "#486892" },
					["@punctuation.delimiter"] = { fg = "#486892" },
					TelescopeSelection = { fg = "rose" },
				},

				-- before_highlight = function(group, highlight, palette)
				-- 	if highlight.fg == palette.base then
				-- 		highlight.fg = "#1a1b26"
				-- 	end
				--
				-- 	if highlight.bg == palette.base then
				-- 		highlight.bg = "#1a1b26"
				-- 	end
				--
				-- 	if highlight.fg == palette.pine then
				-- 		highlight.fg = "#91B4D5"
				-- 	end
				-- 	if highlight.bg == palette.pine then
				-- 		highlight.bg = "#91B4D5"
				-- 	end
				--
				-- 	if highlight.fg == palette.gold then
				-- 		highlight.fg = "#9398cf"
				-- 	end
				-- 	if highlight.bg == palette.gold then
				-- 		highlight.bg = "#9398cf"
				-- 	end
				--
				-- 	if highlight.fg == palette.foam then
				-- 		highlight.fg = "#81c8be"
				-- 	end
				-- 	if highlight.bg == palette.foam then
				-- 		highlight.bg = "#81c8be"
				-- 	end
				--
				-- 	if highlight.fg == palette.rose then
				-- 		highlight.fg = "#6e88a6"
				-- 	end
				-- 	if highlight.bg == palette.rose then
				-- 		highlight.bg = "#6e88a6"
				-- 	end
				--
				-- 	if highlight.fg == palette.iris then
				-- 		highlight.fg = "#babbf1"
				-- 	end
				-- 	if highlight.bg == palette.iris then
				-- 		highlight.bg = "#babbf1"
				-- 	end
				-- end,
			})
		end,
	},
	{
		"EdenEast/nightfox.nvim",
		opts = {
			options = {
				dim_inactive = true,
			},
			groups = {
				all = {
					MiniDiffOverAdd = { link = "DiffAdd" },
					MiniDiffOverChange = { link = "DiffText" },
					MiniDiffOverContext = { link = "DiffChange" },
					MiniDiffOverDelete = { link = "DiffDelete" },

					MiniFilesBorder = { link = "FloatBorder" },
					MiniFilesBorderModified = { link = "DiagnosticFloatingWarn" },
					MiniFilesCursorLine = { link = "CursorLine" },
					MiniFilesDirectory = { link = "Directory" },
					MiniFilesFile = { fg = "fg1" },
					MiniFilesNormal = { link = "NormalFloat" },
					MiniFilesTitle = { link = "FloatTitle" },
					MiniFilesTitleFocused = { fg = "fg1", style = "bold" },

					MiniHipatternsFixme = { fg = "bg0", bg = "diag.error", style = "bold" },
					MiniHipatternsHack = { fg = "bg0", bg = "diag.warn", style = "bold" },
					MiniHipatternsNote = { fg = "bg0", bg = "diag.info", style = "bold" },
					MiniHipatternsTodo = { fg = "bg0", bg = "diag.hint", style = "bold" },

					MiniIconsAzure = { fg = "palette.blue.bright" },
					MiniIconsBlue = { fg = "palette.blue.base" },
					MiniIconsCyan = { fg = "palette.cyan.base" },
					MiniIconsGreen = { fg = "palette.green.base" },
					MiniIconsGrey = { fg = "fg0" },
					MiniIconsOrange = { fg = "palette.orange.base" },
					MiniIconsPurple = { fg = "palette.magenta.base" },
					MiniIconsRed = { fg = "palette.red.base" },
					MiniIconsYellow = { fg = "palette.yellow.base" },
				},
			},
		},
	},
}
