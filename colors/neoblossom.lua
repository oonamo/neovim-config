-- local base00 = "#ede6e3", "254"
-- local base00 = "#dad3d0", "252"
-- local base00 = "#b6a8a2", "248"
-- local base00 = "#e3d0cb", "188"
-- local base00 = "#e6dad6", "253"
-- local base00 = "#685c56", "240"
-- local base00 = "#574b45", "239"
-- local base00 = "#938680", "102"
-- local base00 = "#8f8678", "102"
-- local base00 = "#fccec1", "217"
-- local base00 = "#fbf1be", "230"
-- local base00 = "#cefbbe", "194"
-- local base00 = "#9e552f", "131"
-- local base00 = "#995c8c", "96"
-- local base00 = "#407680", "66"

local palette = {}
local use_cterm = {}
palette = {
	-- Default Background
	-- Lighter Background (Used for status bars, line number and folding marks)
	-- Selection Background
	-- Comments, Invisibles, Line Highlighting
	-- Dark Foreground (Used for status bars)
	-- Default Foreground, Caret, Delimiters, Operators
	-- Light Foreground (Not often used)
	-- Light Background (Not often used)
	-- Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
	-- Integers, Boolean, Constants, XML Attributes, Markup Link Url
	-- Classes, Markup Bold, Search Text Background
	-- Strings, Inherited Class, Markup Code, Diff Inserted
	-- Support, Regular Expressions, Escape Characters, Markup Quotes
	-- Functions, Methods, Attribute IDs, Headings
	-- Keywords, Storage, Selector, Markup Italic, Diff Changed
	-- Deprecated, Opening/Closing Embedded Language Tags
	base00 = "#ede6e3",
	base01 = "#dad3d0",
	base02 = "#b6a8a2",
	base03 = "#8f8678",
	base04 = "#574b45",
	base05 = "#685c56",
	base06 = "#938680",
	base07 = "#938680",
	base08 = "#8f8678",
	base09 = "#407680",
	base0A = "#fbf1be",
	base0B = "#407680",
	base0C = "#574b45",
	base0D = "#995c8c",
	base0E = "#9e552f",
	base0F = "#fbf1be",
}

use_cterm = {
	-- base00 = 235,
	-- base01 = 238,
	-- base02 = 241,
	-- base03 = 102,
	-- base04 = 250,
	-- base05 = 252,
	-- base06 = 254,
	-- base07 = 231,
	-- base08 = 186,
	-- base09 = 136,
	-- base0A = 29,
	-- base0B = 115,
	-- base0C = 132,
	-- base0D = 153,
	-- base0E = 218,
	-- base0F = 67,
	base00 = 254,
	base01 = 252,
	base02 = 248,
	base03 = 188,
	base04 = 253,
	base05 = 240,
	base06 = 239,
	base07 = 102,
	base08 = 102,
	base09 = 217,
	base0A = 230,
	base0B = 194,
	base0C = 131,
	base0D = 96,
	base0E = 66,
	base0F = 66,
}

local pal = {}
if vim.o.background == "light" then
	-- pal = require("mini.base16").mini_palette("#e3d0cb", "#574b45", 80)
	-- pal = require("mini.base16").mini_palette("#e3d0cb", "#574b45", 80)
	pal = require("mini.base16").mini_palette("#ede6e3", "#574b45", 80)
else
	pal = require("mini.base16").mini_palette("#574b45", "#ede6e3", 80)
end

if pal then
	-- require("mini.base16").setup({ palette = palette, use_cterm = use_cterm })
	require("mini.base16").setup({ palette = pal })
	vim.g.colors_name = "neoblossom"
	-- vim.g.colors_name = "blossom"
end
