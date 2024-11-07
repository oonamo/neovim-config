local l = {
	blue = "#a6dbff",
	cyan = "#8cf8f7",
	green = "#b3f6c0",
	grey1 = "#eef1f8",
	grey2 = "#e0e2ea",
	grey3 = "#c4c6cd",
	grey4 = "#9b9ea4",
	magenta = "#ffcaff",
	red = "#ffc0b9",
	yellow = "#fce094",
}

local d = {
	blue = "#004c73",
	cyan = "#007373",
	green = "#005523",
	grey1 = "#07080d",
	grey2 = "#14161b",
	grey3 = "#2c2e33",
	grey4 = "#4f5258",
	magenta = "#470045",
	red = "#590008",
	yellow = "#6b5300",
}

local themes = {
	default_light = {
		base16 = {
			base00 = l.grey2, -- Default bg
			base01 = l.grey3, -- Lighter bg (status bar, line number, folding mks)
			base02 = l.grey3, -- Selection bg
			base03 = d.grey4, -- Comments, invisibles, line hl
			base04 = d.grey3, -- Dark fg (status bars)
			base05 = d.grey2, -- Default fg (caret, delimiters, Operators)
			base06 = d.grey2, -- Light fg (not often used)
			base07 = l.grey2, -- Light bg (not often used)
			base08 = d.blue, -- Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
			base09 = d.magenta, -- Integers, Boolean, Constants, XML Attributes, Markup Link Url
			base0A = d.red, -- Classes, Markup Bold, Search Text Background
			base0B = d.green, -- Strings, Inherited Class, Markup Code, Diff Inserted
			base0C = d.yellow, -- Support, regex, escape chars
			base0D = d.cyan, -- Function, methods, headings
			base0E = d.magenta, -- Keywords
			base0F = d.blue, -- Deprecated, open/close embedded tags
		},
		base30 = {
			white = d.grey2,
			black = l.grey2, --  nvim bg
			darker_black = l.grey2,
			black2 = l.grey3,
			one_bg = l.grey1,
			one_bg2 = l.grey2, -- StatusBar (filename)
			one_bg3 = l.grey3,
			grey = d.grey1, -- Line numbers )
			grey_fg = l.grey4,
			grey_fg2 = d.grey4,
			light_grey = d.grey4,
			red = d.red, -- StatusBar (username)
			baby_pink = l.magenta,
			pink = l.red,
			line = d.grey1, -- for lines like vertsplit
			green = d.green,
			vibrant_green = l.green,
			nord_blue = d.blue, -- Mode indicator
			blue = d.blue,
			yellow = d.yellow,
			sun = l.yellow,
			purple = "#8263EB",
			dark_purple = "#5a32a3",
			teal = l.blue,
			orange = d.yellow,
			cyan = d.cyan,
			statusline_bg = d.grey3,
			lightbg = d.grey2,
			pmenu_bg = d.red,
			folder_bg = "#6a737d",
		},
		override = function(c, theme)
			return {
				StatusLine = { bg = theme.statusline_bg, fg = l.grey2 },
				MiniDiffSignAdd = { fg = theme.green },
				MiniDiffSignChange = { fg = theme.yellow },
				MiniDiffSignDelete = { fg = theme.red },
			}
		end,
	},
  default_dark = {
		base16 = {
			base00 = d.grey2, -- Default bg
			base01 = d.grey3, -- Lighter bg (status bar, line number, folding mks)
			base02 = l.grey3, -- Selection bg
			base03 = l.grey4, -- Comments, invisibles, line hl
			base04 = l.grey3, -- Dark fg (status bars)
			base05 = l.grey2, -- Default fg (caret, delimiters, Operators)
			base06 = l.grey2, -- Light fg (not often used)
			base07 = d.grey2, -- Light bg (not often used)
			base08 = l.blue, -- Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
			base09 = l.magenta, -- Integers, Boolean, Constants, XML Attributes, Markup Link Url
			base0A = l.red, -- Classes, Markup Bold, Search Text Background
			base0B = l.green, -- Strings, Inherited Class, Markup Code, Diff Inserted
			base0C = l.yellow, -- Support, regex, escape chars
			base0D = l.cyan, -- Function, methods, headings
			base0E = l.magenta, -- Keywords
			base0F = l.blue, -- Deprecated, open/close embedded tags
		},
		base30 = {
			white = l.grey2,
			black = d.grey2, --  nvim bg
			darker_black = d.grey2,
			black2 = d.grey3,
			one_bg = d.grey1,
			one_bg2 = d.grey2, -- StatusBar (filename)
			one_bg3 = d.grey3,
			grey = l.grey1, -- Line numbers )
			grey_fg = d.grey4,
			grey_fg2 = l.grey4,
			light_grey = l.grey4,
			red = l.red, -- StatusBar (username)
			baby_pink = d.magenta,
			pink = d.red,
			line = l.grey1, -- for lines like vertsplit
			green = l.green,
			vibrant_green = d.green,
			nord_blue = l.blue, -- Mode indicator
			blue = l.blue,
			yellow = l.yellow,
			sun = d.yellow,
			purple = "#8263EB",
			dark_purple = "#5a32a3",
			teal = d.blue,
			orange = l.yellow,
			cyan = l.cyan,
			statusline_bg = l.grey3,
			lightbg = l.grey2,
			pmenu_bg = l.red,
			folder_bg = "#6a737d",
		},
  }
}

-- require("mini.base16").setup({ palette = themes.default_light.base16 })

for k, v in pairs(themes) do
	if type(v.base16) == "function" then
		local tbl = {}
		v.base16(tbl, v.base30)
		v.base16 = tbl
	end

	require("tests.minibasechad").gencolorscheme(k, v.base16, v.base30, v.override)
end
