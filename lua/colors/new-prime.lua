local M = {
	fg = "#e0def4",
	bg = "#28272a",
	green = "#698282",
	yellow = "#ffc2c6",
	magenta = "#dda0dd",
	red = "#ea83a5",
	blue = "#31748f",
	cyan = "#b3c3c4",
	gray = "#3d3d3d",
	orange = "#d3a38d",
	white = "#e0def4",
	black = "#21202e",
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
}

M.setup = function()
	O.colorscheme = "rose-pine-prime"
	O.fn = "new-prime"
	-- utils.hl = {
	-- 	opts = {
	-- 		{ "TreesitterContext", bg = O.black },
	-- 		{ "TreesitterContextBottom", bg = O.yellow },
	-- 	},
	-- }
	vim.cmd("colorscheme " .. O.colorscheme)
	utils:create_hl()
end

return M
