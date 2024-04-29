local M = {}
M.colors = {
	none = "NONE",
	bg = "#181818",
	fg = "#d7d7ff",
	blue = "#005f5f",
	green = "#5f875f",
	red = "#5f0000",
	bright_red = "#ec5f67",
	white = "#1f1f1f",
	grey = "#1c1c1c",
	bright_grey = "#777d86",
	dark_grey = "#5c5c5c",
	orange = "#ff9640",
	purple = "#5f005f",
	bright_purple = "#5f00d7",
	yellow = "#e5c07b",
	bright_yellow = "#ebae34",
	--  "#181818"
	--  "#1c1c1c"
	--  "#5F875F"
	--  "#d7ffaf"
	--  "#5F5F87"
	--  "#d7d7ff"
	--  "#00005f"
	--  "#005f5f"
	--  "#5f0000"
	--  "#5f005f"
}

M.setup = function()
	vim.cmd.hi("clear")
	vim.opt.cursorline = true
	vim.o.background = "dark"
	utils.hl = {
		opts = {
			{ "DiffChange", { bg = "NONE", fg = "#d7d7ff" } },
			{ "CursorLine", { bg = "#262626" } }, -- fg = "#d7d7ff" } },
			{ "CursorLineNr", { fg = M.colors.orange } },
			{ "Search", { bg = M.colors.bright_yellow, fg = M.colors.bg } },
			{ "Visual", { bg = M.colors.bright_yellow, fg = M.colors.bg } },
			{ "IncSearch", { bg = M.colors.bright_yellow, fg = M.colors.bg } },
			{ "StatusLine", { bg = "#5f666d", fg = M.colors.bg } },
			{ "StatusLineNC", { bg = "#272a30", fg = M.colors.bg } },
			{ "MatchParen", { fg = M.colors.orange } },
			-- { "TabLine", { bg = "#272a30", fg = M.colors.fg } },
		},
	}
	vim.cmd.colorscheme("flesh-and-blood")
	utils:create_hl()
	utils.create_virt_diagnostics_hl()
end

return M
