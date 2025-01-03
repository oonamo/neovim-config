-- "Cooling red autumn" vibe
-- Dark  (OKLch): bg=10-2-315 and fg=80-2-0
-- Light (OKLch): bg=85-2-315 and fg=15-2-0
-- Foreground hues are picked to maximize palette's bg colors visibility
local is_dark = vim.o.background == 'dark'
local bg = is_dark and '#1a141d' or '#dad1de'
local fg = is_dark and '#d3c2c6' or '#2b1e22'

local palette = require('mini.hues').make_palette({
  background = bg,
  foreground = fg,
  saturation = is_dark and 'medium' or 'high',
  accent = 'red',
})

require("mini.hues").apply_palette(palette)

local function hi(...) vim.api.nvim_set_hl(0, ...) end
hi("DiagnosticVirtualTextError", { fg = palette.red, bg = palette.red_bg })
hi("DiagnosticVirtualTextHint", { fg = palette.blue, bg = palette.blue_bg })
hi("DiagnosticVirtualTextInfo", { fg = palette.green, bg = palette.green_bg })
hi("DiagnosticVirtualTextWarn", { fg = palette.yellow, bg = palette.yellow_bg })

hi("MiniTablineCurrent", { bg = bg, fg = palette.fg_edge2, underline = true })
hi("MiniTablineVisible", { bg = bg, fg = palette.bg_mid })
hi("MiniTablineHidden", { bg = bg, fg = palette.bg_mid })

vim.g.colors_name = 'miniautumn'
