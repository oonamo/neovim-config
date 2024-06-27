-- Made with 'mini.colors' module of https://github.com/echasnovski/mini.nvim

if vim.g.colors_name ~= nil then vim.cmd('highlight clear') end
vim.g.colors_name = "pink-moon-dark"

-- Highlight groups
local hi = vim.api.nvim_set_hl

hi(0, "Bold", { bold = true })
hi(0, "Boolean", { ctermfg = 14, fg = "#6f98b3" })
hi(0, "Character", { ctermfg = 11, fg = "#d08785" })
hi(0, "CmpItemAbbrDefault", { fg = "#fcdbd9" })
hi(0, "CmpItemAbbrDeprecatedDefault", { fg = "#6d7b8b" })
hi(0, "CmpItemAbbrMatchDefault", { fg = "#fcdbd9" })
hi(0, "CmpItemAbbrMatchFuzzyDefault", { fg = "#fcdbd9" })
hi(0, "CmpItemKindClassDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindColorDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindConstantDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindConstructorDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindDefault", { fg = "#ffd17f" })
hi(0, "CmpItemKindEnumDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindEnumMemberDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindEventDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindFieldDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindFileDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindFolderDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindFunctionDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindInterfaceDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindKeywordDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindMethodDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindModuleDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindOperatorDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindPropertyDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindReferenceDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindSnippetDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindStructDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindTextDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindTypeParameterDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindUnitDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindValueDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindVariableDefault", { link = "CmpItemKind" })
hi(0, "CmpItemMenuDefault", { fg = "#fcdbd9" })
hi(0, "ColorColumn", { bg = "#333c47", ctermbg = 8 })
hi(0, "Comment", { ctermfg = 2, fg = "#6d7b8b" })
hi(0, "Conceal", { bg = "#2a2e38", ctermbg = 0, ctermfg = 3, fg = "#fcdbd9" })
hi(0, "Conditional", { ctermfg = 9, fg = "#6f98b3" })
hi(0, "Constant", { ctermfg = 14, fg = "#d08785" })
hi(0, "Cursor", { bg = "#f0fdff", ctermbg = 7, ctermfg = 0, fg = "#2a2e38" })
hi(0, "CursorColumn", { bg = "#333c47", ctermbg = 8 })
hi(0, "CursorLine", { bg = "#333c47", ctermbg = 8 })
hi(0, "CursorLineNr", { bg = "#434852", bold = true, ctermbg = 8, ctermfg = 2, fg = "#fcdbd9" })
hi(0, "Debug", { ctermfg = 11, fg = "#d08785" })
hi(0, "Define", { ctermfg = 9, fg = "#6f98b3" })
hi(0, "Delimiter", { ctermfg = 3, fg = "#f0fdff" })
hi(0, "DiffAdd", { bg = "#2a2e38", ctermbg = 0, ctermfg = 12, fg = "#fdf8ce" })
hi(0, "DiffChange", { bg = "#2a2e38", ctermbg = 0, ctermfg = 3, fg = "#fcdbd9" })
hi(0, "DiffDelete", { bg = "#2a2e38", bold = true, ctermbg = 0, ctermfg = 11, fg = "#d08785" })
hi(0, "DiffText", { bg = "#2a2e38", ctermbg = 0, ctermfg = 3, fg = "#fcdbd9" })
hi(0, "Directory", { ctermfg = 3, fg = "#fcdbd9" })
hi(0, "ErrorMsg", { bg = "#2a2e38", ctermbg = 0, ctermfg = 11, fg = "#d08785" })
hi(0, "Exception", { ctermfg = 11, fg = "#d08785" })
hi(0, "Float", { ctermfg = 14, fg = "#6f98b3" })
hi(0, "FoldColumn", { bg = "#333c47", ctermbg = 8 })
hi(0, "Folded", { bg = "#333c47", ctermbg = 8, ctermfg = 2, fg = "#a6b8cc" })
hi(0, "Function", { ctermfg = 3, fg = "#fcdbd9" })
hi(0, "GitGutterAdd", { bg = "#333c47", ctermbg = 8, ctermfg = 12, fg = "#fdf8ce" })
hi(0, "GitGutterChange", { bg = "#333c47", ctermbg = 8, ctermfg = 3, fg = "#fcdbd9" })
hi(0, "GitGutterChangeDelete", { bg = "#333c47", ctermbg = 8, ctermfg = 9, fg = "#6f98b3" })
hi(0, "GitGutterDelete", { bg = "#333c47", ctermbg = 8, ctermfg = 11, fg = "#d08785" })
hi(0, "Identifier", { ctermfg = 11, fg = "#d08785" })
hi(0, "IncSearch", { bg = "#6f98b3", ctermbg = 14, ctermfg = 8, fg = "#333c47" })
hi(0, "Include", { ctermfg = 3, fg = "#fcdbd9" })
hi(0, "Keyword", { ctermfg = 9, fg = "#d08785" })
hi(0, "Label", { ctermfg = 11, fg = "#fcdbd9" })
hi(0, "LazyBold", { bold = true })
hi(0, "LazyItalic", { italic = true })
hi(0, "LineNr", { bg = "#333c47", ctermbg = 8, ctermfg = 2, fg = "#a6b8cc" })
hi(0, "Macro", { ctermfg = 11, fg = "#d08785" })
hi(0, "MatchParen", { bg = "#a6b8cc", bold = true, ctermbg = 2, ctermfg = 0, fg = "#2a2e38" })
hi(0, "MiniCursorword", { underline = true })
hi(0, "MiniDiffSignAdd_stl", { fg = "#b3f6c0" })
hi(0, "MiniDiffSignChange_stl", { fg = "#8cf8f7" })
hi(0, "MiniDiffSignDelete_stl", { fg = "#ffc0b9" })
hi(0, "ModeMsg", { ctermfg = 12, fg = "#fdf8ce" })
hi(0, "MoreMsg", { ctermfg = 12, fg = "#fdf8ce" })
hi(0, "NERDTreeDirSlash", { ctermfg = 3, fg = "#fcdbd9" })
hi(0, "NERDTreeExecFile", { ctermfg = 7, fg = "#f0fdff" })
hi(0, "NonText", { ctermfg = 2, fg = "#a6b8cc" })
hi(0, "Normal", { bg = "#2a2e38", ctermbg = 0, ctermfg = 7, fg = "#f0fdff" })
hi(0, "Number", { ctermfg = 14, fg = "#a6b8cc" })
hi(0, "Operator", { ctermfg = 7, fg = "#d08785" })
hi(0, "Pmenu", { bg = "#333c47", ctermbg = 8, ctermfg = 3, fg = "#fcdbd9" })
hi(0, "PmenuSel", { bg = "#fcdbd9", blend = 0, ctermbg = 3, ctermfg = 8, fg = "#333c47" })
hi(0, "PreProc", { ctermfg = 11, fg = "#fcdbd9" })
hi(0, "Question", { ctermfg = 14, fg = "#6f98b3" })
hi(0, "Repeat", { ctermfg = 11, fg = "#fcdbd9" })
hi(0, "Search", { bg = "#fcdbd9", ctermbg = 11, ctermfg = 2, fg = "#a6b8cc" })
hi(0, "SignColumn", { bg = "#333c47", ctermbg = 8, ctermfg = 2, fg = "#a6b8cc" })
hi(0, "SignifySignAdd", { bg = "#333c47", ctermbg = 8, ctermfg = 12, fg = "#fdf8ce" })
hi(0, "SignifySignChange", { bg = "#333c47", ctermbg = 8, ctermfg = 3, fg = "#fcdbd9" })
hi(0, "SignifySignDelete", { bg = "#333c47", ctermbg = 8, ctermfg = 11, fg = "#d08785" })
hi(0, "Special", { ctermfg = 14, fg = "#ffd17f" })
hi(0, "SpecialChar", { ctermfg = 3, fg = "#ffd17f" })
hi(0, "SpecialKey", { ctermfg = 2, fg = "#a6b8cc" })
hi(0, "SpellBad", { bg = "#2a2e38", ctermbg = 0, sp = "#ffc0b9", undercurl = true })
hi(0, "SpellCap", { bg = "#2a2e38", ctermbg = 0, sp = "#fce094", undercurl = true })
hi(0, "SpellLocal", { bg = "#2a2e38", ctermbg = 0, sp = "#b3f6c0", undercurl = true })
hi(0, "SpellRare", { bg = "#2a2e38", ctermbg = 0, sp = "#8cf8f7", undercurl = true })
hi(0, "Statement", { bold = true, ctermfg = 11, fg = "#6f98b3" })
hi(0, "StatusLine", { bg = "#434852", ctermbg = 8, ctermfg = 3, fg = "#fcdbd9" })
hi(0, "StatusLineNC", { bg = "#333c47", ctermbg = 8, ctermfg = 2, fg = "#a6b8cc" })
hi(0, "StorageClass", { ctermfg = 11, fg = "#fcdbd9" })
hi(0, "String", { ctermfg = 12, fg = "#fdf8ce" })
hi(0, "Structure", { ctermfg = 9, fg = "#6f98b3" })
hi(0, "TabLine", { bg = "#333c47", ctermbg = 8, ctermfg = 2, fg = "#a6b8cc" })
hi(0, "TabLineFill", { bg = "#333c47", ctermbg = 8, ctermfg = 2, fg = "#a6b8cc" })
hi(0, "TabLineSel", { bg = "#333c47", ctermbg = 8, ctermfg = 12, fg = "#fdf8ce" })
hi(0, "Tag", { ctermfg = 11, fg = "#fcdbd9" })
hi(0, "Title", { ctermfg = 3, fg = "#fcdbd9" })
hi(0, "Todo", { bg = "#333c47", bold = true, ctermbg = 8, ctermfg = 11, fg = "#fcdbd9" })
hi(0, "TooLong", { ctermfg = 11, fg = "#d08785" })
hi(0, "Type", { ctermfg = 14, fg = "#6f98b3" })
hi(0, "Typedef", { ctermfg = 11, fg = "#fcdbd9" })
hi(0, "Underlined", { ctermfg = 11, fg = "#d08785", underline = true })
hi(0, "VertSplit", { bg = "#434852", ctermbg = 8, ctermfg = 8, fg = "#434852" })
hi(0, "Visual", { bg = "#434852", ctermbg = 8, ctermfg = 0 })
hi(0, "VisualNOS", { ctermfg = 11, fg = "#d08785" })
hi(0, "WarningMsg", { ctermfg = 11, fg = "#d08785" })
hi(0, "WildMenu", { ctermfg = 11, fg = "#d08785" })
hi(0, "cssBraces", { ctermfg = 7, fg = "#f0fdff" })
hi(0, "cssClassName", { ctermfg = 9, fg = "#d08785" })
hi(0, "cssClassNameDot", { ctermfg = 9, fg = "#d08785" })
hi(0, "cssColor", { ctermfg = 14, fg = "#fdf8ce" })
hi(0, "cssPseudoClassId", { ctermfg = 9, fg = "#d08785" })
hi(0, "cssTagName", { ctermfg = 9, fg = "#d08785" })
hi(0, "diffAdded", { bg = "#2a2e38", ctermbg = 0, ctermfg = 12, fg = "#fdf8ce" })
hi(0, "diffFile", { bg = "#2a2e38", ctermbg = 0, ctermfg = 11, fg = "#d08785" })
hi(0, "diffLine", { bg = "#2a2e38", ctermbg = 0, ctermfg = 3, fg = "#fcdbd9" })
hi(0, "diffNewFile", { bg = "#2a2e38", ctermbg = 0, ctermfg = 12, fg = "#fdf8ce" })
hi(0, "diffRemoved", { bg = "#2a2e38", ctermbg = 0, ctermfg = 11, fg = "#d08785" })
hi(0, "gitcommitOverflow", { ctermfg = 11, fg = "#d08785" })
hi(0, "gitcommitSummary", { ctermfg = 12, fg = "#fdf8ce" })
hi(0, "htmlBold", { ctermfg = 11, fg = "#fcdbd9" })
hi(0, "htmlEndTag", { ctermfg = 7, fg = "#f0fdff" })
hi(0, "htmlItalic", { ctermfg = 9, fg = "#6f98b3" })
hi(0, "htmlTag", { ctermfg = 7, fg = "#f0fdff" })
hi(0, "javaScript", { ctermfg = 7, fg = "#f0fdff" })
hi(0, "javaScriptBraces", { ctermfg = 7, fg = "#f0fdff" })
hi(0, "javaScriptNumber", { ctermfg = 14, fg = "#6f98b3" })
hi(0, "lCursor", { bg = "#f0fdff", fg = "#2a2e38" })
hi(0, "markdownCode", { ctermfg = 12, fg = "#fdf8ce" })
hi(0, "markdownCodeBlock", { ctermfg = 12, fg = "#fdf8ce" })
hi(0, "markdownError", { bg = "#2a2e38", ctermbg = 0, ctermfg = 7, fg = "#f0fdff" })
hi(0, "markdownHeadingDelimiter", { ctermfg = 3, fg = "#fcdbd9" })
hi(0, "phpComparison", { ctermfg = 7, fg = "#f0fdff" })
hi(0, "phpMemberSelector", { ctermfg = 7, fg = "#f0fdff" })
hi(0, "phpParent", { ctermfg = 7, fg = "#f0fdff" })
hi(0, "pythonOperator", { ctermfg = 9, fg = "#6f98b3" })
hi(0, "pythonRepeat", { ctermfg = 9, fg = "#6f98b3" })
hi(0, "rubyAttribute", { ctermfg = 3, fg = "#fcdbd9" })
hi(0, "rubyConstant", { ctermfg = 11, fg = "#fcdbd9" })
hi(0, "rubyInterpolation", { ctermfg = 12, fg = "#fcdbd9" })
hi(0, "rubyInterpolationDelimiter", { ctermfg = 3, fg = "#6f98b3" })
hi(0, "rubyRegexp", { ctermfg = 14, fg = "#fdf8ce" })
hi(0, "rubyStringDelimiter", { ctermfg = 12, fg = "#fdf8ce" })
hi(0, "rubySymbol", { ctermfg = 12, fg = "#d08785" })
hi(0, "sassClassChar", { ctermfg = 14, fg = "#6f98b3" })
hi(0, "sassInclude", { ctermfg = 9, fg = "#6f98b3" })
hi(0, "sassMixinName", { ctermfg = 3, fg = "#fcdbd9" })
hi(0, "sassMixing", { ctermfg = 9, fg = "#6f98b3" })
hi(0, "sassidChar", { ctermfg = 11, fg = "#d08785" })
hi(0, "stl_fill", { fg = "#fcdbd9" })

-- Terminal colors
local g = vim.g

g.terminal_color_0 = "#252932"
g.terminal_color_1 = "#9dd6f4"
g.terminal_color_2 = "#6e7b87"
g.terminal_color_3 = "#5f7c99"
g.terminal_color_4 = "#edd98f"
g.terminal_color_5 = "#f8f8f2"
g.terminal_color_6 = "#9dd6f4"
g.terminal_color_7 = "#f8f8f2"
g.terminal_color_8 = "#edd98f"
g.terminal_color_9 = "#608dab"
g.terminal_color_10 = "#f8f8f2"
g.terminal_color_11 = "#9dd6f4"
g.terminal_color_12 = "#608dab"
g.terminal_color_13 = "#5673be"
g.terminal_color_14 = "#5673be"
g.terminal_color_15 = "#5673be"
