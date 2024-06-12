local use_cterm, palette

--base00 - Default Background
--base01 - Lighter Background (Used for status bars, line number and folding marks)
--base02 - Selection Background
--base03 - Comments, Invisibles, Line Highlighting
--base04 - Dark Foreground (Used for status bars)
--base05 - Default Foreground, Caret, Delimiters, Operators
--base06 - Light Foreground (Not often used)
--base07 - Light Background (Not often used)
--base08 - Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
--base09 - Integers, Boolean, Constants, XML Attributes, Markup Link Url
--base0A - Classes, Markup Bold, Search Text Background
--base0B - Strings, Inherited Class, Markup Code, Diff Inserted
--base0C - Support, Regular Expressions, Escape Characters, Markup Quotes
--base0D - Functions, Methods, Attribute IDs, Headings
--base0E - Keywords, Storage, Selector, Markup Italic, Diff Changed
--base0F - Deprecated, Opening/Closing Embedded Language Tags, e.g. <?php ?>

palette = {
	base00 = "#efecf4",
	base01 = "#e2dfe7",
	base02 = "#8b8792",
	base03 = "#7e7887",
	base04 = "#655f6d",
	base05 = "#585260",
	base06 = "#26232a",
	base07 = "#19171c",
	base08 = "#be4678",
	base09 = "#aa573c",
	base0A = "#a06e3b",
	base0B = "#2a9292",
	base0C = "#398bc6",
	base0D = "#576ddb",
	base0E = "#955ae7",
	base0F = "#bf40bf",
}

if palette then
	require("mini.base16").setup({ palette = palette, use_cterm = use_cterm })
	vim.g.colors_name = "base16-atelier-cave-light"
end
