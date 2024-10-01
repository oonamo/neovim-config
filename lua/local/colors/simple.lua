local palette = {
	base00 = "#1b1c20",
	base01 = "#1b1c20",
	-- base01 = "#c3c4cb",
	base02 = "#c3c4cb",
	base03 = "#9d9fa4",
	base04 = "#202125",
	base05 = "#d4d6dd",
	base06 = "#d4d6dd",
	base07 = "#565c64",
	base08 = "#d4d6dd",
	base09 = "#ffeba2",
	base0A = "#98c379",
	base0B = "#56b6c2",
	base0C = "#e06c75",
	base0D = "#a9d1f3",
	base0E = "#d19a66",
	base0F = "#be5046",
}

require("mini.base16").setup({ palette = palette })
-- require("mini.base16").setup({ palette = require("mini.base16").mini_palette("#1b1c20", "#eaecf3", 70) })
