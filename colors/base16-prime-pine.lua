local palette = {
	-- base00 = "#1c1f20",
	base00 = "#0e0a00",
	base01 = "#282626",
	base02 = "#4d4d4f",
	base03 = "#58555e",
	base04 = "#908caa",
	base05 = "#e0dcd8",
	base06 = "#e69ec4",
	base07 = "#f8c984",
	base08 = "#f3afab",
	base09 = "#78b2cd",
	base0A = "#aed6e1",
	base0B = "#d2b3a4",
	base0C = "#a28985",
	base0D = "#becbc4",
	base0E = "#4e5751",
	base0F = "#c4a7e7",
}

require("mini.base16").setup({ palette = palette })
vim.g.colors_name = "base16-prime-pine"
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
