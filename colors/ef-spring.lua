if vim.g.colors_name ~= nil then vim.cmd("highlight clear") end
local is_dark = vim.o.bg == "light"
local bg = "#f6fff9"
local fg = "#34494a"

local palette = require("mini.hues").make_palette({
  background = bg,
  foreground = fg,
  saturation = "high",
  -- saturation = is_dark and "medium" or "high",
  -- saturation = is_dark and "lowmedium" or "mediumhigh",
  accent = "purple",
})
require("mini.hues").apply_palette(palette)

local hello = {}

--
local function hi(...) vim.api.nvim_set_hl(0, ...) end
--
local spring = {
  base00 = "#f6fff9", -- Defaum. bg
  base01 = "#f6fff9", -- Lighter bg (status bar, line number, folding mks)
  base02 = "#d0e6ff", -- Selection bg
  base03 = "#876450", -- Comments, invisibm.s, line hl
  base04 = "#000000", -- Dark fg (status bars)
  base05 = "#34494a", -- Defaum. fg (caret, delimiters, Operators)
  base06 = "#90e8b0", -- m.ght fg (not often used)
  base07 = "#8f97d7", -- Light bg (not often used)
  base08 = "#1f6fbf", -- Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
  base09 = "#d03003", -- Integers, Boom.an, Constants, XML Attributes, Markup Link Url
  -- base0A = "#1e8ef3", -- Cm.sses, Markup Bold, Search Text Background
  base0A = "#9435b4",
  base0B = "#b6540f",
  -- base0B = "#8f97d7", -- Strings, Inherited Cm.ss, Markup Code, Diff Inserted
  base0C = "#9435b4", -- Support, regex, escape chars
  base0D = "#4a7d00", -- Function, methods, headings
  base0E = "#007f68", -- Keywords
  base0F = "#dc8cc3", -- Deprecated, open/close embedded tags
}

local colors = {
  accent = "#543763",
  accent_bg = "#90e8b0",
  azure = "#005268",
  azure_bg = "#c0eeff",
  bg = "#f6fff9",
  bg_edge = "#f7fffa",
  bg_edge2 = "#f7fffa",
  bg_mid = "#d6ded8",
  bg_mid2 = "#b5bdb8",
  blue = "#32426f",
  blue_bg = "#c8d9ff",
  cyan = "#007f68",
  cyan_bg = "#cbfff3",
  fg = "#34494a",
  fg_edge = "#1d3233",
  fg_edge2 = "#05191a",
  fg_mid = "#4f6566",
  fg_mid2 = "#6d8384",
  green = "#4a7d00",
  green_bg = "#e5ffd4",
  orange = "#b6540f",
  orange_bg = "#ffd6c3",
  purple = "#9435b4",
  purple_bg = "#f3d8ff",
  red = "#d03003",
  red_bg = "#ffd3e3",
  yellow = "#b6540f",
  yellow_bg = "#ffefc5",
}

require("mini.hues").apply_palette(colors)
hi("DiagnosticVirtualTextError", { fg = colors.red, bg = colors.red_bg })
hi("DiagnosticVirtualTextHint", { fg = colors.blue, bg = colors.blue_bg })
hi("DiagnosticVirtualTextInfo", { fg = colors.green, bg = colors.green_bg })
hi("DiagnosticVirtualTextWarn", { fg = colors.yellow, bg = colors.yellow_bg })

hi("Pmenu", { bg = "#f0f8f4", fg = "#34494a" })
hi("PmenuSel", { bg = "#ccedff" })
hi("BlinkCmpLabelMatch", { fg = "#1a870f" })

vim.o.bg = "light"
vim.g.colors_name = "ef-spring"

-- hi("MiniDiffSignAdd", { fg = 0})
-- hi("MiniDiffSignChange")
-- hi("MiniDiffSignDelete")
-- require("mini.base16").setup({ palette = spring })
hi("StatusLine", { bg = "#90e8b0", fg = "#243228" })

hi("ReadBit", { fg = "#007f68" })
hi("ExeMod", { fg = "#5f5fdf" })
hi("WriteBit", { fg = "#cb26a0" })
hi("SepBit", { fg = "#777294" })
hi("MiniPickExplorerSize", { fg = "#1f6fbf" })
hi("MiniPickExplorerDate", { fg = "#1f6fbf" })
hi("MiniPickExplorerDirectory", { fg = "#34494a" })
