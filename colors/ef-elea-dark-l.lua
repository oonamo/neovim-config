vim.cmd("highlight clear")
local is_dark = vim.o.bg == "light"
local bg = "#222524"
local fg = "#eaf2ef"

local palette = require("mini.hues").make_palette({
  background = bg,
  foreground = fg,
  saturation = "high",
  -- saturation = is_dark and "medium" or "high",
  -- saturation = is_dark and "lowmedium" or "mediumhigh",
  accent = "cyan",
})

require("mini.hues").apply_palette(palette)
local function hi(...) vim.api.nvim_set_hl(0, ...) end

local colors = {
  accent = "#91ffff",
  accent_bg = "#007e7e",
  azure = "#97d5ff",
  azure_bg = "#005681",
  bg = "#222524",
  bg_edge = "#2b2e2d",
  bg_edge2 = "#070a09",
  bg_mid = "#303332",
  bg_mid2 = "#3e4140",
  blue = "#57aff6",
  blue_bg = "#26486c",
  cyan = "#6fcfd2",
  cyan_bg = "#204c60",
  fg = "#eaf2ef",
  fg_edge = "#eff7f4",
  fg_edge2 = "#f4fcf9",
  fg_mid = "#969faf",
  fg_mid2 = "#8fcfbb",
  green = "#7fc87f",
  green_bg = "#408420",
  orange = "#e0b02f",
  orange_bg = "#62432a",
  purple = "#cfaaff",
  purple_bg = "#59335b",
  red = "#ff656a",
  red_bg = "#6c2a2a",
  yellow = "#cac85f",
  yellow_bg = "#6b6500",
}

hi("StatusLine", { bg = "#35605d", fg = "#ecf0ff" })
hi("Cursor", { fg = colors.bg, bg = "#ef7fa8" })
hi("CursorIM", { link = "Cursor" })
hi("lCursor", { link = "Cursor" })
hi("TermCursor", { link = "Cursor" })
hi("Pmenu", { bg = "#2b2e2d", fg = colors.fg })
hi("PmenuSel", { bg = "#37493f", fg = colors.fg })
hi("FloatBorder", { fg = "#5d5f63" })
hi("CursorLine", { bg = "#2f413f" })
hi("MatchParen", { bg = "#3f6f5f" })

hi("VertSplit", { fg = "#5d5f63" })

hi("@markup.link", { fg = "#7fca5a", underline = true })

hi("Error", { bg = "#ff7a5f" })
hi("WarningMsg", { fg = "#e0b02f" })

hi("DiagnosticVirtualTextError", { fg = colors.red, bg = colors.red_bg })
hi("DiagnosticVirtualTextHint", { fg = colors.blue, bg = colors.blue_bg })
hi("DiagnosticVirtualTextInfo", { fg = colors.green, bg = colors.green_bg })
hi("DiagnosticVirtualTextWarn", { fg = colors.yellow, bg = colors.yellow_bg })

hi("Identifier", { fg = "#d0b9f0" })
hi("Visual", { bg = "#543040" })

hi("@function.builtin", { fg = "#d0b9f0" })
hi("@module.builtin", { link = "@function.builtin" })
hi("@variable.builtin", { link = "@function.builtin" })

hi("Comment", { fg = "#cac89f", italic = true })
hi("Constant", { fg = "#cfaaff" })
hi("Keyword", { fg = "#eba8a8", bold = true })
hi("PreProc", { fg = "#fa90ea" })
hi("String", { fg = "#50cf89" })
hi("Type", { fg = "#6fcfd2" })
-- hi("Variable", { fg = "#f59acf" })
-- hi("@variable", { fg = "#f59acf" })
hi("@string.escape", { fg = "#cfaaff" })
hi("Function", { fg = "#7fca5a" })
hi("Operator", { bold = true })

-- hi("Search", { bg = "#bd1f30" })
-- hi("IncSearch", { bg = "#424223", fg = "#ffffff" })
-- hi("CurSearch", { bg = "#847020" })

hi("DiffAdd", { fg = "#a0e0a0", bg = "#20493f" })
hi("DiffChange", { fg = "#dada90", bg = "#51512f" })
hi("DiffDelete", { fg = "#ffbfbf", bg = "#5e242f" })

hi("MiniDiffSignAdd", { fg = "#a0e0a0" })
hi("MiniDiffSignChange", { fg = "#dada90" })
hi("MiniDiffSignDelete", { fg = "#ffbfbf" })

hi("markdownH1", { fg = "#7fca5a" })
hi("markdownH2", { fg = "#eba8a8" })
hi("markdownH3", { fg = "#a9c99f" })
hi("markdownH4", { fg = "#60d5c2" })
hi("markdownH5", { fg = "#cfaaff" })
hi("markdownH6", { fg = "#f59acf" })

hi("@markup.heading.1.markdown", { link = "markdownH1" })
hi("@markup.heading.2.markdown", { link = "markdownH2" })
hi("@markup.heading.3.markdown", { link = "markdownH3" })
hi("@markup.heading.4.markdown", { link = "markdownH4" })
hi("@markup.heading.5.markdown", { link = "markdownH5" })
hi("@markup.heading.6.markdown", { link = "markdownH6" })

hi("MiniFilesCursorLine", { bg = "#37493f" })
hi("MiniPickMatchCurrent", { link = "MiniFilesCursorLine" })

hi("MiniPickPrompt", { fg = "#cfaaff", bold = true })
hi("Directory", { fg = "#50cf89" })

hi("markdownCodeBlock", { bg = "#2b2e2d" })
hi("RenderMarkdownCode", { bg = "#2b2e2d" })
hi("RenderMarkdownCodeInline", { fg = "#f59acf", bg = "#2b2e2d" })

vim.g.colors_name = "ef-elea-dark"
