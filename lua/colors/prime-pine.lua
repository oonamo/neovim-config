local M = {}

M.fn = "prime-pine"
M.name = "rose-pine"

M.colors = {
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
	white = "##e0def4",
	black = "#21202e",
}

function M.setup()
	O.colorscheme = "rose-pine"
	O.fn = M.fn
	vim.cmd("colorscheme " .. O.colorscheme)

	utils.hl = {
		opts = {
			{ "@keyword", { fg = M.colors.green } },
			{ "Statement", { link = "@keyword" } },
			{ "Function", { fg = M.colors.yellow } },
			{ "String", { fg = M.colors.orange } },
			{ "@property", { fg = M.colors.cyan } },
			{ "NormalFloat", { blend = 15 } },
			{ "FloatBorder", { blend = 15 } },
			{ "PmenuSel", { bold = true, fg = M.colors.yellow } },
			{ "Title", { bold = true, fg = M.colors.green } },
			{ "Directory", { bold = true, fg = M.colors.green } },
		},
	}
	utils:create_hl()
end

return M
