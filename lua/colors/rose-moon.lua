local M = {}
M.colors = {
	bg = "#232136",
}
function M.setup()
	O.colorscheme = "rose-pine"
	require("rose-pine").setup({
		variant = "moon",
		styles = {
			bold = true,
			italic = true,
			transparency = true,
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
		},
	})

	if vim.g.transparent_enabled and vim.g.neovide then
		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	end

	vim.cmd("colorscheme " .. O.colorscheme)
end

return M
