local palette = {
	-- base00 = "#faf0dc",
	-- base01 = "#c8c8c8",
	-- base02 = "#888888",
	-- base03 = "#585858",
	-- base04 = "#282828",
	-- base05 = "#181818",
	-- base06 = "#000000",
	-- base07 = "#000000",
	-- base08 = "#de5d6e",
	-- base09 = "#ff9470",
	-- base0A = "#b3684f",
	-- base0B = "#76a85d",
	-- base0C = "#64b5a7",
	-- base0D = "#5890f8",
	-- base0E = "#c173d1",
	-- base0F = "#b3684f",
  --
    base00 = '#212121', base01 = '#303030', base02 = '#353535', base03 = '#4a4a4a',
    base04 = '#b2ccd6', base05 = '#eeffff', base06 = '#eeffff', base07 = '#ffffff',
    base08 = '#f07178', base09 = '#f78c6c', base0A = '#ffcb6b', base0B = '#c3e88d',
    base0C = '#89ddff', base0D = '#82aaff', base0E = '#c792ea', base0F = '#ff5370'
}

require("mini.base16").setup({ palette = palette })
