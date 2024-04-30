local M = {}

M.fn = "prime-pine"
M.name = "rose-pine"

M.colors = {
	fg = "#e0def4",
	-- bg = "#28272a",
	bg = "#1c1c1c",
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
function M.setup(flavour)
	vim.cmd.colorscheme("rose-pine")
	vim.opt.cursorline = true
	vim.o.background = "dark"
	-- utils.hl = {
	-- 	opts = {
	-- 		{ "@keyword", { fg = M.colors.green } },
	-- 		{ "Normal", { fg = M.colors.fg, bg = M.colors.bg } },
	-- 		{ "NormalNC", { fg = M.colors.fg, bg = M.colors.bg } },
	-- 		{ "Statement", { link = "@keyword" } },
	-- 		{ "Function", { fg = M.colors.yellow } },
	-- 		-- { "String", { fg = M.colors.orange } },
	-- 		{ "@property", { link = "@variable.member" } },
	-- 		{ "NormalFloat", { bg = M.colors.gray } },
	-- 		{ "FloatBorder", { bg = M.colors.gray } },
	-- 		{ "Title", { bold = true, fg = M.colors.green } },
	-- 		{ "Directory", { bold = true, fg = M.colors.green } },
	-- 		{ "DiagnosticVirtualTextError", { fg = M.colors.red, bg = "#2e202f", blend = 10 } },
	-- 		{ "DiagnosticVirtualTextHint", { fg = "#c4a7e7", bg = "#2a2538", blend = 10 } },
	-- 		{ "DiagnosticVirtualTextInfo", { fg = "#9ccfd8", bg = "#292936", blend = 10 } },
	-- 		{ "DiagnosticVirtualTextWarn", { fg = "#f6c177", bg = "#2f282c", blend = 10 } },
	--
	-- 		{ "CursorLine", { bg = "#262626" } }, -- fg = "#d7d7ff" } },
	-- 		{ "CursorLineNr", { fg = M.colors.orange } },
	-- 		{ "StatusLine", { bg = M.colors.gray, fg = "#d7d7ff" } },
	-- 		{ "@attribute", { fg = M.colors.blue } },
	-- 		{ "@text.uri", { fg = M.colors.blue, underline = true } },
	-- 		{ "@neorg.headings.1.title.norg", { fg = M.colors.blue } },
	-- 		{ "@neorg", { fg = M.colors.red } },
	-- 		{ "Float", { fg = M.colors.orange } },
	-- 		{ "ModeMsg", { fg = M.colors.green } },
	-- 		{ "TelescopeBorder", { fg = "#262626", bg = "none" } },
	-- 		{ "TelescopeNormal", { bg = "none" } },
	-- 		{ "TelescopePromptNormal", { bg = "#262626" } },
	-- 		{ "TelescopeResultsNormal", { fg = M.colors.text, bg = M.colors.bg } },
	-- 		{ "TelescopeTitle", { fg = M.colors.bg, bg = M.colors.red } },
	-- 		{ "TelescopeSelection", { fg = M.colors.text, bg = M.colors.bg } },
	-- 		{ "TelescopeSelectionCaret", { fg = M.colors.red, bg = M.colors.red } },
	-- 		{ "BufferVisible", { bg = "none", fg = M.colors.text, bold = true, italic = true } },
	-- 		{ "Pmenu", { bold = true, fg = M.colors.fg, bg = M.colors.bg } },
	-- 		{ "Folded", { link = "StatusLine" } },
	-- 		-- { "StatusLine", { link = "Pmenu" } },
	-- 	},
	-- }
	require("rose-pine").setup({
		variant = "main", -- auto, main, moon, or dawn
		dark_variant = "main", -- main, moon, or dawn
		dim_inactive_windows = false,
		extend_background_behind_borders = true,
		styles = {
			bold = true,
			italic = true,
			transparency = false,
		},
		groups = {
			border = "muted",
			link = "iris",
			panel = "surface",

			error = "love",
			hint = "iris",
			info = "foam",
			note = "pine",
			todo = "rose",
			warn = "gold",

			git_add = "foam",
			git_change = "rose",
			git_delete = "love",
			git_dirty = "rose",
			git_ignore = "muted",
			git_merge = "iris",
			git_rename = "pine",
			git_stage = "iris",
			git_text = "rose",
			git_untracked = "subtle",

			h1 = "iris",
			h2 = "foam",
			h3 = "rose",
			h4 = "gold",
			h5 = "pine",
			h6 = "foam",
		},
		highlight_groups = {
			["@keyword"] = { fg = M.colors.green },
			-- 	Normal = { bg = M.colors.bg, fg = M.colors.fg },
			-- 	["@property"] = { link = "@variable.member" },
			Statement = { link = "@keyword" },
			Function = { fg = M.colors.yellow },
			CursorLineNr = { fg = M.colors.orange },
			-- StatusLine = { fg = "iris", bg = "iris", blend = 10 },
			-- StatusLine = { fg = "#9ccfd8", bg = "#9ccfd8", blend = 10 },
			-- StatusLine = { bg = M.colors.blue, fg = "base" },
			StatusLineNC = { fg = "subtle", bg = "surface" },
		},
		before_highlight = function(_, highlight, palette)
			if highlight.fg == palette.base then
				highlight.fg = M.colors.bg
			end
			if highlight.bg == palette.base then
				highlight.bg = M.colors.bg
			end
			if highlight.fg == palette.surface then
				highlight.fg = M.colors.gray
			end
			if highlight.bg == palette.surface then
				highlight.bg = M.colors.gray
			end
			if highlight.fg == palette.overlay then
				highlight.fg = M.colors.gray
			end
			if highlight.bg == palette.overlay then
				highlight.bg = M.colors.gray
			end
			if highlight.fg == palette.love then
				highlight.fg = M.colors.red
			end
			if highlight.bg == palette.love then
				highlight.bg = M.colors.red
			end
			if highlight.fg == palette.gold then
				highlight.fg = M.colors.orange
			end
			if highlight.bg == palette.gold then
				highlight.bg = M.colors.orange
			end
			if highlight.fg == palette.foam then
				highlight.fg = M.colors.green
			end
			if highlight.bg == palette.foam then
				highlight.bg = M.colors.green
			end
			if highlight.fg == palette.pine then
				highlight.fg = M.colors.cyan
			end
			if highlight.bg == palette.pine then
				highlight.bg = M.colors.cyan
			end
			if highlight.fg == palette.iris then
				highlight.fg = M.colors.magenta
			end
			if highlight.bg == palette.iris then
				highlight.bg = M.colors.magenta
			end
			if highlight.fg == palette.text then
				highlight.fg = M.colors.fg
			end
			if highlight.bg == palette.text then
				highlight.bg = M.colors.fg
			end
			-- palette.surface = M.colors.black
			-- palette.overlay = M.colors.gray
			-- palette.love = M.colors.red
			-- palette.gold = M.colors.orange
			-- palette.pine = M.colors.cyan
			-- palette.foam = M.colors.green
			-- palette.iris = M.colors.magenta
			-- palette.text = M.colors.fg
		end,
	})
	-- utils:create_hl()
	vim.cmd.colorscheme("rose-pine")
	vim.api.nvim_set_hl(0, "StatusLine", { fg = M.colors.bg, bg = "#9ccfd8" })
	TJ_STL_BG = "#9ccfd8"
end

function M.setup_pmenu()
	utils.pmenu = {
		opts = {
			{ "Pmenu", { bold = true, fg = M.colors.fg, bg = M.colors.bg } },
			{ "PmenuSel", { bold = true, fg = M.colors.yellow } },
			{ "PmenuExtra", { fg = M.colors.bg, bg = M.colors.green, bold = true } },
			{ "PmenuSel", { bg = "#282C34", fg = "NONE" } },
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
