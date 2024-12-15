if vim.g.colors_name ~= nil then
	vim.cmd("highlight clear")
end
vim.g.colors_name = "ef-arbutus"
vim.o.background = "light"

local function hi(name, hl)
	vim.api.nvim_set_hl(0, name, hl)
end

local function get_hi(name, prop)
	local hl = vim.api.nvim_get_hl(0, {
		name = name,
		link = false,
	})
	return hl[prop]
end

local function normalize(c)
	local sc = get_hi("LineNr", "bg")
	hi("MiniDiffSignAdd", { fg = c["bg-added"], bg = sc })
	hi("MiniDiffSignChange", { fg = c["bg-changed"], bg = sc })
	hi("MiniDiffSignDelete", { fg = c["bg-removed"], bg = sc })
	hi("MiniDiffOverAdd", { fg = c["fg-added"], bg = c["bg-added-refine"] })
	hi("MiniDiffOverChange", { fg = c["fg-changed"], bg = c["bg-changed-refine"] })
	hi("MiniDiffOverDelete", { fg = c["fg-removed"], bg = c["bg-removed-refine"] })
	hi("MiniIconsAzure", { fg = c["blue-warmer"] })
	hi("MiniIconsBlue", { fg = c["blue"] })
	hi("MiniIconsCyan", { fg = c["cyan"] })
	hi("MiniIconsGreen", { fg = c["green"] })
	hi("MiniIconsGrey", { fg = c["bf-active"] })
	hi("MiniIconsOrange", { fg = c["bg-yellow-intense"] })
	hi("MiniIconsPurple", { fg = c["magenta"] })
	hi("MiniIconsRed", { fg = c["red"] })
	hi("MiniIconsYellow", { fg = c["yellow"] })
	hi("DiagnosticFloatingError", { fg = c["bg-red-intense"], bg = c["bg-red-subtle"] })
	hi("DiagnosticFloatingWarn", { fg = c["bg-yellow-intense"], bg = c["bg-yellow-subtle"] })
	hi("DiagnosticFloatingInfo", { fg = c["bg-green-intense"], bg = c["bg-green-subtle"] })
	hi("DiagnosticFloatingHint", { fg = c["bg-blue-intense"], bg = c["bg-blue-subtle"] })
	hi("DiagnosticError", { link = "DiagnosticFloatingError" })
	hi("DiagnosticWarn", { link = "DiagnosticFloatingWarn" })
	hi("DiagnosticInfo", { link = "DiagnosticFloatingInfo" })
	hi("DiagnosticHint", { link = "DiagnosticFloatingHint" })
end

local palette = {
	base00 = "#ffead8", -- Defaum. bg
	base01 = "#e8d2cb", -- Lighter bg (status bar, line number, folding mks)
	base02 = "#dbe0c0", -- Selection bg
	base03 = "#6e678f", -- Comments, invisibm.s, line hl
	base04 = "#e9a0a0", -- Dark fg (status bars)
	base05 = "#393330", -- Defaum. fg (caret, delimiters, Operators)
	base06 = "#8a5f4a", -- m.ght fg (not often used)
	base07 = "#8f97d7", -- Light bg (not often used)
	base08 = "#aa184f", -- Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
	base09 = "#906200", -- Integers, Boom.an, Constants, XML Attributes, Markup Link Url
	base0A = "#b0000f",
	base0B = "#557000",
	base0C = "#b44405", -- Support, regex, escape chars
	base0D = "#007000", -- Function, methods, headings
	base0E = "#8f2f30", -- Keywords
	base0F = "#dc8cc3", -- Deprecated, open/close embedded tags
}
local c = {
	["bg-main"] = "#ffead8",
	["fg-main"] = "#393330",
	["bg-dim"] = "#f0d8cf",
	["fg-dim"] = "#6e678f",
	["bg-alt"] = "#e7d2cb",
	["fg-alt"] = "#8a5f4a",

	["bg-active"] = "#c7b2ab",
	["bg-inactive"] = "#f7e2d2",
	["red"] = "#b0000f",
	["red-warmer"] = "#b20f00",
	["red-cooler"] = "#aa184f",
	["red-faint "] = "#8f2f30",
	["green"] = "#007000",
	["green-warmer"] = "#557000",
	["green-cooler"] = "#00704f",
	["green-faint"] = "#3f712f",
	["yellow"] = "#906200",
	["yellow-warmer"] = "#b44405",
	["yellow-cooler"] = "#8a6340",
	["yellow-faint"] = "#8d6068",
	["blue"] = "#375cc6",
	["blue-warmer"] = "#5f55df",
	["blue-cooler"] = "#265fbf",
	["blue-faint"] = "#4a659f",
	["magenta"] = "#a23ea4",
	["magenta-warmer"] = "#bf2c90",
	["magenta-cooler"] = "#6448ca",
	["magenta-faint"] = "#845592",
	["cyan"] = "#3f69af",
	["cyan-warmer"] = "#4060a0",
	["cyan-cooler"] = "#0f7688",
	["cyan-faint"] = "#546f70",
	["bg-red-intense"] = "#ff8f88",
	["bg-green-intense"] = "#96df80",
	["bg-yellow-intense"] = "#efbf00",
	["bg-blue-intense"] = "#afbeff",
	["bg-magenta-intense"] = "#bf9fff",
	["bg-cyan-intense"] = "#88d4f0",

	["bg-red-subtle"] = "#f9c2bf",
	["bg-green-subtle"] = "#c4eda0",
	["bg-yellow-subtle"] = "#efe76f",
	["bg-blue-subtle"] = "#cfdff0",
	["bg-magenta-subtle"] = "#f0d0f0",
	["bg-cyan-subtle"] = "#bfe8eb",
	["bg-added"] = "#d0e6b0",
	["bg-added-faint"] = "#e2efc0",
	["bg-added-refine"] = "#bbd799",
	["fg-added"] = "#005000",

	["bg-changed"] = "#f5e690",
	["bg-changed-faint"] = "#f5edaf",
	["bg-changed-refine"] = "#edd482",
	["fg-changed"] = "#553d00",

	["bg-removed"] = "#f8c6b6",
	["bg-removed-faint"] = "#f5d0b0",
	["bg-removed-refine"] = "#f0aaa9",
	["fg-removed"] = "#8f1313",
}

require("mini.base16").setup({ palette = palette })
hi("LineNr", { fg = c["fg-dim"] })
hi("LineNrAbove", { fg = c["fg-dim"] })
hi("LineNrBelow", { fg = c["fg-dim"] })
hi("CursorLineNr", { fg = "#000000", bold = true })
hi("PmenuKind", { bg = "#f6e2d2", fg = "#393330" })
hi("Pmenu", { bg = "#f6e2d2", fg = "#393330" })
hi("PmenuSel", { bg = "#f3c4c4" })
hi("MiniPickMatchCurrent", { bg = "#f3c4c4" })
hi("MiniPickMatchRanges", { fg = "#007000", bold = true })
hi("StatusLine", { bg = "#e9a0a0", fg = "#000000" })

hi("BlinkCmpLabelMatch", { fg = "#007000" })



normalize(c)

vim.cmd("doautocmd Colorscheme")
