if vim.g.colors_name ~= nil then vim.cmd("highlight clear") end

local function hi(...) vim.api.nvim_set_hl(0, ...) end

local is_dark = vim.o.background == "dark"
local bg = is_dark and "#232025" or "#ffead8"
local fg = is_dark and "#efd5c5" or "#393330"
local palette = require("mini.hues").make_palette({
  background = bg,
  foreground = fg,
  saturation = is_dark and "medium" or "high",
  accent = "purple",
})

local pal = {
  accent = "#dacdff",
  accent_bg = "#251743",
  azure = "#9aebf4",
  azure_bg = "#004a51",
  bg = "#232025",
  bg_edge = "#171419",
  bg_edge2 = "#09070b",
  bg_mid = "#3f3c42",
  bg_mid2 = "#5d5a60",
  blue = "#b0d8ff",
  blue_bg = "#002649",
  cyan = "#acecc9",
  cyan_bg = "#003d25",
  fg = "#efd5c5",
  fg_edge = "#fbe1d1",
  fg_edge2 = "#ffe9da",
  fg_mid = "#cdb4a4",
  fg_mid2 = "#ab9384",
  green = "#d8e2a5",
  green_bg = "#313600",
  orange = "#ffc6bf",
  orange_bg = "#400c0c",
  purple = "#dacdff",
  purple_bg = "#251743",
  red = "#ffc7eb",
  red_bg = "#390e2d",
  yellow = "#fdd2a1",
  yellow_bg = "#492c00",
}

palette.accent_bg = "#675072"

require("mini.hues").apply_palette(palette)

hi("DiagnosticVirtualTextError", { fg = palette.red, bg = palette.red_bg })
hi("DiagnosticVirtualTextHint", { fg = palette.blue, bg = palette.blue_bg })
hi("DiagnosticVirtualTextInfo", { fg = palette.green, bg = palette.green_bg })
hi("DiagnosticVirtualTextWarn", { fg = palette.yellow, bg = palette.yellow_bg })

hi("Pmenu", { bg = "#2a272c", fg = "#f6e2d2" })
-- hi("PmenuKind", { bg = "#f6e2d2", fg = "#393330" })
hi("PmenuSel", { bg = "#503240" })
hi("BlinkCmpLabelMatch", { fg = "#deb07a" })

hi("MiniTablineCurrent", { bg = bg, fg = pal.fg_edge2, underline = true })
hi("MiniTablineVisible", { bg = bg, fg = pal.bg_mid })
hi("MiniTablineHidden", { bg = bg, fg = pal.bg_mid })

