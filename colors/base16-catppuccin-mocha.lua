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
	base00 = "#1e1e2e",
	base01 = "#181825",
	base02 = "#313244",
	base03 = "#45475a",
	base04 = "#585b70",
	base05 = "#cdd6f4",
	base06 = "#f5e0dc",
	base07 = "#b4befe",
	base08 = "#f38ba8",
	base09 = "#fab387",
	base0A = "#f9e2af",
	base0B = "#a6e3a1",
	base0C = "#94e2d5",
	base0D = "#89b4fa",
	base0E = "#cba6f7",
	base0F = "#f2cdcd",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-catppuccin-mocha"
end
