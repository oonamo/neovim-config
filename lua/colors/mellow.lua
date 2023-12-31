local M = {}

-- M.colors = {
-- 	red = "#f38ba8",
-- 	orange = "#fab387",
-- 	yellow = "#f9e2af",
-- 	green = "#a6e3a1",
-- 	cyan = "#94e2d5",
-- 	blue = "#89b4fa",
-- 	purple = "#cba6f7",
-- 	magenta = "#f5c2e7",
-- }

M.colors = {
	fg = "#cac9dd",
	bg = "#161617",
	green = "#90b99f",
	yellow = "#e6b99d",
	magenta = "#aca1cf",
	red = "#ea83a5",
	blue = "#8a9ae5",
	cyan = "#94e2d5",
	gray = "#c9c7cd",
	orange = "#f5a191",
	white = "##e0def4",
	black = "#131314",
}

function M.setup()
	O.colorscheme = "mellow"
	vim.cmd("colorscheme " .. O.colorscheme)
	utils.hl = {
		opts = {
			{ "NormalFloat", { bg = "#27272a", blend = 15 } },
			{ "FloatBorder", { bg = "#ea83a5", blend = 15, fg = "#dda0dd" } },
			{ "Pmenu", { bg = "#27272a" } },
			{ "PmenuSel", { bold = true, fg = "#dda0dd", bg = "#353539" } },
		},
	}

	utils:create_hl()
end

return M
