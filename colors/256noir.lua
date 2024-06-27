-- Made with 'mini.colors' module of https://github.com/echasnovski/mini.nvim

if vim.g.colors_name ~= nil then vim.cmd('highlight clear') end
vim.g.colors_name = "256noir"

-- Highlight groups
local hi = vim.api.nvim_set_hl

hi(0, "Boolean", { bg = "#000000", ctermbg = 16, ctermfg = 250, fg = "#bcbcbc" })
hi(0, "Character", { bg = "#000000", ctermbg = 16, ctermfg = 196, fg = "#ff0000" })
hi(0, "CmpItemAbbrDefault", { fg = "#eeeeee" })
hi(0, "CmpItemAbbrDeprecatedDefault", { fg = "#585858" })
hi(0, "CmpItemAbbrMatchDefault", { fg = "#eeeeee" })
hi(0, "CmpItemAbbrMatchFuzzyDefault", { fg = "#eeeeee" })
hi(0, "CmpItemKindClassDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindColorDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindConstantDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindConstructorDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindDefault", { fg = "#8cf8f7" })
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
hi(0, "CmpItemMenuDefault", { fg = "#eeeeee" })
hi(0, "Comment", { bg = "#000000", ctermbg = 16, ctermfg = 240, fg = "#585858" })
hi(0, "Conditional", { bg = "#000000", ctermbg = 16, ctermfg = 255, fg = "#eeeeee" })
hi(0, "Constant", { bg = "#000000", ctermbg = 16, ctermfg = 252, fg = "#d0d0d0" })
hi(0, "Cursor", { bg = "#000000", bold = true, ctermbg = 16, ctermfg = 245, fg = "#8a8a8a", reverse = true })
hi(0, "CursorLine", { bg = "#121212", ctermbg = 233 })
hi(0, "CursorLineNr", { bg = "#000000", ctermbg = 16, ctermfg = 245, fg = "#8a8a8a" })
hi(0, "Debug", { bg = "#000000", ctermbg = 16, ctermfg = 250, fg = "#bcbcbc" })
hi(0, "Define", { bg = "#000000", ctermbg = 16, ctermfg = 255, fg = "#eeeeee" })
hi(0, "Delimiter", { bg = "#000000", ctermbg = 16, ctermfg = 250, fg = "#bcbcbc" })
hi(0, "DiffAdd", { bg = "#000000", ctermbg = 16, ctermfg = 255, fg = "#eeeeee" })
hi(0, "DiffChange", { bg = "#eeeeee", ctermbg = 255, ctermfg = 160, fg = "#d70000" })
hi(0, "DiffDelete", { bg = "#000000", ctermbg = 16, ctermfg = 240, fg = "#585858" })
hi(0, "DiffText", { bg = "#ff0000", bold = true, ctermbg = 196, ctermfg = 250, fg = "#bcbcbc" })
hi(0, "Directory", { bg = "#000000", ctermbg = 16, ctermfg = 255, fg = "#eeeeee" })
hi(0, "Error", { bg = "#870000", ctermbg = 88, ctermfg = 255, fg = "#eeeeee" })
hi(0, "ErrorMsg", { bg = "#af0000", ctermbg = 124, ctermfg = 255, fg = "#eeeeee" })
hi(0, "Exception", { bg = "#000000", ctermbg = 16, ctermfg = 250, fg = "#bcbcbc" })
hi(0, "FoldColumn", { bg = "#000000", ctermbg = 16, ctermfg = 250, fg = "#bcbcbc" })
hi(0, "Folded", { bg = "#000000", ctermbg = 16, ctermfg = 196, fg = "#ff0000" })
hi(0, "Function", { bg = "#000000", ctermbg = 16, ctermfg = 255, fg = "#eeeeee" })
hi(0, "Identifier", { bg = "#000000", ctermbg = 16, ctermfg = 250, fg = "#bcbcbc" })
hi(0, "IncSearch", { bg = "#8a8a8a", ctermbg = 245, ctermfg = 255, fg = "#eeeeee", reverse = true })
hi(0, "Include", { bg = "#000000", ctermbg = 16, ctermfg = 255, fg = "#eeeeee" })
hi(0, "Keyword", { bg = "#000000", ctermbg = 16, ctermfg = 255, fg = "#eeeeee" })
hi(0, "Label", { bg = "#000000", ctermbg = 16, ctermfg = 255, fg = "#eeeeee" })
hi(0, "LazyBold", { bold = true })
hi(0, "LazyItalic", { italic = true })
hi(0, "LineNr", { bg = "#000000", ctermbg = 16, ctermfg = 240, fg = "#585858" })
hi(0, "Macro", { bg = "#000000", ctermbg = 16, ctermfg = 250, fg = "#bcbcbc" })
hi(0, "MatchParen", { bg = "#585858", ctermbg = 240, ctermfg = 16, fg = "#000000" })
hi(0, "MiniCursorword", { underline = true })
hi(0, "MiniDiffSignAdd_stl", { fg = "#b3f6c0" })
hi(0, "MiniDiffSignChange_stl", { fg = "#8cf8f7" })
hi(0, "MiniDiffSignDelete_stl", { fg = "#ffc0b9" })
hi(0, "ModeMsg", { bg = "#000000", ctermbg = 16, ctermfg = 250, fg = "#bcbcbc" })
hi(0, "MoreMsg", { bg = "#000000", ctermbg = 16, ctermfg = 250, fg = "#bcbcbc" })
hi(0, "NonText", { bg = "#000000", ctermbg = 16, ctermfg = 240, fg = "#585858" })
hi(0, "Normal", { bg = "#000000", ctermbg = 16, ctermfg = 250, fg = "#bcbcbc" })
hi(0, "Number", { bg = "#000000", ctermbg = 16, ctermfg = 196, fg = "#ff0000" })
hi(0, "Operator", { bg = "#000000", ctermbg = 16, ctermfg = 255, fg = "#eeeeee" })
hi(0, "Pmenu", { bg = "#585858", ctermbg = 240, ctermfg = 255, fg = "#eeeeee" })
hi(0, "PmenuSbar", { bg = "#000000", ctermbg = 16, ctermfg = 250, fg = "#bcbcbc", reverse = true })
hi(0, "PmenuSel", { bg = "#000000", ctermbg = 16, ctermfg = 250, fg = "#bcbcbc", reverse = true })
hi(0, "PmenuThumb", { bg = "#585858", ctermbg = 240, ctermfg = 232, fg = "#080808" })
hi(0, "PreCondit", { bg = "#000000", ctermbg = 16, ctermfg = 255, fg = "#eeeeee" })
hi(0, "PreProc", { bg = "#000000", ctermbg = 16, ctermfg = 255, fg = "#eeeeee" })
hi(0, "Question", { bg = "#000000", ctermbg = 16, ctermfg = 250, fg = "#bcbcbc" })
hi(0, "Repeat", { bg = "#000000", ctermbg = 16, ctermfg = 255, fg = "#eeeeee" })
hi(0, "Search", { bg = "#303030", ctermbg = 236, ctermfg = 245, fg = "#8a8a8a" })
hi(0, "SignColumn", { bg = "#585858", ctermbg = 240, ctermfg = 124, fg = "#af0000" })
hi(0, "Special", { bg = "#000000", ctermbg = 16, ctermfg = 255, fg = "#eeeeee" })
hi(0, "SpecialChar", { bg = "#000000", ctermbg = 16, ctermfg = 255, fg = "#eeeeee" })
hi(0, "SpecialComment", { bg = "#000000", ctermbg = 16, ctermfg = 245, fg = "#8a8a8a" })
hi(0, "SpecialKey", { bg = "#eeeeee", ctermbg = 255, ctermfg = 16, fg = "#000000" })
hi(0, "SpellBad", { bg = "#870000", ctermbg = 88, ctermfg = 255, fg = "#eeeeee", sp = "#ffc0b9", undercurl = true })
hi(0, "SpellCap", { bg = "#af0000", ctermbg = 124, ctermfg = 255, fg = "#eeeeee", sp = "#fce094" })
hi(0, "SpellLocal", { bg = "#af0000", ctermbg = 124, ctermfg = 255, fg = "#eeeeee", sp = "#fce094" })
hi(0, "SpellRare", { bg = "#000000", ctermbg = 16, ctermfg = 124, fg = "#af0000", sp = "#8cf8f7" })
hi(0, "Statement", { bg = "#000000", ctermbg = 16, ctermfg = 255, fg = "#eeeeee" })
hi(0, "StatusLine", { bg = "#000000", bold = true, ctermbg = 16, ctermfg = 245, fg = "#8a8a8a", reverse = true })
hi(0, "StatusLineNC", { bg = "#000000", ctermbg = 16, ctermfg = 236, fg = "#303030", reverse = true })
hi(0, "StorageClass", { bg = "#000000", ctermbg = 16, ctermfg = 255, fg = "#eeeeee" })
hi(0, "String", { bg = "#000000", ctermbg = 16, ctermfg = 245, fg = "#8a8a8a" })
hi(0, "Structure", { bg = "#000000", ctermbg = 16, ctermfg = 255, fg = "#eeeeee" })
hi(0, "Tag", { bg = "#000000", ctermbg = 16, ctermfg = 196, fg = "#ff0000" })
hi(0, "Title", { bg = "#000000", ctermbg = 16, ctermfg = 250, fg = "#bcbcbc" })
hi(0, "Todo", { bg = "#000000", ctermbg = 16, ctermfg = 255, fg = "#eeeeee" })
hi(0, "Type", { bg = "#000000", ctermbg = 16, ctermfg = 255, fg = "#eeeeee" })
hi(0, "Typedef", { bg = "#000000", ctermbg = 16, ctermfg = 255, fg = "#eeeeee" })
hi(0, "Underlined", { bg = "#000000", ctermbg = 16, ctermfg = 124, fg = "#af0000", sp = "#8cf8f7" })
hi(0, "VertSplit", { bg = "#000000", ctermbg = 16, ctermfg = 250, fg = "#bcbcbc", reverse = true })
hi(0, "Visual", { bg = "#000000", ctermbg = 16, ctermfg = 250, fg = "#bcbcbc", reverse = true })
hi(0, "WarningMsg", { bg = "#000000", ctermbg = 16, ctermfg = 196, fg = "#ff0000" })
hi(0, "WildMenu", { bg = "#eeeeee", ctermbg = 255, ctermfg = 240, fg = "#585858" })
hi(0, "diffAdded", { bg = "#000000", ctermbg = 16, ctermfg = 255, fg = "#eeeeee" })
hi(0, "diffChanged", { bg = "#eeeeee", ctermbg = 255, ctermfg = 160, fg = "#d70000" })
hi(0, "diffCommon", { bg = "#000000", ctermbg = 16, ctermfg = 255, fg = "#eeeeee" })
hi(0, "diffRemoved", { bg = "#000000", ctermbg = 16, ctermfg = 240, fg = "#585858" })
hi(0, "iCursor", { bg = "#eeeeee", ctermbg = 255, ctermfg = 16, fg = "#000000" })
hi(0, "lCursor", { bg = "#bcbcbc", fg = "#000000" })
hi(0, "rstEmphasis", { bg = "#000000", ctermbg = 16, ctermfg = 124, fg = "#af0000", sp = "#8cf8f7" })
hi(0, "stl_fill", { fg = "#8a8a8a" })

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
