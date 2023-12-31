--- Highlights
-- StatuslineAccent
-- StatuslineInsertAccent
-- StatuslineVisualAccent
-- StatuslineReplaceAccent
-- StatuslineCmdLineAccent
-- StatuslineTerminalAccent
-- HarpoonActive
-- HarpoonInactive
-- Statusline
-- StatusBarLong
-- StatusEmpty
-- StatusLineExtra
local M = {}

M.colors = {
	fg = "#2b2b2b",
	bg = "#f1f3f2",
	green = "#008700",
	yellow = "#af5f00",
	magenta = "#af00af",
	red = "#af0000",
	blue = "#005f87",
	cyan = "#0087af",
	gray = "#878787",
	orange = "#d75f00",
	white = "#f1f3f2",
	black = "#2b2b2b",
	dim = {
		green = "#50a14f",
		yellow = "#c18401",
		magenta = "#e563ba",
		red = "#e14133",
		blue = "#0072c1",
		cyan = "#0087af",
		grey = "#444444",
		orange = "#d75f00",
	},
}

function M.setup()
	O.colorscheme = "newpaper"
	vim.cmd("colorscheme " .. O.colorscheme)
	utils.hl = {
		opts = {},
	}
	vim.opt.background = "light"
end

function M.setup_status()
	utils.statuscolors = {
		opts = {
			{ "StatuslineAccent", { bg = M.colors.dim.green, fg = M.colors.black } },
			{ "StatuslineInsertAccent", { bg = M.colors.yellow, fg = M.colors.black } },
			{ "StatuslineReplaceAccent", { bg = M.colors.magenta, fg = M.colors.black } },
			{ "StatuslineCmdLineAccent", { bg = M.colors.dim.red, fg = M.colors.black } },
			{ "StatuslineTerminalAccent", { bg = M.colors.blue, fg = M.colors.black } },
			-- { "HarpoonActive" },
			{ "HarpoonInactive", { bg = M.colors.bg, fg = M.colors.black } },
			{ "Statusline", { bg = M.colors.bg, fg = M.colors.fg } },
			{ "StatusBarLong", { bg = M.colors.bg, fg = M.colors.fg } },
			{ "StatusEmpty", { bg = M.colors.bg, fg = M.colors.fg } },
			{ "StatusLineExtra", { link = "HarpoonInactive" } },
		},
	}
	utils:create_statusline()
end

return M
