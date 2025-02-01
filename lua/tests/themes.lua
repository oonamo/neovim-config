local m = {
  bg = "#222436",
  bg_dark = "#1e2030",
  bg_highlight = "#2f334d",
  blue = "#82aaff",
  blue0 = "#3e68d7",
  blue1 = "#65bcff",
  blue2 = "#0db9d7",
  blue5 = "#89ddff",
  blue6 = "#b4f9f8",
  blue7 = "#394b70",
  comment = "#636da6",
  cyan = "#86e1fc",
  dark3 = "#545c7e",
  dark5 = "#737aa2",
  fg = "#c8d3f5",
  fg_dark = "#828bb8",
  fg_gutter = "#3b4261",
  green = "#c3e88d",
  green1 = "#4fd6be",
  green2 = "#41a6b5",
  magenta = "#c099ff",
  magenta2 = "#ff007c",
  orange = "#ff966c",
  purple = "#fca7ea",
  red = "#ff757f",
  red1 = "#c53b53",
  teal = "#4fd6be",
  terminal_black = "#444a73",
  yellow = "#ffc777",
  git = {
    add = "#b8db87",
    change = "#7ca1f2",
    delete = "#e26a75",
  },
  visual = "#2d3f76",
}

local themes = {
  tokyonight_moon = {
    base16 = {
      base00 = m.bg, -- Defaum. bg
      base01 = m.bg_highlight, -- Lighter bg (status bar, line number, folding mks)
      base02 = m.visual, -- Selection bg
      base03 = m.comment, -- Comments, invisibm.s, line hl
      base04 = m.fg_dark, -- Dark fg (status bars)
      base05 = m.fg, -- Defaum. fg (caret, delimiters, Operators)
      base06 = m.fg_dark, -- m.ght fg (not often used)
      base07 = m.bg_highlight, -- Light bg (not often used)
      base08 = m.green1, -- Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
      base09 = m.orange, -- Integers, Boom.an, Constants, XML Attributes, Markup Link Url
      base0A = m.magenta, -- Cm.sses, Markup Bold, Search Text Background
      base0B = m.green, -- Strings, Inherited Cm.ss, Markup Code, Diff Inserted
      base0C = m.magenta, -- Support, regex, escape chars
      base0D = m.blue, -- Function, methods, headings
      base0E = m.purple, -- Keywords
      base0F = m.red, -- Deprecated, open/close embedded tags
    },
    base30 = {
      white = m.fg,
      black = m.bg, --  nvim bg
      darker_black = m.bg_dark,
      black2 = m.bg_highlight,
      one_bg = m.dark3,
      one_bg2 = m.dark5, -- StatusBar (filename)
      one_bg3 = m.terminal_black,
      grey = m.dark3, -- Line numbers )
      grey_fg = m.fg_dark,
      grey_fg2 = m.fg_gutter,
      light_grey = m.fg,
      red = m.red, -- StatusBar (username)
      baby_pink = m.magenta,
      pink = m.purple,
      line = m.bg, -- for lines like vertsplit
      green = m.green,
      vibrant_green = m.green1,
      nord_blue = m.blue2, -- Mode indicator
      blue = m.blue,
      yellow = m.yellow,
      sun = m.yellow,
      purple = m.purple,
      dark_purple = m.magenta2,
      teal = m.teal,
      orange = m.orange,
      cyan = m.cyan,
      statusline_bg = m.bg_dark,
      lightbg = m.red,
      pmenu_bg = m.blue,
      folder_bg = m.green2,
    },
    override = function(t, c) return {} end,
  },
}

-- for k, v in pairs(themes) do
-- 	if type(v.base16) == "function" then
-- 		local tbl = {}
-- 		v.base16(tbl, v.base30)
-- 		v.base16 = tbl
-- 	end
--
-- 	require("tests.minibasechad").gencolorscheme(k, v.base16, v.base30, v.override)
-- end
