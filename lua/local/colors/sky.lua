vim.cmd.hi("clear")

local p = {
	bg = "#1b1c20",
	light_bg = "#c3c4cb",
	fg = "#d7d9df",
	light_fg = "#000000",
	light_blue = "#aed7fa",
	dark_blue = "#699af7",
	yellow = "#ffeba2",
}

local hls = {
	Normal = { fg = p.fg, bg = p.bg },
	-- StatusLine = { fg = p.light_bg, p.light_fg },
	EndOfBuffer = { fg = "#14161b" },
	Function = { fg = "#a6dbff", ctermfg = 12 },
	["@property"] = { link = "@variable" },
	Type = { fg = "#fce094", ctermfg = 11 },
	["@type.builtin"] = { link = "Type" },
	["@type"] = { link = "Type" },
	DiagnosticUnderlineError = { special = "#ffc0b9", undercurl = true },
	DiagnosticUnderlineWarn = { special = "#fce094", undercurl = true },
	DiagnosticUnderlineInfo = { special = "#8cf8f7", undercurl = true },
	DiagnosticUnderlineHint = { special = "#a6dbff", undercurl = true },
	DiagnosticUnderlineOk = { special = "#b3f6c0", undercurl = true },

	DashboardHeader = { fg = "#b3f6c0" },
	MiniDiffAdd = { fg = "#005523" },
	MiniDiffChange = { fg = "#007373" },
	MiniDiffDelete = { fg = "#590008" },
	MiniIconsAzure = { fg = "#89b482" },
	MiniIconsBlue = { fg = "#7daea3" },
	MiniIconsCyan = { fg = "#89b482" },
	MiniIconsGreen = { fg = "#a9b665" },
	MiniIconsGrey = { fg = "#ebdbb2" },
	MiniIconsOrange = { fg = "#e78a4e" },
	MiniIconsPurple = { fg = "#d3869b" },
	MiniIconsRed = { fg = "#ea6962" },
	MiniIconsYellow = { fg = "#d8a657" },
}

for k, v in pairs(hls) do
	vim.api.nvim_set_hl(0, k, v)
end
