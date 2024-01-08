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
	white = "#e0def4",
	black = "#21202e",
}

-- test.nvim_set_hl(0, "CursorLine", { bg = M.colors.bg, blend = 40 })
function M.setup()
	O.colorscheme = "rose-pine"
	O.fn = M.fn
	vim.cmd("colorscheme " .. O.colorscheme)

	vim.opt.cursorline = true
	utils.hl = {
		opts = {
			{ "@keyword", { fg = M.colors.green } },
			{ "Statement", { link = "@keyword" } },
			{ "Function", { fg = M.colors.yellow } },
			{ "String", { fg = M.colors.orange } },
			{ "@property", { fg = M.colors.cyan } },
			{ "NormalFloat", { blend = 15 } },
			{ "FloatBorder", { blend = 15 } },
			{ "Title", { bold = true, fg = M.colors.green } },
			{ "Directory", { bold = true, fg = M.colors.green } },
			{ "DiagnosticVirtualTextError", { fg = M.colors.red, bg = "#2e202f", blend = 10 } },
			{ "DiagnosticVirtualTextHint", { fg = "#c4a7e7", bg = "#2a2538", blend = 10 } },
			{ "DiagnosticVirtualTextInfo", { fg = "#9ccfd8", bg = "#292936", blend = 10 } },
			{ "DiagnosticVirtualTextWarn", { fg = "#f6c177", bg = "#2f282c", blend = 10 } },
		},
	}
	utils:create_hl()
end

function M.setup_pmenu()
	utils.pmenu = {
		opts = {
			{ "Pmenu", { bold = true, fg = M.colors.fg, bg = M.colors.bg } },
			{ "PmenuSel", { bold = true, fg = M.colors.yellow } },
			{ "PmenuExtra", { fg = M.colors.bg, bg = M.colors.green, bold = true } },
		},
	}
	utils:create_pmenu()
end

function M.setup_statusline()
	utils.statuscolors = {
		opts = {
			{ "StatusLineExtra", { fg = M.colors.bg, bg = M.colors.red } },
			{ "StatuslineAccent", { bg = M.colors.yellow, fg = "#27272a" } },
			{ "StatuslineInsertAccent", { link = "CurSearch" } },
			{ "StatuslineVisualAccent", { bg = M.colors.cyan, fg = "#27272a" } },
			{ "StatuslineCmdLineAccent", { bg = M.colors.magenta, fg = "#27272a" } },
			{ "StatusCmdLine", { bg = M.colors.magenta, fg = "#27272a" } },
			{ "StatuslineReplaceAccent", { bold = true, fg = M.colors.green } },
			{ "StatusEmpty", { bg = M.colors.bg, blend = 10 } },
			{ "StatusBarLong", { bg = M.colors.bg, blend = 10, fg = "#ffffff" } },
			{ "HarpoonActive", { bg = M.colors.magenta, blend = 10, fg = "#000000" } },
			{ "HarpoonInactive", { bg = M.colors.green, blend = 10, fg = "#000000" } },
		},
	}
	vim.opt.pumblend = 30
	utils:create_statusline()
end

return M
