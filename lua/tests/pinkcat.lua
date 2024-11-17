--[[
lol
"#fe7c8e",
"#202330",
"#fde3e8",
"#fe7c8e",
"#fe7c8e",
"#202330",	
"#202330",
"#FFF0F5",
"#472541",
"#575b61",
"#472541",
"#4747a1",
"#6767ce",
"#d0963a",
"#ffedf0",
"#ff62a5",
"#3bc089",
"#1e1e1e",
"#2d2f42",
"#ffffff",
"#fe7c8e",
"#fe7c8e",
"#202330",
"#fe7c8e",
"#d0963a",
"#707070",
"#765d36",
"#565970",
"#FFFFFF",
"#ff62a5",
"#f3b4bf",
"#f3b4bf",
"#f3b4bf",
"#ffffff",
"#fe7c8e",
"#6d5d72",
"#f3b4bf",
"#d0963a",
"#ffffff",
"#f3b4bf48",
"#f3b4bf66",
"#e9a6b288",
"#f3b4bf",
"#f3b4bf",
"#f3b4bf",
"#2d2f42",
"#202330",
"#2d2f42",
"#9498a144",
"#9498a1",
"#fe7c8e",
"#fe7c8e",
"#ffffff",		
"#2d2f42"
"#202330",
"#FFF0F5"
"#202025",
"#c5c8c6"
"#1e1e1e",
"#C5C8C6"
"#6D7A72"
"#FAE8B6"
"#FF38A2"
"#58B896"
"#FF7F9D"
"#FF4791"
"#FEC831"
"#DCBFF2"
"#F5A6C6"
"#37e884ff"
"#ffc85b"
"#9CD162"
"#FA508C"
"#A2C2EB"
"#EBA4AC"
"#FFFFFF"
"#EBA4AC"
"#DCBFF2"
"#FFF0F5"
"#FA508C"
"#73b5d7"
"#73b5d7"
"#E6A1FF"
"#6089B4"
"#D0B344"
"#73b5d7"
"#FFF0F5"
"#94AFE8"
"#D08442"
"#C5C8C6"
"#e1ecf2"
"#787878"
"#ec9a5e"
"#D0B344"
"#b58900",
"#E0EDDD"
"#f0e8cf",
"#dc322f"
"#f0e8cf",
"#e53c70"
"#f0e8cf",
"#219186"
"#9e6dbc"
"#73b5d7"
"#6089B4"
"#FF0080"
"#D0B344"
"#D0B344"
"#6796e6"
"#e5ac40"
"#f44747"
"#b267e6"
--]]
local M = {}

M.base16 = {
	base00 = "#27273a", -- Defaum. bg
	base01 = "#27273a", -- Lighter bg (status bar, line number, folding mks)
	base02 = "#472541", -- Selection bg
	base03 = "#676b73", -- Comments, invisibm.s, line hl
	base04 = "#676b73", -- Dark fg (status bars)
	base05 = "#faeff2", -- Defaum. fg (caret, delimiters, Operators)
	base06 = "#dcdccc", -- m.ght fg (not often used)
	base07 = "#8f97d7", -- Light bg (not often used)
	base08 = "#b6a3e4", -- Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
	base09 = "#e8ba70", -- Integers, Boom.an, Constants, XML Attributes, Markup Link Url
	-- base0A = "#1e8ef3", -- Cm.sses, Markup Bold, Search Text Background
	base0A = "#F5A6C6",
	base0B = "#FAE8B6",
	-- base0B = "#8f97d7", -- Strings, Inherited Cm.ss, Markup Code, Diff Inserted
	base0C = "#d6a0e5", -- Support, regex, escape chars
	base0D = "#f06e94", -- Function, methods, headings
	base0E = "#e55099", -- Keywords
	base0F = "#dc8cc3", -- Deprecated, open/close embedded tags
}

M.base30 = {
	white = "#ffedf0",
	darker_black = "#1e1e1e",
	black = "#27273a", --  nvim bg
	black2 = "#202330",
	one_bg = "#32363e", -- real bg of onedark
	one_bg2 = "#3c4048",
	one_bg3 = "#41454d",
	grey = "#474756",
	grey_fg = "#C5C8C6",
	grey_fg2 = "#787878",
	light_grey = "#676b73",
	red = "#fe7c8e",
	baby_pink = "#FF7F9D",
	pink = "#FF4791",
	line = "#3b3f47", -- for lines like vertsplit
	green = "#58B896",
	vibrant_green = "#9CD162",
	nord_blue = "#A2C2EB",
	blue = "#6089B4",
	yellow = "#D0B344",
	sun = "#D0B344",
	purple = "#4747a1",
	dark_purple = "#b267e6",
	teal = "#73b5d7",
	orange = "#ec9a5e",
	cyan = "#73b5d7",
	statusline_bg = "#2d2e43",
	-- statusline_bg = "#40405f",
	-- statusline_bg = "#40405f",
	-- statusline_bg = "#fde3e8",
	lightbg = "#fde3e8",
	pmenu_bg = "#98be65",
	folder_bg = "#51afef",
}

M.overrides = function(theme, colors)
	return {
		["@type.builtin"] = { fg = "#d6a0e5" },
		["@operator"] = { fg = "#c5498c" },
		LineNr = { link = "CursorLineNr" },
		["@lsp.type.class.c"] = { link = "Type" },
    ["@comment"] = { link = "Comment" }
    -- ["StatusLine"] = { fg = "#27273a", bg = "#fde3e8"}
	}
end

function M.try()
	vim.cmd.hi("clear")
	require("tests.minibasechad").gencolorscheme("pinkcat", M.base16, M.base30, M.overrides, true)
  vim.cmd("doautocmd ColorScheme")
end
M.try()

local function something()
  print("hello world")
end
something()

return M
