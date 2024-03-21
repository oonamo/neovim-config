local M = {}
M.colors = {
	bg = "#191724",
}

function M.setup()
	O.colorscheme = "rose-pine"
	vim.opt.background = "light"
	require("rose-pine").setup({
		variant = "dawn",
		styles = {
			bold = true,
			italic = true,
			transparency = false,
		},
		highlight_groups = {
			-- _nc = "#16141f",
			-- base = "#191724",
			-- surface = "#1f1d2e",
			-- overlay = "#26233a",
			-- muted = "#6e6a86",
			-- subtle = "#908caa",
			-- text = "#e0def4",
			-- love = "#eb6f92",
			-- gold = "#f9bd98",
			-- rose = "#ebbcba",
			-- pine = "#7f9f9f",
			-- foam = "#bedfe0",
			-- iris = "#debee2",
			-- highlight_low = "#21202e",
			-- highlight_med = "#403d52",
			-- highlight_high = "#524f67",
			-- none = "NONE",
			TreesitterContext = { bg = "highlight_low" },
			TreesitterContextBottom = { sp = "rose", underline = true },
			TreesitterContextNumberBottom = { sp = "rose", underline = true },
			TelescopeTitle = { fg = "base", bg = "love" },
			TelescopePromptTitle = { fg = "base", bg = "pine" },
			TelescopePreviewTitle = { fg = "base", bg = "iris" },
			BufferVisible = { bg = "none", fg = "text", bold = true, italic = true },
			NoiceCmdlinePopupBorder = { fg = "subtle", bg = "subtle" },
			DiagnosticUnderlineWarn = { sp = "gold", undercurl = true },
			DiagnosticUnderlineOk = { sp = "gold", undercurl = true },
			DiagnosticUnderlineError = { sp = "love", undercurl = true },

			FzfLuaCursor = { fg = "love" },
			FzfLuaBufNr = { fg = "subtle" },
			FzfLuaBufLineNr = { fg = "subtle" },
			FzfLuaBufFlagCur = { fg = "love" },
			FzfLuaTabMarker = { fg = "gold" },
			FzfLuaCursorLine = { fg = "love" },
			FzfLuaCursorLineNr = { fg = "love" },
			FzfLuaLiveSym = { fg = "love" },
		},
	})

	require("nvim-web-devicons").setup()
	vim.cmd("colorscheme " .. O.colorscheme)
	vim.g.colors_name = O.colorscheme
	-- Setup to get properly colored icons
end
return M
