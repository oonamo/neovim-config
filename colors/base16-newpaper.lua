local palette = {}

if vim.o.bg == "light" then
	palette = {
		base00 = "#f2f2f2",
		base01 = "#eeeeee",
		-- base02 = "#008700",
		base02 = "#0087af",
		base03 = "#878787",
		base04 = "#e4e4e4",
		base05 = "#2b2b2b",
		base06 = "#005f87",
		base07 = "#878787",
		base08 = "#008000",
		base09 = "#d70000",
		base0A = "#d70087",
		base0B = "#0072c1",
		base0C = "#5588ff",
		base0D = "#010183",
		base0E = "#8700af",
		base0F = "#f57613",
	}
else
	palette = {
		base00 = "#1c1c1c",
		base01 = "#2b2b2b",
		-- base02 = "#5f8787",
		base02 = "#333333",
		-- #6d9b9b
		-- #507272
		-- #4c6c6c
		-- base02 = "#000000",
		-- base03 = "#d7af5f",
		base03 = "#878787",
		base04 = "#d0d0d0",
		base05 = "#808080",
		base06 = "#d7875f",
		base07 = "#d0d0d0",
		base08 = "#585858",
		base09 = "#5faf5f",
		base0A = "#afd700",
		base0B = "#af87d7",
		base0C = "#ffaf00",
		base0D = "#ff5faf",
		base0E = "#00afaf",
		base0F = "#5f8787",
	}
end

require("onam.helpers.colors.mini_base16").apply_custom_highlights(palette)

vim.g.colors_name = "base16-newpaper"
-- require("mini.base16").setup({
-- 	palette = palette,
-- })

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
