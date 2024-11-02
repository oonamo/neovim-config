local themes = {
	rosepine = {
		base16 = {
			base00 = "#191724",
			base01 = "#1f1d2e",
			base02 = "#26233a",
			base03 = "#6e6a86",
			base04 = "#908caa",
			base05 = "#e0def4",
			base06 = "#e0def4",
			base07 = "#524f67",
			base08 = "#eb6f92",
			base09 = "#f6c177",
			base0A = "#ebbcba",
			base0B = "#31748f",
			base0C = "#9ccfd8",
			base0D = "#c4a7e7",
			base0E = "#f6c177",
			base0F = "#524f67",
		},
		base30 = {
			black = "#191724", --  nvim bg
			darker_black = "#13111e",
			white = "#e0def4",
			black2 = "#1f1d2a",
			one_bg = "#262431", -- real bg of onedark
			one_bg2 = "#2d2b38",
			one_bg3 = "#353340",
			grey = "#3f3d4a",
			grey_fg = "#474552",
			grey_fg2 = "#514f5c",
			light_grey = "#5d5b68",
			red = "#eb6f92",
			baby_pink = "#f5799c",
			pink = "#ff83a6",
			line = "#2e2c39", -- for lines like vertsplit
			green = "#ABE9B3",
			vibrant_green = "#b5f3bd",
			nord_blue = "#86b9c2",
			blue = "#8bbec7",
			yellow = "#f6c177",
			sun = "#fec97f",
			purple = "#c4a7e7",
			dark_purple = "#bb9ede",
			teal = "#6aadc8",
			orange = "#f6c177",
			cyan = "#a3d6df",
			statusline_bg = "#201e2b",
			lightbg = "#2d2b38",
			pmenu_bg = "#c4a7e7",
			folder_bg = "#6aadc8",
		},
	},
	["rosepine-dawn"] = {
		base16 = {
			base00 = "#faf4ed",
			base01 = "#fffaf3",
			base02 = "#f2e9e1",
			base03 = "#9893a5",
			base04 = "#797593",
			base05 = "#575279",
			base06 = "#423e5b",
			base07 = "#dfdad9",
			base08 = "#b4637a",
			base09 = "#ea9d34",
			base0A = "#d7827e",
			base0B = "#56949f",
			base0C = "#286983",
			base0D = "#907aa9",
			base0E = "#ea9d34",
			base0F = "#A39EAD",
		},
		base30 = {
			white = "#575279",
			black = "#faf4ed", -- usually your theme bg
			darker_black = "#f2e9e1", -- 6% darker than black
			black2 = "#EDE1D6", -- 6% lighter than black
			one_bg = "#EADCCF", -- 10% lighter than black
			one_bg2 = "#E4D2C1", -- 6% lighter than one_bg2
			one_bg3 = "#DEC7B3", -- 6% lighter than one_bg3
			grey = "#b0acb9", -- 40% lighter than black (the % here depends so choose the perfect grey!)
			grey_fg = "#A39EAD", -- 10% lighter than grey
			grey_fg2 = "#9893A4", -- 5% lighter than grey
			light_grey = "#908B9D",
			red = "#b4637a",
			baby_pink = "#eb6f92",
			pink = "#eb6f92",
			line = "#EADCCF", -- 15% lighter than black
			green = "#286983",
			vibrant_green = "#3e8fb0",
			nord_blue = "#459BBD",
			blue = "#56949f",
			yellow = "#ea9d34",
			sun = "#f6c177",
			purple = "#907aa9",
			dark_purple = "#c4a7e7",
			teal = "#3e8fb0",
			orange = "#ea9d34",
			cyan = "#d7827e",
			statusline_bg = "#f2e9e1",
			lightbg = "#EADCCF",
			pmenu_bg = "#907aa9",
			folder_bg = "#56949f",
		},
	},
	catppuccin = {
		base16 = {
			base00 = "#1E1D2D",
			base01 = "#282737",
			base02 = "#2f2e3e",
			base03 = "#383747",
			base04 = "#414050",
			base05 = "#bfc6d4",
			base06 = "#ccd3e1",
			base07 = "#D9E0EE",
			base08 = "#F38BA8",
			base09 = "#F8BD96",
			base0A = "#FAE3B0",
			base0B = "#ABE9B3",
			base0C = "#89DCEB",
			base0D = "#89B4FA",
			base0E = "#CBA6F7",
			base0F = "#F38BA8",
		},
		base30 = {
			white = "#D9E0EE",
			darker_black = "#191828",
			black = "#1E1D2D", --  nvim bg
			black2 = "#252434",
			one_bg = "#2d2c3c", -- real bg of onedark
			one_bg2 = "#363545",
			one_bg3 = "#3e3d4d",
			grey = "#474656",
			grey_fg = "#4e4d5d",
			grey_fg2 = "#555464",
			light_grey = "#605f6f",
			red = "#F38BA8",
			baby_pink = "#ffa5c3",
			pink = "#F5C2E7",
			line = "#383747", -- for lines like vertsplit
			green = "#ABE9B3",
			vibrant_green = "#b6f4be",
			nord_blue = "#8bc2f0",
			blue = "#89B4FA",
			yellow = "#FAE3B0",
			sun = "#ffe9b6",
			purple = "#d0a9e5",
			dark_purple = "#c7a0dc",
			teal = "#B5E8E0",
			orange = "#F8BD96",
			cyan = "#89DCEB",
			statusline_bg = "#232232",
			lightbg = "#2f2e3e",
			pmenu_bg = "#ABE9B3",
			folder_bg = "#89B4FA",
			lavender = "#c7d1ff",
		},
		override = function(theme, colors)
			return {
				["@variable"] = { fg = colors.lavender },
				["@property"] = { fg = colors.teal },
				["@variable.builtin"] = { fg = colors.red },
			}
		end,
	},
	flexoki = {
		base16 = function(base16, base30)
			base16.base00 = base30.black
			base16.base01 = base30.black2
			base16.base02 = base30.one_bg
			base16.base03 = base30.grey
			base16.base04 = base30.grey_fg
			base16.base05 = base30.white
			base16.base06 = "#b6bdca"
			base16.base07 = "#c8ccd4"
			base16.base08 = base30.red
			base16.base09 = base30.orange
			base16.base0A = base30.purple
			base16.base0B = base30.green
			base16.base0C = base30.cyan
			base16.base0D = base30.blue
			base16.base0E = base30.yellow
			base16.base0F = base30.teal
		end,
		base30 = {
			white = "#CECDC3",
			darker_black = "#171616",
			black = "#100F0F", --  nvim bg
			black2 = "#1c1b1b",
			one_bg = "#292626", -- real bg of onedark
			one_bg2 = "#353232",
			one_bg3 = "#373434",
			grey = "#393636",
			grey_fg = "#555050",
			grey_fg2 = "#5f5959",
			light_grey = "#6a6363",
			red = "#D14D41",
			baby_pink = "#d36da1",
			pink = "#CE5D97",
			line = "#292626", -- for lines like vertsplit
			green = "#879A39",
			vibrant_green = "#7e9f0e",
			nord_blue = "#4385BE",
			blue = "#4385BE",
			yellow = "#D0A215",
			sun = "#eabb2b",
			purple = "#8B7EC8",
			dark_purple = "#7f70c2",
			teal = "#519ABA",
			orange = "#DA702C",
			cyan = "#3AA99F",
			statusline_bg = "#171616",
			lightbg = "#292626",
			pmenu_bg = "#3AA99F",
			folder_bg = "#4385BE",
		},
		override = function(base16, colors)
			return {
				Keyword = { fg = colors.cyan },
				Include = { fg = colors.yellow },
				Tag = { fg = colors.blue },
				["@keyword"] = { fg = colors.cyan },
				["@variable.parameter"] = { fg = colors.baby_pink },
				["@tag.attribute"] = { fg = colors.orange },
				["@tag"] = { fg = colors.blue },
				["@string"] = { fg = colors.green },
				["@string.special.url"] = { fg = colors.green },
				["@markup.link.url"] = { fg = colors.green },
				["@punctuation.bracket"] = { fg = colors.yellow },
			}
		end,
	},
	jellybeans = {
		base16 = {
			base00 = "#151515",
			base01 = "#2e2e2e",
			base02 = "#3a3a3a",
			base03 = "#424242",
			base04 = "#474747",
			base05 = "#d9d9c4",
			base06 = "#dedec9",
			base07 = "#f1f1e5",
			base08 = "#C6B5DA",
			base09 = "#c99f4a",
			base0A = "#e1b655",
			base0B = "#99ad6a",
			base0C = "#99ad6a",
			base0D = "#8fa5cd",
			base0E = "#e18be1",
			base0F = "#cf6a4c",
		},
		base30 = {
			white = "#e8e8d3",
			darker_black = "#101010",
			black = "#151515", --  nvim bg
			black2 = "#1c1c1c",
			one_bg = "#252525",
			one_bg2 = "#2e2e2e",
			one_bg3 = "#3a3a3a",
			grey = "#424242",
			grey_fg = "#474747",
			grey_fg2 = "#4c4c4c",
			light_grey = "#525252",
			red = "#cf6a4c",
			baby_pink = "#da7557",
			pink = "#f0a0c0",
			line = "#2d2d2d", -- for lines like vertsplit
			green = "#99ad6a",
			vibrant_green = "#c2cea6",
			nord_blue = "#768cb4",
			blue = "#8197bf",
			yellow = "#fad07a",
			sun = "#ffb964",
			purple = "#ea94ea",
			dark_purple = "#e58fe5",
			teal = "#668799",
			orange = "#e78a4e",
			cyan = "#8fbfdc",
			statusline_bg = "#191919",
			lightbg = "#2c2c2c",
			pmenu_bg = "#8197bf",
			folder_bg = "#8197bf",
		},
	},
	tokyodark = {
		base16 = {
			base00 = "#11121d",
			base01 = "#151621",
			base02 = "#43444f",
			base03 = "#393a45",
			base04 = "#1b1c27",
			base05 = "#abb2bf",
			base06 = "#555661",
			base07 = "#2c2d38",
			base08 = "#a485dd",
			base09 = "#a485dd",
			base0A = "#7199ee",
			base0B = "#d7a65f",
			base0C = "#a485dd",
			base0D = "#95c561",
			base0E = "#ee6d85",
			base0F = "#773440",
		},
		base30 = {
			white = "#A0A8CD",
			darker_black = "#0c0d18",
			black = "#11121D", --  nvim bg
			black2 = "#171823",
			one_bg = "#1d1e29",
			one_bg2 = "#252631",
			one_bg3 = "#252631",
			grey = "#474853",
			grey_fg = "#474853",
			grey_fg2 = "#4e4f5a",
			light_grey = "#545560",
			red = "#ee6d85",
			baby_pink = "#fd7c94",
			pink = "#fe6D85",
			line = "#252631",
			green = "#98c379",
			vibrant_green = "#95c561",
			nord_blue = "#648ce1",
			blue = "#7199ee",
			yellow = "#d7a65f",
			sun = "#dfae67",
			purple = "#a485dd",
			dark_purple = "#9071c9",
			teal = "#519aba",
			orange = "#f6955b",
			cyan = "#38a89d",
			statusline_bg = "#161722",
			lightbg = "#2a2b36",
			pmenu_bg = "#ee6d85",
			folder_bg = "#7199ee",
		},
	},
	everforest = {
		base16 = {
			base00 = "#2b3339",
			base01 = "#323c41",
			base02 = "#3a4248",
			base03 = "#424a50",
			base04 = "#4a5258",
			base05 = "#d3c6aa",
			base06 = "#ddd0b4",
			base07 = "#e7dabe",
			base08 = "#7fbbb3",
			base09 = "#d699b6",
			base0A = "#83c092",
			base0B = "#dbbc7f",
			base0C = "#e69875",
			base0D = "#a7c080",
			base0E = "#e67e80",
			base0F = "#d699b6",
		},
		base30 = {
			white = "#D3C6AA",
			darker_black = "#272f35",
			black = "#2b3339", --  nvim bg
			black2 = "#323a40",
			one_bg = "#363e44",
			one_bg2 = "#363e44",
			one_bg3 = "#3a4248",
			grey = "#4e565c",
			grey_fg = "#545c62",
			grey_fg2 = "#626a70",
			light_grey = "#656d73",
			red = "#e67e80",
			baby_pink = "#ce8196",
			pink = "#ff75a0",
			line = "#3a4248", -- for lines like vertsplit
			green = "#83c092",
			vibrant_green = "#a7c080",
			nord_blue = "#78b4ac",
			blue = "#7393b3",
			yellow = "#dbbc7f",
			sun = "#d1b171",
			purple = "#ecafcc",
			dark_purple = "#d699b6",
			teal = "#69a59d",
			orange = "#e69875",
			cyan = "#95d1c9",
			statusline_bg = "#2e363c",
			lightbg = "#3d454b",
			pmenu_bg = "#83c092",
			folder_bg = "#7393b3",
		},
		override = function(_, colors)
			return {
				["@tag"] = { fg = colors.orange },
				["@tag.delimiter"] = { fg = colors.green },
			}
		end,
	},
}

for k, v in pairs(themes) do
	if type(v.base16) == "function" then
		local tbl = {}
		v.base16(tbl, v.base30)
		v.base16 = tbl
	end

	require("tests.minibasechad").gencolorscheme(k, v.base16, v.base30, v.override)
end
