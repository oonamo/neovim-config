if vim.g.colors_name ~= nil then vim.cmd('highlight clear') end

local function hi(...)
  vim.api.nvim_set_hl(0, ...)
end

local is_dark = vim.o.background == "dark"
local bg = is_dark and "#232025" or "#ffead8"
local fg = is_dark and "#efd5c5" or "#393330"
local palette = require("mini.hues").make_palette({
	background = bg,
	foreground = fg,
	saturation = is_dark and "medium" or "high",
	accent = "purple",
})

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

vim.g.colors_name = "ef-dream"
