local c = {
  background = "#F7F7FF", --Off-white background (from your visual identity)
  foreground = "#1E1E2E", --Deep navy foreground (from your visual identity)
  cursor_fg = "#F7F7FF", --Off-white cursor text
  cursor_bg = "#9655FF", --Deep purple cursor (from your visual identity)
  cursorline = "#E8E8F0", --Slightly darker than background
  selection = "#FEF5BC", --Soft yellow selection (from your visual identity)
  line_nr = "#6E6A86", --Medium gray for line numbers
  line_nr_selected = "#1E1E2E", --Deep navy for selected line number
  status_fg = "#1E1E2E", --Deep navy
  status_bg = "#E8E8F0", --Light gray
  status_inactive_fg = "#6E6A86", --Medium gray
  status_inactive_bg = "#F7F7FF", --Off-white
  menu_fg = "#1E1E2E", --Deep navy
  menu_bg = "#E8E8F0", --Light gray
  menu_sel_fg = "#F7F7FF", --Off-white
  menu_sel_bg = "#FEF5BC", --Soft yellow selection
  menu_scroll_fg = "#6E6A86", --Medium gray
  menu_scroll_bg = "#E8E8F0", --Light gray
  popup_fg = "#1E1E2E", --Deep navy
  popup_bg = "#E8E8F0", --Light gray
  match_paren_fg = "#1E1E2E", --Deep navy
  match_paren_bg = "#FEF5BC", --Soft yellow

  comment_fg = "#6E6A86", --Medium gray comments
  string_fg = "#FEF5BC", --Soft yellow strings (from your visual identity)
  string_special_fg = "#F28FAD", --Pink special strings
  constant_fg = "#F28FAD", --Pink constants
  constant_builtin_fg = "#F28FAD", --Pink built-in constants
  number_fg = "#F8BD96", --Peach numbers
  boolean_fg = "#F28FAD", --Pink booleans
  function_fg = "#005F87", --Dark blue functions (more distinguishable)
  function_builtin_fg = "#005F87", --Dark blue built-in functions
  keyword_fg = "#9655FF", --Deep purple keywords
  keyword_control_fg = "#9655FF", --Deep purple control keywords
  operator_fg = "#6E6A86", --Medium gray operators (adjusted for better contrast)
  variable_fg = "#1E1E2E", --Deep navy variables
  variable_builtin_fg = "#F28FAD", --Pink built-in variables
  type_fg = "#C9CBFF", --Lavender types
  type_builtin_fg = "#C9CBFF", --Lavender built-in types
  attribute_fg = "#9655FF", --Deep purple attributes
  namespace_fg = "#9655FF", --Deep purple namespaces
  punctuation_fg = "#1E1E2E", --Deep navy punctuation
  symbol_fg = "#F28FAD", --Pink symbols (e.g., Elixir atoms)

  error_fg = "#E78284", --Soft red errors
  warning_fg = "#E5C890", --Soft yellow warnings
  info_fg = "#8CAAEE", --Soft blue info
  hint_fg = "#8BD5CA", --Soft cyan hints

  diff_add_fg = "#A6DA95", --Soft green additions
  diff_delete_fg = "#E78284", --Soft red deletions
  diff_change_fg = "#E5C890", --Soft yellow changes

  markup_heading_fg = "#9655FF", --Deep purple headings
  markup_bold_fg = "#1E1E2E", --Deep navy bold text
  markup_italic_fg = "#1E1E2E", --Deep navy italic text
  markup_link_url_fg = "#005F87", --Dark blue links
  markup_link_text_fg = "#9655FF", --Deep purple link text
  markup_quote_fg = "#6E6A86", --Gray quotes
}

local palette = {
  base00 = "#F7F7FF",
  base01 = "#FEF5BC",
  base02 = "#494D64",
  base03 = "#6E6A86",
  base04 = "#1E1E2E",
  base05 = "#1E1E2E",
  base06 = "#E5C890",
  base07 = "#8CAAEE",
  base08 = "#E78284",
  base09 = "#F5C2E7",
  base0A = "#F5C2E7",
  base0B = "#005F87",
  base0C = "#8CAAEE",
  base0D = "#005F87",
  base0E = "#9655FF",
  base0F = "#8BD5CA",
}

local hi = function(...) vim.api.nvim_set_hl(0, ...) end
require("mini.base16").setup({ palette = palette })

hi("Cursor", { fg = c.cursor_fg, bg = c.cursor_bg })

hi("CursorIM", { link = "Cursor" })
hi("lCursor", { link = "Cursor" })
hi("TermCursor", { link = "Cursor" })

hi("SignColumn", { fg = c.line_nr })
hi("LineNrAbove", { fg = c.line_nr })
hi("LineNrBelow", { fg = c.line_nr })

--
hi("StatusLine", { fg = c.status_fg, bg = c.status_bg })
hi("StatusLineNC", { fg = c.status_inactive_fg, bg = c.status_inactive_bg })
--
hi("Pmenu", { fg = c.popup_fg, bg = c.popup_bg })
hi("PmenuSel", { fg = c.menu_fg, bg = c.menu_sel_bg, bold = true })
hi("PmenuSbar", { fg = c.menu_scroll_fg, bg = c.menu_scroll_bg })
hi("CursorLine", { bg = c.cursorline })
hi("MatchParen", { bg = c.match_paren_bg, fg = c.match_paren_fg, bold = true })
hi("LineNr", { fg = c.line_nr })
hi("CursorLineNr", { fg = c.line_nr_selected, bg = c.cursorline, bold = true })
--
hi("Visual", { bg = c.selection })
--
hi("Comment", { fg = c.comment_fg, italic = true })
hi("String", { fg = c.markup_quote_fg })
hi("Constant", { fg = c.constant_fg })
hi("@type.builtin", { fg = c.constant_builtin_fg })
hi("@module.builtin", { link = "@type.builtin" })
hi("Number", { fg = c.number_fg })
--
hi("DiagnosticVirtualTextError", { fg = c.error_fg, bold = true })
hi("DiagnosticVirtualTextHint", { fg = c.hint_fg, bold = true })
hi("DiagnosticVirtualTextInfo", { fg = c.info_fg, bold = true })
hi("DiagnosticVirtualTextWarn", { fg = c.warning_fg, bold = true })
hi("DiagnosticSignError", { fg = c.error_fg, bold = true })
hi("DiagnosticSignHint", { fg = c.hint_fg, bold = true })
hi("DiagnosticSignInfo", { fg = c.info_fg, bold = true })
hi("DiagnosticSignWarn", { fg = c.warning_fg, bold = true })

hi("Keyword", { fg = c.keyword_fg, bold = true })
hi("Conditional", { fg = c.keyword_control_fg, bold = true })

hi("Operator", { fg = c.operator_fg })
hi("@variable", { fg = c.variable_fg })
hi("Type", { fg = c.type_fg })
hi("@type.builtin", { fg = c.type_builtin_fg })

hi("DiffAdd", { fg = c.diff_add_fg })
hi("DiffDelete", { fg = c.diff_delete_fg })
hi("DiffChange", { fg = c.diff_change_fg })

hi("MiniDiffSignAdd", { link = "DiffAdd" })
hi("MiniDiffSignDelete", { link = "DiffDelete" })
hi("MiniDiffSignChange", { link = "DiffChange" })

hi("MiniPickNormal", { fg = c.menu_fg, bg = c.menu_bg })
hi("MiniPickBorder", { link = "MiniPickNormal" })
hi("MiniPickMatchCurrent", { bg = c.menu_sel_bg })

vim.g.colors_name = "radiance"
