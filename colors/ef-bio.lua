if vim.g.colors_name ~= nil then vim.cmd("highlight clear") end
local is_dark = vim.o.bg == "dark"

local bg = "#111111"
local fg = "#cfdfd5"

local palette = {
  accent = "#dadada",
  accent_bg = "#111111",
  azure = "#a2e4ff",
  azure_bg = "#00384a",
  bg = "#111111",
  bg_edge = "#090909",
  bg_edge2 = "#030303",
  bg_mid = "#313131",
  bg_mid2 = "#505050",
  blue = "#c1d1ff",
  blue_bg = "#070a33",
  cyan = "#9eecdd",
  cyan_bg = "#00433a",
  fg = "#cfdfd5",
  fg_edge = "#dbebe1",
  fg_edge2 = "#e7f8ed",
  fg_mid = "#abbbb1",
  fg_mid2 = "#88978d",
  -- green = "#c3e7b3",
  green = "#3fb83f",
  green_bg = "#0a4425",
  orange = "#e09a0f",
  orange_bg = "#523324",
  purple = "#d38faf",
  purple_bg = "#572853",
  red = "#ef6560",
  red_bg = "#65201a",
  yellow = "#d4aa02",
  yellow_bg = "#523324",
}

require("mini.hues").apply_palette(palette)

vim.o.bg = "dark"
vim.g.colors_name = "ef-bio"

local function hi(...) vim.api.nvim_set_hl(0, ...) end
hi("StatusLine", { bg = "#00552f", fg = "#d0ffe0" })
hi("String", { fg = "#af9fff" })
hi("@keyword", { fg = "#00c089", bold = true })

hi("DiagnosticVirtualTextError", { fg = palette.red, bg = "#48100f" })
hi("DiagnosticVirtualTextHint", { fg = palette.blue, bg = palette.blue_bg })
hi("DiagnosticVirtualTextInfo", { fg = palette.green, bg = "#1a3b0f" })
hi("DiagnosticVirtualTextWarn", { fg = palette.yellow, bg = "#3b3400" })

hi("DiffAdd", { fg = "#a0e0a0" })
hi("DiffChange", { fg = "#efef80" })
hi("DiffDelete", { fg = "#ffbfbf" })

-- hi("MiniDiffSignAdd", { fg = "#a0e0a0", bg = "#003b1f" })
-- hi("MiniDiffSignChange", { fg = "#efef80", bg = "#363300" })
-- hi("MiniDiffSignDelete", { fg = "#ffbfbf", bg = "#4e1119" })
hi("MiniDiffSignAdd", { fg = "#a0e0a0" })
hi("MiniDiffSignChange", { fg = "#efef80" })
hi("MiniDiffSignDelete", { fg = "#ffbfbf" })

-- hi("Pmenu", { bg = "#ccedff" })
-- hi("Pmenu", { bg = "#f0f8f4", fg = "#34494a" })
hi("PmenuSel", { bg = "#0f3c2f" })
hi("BlinkCmpLabelMatch", { fg = "#1a870f" })
hi("Visual", { bg = "#00331f" })

hi("statusdiagnosticError", { fg = "#ff9fbf" })
hi("statusdiagnosticWarn", { fg = "#dfcf33" })
hi("statusdiagnosticInfo", { fg = "#7fdfff" })

hi("MiniJump2dSpot", { fg = "#e09a0f", bold = true, underline = true })
hi("MiniJump2dSpotUnique", { fg = "#ff778f", bold = true, underline = true })
hi("MiniJump2dSpotAhead", { fg = "#b7a07f", bold = true })
