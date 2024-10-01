vim.cmd.hi("clear")
vim.g.colors_name = "art"

local p = {
	bg = "#1b1c20",
	light_bg = "#c3c4cb",
	fg = "#d7d9df",
	light_fg = "#000000",
	light_blue = "#aed7fa",
	dark_blue = "#699af7",
	yellow = "#ffeba2",
	green = "#b3f6c0",
}

local hls = {
	Normal = { fg = p.fg, bg = p.bg },
	StatusLine = { fg = p.light_fg, bg = p.light_bg },
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

	MiniDiffSignAdd = { fg = "#005523" },
	MiniDiffSignChange = { fg = "#f7df9b" },
	MiniDiffSignDelete = { fg = "#f1c0ba" },

	MiniIconsAzure = { fg = p.light_blue },
	MiniIconsBlue = { fg = p.dark_blue },
	MiniIconsCyan = { fg = p.light_blue },
	MiniIconsGreen = { fg = p.green },
	MiniIconsGrey = { fg = p.light_bg },
	MiniIconsOrange = { fg = "#e78a4e" },
	MiniIconsPurple = { fg = "#d3869b" },
	MiniIconsRed = { fg = "#ea6962" },
	MiniIconsYellow = { fg = "#d8a657" },
}

for k, v in pairs(hls) do
	vim.api.nvim_set_hl(0, k, v)
end
