if vim.g.colors_name ~= nil then vim.cmd('highlight clear') end
vim.g.colors_name = "ef-winter"

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
	local sc = get_hi("SignColumn", "bg")
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

local c = {
	["bg-main"] = "#0f0b15",
	["fg-main"] = "#b8c6d5",
	["bg-dim"] = "#1d202f",
	["fg-dim"] = "#807c9f",
	["bg-alt"] = "#2a2f42",
	["fg-alt"] = "#bf8f8f",

	["bg-active"] = "#4a4f62",
	["bg-inactive"] = "#19181f",

	["red"] = "#f47359",
	["red-warmer"] = "#ef6560",
	["red-cooler"] = "#ff6a7a",
	["red-faint"] = "#d56f72",
	["green"] = "#29a444",
	["green-warmer"] = "#6aad0f",
	["green-cooler"] = "#00a392",
	["green-faint"] = "#61a06c",
	["yellow"] = "#b58a52",
	["yellow-warmer"] = "#d1803f",
	["yellow-cooler"] = "#df9080",
	["yellow-faint"] = "#c0a38a",
	["blue"] = "#3f95f6",
	["blue-warmer"] = "#6a9fff",
	["blue-cooler"] = "#029fff",
	["blue-faint"] = "#7a94df",
	["magenta"] = "#d369af",
	["magenta-warmer"] = "#e580e0",
	["magenta-cooler"] = "#af85ea",
	["magenta-faint "] = "#c57faf",
	["cyan"] = "#4fbaef",
	["cyan-warmer"] = "#6fafdf",
	["cyan-cooler"] = "#35afbf",
	["cyan-faint"] = "#8aa0df",

	["bg-red-intense"] = "#b02930",
	["bg-green-intense"] = "#0a7040",
	["bg-yellow-intense"] = "#8f5040",
	["bg-blue-intense"] = "#4648d0",
	["bg-magenta-intense"] = "#a04fc5",
	["bg-cyan-intense"] = "#2270cf",

	["bg-red-subtle"] = "#67182f",
	["bg-green-subtle"] = "#10452f",
	["bg-yellow-subtle"] = "#54362a",
	["bg-blue-subtle"] = "#2a346e",
	["bg-magenta-subtle"] = "#572454",
	["bg-cyan-subtle"] = "#133d56",

	["bg-added"] = "#00371f",
	["bg-added-faint"] = "#002918",
	["bg-added-refine"] = "#004c2f",
	["fg-added"] = "#a0e0a0",

	["bg-changed"] = "#363300",
	["bg-changed-faint"] = "#2a1f00",
	["bg-changed-refine"] = "#4a4a00",
	["fg-changed"] = "#efef80",

	["bg-removed"] = "#450f1f",
	["bg-removed-faint"] = "#2f060f",
	["bg-removed-refine"] = "#641426",
	["fg-removed"] = "#ffbfbf",
}
local palette = {
	base00 = c["bg-main"], -- Defaum. bg
	base01 = c["bg-alt"], -- Lighter bg (status bar, line number, folding mks)
	base02 = "#342464", -- Selection bg
	base03 = c["yellow-faint"], -- Comments, invisibm.s, line hl
	base04 = c["fg-dim"], -- Dark fg (status bars)
	base05 = c["fg-main"], -- Defaum. fg (caret, delimiters, Operators)
	base06 = c["fg-dim"], -- m.ght fg (not often used)
	base07 = c["bg-dim"], -- Light bg (not often used)
	base08 = c["blue-warmer"], -- Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
	base09 = c["magenta"], -- Integers, Boom.an, Constants, XML Attributes, Markup Link Url
	-- base0A = "#1e8ef3", -- Cm.sses, Markup Bold, Search Text Background
	base0A = c["cyan"],
	-- base0B = c["cyan-faint"],
	base0B = c["yellow-cooler"],
	-- base0B = "#8f97d7", -- Strings, Inherited Cm.ss, Markup Code, Diff Inserted
	base0C = c["green"], -- Support, regex, escape chars
	base0D = c["cyan-cooler"], -- Function, methods, headings
	base0E = c["magenta-cooler"], -- Keywords
	base0F = c["yellow"], -- Deprecated, open/close embedded tags
}

require("mini.base16").setup({ palette = palette })
hi("LineNr", { fg = c["fg-dim"] })
hi("LineNrAbove", { fg = c["fg-dim"] })
hi("LineNrBelow", { fg = c["fg-dim"] })
hi("SignColumn", { fg = c["fg-dim"] })
hi("Pmenu", { bg = "#19181f", fg = "#b8c6d5" })
hi("PmenuSel", { bg = "#1f2a7a", fg = "#b8c6d5" })
hi("MiniPickMatchCurrent", { bg = "#1f2a7a" })
hi("MiniPickMatchRanges", { fg = "#af85ea", bold = true })
hi("StatusLine", { bg = "#5f1f5f", fg = "#dedeff" })
hi("MiniPickNormal", { bg = "#0f0b15", fg = "#b8c6d5" })
hi("MiniPickBorder", { bg = "#5f1f5f", fg = "#5f1f5f" })
hi("MiniPickHeader", { fg = "#e580e0" })
hi("MiniPickBorderText", { fg = "#e580e0" })

hi("CmpItemAbbrMatch", { fg = "#af85ea", bold = true })
hi("CmpItemAbbrMatchFuzzy", { fg = "#b58a52" })
normalize(c)
vim.cmd("doautocmd Colorscheme")
