local base16 = {
	-- base00 = "#232136",
	-- base01 = "#2a273f",
	-- base02 = "#393552",
	-- base03 = "#6e6a86",
	-- base04 = "#908caa",
	-- base05 = "#e0def4",
	-- base06 = "#e69ec4",
	-- base07 = "#f8c984",
	-- base08 = "#f3afab",
	-- base09 = "#78b2cd",
	-- base0A = "#aed6e1",
	-- base0B = "#c2ade4",
	-- base0C = "#e0def4",
	-- base0D = "#f6c177",
	-- base0E = "#eb6f92",
	-- base0F = "#c4a7e7",
	-- base00 = "#232136",
	base00 = "#1a1b26",
	base01 = "#2a273f",
	base02 = "#393552",
	base03 = "#6e6a86",
	base04 = "#908caa",
	base05 = "#e0def4",
	base06 = "#cccccc",
	base07 = "#f8c984",
	base08 = "#e69ec4",
	base09 = "#78b2cd",
	base0A = "#aed6e1",
	base0B = "#c2ade4",
	base0C = "#f3afab",
	base0D = "#f6c177",
	base0E = "#aaaaaa",
	base0F = "#eb6f92",
}
local something = "something"

local numbedr = 3

-- base00 - Default Background
-- base01 - Lighter Background (Used for status bars, line number and folding marks)
-- base02 - Selection Background
-- base03 - Comments, Invisibles, Line Highlighting
-- base04 - Dark Foreground (Used for status bars)
-- base05 - Default Foreground, Caret, Delimiters, Operators
-- base06 - Light Foreground (Not often used)
-- base07 - Light Background (Not often used)
-- base08 - Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
-- base09 - Integers, Boolean, Constants, XML Attributes, Markup Link Url
-- base0A - Classes, Markup Bold, Search Text Background
-- base0B - Strings, Inherited Class, Markup Code, Diff Inserted
-- base0C - Support, Regular Expressions, Escape Characters, Markup Quotes
-- base0D - Functions, Methods, Attribute IDs, Headings
-- base0E - Keywords, Storage, Selector, Markup Italic, Diff Changed
-- base0F - Deprecated, Opening/Closing Embedded Language Tags, e.g. <?php ?>
--
require("mini.base16").setup({
	palette = base16,
})
