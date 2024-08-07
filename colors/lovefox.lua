-- Made with 'mini.colors' module of https://github.com/echasnovski/mini.nvim
vim.o.background = "light"

if vim.g.colors_name ~= nil then
	vim.cmd("highlight clear")
end
vim.g.colors_name = "lovefox"

-- Highlight groups
local hi = vim.api.nvim_set_hl

hi(0, "@attribute", { link = "Constant" })
hi(0, "@character.special", { link = "SpecialChar" })
hi(0, "@comment.error", { bg = "#bb5d6e", fg = "#fff5f6" })
hi(0, "@comment.note", { bg = "#89565e", fg = "#fff5f6" })
hi(0, "@comment.todo", { bg = "#79825f", fg = "#fff5f6" })
hi(0, "@comment.warning", { bg = "#c36c7b", fg = "#fff5f6" })
hi(0, "@conditional", { link = "Conditional" })
hi(0, "@constant.builtin", { bold = true, fg = "#f4376d" })
hi(0, "@constant.macro", { link = "Macro" })
hi(0, "@constructor", { fg = "#e4005c" })
hi(0, "@constructor.lua", { fg = "#662231" })
hi(0, "@diff.delta", { link = "diffChanged" })
hi(0, "@diff.minus", { link = "diffRemoved" })
hi(0, "@diff.plus", { link = "diffAdded" })
hi(0, "@exception", { link = "Exception" })
hi(0, "@field", { fg = "#b12d50" })
hi(0, "@field.rust", { fg = "#662231" })
hi(0, "@float", { link = "Float" })
hi(0, "@function.builtin", { link = "@keyword" })
hi(0, "@function.macro", { bold = true, fg = "#df2961" })
hi(0, "@include", { link = "Include" })
hi(0, "@keyword", { link = "@keyword.return" })
hi(0, "@keyword.conditional", { link = "@keyword.return" })
hi(0, "@keyword.conditional.ternary", { link = "Conditional" })
hi(0, "@keyword.exception", { link = "@keyword.return" })
hi(0, "@keyword.function", { link = "@keyword.return" })
hi(0, "@keyword.import", { link = "Include" })
hi(0, "@keyword.operator", { link = "@keyword.return" })
hi(0, "@keyword.repeat", { link = "@keyword.return" })
hi(0, "@keyword.return", { bold = true, fg = "#df2961" })
hi(0, "@keyword.storage", { link = "StorageClass" })
hi(0, "@label.json", { fg = "#c4375b" })
hi(0, "@lsp.type.boolean", { link = "@boolean" })
hi(0, "@lsp.type.builtinType", { link = "@type.builtin" })
hi(0, "@lsp.type.comment", { link = "@comment" })
hi(0, "@lsp.type.enum", { link = "@type" })
hi(0, "@lsp.type.enumMember", { link = "@constant" })
hi(0, "@lsp.type.escapeSequence", { link = "@string.escape" })
hi(0, "@lsp.type.formatSpecifier", { link = "@punctuation.special" })
hi(0, "@lsp.type.interface", { fg = "#cc2458" })
hi(0, "@lsp.type.keyword", { link = "@keyword" })
hi(0, "@lsp.type.namespace", { link = "@module" })
hi(0, "@lsp.type.number", { link = "@number" })
hi(0, "@lsp.type.operator", { link = "@operator" })
hi(0, "@lsp.type.parameter", { link = "@parameter" })
hi(0, "@lsp.type.property", { link = "@property" })
hi(0, "@lsp.type.selfKeyword", { link = "@variable.builtin" })
hi(0, "@lsp.type.typeAlias", { link = "@type.definition" })
hi(0, "@lsp.type.unresolvedReference", { link = "@error" })
hi(0, "@lsp.type.variable", {})
hi(0, "@lsp.typemod.class.defaultLibrary", { link = "@type.builtin" })
hi(0, "@lsp.typemod.enum.defaultLibrary", { link = "@type.builtin" })
hi(0, "@lsp.typemod.enumMember.defaultLibrary", { link = "@constant.builtin" })
hi(0, "@lsp.typemod.function.defaultLibrary", { link = "@function.builtin" })
hi(0, "@lsp.typemod.keyword.async", { link = "@keyword.coroutine" })
hi(0, "@lsp.typemod.macro.defaultLibrary", { link = "@function.builtin" })
hi(0, "@lsp.typemod.method.defaultLibrary", { link = "@function.builtin" })
hi(0, "@lsp.typemod.operator.injected", { link = "@operator" })
hi(0, "@lsp.typemod.string.injected", { link = "@string" })
hi(0, "@lsp.typemod.type.defaultLibrary", { link = "@type.builtin" })
hi(0, "@lsp.typemod.variable.defaultLibrary", { link = "@variable.builtin" })
hi(0, "@lsp.typemod.variable.injected", { link = "@variable" })
hi(0, "@markup", { fg = "#581a28" })
hi(0, "@markup.heading", { link = "Title" })
hi(0, "@markup.italic", {})
hi(0, "@markup.link", { bold = true, fg = "#e4005c" })
hi(0, "@markup.link.label", { link = "Special" })
hi(0, "@markup.link.url", { fg = "#f4376d", italic = true, underline = true })
hi(0, "@markup.list", { fg = "#64713a" })
hi(0, "@markup.list.checked", { fg = "#74872d" })
hi(0, "@markup.list.unchecked", { fg = "#cd6478" })
hi(0, "@markup.math", { fg = "#c4375b" })
hi(0, "@markup.quote", { fg = "#662231" })
hi(0, "@markup.raw", { fg = "#e4005c", italic = true })
hi(0, "@markup.raw.block", { fg = "#ff5e85" })
hi(0, "@markup.strikethrough", { fg = "#581a28", strikethrough = true })
hi(0, "@markup.strong", { bold = true, fg = "#f42d6a" })
hi(0, "@markup.underline", { link = "Underline" })
hi(0, "@module", { fg = "#64713a" })
hi(0, "@namespace", { fg = "#64713a" })
hi(0, "@number.float", { link = "Float" })
hi(0, "@parameter", { fg = "#64713a" })
hi(0, "@property", { fg = "#b12d50" })
hi(0, "@punctuation.bracket", { fg = "#662231" })
hi(0, "@punctuation.delimiter", { fg = "#662231" })
hi(0, "@punctuation.special", { fg = "#64713a" })
hi(0, "@repeat", { link = "@keyword.return" })
hi(0, "@storageclass", { link = "StorageClass" })
hi(0, "@string.escape", { bold = true, fg = "#b85b6c" })
hi(0, "@string.regex", { fg = "#b85b6c" })
hi(0, "@string.regexp", { fg = "#b85b6c" })
hi(0, "@string.special", { link = "Special" })
hi(0, "@string.special.url", { fg = "#f4376d", italic = true, underline = true })
hi(0, "@tag", { fg = "#e4005c" })
hi(0, "@tag.attribute", { fg = "#c4375b", italic = true })
hi(0, "@tag.delimiter", { fg = "#64713a" })
hi(0, "@text", { fg = "#581a28" })
hi(0, "@text.danger", { bg = "#bb5d6e", fg = "#fff5f6" })
hi(0, "@text.diff.add", { link = "diffAdded" })
hi(0, "@text.diff.delete", { link = "diffRemoved" })
hi(0, "@text.emphasis", {})
hi(0, "@text.literal", { fg = "#e4005c", italic = true })
hi(0, "@text.math", { fg = "#c4375b" })
hi(0, "@text.note", { bg = "#89565e", fg = "#fff5f6" })
hi(0, "@text.reference", { bold = true, fg = "#e4005c" })
hi(0, "@text.strike", { fg = "#581a28", strikethrough = true })
hi(0, "@text.strong", { bold = true, fg = "#f42d6a" })
hi(0, "@text.title", { link = "Title" })
hi(0, "@text.todo", { bg = "#79825f", fg = "#fff5f6" })
hi(0, "@text.todo.checked", { fg = "#74872d" })
hi(0, "@text.todo.unchecked", { fg = "#cd6478" })
hi(0, "@text.underline", { link = "Underline" })
hi(0, "@text.warning", { bg = "#c36c7b", fg = "#fff5f6" })
hi(0, "@type.builtin", { fg = "#64713a" })
hi(0, "@variable", { fg = "#581a28" })
hi(0, "@variable.builtin", { fg = "#df2961" })
hi(0, "@variable.member", { fg = "#b12d50" })
hi(0, "@variable.parameter", { fg = "#64713a" })
hi(0, "Added", { ctermfg = 2, fg = "#404d00" })
hi(0, "AerialGuide", { fg = "#dcdcdc" })
hi(0, "AerialLine", { link = "Search" })
hi(0, "AlphaButtons", { fg = "#738143" })
hi(0, "AlphaFooter", { fg = "#b12d50" })
hi(0, "AlphaHeader", { fg = "#9f2b49" })
hi(0, "AlphaHeaderLabel", { fg = "#f95c80" })
hi(0, "AlphaShortcut", { fg = "#f95c80" })
hi(0, "Bold", { bold = true })
hi(0, "Boolean", { link = "Number" })
hi(0, "BufferCurrent", { bg = "#773d47", fg = "#581a28" })
hi(0, "BufferCurrentIndex", { bg = "#773d47", fg = "#b12d50" })
hi(0, "BufferCurrentMod", { bg = "#773d47", fg = "#cd6478" })
hi(0, "BufferCurrentSign", { bg = "#773d47", fg = "#b12d50" })
hi(0, "BufferCurrentTarget", { bg = "#773d47", fg = "#df2961" })
hi(0, "BufferInactive", { bg = "#dfdfdf", fg = "#917f81" })
hi(0, "BufferInactiveIndex", { bg = "#dfdfdf", fg = "#917f81" })
hi(0, "BufferInactiveMod", { bg = "#dfdfdf", fg = "#ffbfc9" })
hi(0, "BufferInactiveSign", { bg = "#dfdfdf", fg = "#ffdfe3" })
hi(0, "BufferInactiveTarget", { bg = "#dfdfdf", fg = "#df2961" })
hi(0, "BufferTabpage", { bg = "#dfdfdf", fg = "#ffdfe3" })
hi(0, "BufferTabpages", { bg = "#dfdfdf" })
hi(0, "BufferVisible", { bg = "#dfdfdf", fg = "#581a28" })
hi(0, "BufferVisibleIndex", { bg = "#dfdfdf", fg = "#b12d50" })
hi(0, "BufferVisibleMod", { bg = "#dfdfdf", fg = "#cd6478" })
hi(0, "BufferVisibleSign", { bg = "#dfdfdf", fg = "#b12d50" })
hi(0, "BufferVisibleTarget", { bg = "#dfdfdf", fg = "#df2961" })
hi(0, "Changed", { ctermfg = 6, fg = "#5f6b36" })
hi(0, "Character", { link = "String" })
hi(0, "CmpDocumentation", { bg = "#dfdfdf", fg = "#581a28" })
hi(0, "CmpDocumentationBorder", { bg = "#dfdfdf", fg = "#fedbdf" })
hi(0, "CmpItemAbbr", { fg = "#581a28" })
hi(0, "CmpItemAbbrDefault", { fg = "#581a28" })
hi(0, "CmpItemAbbrDeprecated", { fg = "#862e42", strikethrough = true })
hi(0, "CmpItemAbbrDeprecatedDefault", { fg = "#917f81" })
hi(0, "CmpItemAbbrMatch", { fg = "#c4375b" })
hi(0, "CmpItemAbbrMatchDefault", { fg = "#581a28" })
hi(0, "CmpItemAbbrMatchFuzzy", { fg = "#c4375b" })
hi(0, "CmpItemAbbrMatchFuzzyDefault", { fg = "#581a28" })
hi(0, "CmpItemKindClass", { link = "Type" })
hi(0, "CmpItemKindClassDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindColorDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindConstant", { link = "@constant" })
hi(0, "CmpItemKindConstantDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindConstructor", { link = "Function" })
hi(0, "CmpItemKindConstructorDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindDefault", { fg = "#c4375b" })
hi(0, "CmpItemKindEnum", { link = "Constant" })
hi(0, "CmpItemKindEnumDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindEnumMember", { link = "@field" })
hi(0, "CmpItemKindEnumMemberDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindEvent", { link = "Constant" })
hi(0, "CmpItemKindEventDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindField", { link = "@field" })
hi(0, "CmpItemKindFieldDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindFileDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindFolderDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindFunction", { link = "Function" })
hi(0, "CmpItemKindFunctionDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindInterface", { link = "Constant" })
hi(0, "CmpItemKindInterfaceDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindKeyword", { link = "Identifier" })
hi(0, "CmpItemKindKeywordDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindMethod", { link = "Function" })
hi(0, "CmpItemKindMethodDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindModule", { link = "@namespace" })
hi(0, "CmpItemKindModuleDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindOperator", { link = "Operator" })
hi(0, "CmpItemKindOperatorDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindProperty", { link = "@property" })
hi(0, "CmpItemKindPropertyDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindReference", { link = "Keyword" })
hi(0, "CmpItemKindReferenceDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindSnippet", { fg = "#662231" })
hi(0, "CmpItemKindSnippetDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindStruct", { link = "Type" })
hi(0, "CmpItemKindStructDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindTextDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindTypeParameter", { link = "@field" })
hi(0, "CmpItemKindTypeParameterDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindUnit", { link = "Constant" })
hi(0, "CmpItemKindUnitDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindValue", { link = "Keyword" })
hi(0, "CmpItemKindValueDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindVariable", { link = "@variable" })
hi(0, "CmpItemKindVariableDefault", { link = "CmpItemKind" })
hi(0, "CmpItemMenu", { link = "Comment" })
hi(0, "CmpItemMenuDefault", { fg = "#581a28" })
hi(0, "CocInlayHint", { bg = "#ece7e8", fg = "#917f81" })
hi(0, "ColorColumn", { bg = "#ece7e8" })
hi(0, "Comment", { fg = "#917f81" })
hi(0, "Conceal", { fg = "#dcdcdc" })
hi(0, "Conditional", { fg = "#cf0053" })
hi(0, "Constant", { fg = "#f4376d" })
hi(0, "CurSearch", { link = "IncSearch" })
hi(0, "Cursor", { bg = "#4b262c", fg = "#fff5f6" })
hi(0, "CursorColumn", { link = "CursorLine" })
hi(0, "CursorLine", { bg = "#fae1e4" })
hi(0, "CursorLineNr", { bold = true, fg = "#cd6478" })
hi(0, "DapUIBreakpointsCurrentLine", { bold = true, fg = "#74872d" })
hi(0, "DapUIBreakpointsDisabledLine", { fg = "#917f81" })
hi(0, "DapUIBreakpointsInfo", { fg = "#b12d50" })
hi(0, "DapUIBreakpointsLine", { link = "DapUILineNumber" })
hi(0, "DapUIBreakpointsPath", { fg = "#64713a" })
hi(0, "DapUIDecoration", { fg = "#862e42" })
hi(0, "DapUIFloatBorder", { link = "FloatBorder" })
hi(0, "DapUIFrameName", { link = "Normal" })
hi(0, "DapUILineNumber", { link = "Number" })
hi(0, "DapUIModifiedValue", { bold = true, fg = "#581a28" })
hi(0, "DapUIScope", { fg = "#64713a" })
hi(0, "DapUISource", { link = "Keyword" })
hi(0, "DapUIStoppedThread", { fg = "#64713a" })
hi(0, "DapUIThread", { link = "String" })
hi(0, "DapUIType", { link = "Type" })
hi(0, "DapUIValue", { fg = "#581a28" })
hi(0, "DapUIVariable", { fg = "#581a28" })
hi(0, "DapUIWatchesEmpty", { fg = "#df2961" })
hi(0, "DapUIWatchesError", { fg = "#df2961" })
hi(0, "DapUIWatchesValue", { fg = "#cd6478" })
hi(0, "DashboardCenter", { link = "String" })
hi(0, "DashboardFooter", { fg = "#f4376d", italic = true })
hi(0, "DashboardHeader", { link = "Title" })
hi(0, "DashboardShortCut", { link = "Identifier" })
hi(0, "Delimiter", { link = "Special" })
hi(0, "DiagnosticDeprecated", { sp = "#57001e", strikethrough = true })
hi(0, "DiagnosticError", { fg = "#df2961" })
hi(0, "DiagnosticHint", { fg = "#74872d" })
hi(0, "DiagnosticInfo", { fg = "#b12d50" })
hi(0, "DiagnosticOk", { fg = "#74872d" })
hi(0, "DiagnosticUnderlineError", { sp = "#bb5d6e", undercurl = true })
hi(0, "DiagnosticUnderlineHint", { sp = "#79825f", undercurl = true })
hi(0, "DiagnosticUnderlineInfo", { sp = "#89565e", undercurl = true })
hi(0, "DiagnosticUnderlineOk", { sp = "#79825f", undercurl = true })
hi(0, "DiagnosticUnderlineWarn", { sp = "#c36c7b", undercurl = true })
hi(0, "DiagnosticVirtualTextError", { bg = "#e6c9cc", fg = "#df2961" })
hi(0, "DiagnosticVirtualTextHint", { bg = "#d1d3ca", fg = "#74872d" })
hi(0, "DiagnosticVirtualTextInfo", { bg = "#d9c6c8", fg = "#b12d50" })
hi(0, "DiagnosticVirtualTextOk", { bg = "#d1d3ca", fg = "#74872d" })
hi(0, "DiagnosticVirtualTextWarn", { bg = "#e8ced1", fg = "#cd6478" })
hi(0, "DiagnosticWarn", { fg = "#cd6478" })
hi(0, "DiffAdd", { bg = "#dee0d9" })
hi(0, "DiffChange", { bg = "#e3d6d8" })
hi(0, "DiffDelete", { bg = "#edd8da" })
hi(0, "DiffText", { bg = "#ceb6b9" })
hi(0, "Directory", { fg = "#c4375b" })
hi(0, "EndOfBuffer", { fg = "#fff5f6" })
hi(0, "Error", { fg = "#df2961" })
hi(0, "ErrorMsg", { fg = "#df2961" })
hi(0, "Exception", { link = "Keyword" })
hi(0, "FernBranchText", { fg = "#b12d50" })
hi(0, "FidgetTask", { link = "LineNr" })
hi(0, "FidgetTitle", { link = "Title" })
hi(0, "FloatBorder", { fg = "#862e42" })
hi(0, "FloatShadow", { bg = "#a49c9d", blend = 80, ctermbg = 0 })
hi(0, "FloatShadowThrough", { bg = "#a49c9d", blend = 100, ctermbg = 0 })
hi(0, "FocusedSymbol", { link = "Search" })
hi(0, "FoldColumn", { fg = "#862e42" })
hi(0, "Folded", { bg = "#ece7e8", fg = "#862e42" })
hi(0, "Function", { bold = true, fg = "#c4375b" })
hi(0, "GitGutterAdd", { fg = "#74872d" })
hi(0, "GitGutterChange", { fg = "#a9c058" })
hi(0, "GitGutterDelete", { fg = "#e82b65" })
hi(0, "GitSignsAdd", { fg = "#74872d" })
hi(0, "GitSignsChange", { fg = "#a9c058" })
hi(0, "GitSignsDelete", { fg = "#e82b65" })
hi(0, "GlyphPalette0", { fg = "#581a28" })
hi(0, "GlyphPalette1", { fg = "#df2961" })
hi(0, "GlyphPalette10", { fg = "#859a33" })
hi(0, "GlyphPalette11", { fg = "#e07085" })
hi(0, "GlyphPalette12", { fg = "#c4375b" })
hi(0, "GlyphPalette13", { fg = "#f70064" })
hi(0, "GlyphPalette14", { fg = "#7b8a48" })
hi(0, "GlyphPalette15", { fg = "#a2bb3f" })
hi(0, "GlyphPalette2", { fg = "#74872d" })
hi(0, "GlyphPalette3", { fg = "#cd6478" })
hi(0, "GlyphPalette4", { fg = "#b12d50" })
hi(0, "GlyphPalette5", { fg = "#e4005c" })
hi(0, "GlyphPalette6", { fg = "#738143" })
hi(0, "GlyphPalette7", { fg = "#a2bb3f" })
hi(0, "GlyphPalette8", { fg = "#752538" })
hi(0, "GlyphPalette9", { fg = "#f42d6a" })
hi(0, "HopNextKey", { bold = true, fg = "#738143" })
hi(0, "HopNextKey1", { bold = true, fg = "#b12d50" })
hi(0, "HopNextKey2", { fg = "#c4375b" })
hi(0, "HopUnmatched", { fg = "#917f81" })
hi(0, "Identifier", { fg = "#e4005c" })
hi(0, "IncSearch", { reverse = true })
hi(0, "IndentBlanklineChar", { fg = "#ffdfe3" })
hi(0, "IndentBlanklineContextChar", { fg = "#581a28" })
hi(0, "IndentBlanklineContextStart", { sp = "#4b262c", underline = true })
hi(0, "IndentBlanklineIndent1", { fg = "#ff5e85" })
hi(0, "IndentBlanklineIndent2", { fg = "#b12d50" })
hi(0, "IndentBlanklineIndent3", { fg = "#f95c80" })
hi(0, "IndentBlanklineIndent4", { fg = "#738143" })
hi(0, "IndentBlanklineIndent5", { fg = "#df2961" })
hi(0, "IndentBlanklineIndent6", { fg = "#cd6478" })
hi(0, "Italic", { italic = true })
hi(0, "Keyword", { bold = true, fg = "#e4005c" })
hi(0, "Label", { link = "Conditional" })
hi(0, "LazyButtonActive", { link = "TabLineSel" })
hi(0, "LazyDimmed", { link = "LineNr" })
hi(0, "LazyProp", { link = "LineNr" })
hi(0, "LeapBackdrop", { fg = "#917f81" })
hi(0, "LeapLabelPrimary", { bg = "#d16f80", fg = "#fff5f6" })
hi(0, "LeapLabelSecondary", { bg = "#647236", fg = "#fff5f6" })
hi(0, "LeapMatch", { bg = "#d16f80", fg = "#fff5f6" })
hi(0, "LightspeedGreyWash", { fg = "#917f81" })
hi(0, "LineNr", { fg = "#862e42" })
hi(0, "LspCodeLens", { fg = "#917f81" })
hi(0, "LspCodeLensSeparator", { fg = "#862e42" })
hi(0, "LspFloatWinBorder", { fg = "#862e42" })
hi(0, "LspFloatWinNormal", { bg = "#dfdfdf" })
hi(0, "LspInlayHint", { bg = "#ece7e8", fg = "#917f81" })
hi(0, "LspReferenceRead", { bg = "#fadde1" })
hi(0, "LspReferenceText", { bg = "#fadde1" })
hi(0, "LspReferenceWrite", { bg = "#fadde1" })
hi(0, "LspSagaBorderTitle", { link = "Title" })
hi(0, "LspSagaCodeActionBorder", { fg = "#862e42" })
hi(0, "LspSagaCodeActionContent", { link = "String" })
hi(0, "LspSagaCodeActionTitle", { link = "Title" })
hi(0, "LspSagaDefPreviewBorder", { fg = "#862e42" })
hi(0, "LspSagaFinderSelection", { fg = "#fedbdf" })
hi(0, "LspSagaHoverBorder", { fg = "#862e42" })
hi(0, "LspSagaRenameBorder", { fg = "#862e42" })
hi(0, "LspSagaSignatureHelpBorder", { fg = "#df2961" })
hi(0, "LspSignatureActiveParameter", { fg = "#dcdcdc" })
hi(0, "LspTroubleCount", { bg = "#773d47", fg = "#e4005c" })
hi(0, "LspTroubleNormal", { bg = "#dfdfdf", fg = "#862e42" })
hi(0, "LspTroubleText", { fg = "#662231" })
hi(0, "MatchParen", { fg = "#74872d", reverse = true })
hi(0, "MiniCompletionActiveParameter", { underline = true })
hi(0, "MiniCursorword", { link = "LspReferenceText" })
hi(0, "MiniCursorwordCurrent", { link = "LspReferenceText" })
hi(0, "MiniIndentscopePrefix", { nocombine = true })
hi(0, "MiniIndentscopeSymbol", { link = "Delimiter" })
hi(0, "MiniJump", { bg = "#a26b73", fg = "#dfdfdf" })
hi(0, "MiniJump2dSpot", { bold = true, fg = "#738143" })
hi(0, "MiniStarterCurrent", { nocombine = true })
hi(0, "MiniStarterFooter", { fg = "#f4376d", italic = true })
hi(0, "MiniStarterHeader", { link = "Title" })
hi(0, "MiniStarterInactive", { link = "Comment" })
hi(0, "MiniStarterItem", { link = "Normal" })
hi(0, "MiniStarterItemBullet", { fg = "#862e42" })
hi(0, "MiniStarterItemPrefix", { fg = "#ff5e85" })
hi(0, "MiniStarterQuery", { fg = "#74872d" })
hi(0, "MiniStarterSection", { fg = "#df2961" })
hi(0, "MiniStatuslineDevinfo", { bg = "#ece7e8", fg = "#662231" })
hi(0, "MiniStatuslineFileinfo", { bg = "#ece7e8", fg = "#662231" })
hi(0, "MiniStatuslineFilename", { link = "StatusLine" })
hi(0, "MiniStatuslineInactive", { link = "StatusLineNC" })
hi(0, "MiniStatuslineModeCommand", { bg = "#c36c7b", bold = true, fg = "#dfdfdf" })
hi(0, "MiniStatuslineModeInsert", { bg = "#79825f", bold = true, fg = "#dfdfdf" })
hi(0, "MiniStatuslineModeNormal", { bg = "#738141", bold = true, fg = "#dfdfdf" })
hi(0, "MiniStatuslineModeOther", { bg = "#89565e", bold = true, fg = "#dfdfdf" })
hi(0, "MiniStatuslineModeReplace", { bg = "#bb5d6e", bold = true, fg = "#dfdfdf" })
hi(0, "MiniStatuslineModeVisual", { bg = "#a26b73", bold = true, fg = "#dfdfdf" })
hi(0, "MiniSurround", { link = "IncSearch" })
hi(0, "MiniTablineCurrent", { bg = "#dcdcdc", bold = true, fg = "#662231" })
hi(0, "MiniTablineFill", { link = "TabLineFill" })
hi(0, "MiniTablineHidden", { bg = "#ece7e8", fg = "#862e42" })
hi(0, "MiniTablineModifiedCurrent", { bg = "#5a2e36", bold = true, fg = "#dcdcdc" })
hi(0, "MiniTablineModifiedHidden", { bg = "#773d47", fg = "#ebe7e8" })
hi(0, "MiniTablineModifiedVisible", { bg = "#5a2e36", fg = "#ebe7e8" })
hi(0, "MiniTablineTabpagesection", { bg = "#faf6f7", bold = true, fg = "#581a28" })
hi(0, "MiniTablineVisible", { bg = "#ece7e8", fg = "#662231" })
hi(0, "MiniTestEmphasis", { bold = true })
hi(0, "MiniTestFail", { bold = true, fg = "#df2961" })
hi(0, "MiniTestPass", { bold = true, fg = "#74872d" })
hi(0, "MiniTrailspace", { bg = "#bb5d6e" })
hi(0, "ModeMsg", { bold = true, fg = "#cd6478" })
hi(0, "ModesCopy", { bg = "#c36c7b" })
hi(0, "ModesDelete", { bg = "#bb5d6e" })
hi(0, "ModesInsert", { bg = "#738141" })
hi(0, "ModesVisual", { bg = "#a26b73" })
hi(0, "MoreMsg", { bold = true, fg = "#b12d50" })
hi(0, "NagicIconsOperator", { link = "Operator" })
hi(0, "NavicIconsBoolean", { link = "Boolean" })
hi(0, "NavicIconsClass", { link = "Type" })
hi(0, "NavicIconsConstant", { link = "Constant" })
hi(0, "NavicIconsConstructor", { link = "Function" })
hi(0, "NavicIconsEnum", { link = "Constant" })
hi(0, "NavicIconsEnumMember", { link = "@field" })
hi(0, "NavicIconsEvent", { link = "Constant" })
hi(0, "NavicIconsField", { link = "@field" })
hi(0, "NavicIconsFile", { link = "Directory" })
hi(0, "NavicIconsFunction", { link = "Function" })
hi(0, "NavicIconsInterface", { link = "Constant" })
hi(0, "NavicIconsKey", { link = "Identifier" })
hi(0, "NavicIconsMethod", { link = "Function" })
hi(0, "NavicIconsModule", { link = "@namespace" })
hi(0, "NavicIconsNamespace", { link = "@namespace" })
hi(0, "NavicIconsNull", { link = "Type" })
hi(0, "NavicIconsNumber", { link = "Number" })
hi(0, "NavicIconsObject", { link = "@namespace" })
hi(0, "NavicIconsPackage", { link = "@namespace" })
hi(0, "NavicIconsProperty", { link = "@property" })
hi(0, "NavicIconsString", { link = "String" })
hi(0, "NavicIconsStruct", { link = "Type" })
hi(0, "NavicIconsTypeParameter", { link = "@field" })
hi(0, "NavicIconsVariable", { link = "@variable" })
hi(0, "NavicSeparator", { fg = "#dcdcdc" })
hi(0, "NavicText", { fg = "#581a28" })
hi(0, "NeoTreeDimText", { link = "Conceal" })
hi(0, "NeoTreeDirectoryIcon", { fg = "#b12d50" })
hi(0, "NeoTreeDirectoryName", { fg = "#b12d50" })
hi(0, "NeoTreeDotfile", { fg = "#c4375b" })
hi(0, "NeoTreeFileName", { fg = "#662231" })
hi(0, "NeoTreeFileNameOpened", { fg = "#581a28" })
hi(0, "NeoTreeGitAdded", { fg = "#74872d" })
hi(0, "NeoTreeGitConflict", { fg = "#f95c80", italic = true })
hi(0, "NeoTreeGitDeleted", { fg = "#e82b65" })
hi(0, "NeoTreeGitIgnored", { fg = "#917f81" })
hi(0, "NeoTreeGitModified", { fg = "#a9c058" })
hi(0, "NeoTreeGitUntracked", { fg = "#f70064" })
hi(0, "NeoTreeIndentMarker", { fg = "#dcdcdc" })
hi(0, "NeoTreeNormal", { bg = "#dfdfdf", fg = "#581a28" })
hi(0, "NeoTreeNormalNC", { link = "NeoTreeNormal" })
hi(0, "NeoTreeRootName", { bold = true, fg = "#f95c80" })
hi(0, "NeoTreeSymbolicLinkTarget", { fg = "#ff7090" })
hi(0, "NeogitBranch", { fg = "#cd6478" })
hi(0, "NeogitDiffAdd", { fg = "#74872d" })
hi(0, "NeogitDiffAddHighlight", { bg = "#dee0d9" })
hi(0, "NeogitDiffContextHighlight", { bg = "#ece7e8" })
hi(0, "NeogitDiffDelete", { fg = "#e82b65" })
hi(0, "NeogitDiffDeleteHighlight", { bg = "#edd8da" })
hi(0, "NeogitHunkHeader", { bg = "#fae1e4", fg = "#b12d50" })
hi(0, "NeogitHunkHeaderHighlight", { bg = "#fadde1", fg = "#b12d50" })
hi(0, "NeogitNotificationError", { fg = "#df2961" })
hi(0, "NeogitNotificationInfo", { fg = "#b12d50" })
hi(0, "NeogitNotificationWarning", { fg = "#cd6478" })
hi(0, "NeogitRemote", { fg = "#74872d" })
hi(0, "NeotestAdapterName", { bold = true, fg = "#ff5e85" })
hi(0, "NeotestDir", { fg = "#738143" })
hi(0, "NeotestExpandMarker", { link = "Conceal" })
hi(0, "NeotestFailed", { fg = "#df2961" })
hi(0, "NeotestFile", { fg = "#b12d50" })
hi(0, "NeotestFocused", { underline = true })
hi(0, "NeotestIndent", { link = "Conceal" })
hi(0, "NeotestMarked", { bold = true, fg = "#581a28" })
hi(0, "NeotestNamespace", { fg = "#64713a" })
hi(0, "NeotestPassed", { fg = "#74872d" })
hi(0, "NeotestRunning", { fg = "#f95c80" })
hi(0, "NeotestSkipped", { fg = "#cd6478" })
hi(0, "NeotestTest", { link = "Normal" })
hi(0, "NonText", { fg = "#dcdcdc" })
hi(0, "Normal", { bg = "#faf6f7", fg = "#581a28" })
hi(0, "NormalFloat", { bg = "#dfdfdf", fg = "#581a28" })
hi(0, "NormalNC", { bg = "#faf6f7", fg = "#581a28" })
hi(0, "NotifyBackground", { link = "NormalFloat" })
hi(0, "NotifyDEBUGBorder", { fg = "#b8bbb1" })
hi(0, "NotifyDEBUGIcon", { link = "NotifyDEBUGTitle" })
hi(0, "NotifyDEBUGTitle", { fg = "#74872d" })
hi(0, "NotifyERRORBorder", { fg = "#ff8ea2" })
hi(0, "NotifyERRORIcon", { link = "NotifyERRORTitle" })
hi(0, "NotifyERRORTitle", { fg = "#df2961" })
hi(0, "NotifyINFOBorder", { fg = "#f18e9e" })
hi(0, "NotifyINFOIcon", { link = "NotifyINFOTitle" })
hi(0, "NotifyINFOTitle", { fg = "#b12d50" })
hi(0, "NotifyTRACEBorder", { fg = "#dcdcdc" })
hi(0, "NotifyTRACEIcon", { link = "NotifyTRACETitle" })
hi(0, "NotifyTRACETitle", { fg = "#917f81" })
hi(0, "NotifyWARNBorder", { fg = "#ff9aac" })
hi(0, "NotifyWARNIcon", { link = "NotifyWARNTitle" })
hi(0, "NotifyWARNTitle", { fg = "#cd6478" })
hi(0, "Number", { fg = "#f95c80" })
hi(0, "NvimInternalError", { bg = "#f90065", ctermbg = 9, ctermfg = 9, fg = "#f22868" })
hi(0, "NvimTreeEmptyFolderName", { fg = "#862e42" })
hi(0, "NvimTreeFolderIcon", { fg = "#b12d50" })
hi(0, "NvimTreeFolderName", { fg = "#b12d50" })
hi(0, "NvimTreeGitDeleted", { fg = "#e82b65" })
hi(0, "NvimTreeGitDirty", { fg = "#a9c058" })
hi(0, "NvimTreeGitMerge", { fg = "#f95c80" })
hi(0, "NvimTreeGitNew", { fg = "#74872d" })
hi(0, "NvimTreeGitRenamed", { link = "NvimTreeGitDeleted" })
hi(0, "NvimTreeGitStaged", { link = "NvimTreeGitStaged" })
hi(0, "NvimTreeImageFile", { fg = "#752538" })
hi(0, "NvimTreeIndentMarker", { fg = "#dcdcdc" })
hi(0, "NvimTreeNormal", { bg = "#dfdfdf", fg = "#581a28" })
hi(0, "NvimTreeOpenedFile", { fg = "#ff2d70" })
hi(0, "NvimTreeOpenedFolderName", { fg = "#9f2b49" })
hi(0, "NvimTreeRootFolder", { bold = true, fg = "#f95c80" })
hi(0, "NvimTreeSpecialFile", { fg = "#738143" })
hi(0, "NvimTreeSymlink", { fg = "#ff7090" })
hi(0, "NvimTreeVertSplit", { link = "VertSplit" })
hi(0, "Operator", { fg = "#662231" })
hi(0, "Pmenu", { bg = "#fadde1", fg = "#581a28" })
hi(0, "PmenuSel", { bg = "#dcdcdc" })
hi(0, "PmenuThumb", { bg = "#dcdcdc" })
hi(0, "PounceAccept", { bg = "#d56278", fg = "#fff5f6" })
hi(0, "PounceAcceptBest", { bg = "#647236", fg = "#fff5f6" })
hi(0, "PounceGap", { bg = "#fadde1", fg = "#581a28" })
hi(0, "PounceMatch", { bg = "#dcdcdc", fg = "#581a28" })
hi(0, "PreProc", { fg = "#ff2d70" })
hi(0, "Question", { link = "MoreMsg" })
hi(0, "QuickFixLine", { link = "CursorLine" })
hi(0, "RedrawDebugClear", { bg = "#d9eda1", ctermbg = 3, ctermfg = 15 })
hi(0, "RedrawDebugComposed", { bg = "#daeda2", ctermbg = 2, ctermfg = 15 })
hi(0, "RedrawDebugRecompose", { bg = "#febfc7", ctermbg = 1, ctermfg = 15 })
hi(0, "Removed", { ctermfg = 1, fg = "#54081f" })
hi(0, "Repeat", { link = "Conditional" })
hi(0, "Search", { reverse = true })
hi(0, "SignColumn", { fg = "#862e42" })
hi(0, "SignColumnSB", { link = "SignColumn" })
hi(0, "SignifySignAdd", { fg = "#74872d" })
hi(0, "SignifySignChange", { fg = "#a9c058" })
hi(0, "SignifySignDelete", { fg = "#e82b65" })
hi(0, "Sneak", { bg = "#a26b73", fg = "#dfdfdf" })
hi(0, "SneakScope", { bg = "#fadde1" })
hi(0, "Special", { fg = "#c4375b" })
hi(0, "SpecialKey", { link = "NonText" })
hi(0, "SpellBad", { sp = "#bb5d6e", undercurl = true })
hi(0, "SpellCap", { sp = "#c36c7b", undercurl = true })
hi(0, "SpellLocal", { sp = "#89565e", undercurl = true })
hi(0, "SpellRare", { sp = "#89565e", undercurl = true })
hi(0, "Statement", { bold = true, fg = "#e4005c" })
hi(0, "StatusLine", { bg = "#dfdfdf", fg = "#662231" })
hi(0, "StatusLineNC", { bg = "#dfdfdf", fg = "#862e42" })
hi(0, "String", { fg = "#74872d" })
hi(0, "Substitute", { bg = "#bb5d6e", fg = "#fff5f6" })
hi(0, "SymbolOutlineConnector", { link = "Conceal" })
hi(0, "TSRainbowBlue", { fg = "#b12d50" })
hi(0, "TSRainbowCyan", { fg = "#738143" })
hi(0, "TSRainbowGreen", { fg = "#74872d" })
hi(0, "TSRainbowOrange", { fg = "#f95c80" })
hi(0, "TSRainbowRed", { fg = "#df2961" })
hi(0, "TSRainbowViolet", { fg = "#e4005c" })
hi(0, "TSRainbowYellow", { fg = "#cd6478" })
hi(0, "TabLine", { bg = "#ece7e8", fg = "#662231" })
hi(0, "TabLineFill", { bg = "#dfdfdf" })
hi(0, "TabLineSel", { bg = "#773d47", fg = "#fff5f6" })
hi(0, "TelescopeBorder", { fg = "#dcdcdc" })
hi(0, "TelescopeMatching", { link = "Search" })
hi(0, "TelescopeSelection", { link = "CursorLine" })
hi(0, "TelescopeSelectionCaret", { fg = "#74872d" })
hi(0, "Title", { bold = true, fg = "#c4375b" })
hi(0, "Todo", { bg = "#89565e", fg = "#fff5f6" })
hi(0, "Type", { fg = "#cd6478" })
hi(0, "Visual", { bg = "#fadde1" })
hi(0, "WarningMsg", { fg = "#cd6478" })
hi(0, "WhichKey", { link = "Identifier" })
hi(0, "WhichKeyDesc", { link = "Keyword" })
hi(0, "WhichKeyFloat", { link = "NormalFloat" })
hi(0, "WhichKeyGroup", { link = "Function" })
hi(0, "WhichKeySeparator", { link = "Comment" })
hi(0, "WhichKeySeperator", { link = "Comment" })
hi(0, "WhichKeyValue", { link = "Comment" })
hi(0, "Whitespace", { fg = "#ffdfe3" })
hi(0, "WildMenu", { link = "Pmenu" })
hi(0, "WinBar", { bg = "#faf6f7", bold = true, fg = "#862e42" })
hi(0, "WinBarNC", { bg = "#faf6f7", bold = true, fg = "#862e42" })
hi(0, "WinSeparator", { fg = "#dfdfdf" })
hi(0, "diffAdded", { fg = "#74872d" })
hi(0, "diffChanged", { fg = "#a9c058" })
hi(0, "diffFile", { fg = "#b12d50" })
hi(0, "diffIndexLine", { fg = "#ff2d70" })
hi(0, "diffLine", { fg = "#f4376d" })
hi(0, "diffNewFile", { fg = "#74872d" })
hi(0, "diffOldFile", { fg = "#cd6478" })
hi(0, "diffRemoved", { fg = "#e82b65" })
hi(0, "illuminatedWordRead", { link = "LspReferenceText" })
hi(0, "illuminatedWordText", { link = "LspReferenceText" })
hi(0, "illuminatedWordWrite", { link = "LspReferenceText" })
hi(0, "lCursor", { link = "Cursor" })
hi(0, "qfFileName", { link = "Directory" })
hi(0, "qfLineNr", { link = "LineNr" })
hi(0, "rainbowcol1", { fg = "#df2961" })
hi(0, "rainbowcol2", { fg = "#cd6478" })
hi(0, "rainbowcol3", { fg = "#74872d" })
hi(0, "rainbowcol4", { fg = "#b12d50" })
hi(0, "rainbowcol5", { fg = "#738143" })
hi(0, "rainbowcol6", { fg = "#e4005c" })
hi(0, "rainbowcol7", { fg = "#ff5e85" })

-- Terminal colors
local g = vim.g

g.terminal_color_0 = "#4b262c"
g.terminal_color_1 = "#bb5d6e"
g.terminal_color_2 = "#79825f"
g.terminal_color_3 = "#c36c7b"
g.terminal_color_4 = "#89565e"
g.terminal_color_5 = "#a26b73"
g.terminal_color_6 = "#738141"
g.terminal_color_7 = "#9fb92b"
g.terminal_color_8 = "#69323c"
g.terminal_color_9 = "#c96879"
g.terminal_color_10 = "#899760"
g.terminal_color_11 = "#d47a89"
g.terminal_color_12 = "#a25b67"
g.terminal_color_13 = "#b86f7a"
g.terminal_color_14 = "#7b8b47"
g.terminal_color_15 = "#a1bc2f"
