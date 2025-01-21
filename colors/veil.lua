local c = {
  background = "#1E1E2E", -- Dark purple background
  foreground = "#D9E0EE", -- Light lavender foreground
  cursor_fg = "#1E1E2E",
  cursor_bg = "#F5C2E7", -- Soft pink cursor
  cursorline = "#2E2E3E", -- Slightly lighter background
  selection = "#494D64", -- Grayish selection
  line_nr = "#6E6A86", -- Medium gray for line numbers
  line_nr_selected = "#D9E0EE", -- Foreground color for selected line number
  status_fg = "#D9E0EE",
  status_bg = "#302D41",
  status_inactive_fg = "#6E6A86",
  status_inactive_bg = "#1E1E2E",
  menu_fg = "#D9E0EE",
  menu_bg = "#1E1E2E",
  menu_sel_fg = "#1E1E2E",
  menu_sel_bg = "#F5C2E7",
  menu_scroll_fg = "#6E6A86",
  menu_scroll_bg = "#1E1E2E",
  popup_fg = "#D9E0EE",
  popup_bg = "#1E1E2E",
  match_paren_fg = "#F28FAD",
  match_paren_bg = "#1E1E2E",

  comment_fg = "#6E6A86", -- Gray comments
  string_fg = "#ABE9B3", -- Green strings
  string_special_fg = "#F28FAD", -- Pink special strings
  constant_fg = "#F28FAD", -- Pink constants
  constant_builtin_fg = "#F28FAD", -- Pink built-in constants
  number_fg = "#F8BD96", -- Peach numbers
  boolean_fg = "#F28FAD", -- Pink booleans
  function_fg = "#96CDFB", -- Blue functions
  function_builtin_fg = "#96CDFB", -- Blue built-in functions
  keyword_fg = "#F5C2E7", -- Pink keywords
  keyword_control_fg = "#F5C2E7", -- Pink control keywords
  operator_fg = "#D9E0EE", -- Foreground color for operators
  variable_fg = "#D9E0EE", -- Foreground color for variables
  variable_builtin_fg = "#F28FAD", -- Pink built-in variables
  type_fg = "#C9CBFF", -- Lavender types
  type_builtin_fg = "#C9CBFF", -- Lavender built-in types
  attribute_fg = "#F5C2E7", -- Pink attributes
  namespace_fg = "#DDB6F2", -- Purple namespaces
  punctuation_fg = "#D9E0EE", -- Foreground color for punctuation
  symbol_fg = "#F28FAD", -- Pink symbols (e.g., Elixir atoms)

  error_fg = "#E78284", -- Red errors
  warning_fg = "#E5C890", -- Yellow warnings
  info_fg = "#8CAAEE", -- Blue info
  hint_fg = "#8BD5CA", -- Cyan hints

  diff_add_fg = "#A6DA95", -- Green additions
  diff_delete_fg = "#E78284", -- Red deletions
  diff_change_fg = "#E5C890", -- Yellow changes

  markup_heading_fg = "#F5C2E7", -- Pink headings
  markup_bold_fg = "#F5C2E7", -- Pink bold text
  markup_italic_fg = "#F5C2E7", -- Pink italic text
  markup_link_url_fg = "#96CDFB", -- Blue links
  markup_link_text_fg = "#F5C2E7", -- Pink link text
  markup_quote_fg = "#6E6A86", -- Gray quotes
}

local palette = {
  base00 = "#1E1E2E",
  base01 = "#302D41",
  base02 = "#494D64",
  base03 = "#6E6A86",
  base04 = "#D9E0EE",
  base05 = "#D9E0EE",
  base06 = "#F8BD96",
  base07 = "#F5C2E7",
  base08 = "#F28FAD",
  base09 = "#F5C2E7",
  base0A = "#F5C2E7",
  base0B = "#ABE9B3",
  base0C = "#F28FAD",
  base0D = "#96CDFB",
  base0E = "#F5C2E7",
  base0F = "#F5C2E7",
}

local hi = function(...) vim.api.nvim_set_hl(0, ...) end

require("mini.base16").setup({ palette = palette })

hi("Cursor", { fg = c.cursor_fg, bg = c.cursor_bg })

hi("StatusLine", { fg = c.status_fg, bg = c.status_bg })
hi("StatusLineNC", { fg = c.status_inactive_fg, bg = c.status_inactive_bg })

hi("Pmenu", { fg = c.popup_fg, bg = c.popup_bg })
hi("PmenuSel", { fg = c.menu_sel_fg, bg = c.menu_sel_bg })
hi("PmenuSbar", { fg = c.menu_scroll_fg, bg = c.menu_scroll_bg })
hi("CursorLine", { bg = c.cursorline })
hi("MatchParen", { bg = c.match_paren_bg, fg = c.match_paren_fg, bold = true })
hi("LineNr", { fg = c.line_nr })
hi("CursorLineNr", { fg = c.line_nr_selected, bg = palette.base01, bold = true })

hi("Visual", { bg = c.selection })

hi("Comment", { fg = c.comment_fg, italic = true })
hi("String", { fg = c.string_fg })
hi("Constant", { fg = c.constant_fg })
hi("@type.builtin", { fg = c.constant_builtin_fg })
hi("@module.builtin", { link = "@type.builtin" })
hi("Number", { fg = c.number_fg })

hi("DiagnosticVirtualTextError", { fg = c.error_fg, bold = true })
hi("DiagnosticVirtualTextHint", { fg = c.hint_fg, bold = true })
hi("DiagnosticVirtualTextInfo", { fg = c.info_fg, bold = true })
hi("DiagnosticVirtualTextWarn", { fg = c.warning_fg, bold = true })

-- hi("Keyword", { fg = c.keyword_fg, bold = true })
-- hi("Conditional", { fg = c.keyword_control_fg, bold = true })
--
-- hi("Operator", { fg = c.operator_fg })
-- hi("@variable", { fg = c.variable_fg })
-- hi("Type", { fg = c.type_fg })
-- hi("@type.builtin", { fg = c.type_builtin_fg })

hi("DiffAdd", { fg = c.diff_add_fg })
hi("DiffDelete", { fg = c.diff_delete_fg })
hi("DiffChange", { fg = c.diff_change_fg })

hi("MiniIconsAzure", { fg = c.function_builtin_fg })
hi("MiniIconsBlue", { fg = c.info_fg })
hi("MiniIconsCyan", { fg = c.hint_fg })
hi("MiniIconsGreen", { fg = c.diff_add_fg })
hi("MiniIconsGrey", { fg = c.menu_scroll_fg })
hi("MiniIconsOrange", { fg = c.number_fg })
hi("MiniIconsPurple", { fg = c.type_fg })
hi("MiniIconsRed", { fg = c.variable_builtin_fg })
hi("MiniIconsYellow", { fg = c.warning_fg })

vim.g.colors_name = "veil"
