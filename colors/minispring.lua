local is_dark = vim.o.background == "dark"
-- local bg = is_dark and "#122722" or "#cfeae1"
-- local fg = is_dark and "#ced7d4" or "#29302e"

local bg = is_dark and "#1c2617" or "#dde6d9"
local fg = is_dark and "#c8d9d4" or "#23322e"

local palette = require("mini.hues").make_palette({
  background = bg,
  foreground = fg,
  saturation = is_dark and "medium" or "high",
  accent = "green",
})

require("mini.hues").apply_palette(palette)

local function hi(...) vim.api.nvim_set_hl(0, ...) end
hi("DiagnosticVirtualTextError", { fg = palette.red, bg = palette.red_bg })
hi("DiagnosticVirtualTextHint", { fg = palette.blue, bg = palette.blue_bg })
hi("DiagnosticVirtualTextInfo", { fg = palette.green, bg = palette.green_bg })
hi("DiagnosticVirtualTextWarn", { fg = palette.yellow, bg = palette.yellow_bg })

vim.g.colors_name = "minispring"
