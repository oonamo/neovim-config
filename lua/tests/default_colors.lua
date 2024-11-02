local palette = {
    base00 = '#11121d', base01 = '#151621', base02 = '#43444f', base03 = '#393a45',
    base04 = '#1b1c27', base05 = '#abb2bf', base06 = '#555661', base07 = '#2c2d38',
    base08 = '#a485dd', base09 = '#a485dd', base0A = '#7199ee', base0B = '#d7a65f',
    base0C = '#a485dd', base0D = '#95c561', base0E = '#ee6d85', base0F = '#773440'
    --  base00 = '#282b35', base01 = '#3d4048', base02 = '#53555d', base03 = '#686a71',
    -- base04 = '#7e8086', base05 = '#939599', base06 = '#a9aaae', base07 = '#bebfc2',
    -- base08 = '#b21889', base09 = '#786dc5', base0A = '#438288', base0B = '#df0002',
    -- base0C = '#00a0be', base0D = '#790ead', base0E = '#b21889', base0F = '#c77c48'
}

local base30 = {
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
}

-- #ffa0a0

-- STRINGs #b3f6c0
--

require("tests.minibasechad").gencolorscheme(palette, base30, "tokyodark")

-- require("mini.base16").setup({ palette = palette })
