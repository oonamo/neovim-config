local palette = {
  base00 = "#000A0F",
  base01 = "#2E2E30",
  base02 = "#1E1E20",
  base03 = "#5E5A76",
  base04 = "#C0C0CE",
  base05 = "#C0C0CE",
  base06 = "#F8BD96",
  base07 = "#F28FAD",
  base08 = "#F28FAD",
  base09 = "#F5C2E7",
  base0A = "#F5C2E7",
  base0B = "#7FAFD7",
  base0C = "#F28FAD",
  base0D = "#005F87",
  base0E = "#9655FF",
  base0F = "#F5C2E7",
}

local c = {
  background = "#000A0F", -- Very dark background
  foreground = "#C0C0CE", -- Slightly muted foreground
  cursor_fg = "#0E0E10",
  cursor_bg = "#F28FAD", -- Pink cursor
  cursorline = "#1E1E20", -- Slightly lighter background
  selection = "#2E2E30", -- Dark gray selection
  line_nr = "#5E5A76", -- Dark gray line numbers
  line_nr_selected = "#C0C0CE", -- Foreground color for selected line number
  status_fg = "#C0C0CE",
  status_bg = "#1E1E20",
  status_inactive_fg = "#5E5A76",
  status_inactive_bg = "#0E0E10",
  menu_fg = "#C0C0CE",
  menu_bg = "#0E0E10",
  menu_sel_fg = "#0E0E10",
  menu_sel_bg = "#F28FAD",
  menu_scroll_fg = "#5E5A76",
  menu_scroll_bg = "#0E0E10",
  popup_fg = "#C0C0CE",
  popup_bg = "#0E0E10",
  match_paren_fg = "#F28FAD",
  match_paren_bg = "#0E0E10",

  comment_fg = "#5E5A76", -- Dark gray comments
  string_fg = "#8FBF8F", -- Muted green strings
  string_special_fg = "#F28FAD", -- Pink special strings
  constant_fg = "#F28FAD", -- Pink constants
  constant_builtin_fg = "#F28FAD",
  number_fg = "#D8A080", -- Muted peach numbers
  boolean_fg = "#F28FAD",
  function_fg = "#7FAFD7", -- Muted blue functions
  function_builtin_fg = "#7FAFD7",
  keyword_fg = "#F5C2E7", -- Pink keywords
  keyword_control_fg = "#F5C2E7",
  operator_fg = "#C0C0CE", -- Foreground color for operators
  variable_fg = "#C0C0CE",
  variable_builtin_fg = "#F28FAD",
  type_fg = "#A0A0D0", -- Muted lavender types
  type_builtin_fg = "#A0A0D0",
  attribute_fg = "#F5C2E7",
  namespace_fg = "#A090C0", -- Muted purple namespaces
  punctuation_fg = "#C0C0CE",
  symbol_fg = "#F28FAD",

  error_fg = "#D78284", -- Muted red errors
  warning_fg = "#D5B880", -- Muted yellow warnings
  info_fg = "#7A9CCC", -- Muted blue info
  hint_fg = "#7BB5A8", -- Muted cyan hints

  diff_add_fg = "#86BA75", -- Muted green additions
  diff_delete_fg = "#D78284", -- Muted red deletions
  diff_change_fg = "#D5B880", -- Muted yellow changes

  markup_heading_fg = "#F5C2E7",
  markup_bold_fg = "#F5C2E7",
  markup_italic_fg = "#F5C2E7",
  markup_link_url_fg = "#7FAFD7",
  markup_link_text_fg = "#F5C2E7",
  markup_quote_fg = "#5E5A76",
}

require("mini.base16").setup({ palette = palette })

local hi = function(...) vim.api.nvim_set_hl(0, ...) end

hi("Cursor", { fg = c.cursor_fg, bg = c.cursor_bg })

hi("StatusLine", { fg = c.status_fg, bg = c.status_bg })
hi("StatusLineNC", { fg = c.status_inactive_fg, bg = c.status_inactive_bg })

hi("Pmenu", { fg = c.popup_fg, bg = c.popup_bg })
hi("PmenuSel", { fg = c.menu_sel_fg, bg = c.menu_sel_bg })
hi("PmenuSbar", { fg = c.menu_scroll_fg, bg = c.menu_scroll_bg })
hi("CursorLine", { bg = c.cursorline })
hi("MatchParen", { bg = c.match_paren_bg, fg = c.match_paren_fg, bold = true })
hi("LineNr", { fg = c.line_nr })
hi("CursorLineNr", { fg = c.line_nr_selected, bg = c.cursorline, bold = true })

hi("Visual", { bg = c.selection })

hi("Comment", { fg = c.comment_fg, italic = true })
hi("String", { fg = c.string_fg })
hi("Constant", { fg = c.constant_fg })
hi("@type.builtin", { fg = c.constant_builtin_fg })
hi("@module.builtin", { link = "@type.builtin" })
hi("Number", { fg = c.number_fg })
hi("Function", { fg = c.function_fg })
hi("Keyword", { fg = c.keyword_fg })
hi("@variable", { fg = c.variable_fg })
hi("@symbol", { fg = c.symbol_fg })

hi("DiagnosticVirtualTextError", { fg = c.error_fg, bold = true })
hi("DiagnosticVirtualTextHint", { fg = c.hint_fg, bold = true })
hi("DiagnosticVirtualTextInfo", { fg = c.info_fg, bold = true })
hi("DiagnosticVirtualTextWarn", { fg = c.warning_fg, bold = true })

hi("DiagnosticFloatingError", { fg = c.error_fg, bold = true })
hi("DiagnosticFloatingHint", { fg = c.hint_fg, bold = true })
hi("DiagnosticFloatingInfo", { fg = c.info_fg, bold = true })
hi("DiagnosticFloatingWarn", { fg = c.warning_fg, bold = true })

hi("DiagnosticUnderlineError", { special = c.error_fg, underline = true })
hi("DiagnosticUnderlineHint", { special = c.hint_fg, underline = true })
hi("DiagnosticUnderlineInfo", { special = c.info_fg, underline = true })
hi("DiagnosticUnderlineWarn", { special = c.warning_fg, underline = true })

hi("Keyword", { fg = c.keyword_fg, bold = true })
hi("Conditional", { fg = c.keyword_control_fg, bold = true })

hi("Operator", { fg = c.operator_fg })
hi("@variable", { fg = c.variable_fg })
hi("Type", { fg = c.type_fg, italic = true })
hi("@type.builtin", { fg = c.type_builtin_fg, italic = true })
hi("@attribute", { fg = c.attribute_fg })
hi("@punctuation", { fg = c.punctuation_fg })

hi("DiffAdd", { fg = c.diff_add_fg })
hi("DiffDelete", { fg = c.diff_delete_fg })
hi("DiffChange", { fg = c.diff_change_fg })

vim.g.colors_name = "obsidian"
