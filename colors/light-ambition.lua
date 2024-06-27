-- Made with 'mini.colors' module of https://github.com/echasnovski/mini.nvim

if vim.g.colors_name ~= nil then vim.cmd('highlight clear') end
vim.g.colors_name = "light-ambition"

-- Highlight groups
local hi = vim.api.nvim_set_hl

hi(0, "@constant.builtin", { link = "Special" })
hi(0, "@constructor", { ctermfg = 159, fg = "#8a5a95" })
hi(0, "@function", { ctermfg = 204, fg = "#cb006b" })
hi(0, "@function.call", { ctermfg = 159, fg = "#8a5a95" })
hi(0, "@keyword.operator", { ctermfg = 122, fg = "#7d6724" })
hi(0, "@markup", { link = "Title" })
hi(0, "@markup.emphasis", { italic = true })
hi(0, "@markup.link", { ctermfg = 141, fg = "#605562" })
hi(0, "@markup.link.uri", { ctermfg = 159, fg = "#8a5a95" })
hi(0, "@markup.list.checked", { ctermfg = 252, fg = "#9d939f" })
hi(0, "@markup.list.unchecked", { bold = true, ctermfg = 121, fg = "#a78933" })
hi(0, "@markup.raw", { ctermfg = 122, fg = "#7d6724" })
hi(0, "@module", { ctermfg = 141, fg = "#605562" })
hi(0, "@punctuation.bracket", { ctermfg = 122, fg = "#7d6724" })
hi(0, "@string.escape", { ctermfg = 122, fg = "#7d6724" })
hi(0, "@string.special", { ctermfg = 135, fg = "#b133cb" })
hi(0, "@string.special.symbol", { ctermfg = 228, fg = "#6f5700" })
hi(0, "@symbol", { ctermfg = 228, fg = "#6f5700" })
hi(0, "@tag", { link = "Keyword" })
hi(0, "@tag.attribute", { link = "Constant" })
hi(0, "@tag.delimiter", { link = "Special" })
hi(0, "@text.emphasis", { italic = true })
hi(0, "@text.literal", { ctermfg = 122, fg = "#7d6724" })
hi(0, "@text.reference", { ctermfg = 141, fg = "#605562" })
hi(0, "@text.strong", { bold = true })
hi(0, "@text.todo.checked", { ctermfg = 252, fg = "#9d939f" })
hi(0, "@text.todo.unchecked", { bold = true, ctermfg = 121, fg = "#a78933" })
hi(0, "@text.uri", { ctermfg = 159, fg = "#8a5a95" })
hi(0, "@variable", { fg = "#4b414d" })
hi(0, "@variable.builtin", { ctermfg = 122, fg = "#7d6724" })
hi(0, "Added", { ctermfg = 10, fg = "#755c00" })
hi(0, "Boolean", { ctermfg = 215, fg = "#886b00" })
hi(0, "Changed", { ctermfg = 14, fg = "#93792c" })
hi(0, "CmpItemAbbrDefault", { fg = "#4c494c" })
hi(0, "CmpItemAbbrDeprecatedDefault", { fg = "#9d939f" })
hi(0, "CmpItemAbbrMatch", { ctermfg = 141, fg = "#605562" })
hi(0, "CmpItemAbbrMatchDefault", { fg = "#4c494c" })
hi(0, "CmpItemAbbrMatchFuzzy", { ctermfg = 228, fg = "#6f5700" })
hi(0, "CmpItemAbbrMatchFuzzyDefault", { fg = "#4c494c" })
hi(0, "CmpItemKindClassDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindColorDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindConstantDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindConstructorDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindDefault", { fg = "#7d6724" })
hi(0, "CmpItemKindEnumDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindEnumMemberDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindEventDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindFieldDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindFileDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindFolderDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindFunction", { link = "Function" })
hi(0, "CmpItemKindFunctionDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindInterface", { link = "CmpItemKindDefault" })
hi(0, "CmpItemKindInterfaceDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindKeywordDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindMethod", { link = "CmpItemKindFunction" })
hi(0, "CmpItemKindMethodDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindModule", { link = "PreProc" })
hi(0, "CmpItemKindModuleDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindOperatorDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindPropertyDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindReference", { link = "CmpItemKindDefault" })
hi(0, "CmpItemKindReferenceDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindSnippet", { link = "Constant" })
hi(0, "CmpItemKindSnippetDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindStruct", { link = "CmpItemKindModule" })
hi(0, "CmpItemKindStructDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindText", { link = "Comment" })
hi(0, "CmpItemKindTextDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindTypeParameterDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindUnitDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindValueDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindVariableDefault", { link = "CmpItemKind" })
hi(0, "CmpItemMenu", { link = "Comment" })
hi(0, "CmpItemMenuDefault", { fg = "#4c494c" })
hi(0, "ColorColumn", { bg = "#ffffff", ctermbg = 233 })
hi(0, "Comment", { ctermfg = 252, fg = "#9d939f", italic = true })
hi(0, "Conceal", { ctermfg = 253, fg = "#4c494c" })
hi(0, "Constant", { ctermfg = 141, fg = "#605562" })
hi(0, "CurSearch", { bg = "#806d39", ctermbg = 11, ctermfg = 0, fg = "#ffffff" })
hi(0, "Cursor", { bg = "#816189", ctermbg = 159, ctermfg = 236, fg = "#e6bcef" })
hi(0, "CursorColumn", { bg = "#ffffff", ctermbg = 232 })
hi(0, "CursorLine", { bg = "#ffffff", ctermbg = 232 })
hi(0, "CursorLineNr", { bg = "#ffffff", bold = true, ctermbg = 232, ctermfg = 159, fg = "#8a5a95" })
hi(0, "Delimiter", { fg = "#4b414d" })
hi(0, "DiagnosticDeprecated", { sp = "#401223", strikethrough = true })
hi(0, "DiagnosticError", { bg = "#ffffff", ctermbg = 232, ctermfg = 204, fg = "#cb006b" })
hi(0, "DiagnosticFloatingError", { link = "DiagnosticSignError" })
hi(0, "DiagnosticFloatingHint", { link = "DiagnosticSignHint" })
hi(0, "DiagnosticFloatingInfo", { link = "DiagnosticSignInfo" })
hi(0, "DiagnosticFloatingWarn", { link = "DiagnosticSignWarn" })
hi(0, "DiagnosticHint", { bg = "#ffffff", ctermbg = 232, ctermfg = 141, fg = "#605562" })
hi(0, "DiagnosticInfo", { bg = "#ffffff", ctermbg = 232, ctermfg = 159, fg = "#8a5a95" })
hi(0, "DiagnosticOk", { ctermfg = 10, fg = "#755c00" })
hi(0, "DiagnosticSignError", { ctermfg = 204, fg = "#cb006b" })
hi(0, "DiagnosticSignHint", { ctermfg = 141, fg = "#605562" })
hi(0, "DiagnosticSignInfo", { ctermfg = 159, fg = "#8a5a95" })
hi(0, "DiagnosticSignWarn", { ctermfg = 228, fg = "#6f5700" })
hi(0, "DiagnosticUnderlineError", { undercurl = true })
hi(0, "DiagnosticUnderlineHint", { undercurl = true })
hi(0, "DiagnosticUnderlineInfo", { undercurl = true })
hi(0, "DiagnosticUnderlineOk", { sp = "#3b2d00", underline = true })
hi(0, "DiagnosticUnderlineWarn", { undercurl = true })
hi(0, "DiagnosticWarn", { bg = "#ffffff", ctermbg = 232, ctermfg = 228, fg = "#6f5700" })
hi(0, "DiffAdd", { bg = "#fefeff", ctermbg = 119 })
hi(0, "DiffChange", { bg = "#ffffff", ctermbg = 233 })
hi(0, "DiffDelete", { bg = "#ffffff", ctermbg = 203, ctermfg = 236, fg = "#f3e1f7" })
hi(0, "DiffText", { bg = "#ffffff", ctermbg = 215 })
hi(0, "Directory", { ctermfg = 141, fg = "#605562" })
hi(0, "Error", { bg = "#ffffff", bold = true, ctermbg = 232, ctermfg = 203, fg = "#fb4e94" })
hi(0, "ErrorMsg", { ctermfg = 203, fg = "#fb4e94" })
hi(0, "Float", { ctermfg = 215, fg = "#886b00" })
hi(0, "FloatBorder", { link = "WinSeparator" })
hi(0, "FloatShadow", { bg = "#d8d2d9", blend = 80, ctermbg = 0 })
hi(0, "FloatShadowThrough", { bg = "#d8d2d9", blend = 100, ctermbg = 0 })
hi(0, "FoldColumn", { ctermfg = 75, fg = "#c369d7" })
hi(0, "Folded", { ctermfg = 75, fg = "#c369d7" })
hi(0, "Function", { ctermfg = 204, fg = "#cb006b" })
hi(0, "FzfLuaPreviewTitle", { bg = "#6f4878", ctermbg = 141, ctermfg = 232, fg = "#ffffff" })
hi(0, "FzfLuaScrollFloatEmpty", { bg = "#dec3e4", ctermbg = 236 })
hi(0, "FzfLuaScrollFloatFull", { bg = "#9c5baa", ctermbg = 135 })
hi(0, "FzfLuaTitle", { bg = "#7a693a", ctermbg = 120, ctermfg = 232, fg = "#ffffff" })
hi(0, "GitSignsAdd", { ctermfg = 120, fg = "#82680b" })
hi(0, "GitSignsAddInline", { bg = "#7a693a", ctermbg = 120, ctermfg = 232, fg = "#ffffff" })
hi(0, "GitSignsAddLn", { ctermfg = 119, fg = "#9c7b06" })
hi(0, "GitSignsAddLnInline", { bg = "#7a693a", ctermbg = 120, ctermfg = 232, fg = "#ffffff" })
hi(0, "GitSignsAddPreview", { bg = "#ffffff", ctermbg = 233, ctermfg = 120, fg = "#82680b" })
hi(0, "GitSignsChange", { ctermfg = 228, fg = "#6f5700" })
hi(0, "GitSignsChangeDelete", { ctermfg = 215, fg = "#886b00" })
hi(0, "GitSignsChangeInline", { bg = "#685932", ctermbg = 228, ctermfg = 232, fg = "#ffffff" })
hi(0, "GitSignsChangeLn", { ctermfg = 228, fg = "#6f5700" })
hi(0, "GitSignsChangeLnInline", { bg = "#685932", ctermbg = 228, ctermfg = 232, fg = "#ffffff" })
hi(0, "GitSignsChangeNr", { ctermfg = 215, fg = "#886b00" })
hi(0, "GitSignsDelete", { ctermfg = 204, fg = "#cb006b" })
hi(0, "GitSignsDeleteInline", { bg = "#aa4c6d", ctermbg = 204, ctermfg = 232, fg = "#ffffff" })
hi(0, "GitSignsDeleteLnInline", { bg = "#aa4c6d", ctermbg = 204, ctermfg = 232, fg = "#ffffff" })
hi(0, "GitSignsDeletePreview", { bg = "#ffffff", ctermbg = 233, ctermfg = 204, fg = "#cb006b" })
hi(0, "GitSignsDeleteVirtLn", { bg = "#ffffff", ctermbg = 233, ctermfg = 204, fg = "#cb006b" })
hi(0, "GitSignsUntracked", { ctermfg = 159, fg = "#8a5a95" })
hi(0, "Identifier", { ctermfg = 141, fg = "#605562" })
hi(0, "Ignore", { ctermfg = 233, fg = "#ffffff" })
hi(0, "IncSearch", { bg = "#685932", ctermbg = 228, ctermfg = 233, fg = "#ffffff" })
hi(0, "Keyword", { link = "@function" })
hi(0, "Label", { ctermfg = 135, fg = "#b133cb" })
hi(0, "LineNr", { ctermfg = 236, fg = "#e6bcef" })
hi(0, "MatchParen", { bg = "#ffffff", bold = true, ctermbg = 232, ctermfg = 141, fg = "#605562", underline = true })
hi(0, "MiniCursorword", { underline = true })
hi(0, "MiniIndentscopeSymbol", { ctermfg = 145, fg = "#454545" })
hi(0, "ModeMsg", { bold = true, ctermfg = 252, fg = "#9d939f" })
hi(0, "MoreMsg", { link = "ModeMsg" })
hi(0, "NonText", { ctermfg = 236, fg = "#e6bcef" })
hi(0, "Normal", { bg = "#ffffff", ctermbg = 233, ctermfg = 253, fg = "#4c494c" })
hi(0, "NormalFloat", { bg = "#ffffff" })
hi(0, "Number", { ctermfg = 215, fg = "#886b00" })
hi(0, "NvimInternalError", { bg = "#f85a97", ctermbg = 9, ctermfg = 9, fg = "#f75293" })
hi(0, "NvimTreeFolderIcon", { ctermfg = 141, fg = "#605562" })
hi(0, "NvimTreeFolderName", { ctermfg = 159, fg = "#8a5a95" })
hi(0, "NvimTreeRootFolder", { ctermfg = 120, fg = "#82680b" })
hi(0, "Operator", { ctermfg = 121, fg = "#a78933" })
hi(0, "Pmenu", { bg = "#ffffff", ctermbg = 233, ctermfg = 253, fg = "#4c494c" })
hi(0, "PmenuSbar", { bg = "#ffffff", ctermbg = 232, ctermfg = 253, fg = "#4c494c" })
hi(0, "PmenuSel", { bg = "#ffffff", ctermbg = 233, ctermfg = 141, fg = "#605562" })
hi(0, "PmenuThumb", { bg = "#9f72a9", ctermbg = 236, ctermfg = 253, fg = "#4c494c" })
hi(0, "PreProc", { ctermfg = 120, fg = "#82680b" })
hi(0, "Question", { ctermfg = 120, fg = "#82680b" })
hi(0, "QuickFixLine", { ctermfg = 14, fg = "#93792c" })
hi(0, "RedrawDebugClear", { bg = "#e7cd87", ctermbg = 11, ctermfg = 0 })
hi(0, "RedrawDebugComposed", { bg = "#ffe08b", ctermbg = 10, ctermfg = 0 })
hi(0, "RedrawDebugRecompose", { bg = "#fffafb", ctermbg = 9, ctermfg = 0 })
hi(0, "Removed", { ctermfg = 9, fg = "#5d5154" })
hi(0, "Search", { bg = "#826c2e", ctermbg = 215, ctermfg = 233, fg = "#ffffff" })
hi(0, "SignColumn", { ctermfg = 120, fg = "#82680b" })
hi(0, "Special", { ctermfg = 122, fg = "#7d6724" })
hi(0, "SpecialKey", { ctermfg = 159, fg = "#8a5a95" })
hi(0, "SpellBad", { ctermfg = 203, fg = "#fb4e94", undercurl = true })
hi(0, "SpellCap", { ctermfg = 120, fg = "#82680b", underline = true })
hi(0, "SpellLocal", { ctermfg = 119, fg = "#9c7b06", underline = true })
hi(0, "SpellRare", { ctermfg = 204, fg = "#cb006b", underline = true })
hi(0, "Statement", { ctermfg = 120, fg = "#82680b" })
hi(0, "StatusLine", { bg = "#9f72a9", ctermbg = 236, ctermfg = 232, fg = "#ffffff" })
hi(0, "StatusLineNC", { bg = "#ffffff", ctermbg = 232, ctermfg = 252, fg = "#9d939f" })
hi(0, "String", { ctermfg = 228, fg = "#6f5700" })
hi(0, "TabLine", { bg = "#ffffff", ctermbg = 233, ctermfg = 252, fg = "#9d939f" })
hi(0, "TabLineFill", { bg = "#ffffff", ctermbg = 233, ctermfg = 252, fg = "#9d939f" })
hi(0, "TabLineSel", { bg = "#f3e2f7", bold = true, ctermbg = 236, ctermfg = 253, fg = "#4c494c" })
hi(0, "TelescopeBorder", { link = "LineNr" })
hi(0, "TelescopeMatching", { link = "String" })
hi(0, "TelescopeNormal", { ctermfg = 252, fg = "#9d939f" })
hi(0, "TelescopePreviewTitle", { ctermfg = 145, fg = "#454545" })
hi(0, "TelescopePromptNormal", { link = "Normal" })
hi(0, "TelescopePromptPrefix", { link = "Type" })
hi(0, "TelescopePromptTitle", { ctermfg = 145, fg = "#454545" })
hi(0, "TelescopeResultsDiffAdd", { ctermfg = 120, fg = "#82680b" })
hi(0, "TelescopeResultsDiffChange", { ctermfg = 228, fg = "#6f5700" })
hi(0, "TelescopeResultsDiffDelete", { ctermfg = 204, fg = "#cb006b" })
hi(0, "TelescopeResultsDiffUntracked", { link = "Title" })
hi(0, "TelescopeResultsTitle", { ctermfg = 145, fg = "#454545" })
hi(0, "TelescopeSelection", { bg = "#f3e2f7", ctermbg = 236, ctermfg = 253, fg = "#4c494c" })
hi(0, "Terminal", { bg = "#ffffff", ctermbg = 232, ctermfg = 253, fg = "#4c494c" })
hi(0, "Title", { ctermfg = 135, fg = "#b133cb" })
hi(0, "Todo", { bg = "#ffffff", bold = true, ctermbg = 233, ctermfg = 215, fg = "#886b00" })
hi(0, "Type", { ctermfg = 141, fg = "#605562" })
hi(0, "Underlined", { ctermfg = 121, fg = "#a78933", underline = true })
hi(0, "Visual", { bg = "#f3e2f7", ctermbg = 236 })
hi(0, "WarningMsg", { ctermfg = 228, fg = "#6f5700" })
hi(0, "WildMenu", { bg = "#766841", ctermbg = 122, ctermfg = 232, fg = "#ffffff" })
hi(0, "WinBar", { bg = "#ffffff", bold = true, fg = "#8a808d" })
hi(0, "WinBarNC", { bg = "#ffffff", fg = "#8a808d" })
hi(0, "WinSeparator", { ctermfg = 236, fg = "#f3e1f7" })
hi(0, "diffAdded", { ctermfg = 120, fg = "#82680b" })
hi(0, "diffFile", { bold = true, ctermfg = 145, fg = "#454545" })
hi(0, "diffFileId", { bold = true, ctermfg = 159, fg = "#8a5a95", reverse = true })
hi(0, "diffIndexLine", { bold = true, ctermfg = 145, fg = "#454545" })
hi(0, "diffLine", { ctermfg = 141, fg = "#605562" })
hi(0, "diffNewFile", { bold = true, ctermfg = 145, fg = "#454545" })
hi(0, "diffNoEOL", { ctermfg = 141, fg = "#605562" })
hi(0, "diffOldFile", { bold = true, ctermfg = 145, fg = "#454545" })
hi(0, "diffRemoved", { ctermfg = 204, fg = "#cb006b" })
hi(0, "diffSubname", { ctermfg = 145, fg = "#454545" })
hi(0, "elixirAtom", { ctermfg = 228, fg = "#6f5700" })
hi(0, "elixirVariable", { ctermfg = 141, fg = "#605562" })
hi(0, "gitcommitBranch", { ctermfg = 141, fg = "#605562" })
hi(0, "gitcommitComment", { ctermfg = 252, fg = "#9d939f" })
hi(0, "gitcommitDiscarded", { link = "gitcommitComment" })
hi(0, "gitcommitDiscardedArrow", { link = "gitcommitDiscardedFile" })
hi(0, "gitcommitDiscardedFile", { ctermfg = 204, fg = "#cb006b" })
hi(0, "gitcommitDiscardedType", { ctermfg = 204, fg = "#cb006b" })
hi(0, "gitcommitNoBranch", { link = "gitcommitBranch" })
hi(0, "gitcommitOverflow", { ctermfg = 204, fg = "#cb006b" })
hi(0, "gitcommitSelected", { link = "gitcommitComment" })
hi(0, "gitcommitSelectedArrow", { link = "gitcommitSelectedFile" })
hi(0, "gitcommitSelectedFile", { ctermfg = 120, fg = "#82680b" })
hi(0, "gitcommitSelectedType", { ctermfg = 120, fg = "#82680b" })
hi(0, "gitcommitSummary", { ctermfg = 145, fg = "#454545" })
hi(0, "gitcommitUnmerged", { ctermfg = 120, fg = "#82680b" })
hi(0, "gitcommitUnmergedArrow", { link = "gitcommitUnmergedFile" })
hi(0, "gitcommitUnmergedFile", { ctermfg = 228, fg = "#6f5700" })
hi(0, "gitcommitUntracked", { link = "gitcommitComment" })
hi(0, "gitcommitUntrackedFile", { ctermfg = 122, fg = "#7d6724" })
hi(0, "htmlBold", { bold = true })
hi(0, "htmlBoldItalic", { bold = true, italic = true })
hi(0, "htmlEndTag", { link = "htmlTag" })
hi(0, "htmlH1", { bold = true, ctermfg = 135, fg = "#b133cb" })
hi(0, "htmlH2", { bold = true, ctermfg = 135, fg = "#b133cb" })
hi(0, "htmlH3", { ctermfg = 159, fg = "#8a5a95", italic = true })
hi(0, "htmlH4", { ctermfg = 159, fg = "#8a5a95", italic = true })
hi(0, "htmlH5", { ctermfg = 121, fg = "#a78933" })
hi(0, "htmlH6", { ctermfg = 121, fg = "#a78933" })
hi(0, "htmlItalic", { italic = true })
hi(0, "htmlLink", { ctermfg = 159, fg = "#8a5a95", underline = true })
hi(0, "htmlTag", { link = "Special" })
hi(0, "htmlTagN", { link = "Keyword" })
hi(0, "htmlTagName", { link = "Keyword" })
hi(0, "jsAsyncKeyword", { link = "PreProc" })
hi(0, "jsClassDefinition", { link = "Type" })
hi(0, "jsClassKeyword", { ctermfg = 141, fg = "#605562" })
hi(0, "jsConditional", { link = "PreProc" })
hi(0, "jsExtendsKeyword", { link = "PreProc" })
hi(0, "jsForAwait", { link = "PreProc" })
hi(0, "jsRepeat", { link = "PreProc" })
hi(0, "jsReturn", { link = "PreProc" })
hi(0, "jsxClosePunct", { link = "jsxOpenPunct" })
hi(0, "jsxOpenPunct", { ctermfg = 252, fg = "#9d939f" })
hi(0, "lCursor", { bg = "#504553", fg = "#ffffff" })
hi(0, "markdownBlockquote", { ctermfg = 252, fg = "#9d939f" })
hi(0, "markdownBold", { bold = true, ctermfg = 253, fg = "#4c494c" })
hi(0, "markdownBoldItalic", { bold = true, ctermfg = 253, fg = "#4c494c", italic = true })
hi(0, "markdownCode", { ctermfg = 120, fg = "#82680b" })
hi(0, "markdownCodeDelimiter", { ctermfg = 252, fg = "#9d939f" })
hi(0, "markdownEscape", { ctermfg = 253, fg = "#4c494c" })
hi(0, "markdownH1", { bold = true, ctermfg = 135, fg = "#b133cb" })
hi(0, "markdownH2", { bold = true, ctermfg = 135, fg = "#b133cb" })
hi(0, "markdownH3", { bold = true, ctermfg = 135, fg = "#b133cb", italic = true })
hi(0, "markdownH4", { bold = true, ctermfg = 135, fg = "#b133cb", italic = true })
hi(0, "markdownH5", { ctermfg = 121, fg = "#a78933" })
hi(0, "markdownH6", { ctermfg = 121, fg = "#a78933" })
hi(0, "markdownHeadingDelimiter", { ctermfg = 253, fg = "#4c494c" })
hi(0, "markdownHeadingRule", { ctermfg = 253, fg = "#4c494c" })
hi(0, "markdownId", { ctermfg = 252, fg = "#9d939f" })
hi(0, "markdownIdDeclaration", { ctermfg = 252, fg = "#9d939f" })
hi(0, "markdownItalic", { ctermfg = 253, fg = "#4c494c", italic = true })
hi(0, "markdownLinkDelimiter", { ctermfg = 252, fg = "#9d939f" })
hi(0, "markdownLinkText", { ctermfg = 253, fg = "#4c494c" })
hi(0, "markdownLinkTextDelimiter", { ctermfg = 252, fg = "#9d939f" })
hi(0, "markdownListMarker", { ctermfg = 204, fg = "#cb006b" })
hi(0, "markdownOrderedListMarker", { ctermfg = 204, fg = "#cb006b" })
hi(0, "markdownRule", { ctermfg = 253, fg = "#4c494c" })
hi(0, "markdownUrl", { ctermfg = 135, fg = "#b133cb", underline = true })
hi(0, "markdownUrlDelimiter", { ctermfg = 252, fg = "#9d939f" })
hi(0, "markdownUrlTitle", { ctermfg = 253, fg = "#4c494c" })
hi(0, "markdownUrlTitleDelimiter", { ctermfg = 252, fg = "#9d939f" })
hi(0, "xmlEndTag", { link = "xmlTag" })
hi(0, "xmlTag", { link = "htmlTag" })
hi(0, "xmlTagName", { link = "htmlTagName" })

-- Terminal colors
local g = vim.g

g.terminal_color_0 = "#a78dad"
g.terminal_color_1 = "#70163d"
g.terminal_color_2 = "#493803"
g.terminal_color_3 = "#362900"
g.terminal_color_4 = "#4f3155"
g.terminal_color_5 = "#3c1745"
g.terminal_color_6 = "#453710"
g.terminal_color_7 = "#e5d0e9"
g.terminal_color_8 = "#a78dad"
g.terminal_color_9 = "#bd0664"
g.terminal_color_10 = "#604b03"
g.terminal_color_11 = "#4d3c00"
g.terminal_color_12 = "#662774"
g.terminal_color_13 = "#922ca7"
g.terminal_color_14 = "#6c581e"
g.terminal_color_15 = "#6c5e6f"
