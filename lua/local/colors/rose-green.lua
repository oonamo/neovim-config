-- FROM: https://github.com/kaiphat/dotfiles/tree/master/nvim/lua/themes
require("rose-pine").setup({
	dim_nc_background = false,
	disable_background = true,
	disable_float_background = true,

	highlight_groups = {
		-- Normal = { fg = "#908caa" },
		Normal = { fg = "#908caa", bg = "#1a1b26" },
		NormalNC = { link = "Normal" },
		GitSignsAdd = { bg = "none" },
		GitSignsChange = { bg = "none" },
		GitSignsDelete = { bg = "none" },
		MiniCursorword = { underline = false, bg = "foam", blend = 30 },
		LocalHighlight = { underline = false, bg = "foam", blend = 30 },
		HopNextKey1 = { fg = "love" },
		HopNextKey2 = { fg = "pine" },
		Keyword = { bold = true, italic = true },
		VertSplit = { fg = "#405879" },
		TreesitterContext = { bg = "muted", blend = 15 },
		TreesitterContextSeparator = { fg = "rose" },
		CmpItemKindCodeium = { fg = "iris" },
		IndentBlanklineChar = { fg = "overlay" },
		IndentBlanklineContextChar = { fg = "overlay" },
		NoiceCmdlinePopupBorder = { link = "NormalFloat" },
		["@variable"] = { italic = false, fg = "#c4c6e7" },
		["@lsp.type.property.typescript"] = { italic = false, fg = "#7a8bb1" },
		["@property.typescript"] = { italic = false, fg = "#7a8bb1" },
		["@attribute"] = { fg = "iris" },
		["@neorg.headings.1.title"] = { fg = "iris" },
		["@neorg.lists.unordered.prefix.norg"] = { fg = "iris" },
		["@neorg.todo_items.done.norg"] = { fg = "foam" },
		["@markup.raw.markdown_inline"] = { fg = "rose" },
		["@punctuation"] = { fg = "#486892", italic = false },
		["@punctuation.bracket"] = { fg = "#486892" },
		["@punctuation.special"] = { fg = "#486892" },
		["@punctuation.delimiter"] = { fg = "#486892" },
		TelescopeSelection = { fg = "rose" },
	},

	before_highlight = function(group, highlight, palette)
		if highlight.fg == palette.pine then
			highlight.fg = "#91B4D5"
		end
		if highlight.bg == palette.pine then
			highlight.bg = "#91B4D5"
		end

		if highlight.fg == palette.gold then
			highlight.fg = "#9398cf"
		end
		if highlight.bg == palette.gold then
			highlight.bg = "#9398cf"
		end

		if highlight.fg == palette.foam then
			highlight.fg = "#81c8be"
		end
		if highlight.bg == palette.foam then
			highlight.bg = "#81c8be"
		end

		if highlight.fg == palette.rose then
			highlight.fg = "#6e88a6"
		end
		if highlight.bg == palette.rose then
			highlight.bg = "#6e88a6"
		end

		if highlight.fg == palette.iris then
			highlight.fg = "#babbf1"
		end
		if highlight.bg == palette.iris then
			highlight.bg = "#babbf1"
		end
	end,
})

vim.cmd.colorscheme("rose-pine")

require("mini.colors")
	.get_colorscheme("rose-pine", {
		new_name = "rose-green",
	})
	:resolve_links()
	:compress()
	:write()

require("mini.colors")
	.get_colorscheme("rose-pine-moon", {
		new_name = "rose-green-moon",
	})
	:resolve_links()
	:compress()
	:write()
