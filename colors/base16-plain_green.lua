local palette = {}
if vim.o.bg == "dark" then
	-- palette = {
	-- 	base00 = "#212121",
	-- 	base01 = "#303030",
	-- 	base02 = "#353535",
	-- 	base03 = "#4A4A4A",
	-- 	base04 = "#B2CCD6",
	-- 	base05 = "#EEFFFF",
	-- 	base06 = "#EEFFFF",
	-- 	base07 = "#FFFFFF",
	-- 	base08 = "#F07178",
	-- 	base09 = "#F78C6C",
	-- 	base0A = "#FFCB6B",
	-- 	base0B = "#C3E88D",
	-- 	base0C = "#89DDFF",
	-- 	base0D = "#82AAFF",
	-- 	base0E = "#C792EA",
	-- 	base0F = "#FF5370",
	-- }
	palette = {
		base00 = "#212121",
		base01 = "#303030",
		base02 = "#353535",
		base03 = "#4A4A4A",
		base04 = "#B2CCD6",
		base05 = "#EEFFFF",
		base06 = "#EEFFFF",
		base07 = "#FFFFFF",
		base08 = "#F07178",
		base09 = "#F78C6C",
		base0A = "#FFCB6B",
		base0B = "#C3E88D",
		base0C = "#89DDFF",
		base0D = "#82AAFF",
		base0E = "#C792EA",
		base0F = "#FF5370",
	}
else
	palette = {
		base00 = "#ffffff",
		base01 = "#e0e0e0",
		base02 = "#d6d6d6",
		base03 = "#8e908c",
		base04 = "#969896",
		base05 = "#4d4d4c",
		base06 = "#282a2e",
		base07 = "#1d1f21",
		base08 = "#c82829",
		base09 = "#f5871f",
		base0A = "#eab700",
		base0B = "#718c00",
		base0C = "#3e999f",
		base0D = "#4271ae",
		base0E = "#8959a8",
		base0F = "#a3685a",
	}
end

require("onam.helpers.colors.mini_base16").apply_custom_highlights(palette)
