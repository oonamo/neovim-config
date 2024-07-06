-- Made with 'mini.colors' module of https://github.com/echasnovski/mini.nvim

if vim.g.colors_name ~= nil then vim.cmd('highlight clear') end
vim.g.colors_name = "prime-pine"

-- Highlight groups
local hi = vim.api.nvim_set_hl

hi(0, "@attribute.diff", { fg = "#feb597" })
hi(0, "@character.special", { link = "Character" })
hi(0, "@class", { fg = "#a4d0c6" })
hi(0, "@comment.error", { fg = "#e274a2" })
hi(0, "@comment.hint", { bg = "#38354c", blend = 20, fg = "#bdaae6" })
hi(0, "@comment.info", { bg = "#303d47", blend = 20, fg = "#a4d0c6" })
hi(0, "@comment.note", { bg = "#192c37", blend = 20, fg = "#2b787c" })
hi(0, "@comment.todo", { bg = "#423843", blend = 20, fg = "#e7bcc3" })
hi(0, "@comment.warning", { fg = "#feb597" })
hi(0, "@conceal", { link = "Conceal" })
hi(0, "@conceal.markdown", { fg = "#8e8ea5" })
hi(0, "@conditional", { link = "Conditional" })
hi(0, "@constant", { fg = "#feb597" })
hi(0, "@constant.builtin", { bold = true, fg = "#feb597" })
hi(0, "@constant.macro", { fg = "#feb597" })
hi(0, "@constructor", { fg = "#a4d0c6" })
hi(0, "@diff.delta", { bg = "#423843", blend = 20 })
hi(0, "@diff.minus", { bg = "#42293d", blend = 20, fg = "#e274a2" })
hi(0, "@diff.plus", { bg = "#303d47", blend = 20, fg = "#a4d0c6" })
hi(0, "@field", { fg = "#a4d0c6" })
hi(0, "@float", { link = "Number" })
hi(0, "@function", { fg = "#e7bcc3" })
hi(0, "@function.builtin", { bold = true, fg = "#e7bcc3" })
hi(0, "@function.macro", { link = "Function" })
hi(0, "@function.method", { fg = "#e7bcc3" })
hi(0, "@function.method.call", { fg = "#bdaae6" })
hi(0, "@include", { link = "Include" })
hi(0, "@interface", { fg = "#a4d0c6" })
hi(0, "@keyword.conditional", { fg = "#2b787c" })
hi(0, "@keyword.conditional.ternary", { fg = "#2b787c" })
hi(0, "@keyword.debug", { fg = "#e7bcc3" })
hi(0, "@keyword.directive", { fg = "#bdaae6" })
hi(0, "@keyword.directive.define", { fg = "#bdaae6" })
hi(0, "@keyword.exception", { fg = "#2b787c" })
hi(0, "@keyword.import", { fg = "#2b787c" })
hi(0, "@keyword.operator", { fg = "#8e8ea5" })
hi(0, "@keyword.repeat", { fg = "#2b787c" })
hi(0, "@keyword.return", { fg = "#2b787c" })
hi(0, "@keyword.storage", { fg = "#a4d0c6" })
hi(0, "@lsp.type.comment", {})
hi(0, "@lsp.type.comment.c", { link = "@comment" })
hi(0, "@lsp.type.comment.cpp", { link = "@comment" })
hi(0, "@lsp.type.enum", { link = "@type" })
hi(0, "@lsp.type.interface", { link = "@interface" })
hi(0, "@lsp.type.keyword", { link = "@keyword" })
hi(0, "@lsp.type.namespace", { link = "@namespace" })
hi(0, "@lsp.type.namespace.python", { link = "@variable" })
hi(0, "@lsp.type.parameter", { link = "@parameter" })
hi(0, "@lsp.type.property", { link = "@property" })
hi(0, "@lsp.type.variable", {})
hi(0, "@lsp.type.variable.svelte", { link = "@variable" })
hi(0, "@lsp.typemod.function.defaultLibrary", { link = "@function.builtin" })
hi(0, "@lsp.typemod.operator.injected", { link = "@operator" })
hi(0, "@lsp.typemod.string.injected", { link = "@string" })
hi(0, "@lsp.typemod.variable.constant", { link = "@constant" })
hi(0, "@lsp.typemod.variable.defaultLibrary", { link = "@variable.builtin" })
hi(0, "@lsp.typemod.variable.injected", { link = "@variable" })
hi(0, "@macro", { link = "Macro" })
hi(0, "@markup.environment", { link = "Macro" })
hi(0, "@markup.environment.name", { link = "@type" })
hi(0, "@markup.heading", { bold = true, fg = "#a4d0c6" })
hi(0, "@markup.heading.1.markdown", { link = "markdownH1" })
hi(0, "@markup.heading.1.marker.markdown", { link = "markdownH1Delimiter" })
hi(0, "@markup.heading.2.markdown", { link = "markdownH2" })
hi(0, "@markup.heading.2.marker.markdown", { link = "markdownH2Delimiter" })
hi(0, "@markup.heading.3.markdown", { link = "markdownH3" })
hi(0, "@markup.heading.3.marker.markdown", { link = "markdownH3Delimiter" })
hi(0, "@markup.heading.4.markdown", { link = "markdownH4" })
hi(0, "@markup.heading.4.marker.markdown", { link = "markdownH4Delimiter" })
hi(0, "@markup.heading.5.markdown", { link = "markdownH5" })
hi(0, "@markup.heading.5.marker.markdown", { link = "markdownH5Delimiter" })
hi(0, "@markup.heading.6.markdown", { link = "markdownH6" })
hi(0, "@markup.heading.6.marker.markdown", { link = "markdownH6Delimiter" })
hi(0, "@markup.link.label.markdown_inline", { fg = "#a4d0c6" })
hi(0, "@markup.link.markdown_inline", { fg = "#8e8ea5" })
hi(0, "@markup.link.url", { fg = "#bdaae6" })
hi(0, "@markup.list", { fg = "#dedff3" })
hi(0, "@markup.list.checked", { bg = "#242a36", blend = 10, fg = "#a4d0c6" })
hi(0, "@markup.list.unchecked", { fg = "#dedff3" })
hi(0, "@markup.math", { link = "Special" })
hi(0, "@markup.quote", { fg = "#8e8ea5" })
hi(0, "@markup.raw.delimiter.markdown", { fg = "#8e8ea5" })
hi(0, "@method", { fg = "#e7bcc3" })
hi(0, "@module", { fg = "#dedff3" })
hi(0, "@module.builtin", { bold = true, fg = "#dedff3" })
hi(0, "@namespace", { link = "Include" })
hi(0, "@number.float", { link = "Number" })
hi(0, "@parameter", { fg = "#bdaae6", italic = true })
hi(0, "@preproc", { link = "PreProc" })
hi(0, "@property", { fg = "#a4d0c6", italic = true })
hi(0, "@punctuation", { fg = "#8e8ea5" })
hi(0, "@punctuation.bracket", { fg = "#8e8ea5" })
hi(0, "@punctuation.delimiter", { fg = "#8e8ea5" })
hi(0, "@punctuation.special", { fg = "#8e8ea5" })
hi(0, "@regexp", { link = "String" })
hi(0, "@repeat", { link = "Repeat" })
hi(0, "@storageclass", { link = "StorageClass" })
hi(0, "@string.escape", { fg = "#2b787c" })
hi(0, "@string.regexp", { fg = "#bdaae6" })
hi(0, "@string.special", { link = "String" })
hi(0, "@string.special.symbol", { link = "Identifier" })
hi(0, "@string.special.url", { fg = "#bdaae6" })
hi(0, "@symbol", { link = "Identifier" })
hi(0, "@tag.attribute", { fg = "#bdaae6" })
hi(0, "@tag.delimiter", { fg = "#8e8ea5" })
hi(0, "@text", { fg = "#dedff3" })
hi(0, "@text.danger", { fg = "#e274a2" })
hi(0, "@text.diff.add", { bg = "#303d47", blend = 20, fg = "#a4d0c6" })
hi(0, "@text.diff.delete", { bg = "#42293d", blend = 20, fg = "#e274a2" })
hi(0, "@text.emphasis", { italic = true })
hi(0, "@text.environment", { link = "Macro" })
hi(0, "@text.environment.name", { link = "Type" })
hi(0, "@text.math", { link = "Special" })
hi(0, "@text.note", { link = "SpecialComment" })
hi(0, "@text.strike", { strikethrough = true })
hi(0, "@text.strong", { bold = true })
hi(0, "@text.title", { link = "Title" })
hi(0, "@text.title.1.markdown", { link = "markdownH1" })
hi(0, "@text.title.1.marker.markdown", { link = "markdownH1Delimiter" })
hi(0, "@text.title.2.markdown", { link = "markdownH2" })
hi(0, "@text.title.2.marker.markdown", { link = "markdownH2Delimiter" })
hi(0, "@text.title.3.markdown", { link = "markdownH3" })
hi(0, "@text.title.3.marker.markdown", { link = "markdownH3Delimiter" })
hi(0, "@text.title.4.markdown", { link = "markdownH4" })
hi(0, "@text.title.4.marker.markdown", { link = "markdownH4Delimiter" })
hi(0, "@text.title.5.markdown", { link = "markdownH5" })
hi(0, "@text.title.5.marker.markdown", { link = "markdownH5Delimiter" })
hi(0, "@text.title.6.markdown", { link = "markdownH6" })
hi(0, "@text.title.6.marker.markdown", { link = "markdownH6Delimiter" })
hi(0, "@text.underline", { underline = true })
hi(0, "@text.uri", { fg = "#bdaae6" })
hi(0, "@text.warning", { fg = "#feb597" })
hi(0, "@todo", { link = "Todo" })
hi(0, "@type", { fg = "#a4d0c6" })
hi(0, "@type.builtin", { bold = true, fg = "#a4d0c6" })
hi(0, "@variable", { fg = "#dedff3", italic = true })
hi(0, "@variable.builtin", { bold = true, fg = "#e274a2" })
hi(0, "@variable.member", { fg = "#a4d0c6" })
hi(0, "@variable.parameter", { fg = "#bdaae6", italic = true })
hi(0, "Added", { ctermfg = 10, fg = "#9bf8e5" })
hi(0, "AlphaButtons", { fg = "#a4d0c6" })
hi(0, "AlphaFooter", { fg = "#feb597" })
hi(0, "AlphaHeader", { fg = "#2b787c" })
hi(0, "AlphaShortcut", { fg = "#e7bcc3" })
hi(0, "Boolean", { fg = "#e7bcc3" })
hi(0, "BufferCurrent", { bg = "#23243b", fg = "#dedff3" })
hi(0, "BufferCurrentIndex", { bg = "#23243b", fg = "#dedff3" })
hi(0, "BufferCurrentMod", { bg = "#23243b", fg = "#a4d0c6" })
hi(0, "BufferCurrentSign", { bg = "#23243b", fg = "#8e8ea5" })
hi(0, "BufferCurrentTarget", { bg = "#23243b", fg = "#feb597" })
hi(0, "BufferInactive", { fg = "#8e8ea5" })
hi(0, "BufferInactiveIndex", { fg = "#8e8ea5" })
hi(0, "BufferInactiveMod", { fg = "#a4d0c6" })
hi(0, "BufferInactiveSign", { fg = "#6c6c7f" })
hi(0, "BufferInactiveTarget", { fg = "#feb597" })
hi(0, "BufferVisible", { fg = "#8e8ea5" })
hi(0, "BufferVisibleIndex", { fg = "#8e8ea5" })
hi(0, "BufferVisibleMod", { fg = "#a4d0c6" })
hi(0, "BufferVisibleSign", { fg = "#6c6c7f" })
hi(0, "BufferVisibleTarget", { fg = "#feb597" })
hi(0, "Changed", { ctermfg = 14, fg = "#9af8e5" })
hi(0, "Character", { fg = "#feb597" })
hi(0, "CmpItemAbbr", { fg = "#8e8ea5" })
hi(0, "CmpItemAbbrDefault", { fg = "#8e8ea5" })
hi(0, "CmpItemAbbrDeprecated", { fg = "#8e8ea5", strikethrough = true })
hi(0, "CmpItemAbbrDeprecatedDefault", { fg = "#8e8ea5" })
hi(0, "CmpItemAbbrMatch", { bold = true, fg = "#dedff3" })
hi(0, "CmpItemAbbrMatchDefault", { fg = "#8e8ea5" })
hi(0, "CmpItemAbbrMatchFuzzy", { bold = true, fg = "#dedff3" })
hi(0, "CmpItemAbbrMatchFuzzyDefault", { fg = "#8e8ea5" })
hi(0, "CmpItemKind", { fg = "#8e8ea5" })
hi(0, "CmpItemKindClass", { link = "StorageClass" })
hi(0, "CmpItemKindClassDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindColorDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindConstantDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindConstructorDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindDefault", { fg = "#a4d0c6" })
hi(0, "CmpItemKindEnumDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindEnumMemberDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindEventDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindFieldDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindFileDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindFolderDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindFunction", { link = "Function" })
hi(0, "CmpItemKindFunctionDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindInterface", { link = "Type" })
hi(0, "CmpItemKindInterfaceDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindKeywordDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindMethod", { link = "PreProc" })
hi(0, "CmpItemKindMethodDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindModuleDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindOperatorDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindPropertyDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindReferenceDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindSnippet", { link = "String" })
hi(0, "CmpItemKindSnippetDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindStructDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindTextDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindTypeParameterDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindUnitDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindValueDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindVariable", { link = "Identifier" })
hi(0, "CmpItemKindVariableDefault", { link = "CmpItemKind" })
hi(0, "CmpItemMenuDefault", { fg = "#8e8ea5" })
hi(0, "ColorColumn", { bg = "#1d1e2f" })
hi(0, "Comment", { fg = "#8e8ea5", italic = true })
hi(0, "Conceal", {})
hi(0, "Conditional", { fg = "#2b787c" })
hi(0, "Constant", { fg = "#feb597" })
hi(0, "CopilotSuggestion", { fg = "#6c6c7f", italic = true })
hi(0, "CurSearch", { bg = "#feb496", fg = "#181821" })
hi(0, "Cursor", { bg = "#4f5068", fg = "#dedff3" })
hi(0, "CursorColumn", { bg = "#23243b" })
hi(0, "CursorLine", { bg = "#23243b" })
hi(0, "CursorLineNr", { bold = true, fg = "#dedff3" })
hi(0, "DapUIBreakpointsCurrentLine", { bold = true, fg = "#feb597" })
hi(0, "DapUIBreakpointsDisabledLine", { fg = "#6c6c7f" })
hi(0, "DapUIBreakpointsInfo", { link = "DapUIThread" })
hi(0, "DapUIBreakpointsLine", { link = "DapUIBreakpointsPath" })
hi(0, "DapUIBreakpointsPath", { fg = "#a4d0c6" })
hi(0, "DapUIDecoration", { link = "DapUIBreakpointsPath" })
hi(0, "DapUIFloatBorder", { bg = "#1d1e2f", fg = "#6c6c7f" })
hi(0, "DapUIFrameName", { fg = "#dedff3" })
hi(0, "DapUILineNumber", { link = "DapUIBreakpointsPath" })
hi(0, "DapUIModifiedValue", { bold = true, fg = "#a4d0c6" })
hi(0, "DapUIScope", { link = "DapUIBreakpointsPath" })
hi(0, "DapUISource", { fg = "#bdaae6" })
hi(0, "DapUIStoppedThread", { link = "DapUIBreakpointsPath" })
hi(0, "DapUIThread", { fg = "#feb597" })
hi(0, "DapUIValue", { fg = "#dedff3" })
hi(0, "DapUIVariable", { fg = "#dedff3" })
hi(0, "DapUIWatchesEmpty", { fg = "#e274a2" })
hi(0, "DapUIWatchesError", { link = "DapUIWatchesEmpty" })
hi(0, "DapUIWatchesValue", { link = "DapUIThread" })
hi(0, "DashboardCenter", { fg = "#feb597" })
hi(0, "DashboardFooter", { fg = "#bdaae6" })
hi(0, "DashboardHeader", { fg = "#2b787c" })
hi(0, "DashboardShortcut", { fg = "#e274a2" })
hi(0, "Debug", { fg = "#e7bcc3" })
hi(0, "Define", { fg = "#bdaae6" })
hi(0, "DefinitionCount", { fg = "#e7bcc3" })
hi(0, "DefinitionIcon", { fg = "#e7bcc3" })
hi(0, "DefinitionPreviewTitle", { bold = true, fg = "#e7bcc3" })
hi(0, "Delimiter", { fg = "#8e8ea5" })
hi(0, "DiagnosticDefaultError", { link = "DiagnosticError" })
hi(0, "DiagnosticDefaultHint", { link = "DiagnosticHint" })
hi(0, "DiagnosticDefaultInfo", { link = "DiagnosticInfo" })
hi(0, "DiagnosticDefaultWarn", { link = "DiagnosticWarn" })
hi(0, "DiagnosticDeprecated", { sp = "#febfc4", strikethrough = true })
hi(0, "DiagnosticError", { fg = "#e274a2" })
hi(0, "DiagnosticHint", { fg = "#bdaae6" })
hi(0, "DiagnosticInfo", { fg = "#a4d0c6" })
hi(0, "DiagnosticOk", { ctermfg = 10, fg = "#9bf8e5" })
hi(0, "DiagnosticUnderlineError", { sp = "#e770a2", undercurl = true })
hi(0, "DiagnosticUnderlineHint", { sp = "#bdaaeb", undercurl = true })
hi(0, "DiagnosticUnderlineInfo", { sp = "#9fd0c6", undercurl = true })
hi(0, "DiagnosticUnderlineOk", { sp = "#93f9e5", underline = true })
hi(0, "DiagnosticUnderlineWarn", { sp = "#feb496", undercurl = true })
hi(0, "DiagnosticVirtualTextError", { bg = "#2c2031", blend = 10, fg = "#e274a2" })
hi(0, "DiagnosticVirtualTextHint", { bg = "#282639", blend = 10, fg = "#bdaae6" })
hi(0, "DiagnosticVirtualTextInfo", { bg = "#242a36", blend = 10, fg = "#a4d0c6" })
hi(0, "DiagnosticVirtualTextWarn", { bg = "#2f282d", blend = 10, fg = "#feb597" })
hi(0, "DiagnosticWarn", { fg = "#feb597" })
hi(0, "DiffAdd", { bg = "#303d47", blend = 20 })
hi(0, "DiffChange", { bg = "#423843", blend = 20 })
hi(0, "DiffDelete", { bg = "#42293d", blend = 20 })
hi(0, "DiffText", { bg = "#423843", blend = 20 })
hi(0, "Directory", { bold = true, fg = "#a4d0c6" })
hi(0, "Error", { fg = "#e274a2" })
hi(0, "ErrorMsg", { bold = true, fg = "#e274a2" })
hi(0, "Exception", { fg = "#2b787c" })
hi(0, "FlashLabel", { bg = "#e770a2", fg = "#181821" })
hi(0, "Float", { fg = "#feb597" })
hi(0, "FloatBorder", { bg = "#1d1e2f", fg = "#6c6c7f" })
hi(0, "FloatShadow", { bg = "#4e5258", blend = 80, ctermbg = 0 })
hi(0, "FloatShadowThrough", { bg = "#4e5258", blend = 100, ctermbg = 0 })
hi(0, "FloatTitle", { link = "Directory" })
hi(0, "FoldColumn", { fg = "#6c6c7f" })
hi(0, "Folded", { bg = "#1d1e2f", fg = "#dedff3" })
hi(0, "Function", { fg = "#e7bcc3" })
hi(0, "FzfLuaBorder", { bg = "#1d1e2f", fg = "#6c6c7f" })
hi(0, "FzfLuaBufFlagAlt", { fg = "#8e8ea5" })
hi(0, "FzfLuaBufFlagCur", { fg = "#8e8ea5" })
hi(0, "FzfLuaHeaderBind", { fg = "#e7bcc3" })
hi(0, "FzfLuaHeaderText", { fg = "#e274a2" })
hi(0, "FzfLuaNormal", { link = "NormalFloat" })
hi(0, "FzfLuaTitle", { bold = true, fg = "#a4d0c6" })
hi(0, "GitSignsAdd", { link = "SignAdd" })
hi(0, "GitSignsChange", { link = "SignChange" })
hi(0, "GitSignsDelete", { link = "SignDelete" })
hi(0, "HopNextKey", { bg = "#42293d", blend = 20, fg = "#e274a2" })
hi(0, "HopNextKey1", { bg = "#303d47", blend = 20, fg = "#a4d0c6" })
hi(0, "HopNextKey2", { bg = "#192c37", blend = 20, fg = "#2b787c" })
hi(0, "HopUnmatched", { fg = "#6c6c7f" })
hi(0, "IblIndent", { fg = "#242538" })
hi(0, "IblScope", { fg = "#a4d0c6" })
hi(0, "IblWhitespace", { fg = "#242538" })
hi(0, "Identifier", { fg = "#dedff3" })
hi(0, "IlluminatedWordRead", { link = "LspReferenceRead" })
hi(0, "IlluminatedWordText", { link = "LspReferenceText" })
hi(0, "IlluminatedWordWrite", { link = "LspReferenceWrite" })
hi(0, "Include", { fg = "#2b787c" })
hi(0, "IndentBlanklineChar", { fg = "#6c6c7f", nocombine = true })
hi(0, "IndentBlanklineSpaceChar", { fg = "#6c6c7f", nocombine = true })
hi(0, "IndentBlanklineSpaceCharBlankline", { fg = "#6c6c7f", nocombine = true })
hi(0, "Keyword", { fg = "#2b787c" })
hi(0, "Label", { fg = "#a4d0c6" })
hi(0, "LeapLabelPrimary", { link = "IncSearch" })
hi(0, "LeapLabelSecondary", { link = "StatusLineTerm" })
hi(0, "LeapMatch", { link = "MatchParen" })
hi(0, "LineNr", { fg = "#6c6c7f" })
hi(0, "LspCodeLens", { fg = "#8e8ea5" })
hi(0, "LspCodeLensSeparator", { fg = "#6c6c7f" })
hi(0, "LspFloatWinBorder", { bg = "#1d1e2f", fg = "#6c6c7f" })
hi(0, "LspFloatWinNormal", { bg = "#1d1e2f" })
hi(0, "LspInlayHint", { bg = "#211f2f", blend = 10, fg = "#6c6c7f" })
hi(0, "LspReferenceRead", { bg = "#3e3e53" })
hi(0, "LspReferenceText", { bg = "#3e3e53" })
hi(0, "LspReferenceWrite", { bg = "#3e3e53" })
hi(0, "LspSagaAutoPreview", { fg = "#8e8ea5" })
hi(0, "LspSagaCodeActionBorder", { bg = "#1d1e2f", fg = "#e7bcc3" })
hi(0, "LspSagaCodeActionContent", { fg = "#a4d0c6" })
hi(0, "LspSagaCodeActionTitle", { bold = true, fg = "#feb597" })
hi(0, "LspSagaCodeActionTruncateLine", { link = "LspSagaCodeActionBorder" })
hi(0, "LspSagaDefPreviewBorder", { bg = "#1d1e2f", fg = "#6c6c7f" })
hi(0, "LspSagaDiagnosticBorder", { bg = "#1d1e2f", fg = "#feb597" })
hi(0, "LspSagaDiagnosticHeader", { bold = true, fg = "#a4d0c6" })
hi(0, "LspSagaDiagnosticTruncateLine", { link = "LspSagaDiagnosticBorder" })
hi(0, "LspSagaDocTruncateLine", { link = "LspSagaHoverBorder" })
hi(0, "LspSagaFinderSelection", { fg = "#feb597" })
hi(0, "LspSagaHoverBorder", { link = "LspFloatWinBorder" })
hi(0, "LspSagaLspFinderBorder", { link = "LspFloatWinBorder" })
hi(0, "LspSagaRenameBorder", { bg = "#1d1e2f", fg = "#2b787c" })
hi(0, "LspSagaRenamePromptPrefix", { fg = "#e274a2" })
hi(0, "LspSagaShTruncateLine", { link = "LspSagaSignatureHelpBorder" })
hi(0, "LspSagaSignatureHelpBorder", { bg = "#1d1e2f", fg = "#a4d0c6" })
hi(0, "LspSignatureActiveParameter", { bg = "#23243b" })
hi(0, "Macro", { fg = "#bdaae6" })
hi(0, "MatchParen", { bg = "#19303d", blend = 25, fg = "#2b787c" })
hi(0, "MiniAnimateCursor", { nocombine = true, reverse = true })
hi(0, "MiniAnimateNormalFloat", { link = "NormalFloat" })
hi(0, "MiniClueBorder", { link = "FloatBorder" })
hi(0, "MiniClueDescGroup", { link = "DiagnosticFloatingWarn" })
hi(0, "MiniClueDescSingle", { link = "NormalFloat" })
hi(0, "MiniClueNextKey", { link = "DiagnosticFloatingHint" })
hi(0, "MiniClueNextKeyWithPostkeys", { link = "DiagnosticFloatingError" })
hi(0, "MiniClueSeparator", { link = "DiagnosticFloatingInfo" })
hi(0, "MiniClueTitle", { bg = "#1d1e2f", bold = true })
hi(0, "MiniCompletionActiveParameter", { underline = true })
hi(0, "MiniCursorword", { underline = true })
hi(0, "MiniCursorwordCurrent", { underline = true })
hi(0, "MiniDepsChangeAdded", { fg = "#a4d0c6" })
hi(0, "MiniDepsChangeRemoved", { fg = "#e274a2" })
hi(0, "MiniDepsHint", { link = "DiagnosticHint" })
hi(0, "MiniDepsInfo", { link = "DiagnosticInfo" })
hi(0, "MiniDepsMsgBreaking", { link = "DiagnosticWarn" })
hi(0, "MiniDepsPlaceholder", { link = "Comment" })
hi(0, "MiniDepsTitle", { link = "Title" })
hi(0, "MiniDepsTitleError", { link = "DiffDelete" })
hi(0, "MiniDepsTitleSame", { link = "DiffText" })
hi(0, "MiniDepsTitleUpdate", { link = "DiffAdd" })
hi(0, "MiniDiffOverAdd", { bg = "#303d47", blend = 20, fg = "#a4d0c6" })
hi(0, "MiniDiffOverChange", { bg = "#423843", blend = 20, fg = "#e7bcc3" })
hi(0, "MiniDiffOverContext", { bg = "#1d1e2f" })
hi(0, "MiniDiffOverDelete", { bg = "#42293d", blend = 20, fg = "#e274a2" })
hi(0, "MiniDiffSignAdd", { fg = "#a4d0c6" })
hi(0, "MiniDiffSignAdd_stl", { fg = "#a4d0c6" })
hi(0, "MiniDiffSignChange", { fg = "#e7bcc3" })
hi(0, "MiniDiffSignChange_stl", { fg = "#e7bcc3" })
hi(0, "MiniDiffSignDelete", { fg = "#e274a2" })
hi(0, "MiniDiffSignDelete_stl", { fg = "#e274a2" })
hi(0, "MiniFilesBorder", { link = "FloatBorder" })
hi(0, "MiniFilesBorderModified", { link = "DiagnosticFloatingWarn" })
hi(0, "MiniFilesCursorLine", { link = "CursorLine" })
hi(0, "MiniFilesDirectory", { link = "Directory" })
hi(0, "MiniFilesFile", { fg = "#dedff3" })
hi(0, "MiniFilesNormal", { link = "NormalFloat" })
hi(0, "MiniFilesTitle", { bg = "#1d1e2f", bold = true, fg = "#a4d0c6" })
hi(0, "MiniFilesTitleFocused", { bg = "#1d1e2f", bold = true, fg = "#e7bcc3" })
hi(0, "MiniHipatternsFixme", { bg = "#e770a2", bold = true, fg = "#181821" })
hi(0, "MiniHipatternsHack", { bg = "#feb496", bold = true, fg = "#181821" })
hi(0, "MiniHipatternsNote", { bg = "#9fd0c6", bold = true, fg = "#181821" })
hi(0, "MiniHipatternsTodo", { bg = "#bdaaeb", bold = true, fg = "#181821" })
hi(0, "MiniIconsAzure", { fg = "#a4d0c6" })
hi(0, "MiniIconsBlue", { fg = "#2b787c" })
hi(0, "MiniIconsCyan", { fg = "#2b787c" })
hi(0, "MiniIconsGreen", { fg = "#a4d0c6" })
hi(0, "MiniIconsGrey", { fg = "#dedff3" })
hi(0, "MiniIconsOrange", { fg = "#feb597" })
hi(0, "MiniIconsPurple", { fg = "#bdaae6" })
hi(0, "MiniIconsRed", { fg = "#e274a2" })
hi(0, "MiniIconsYellow", { fg = "#feb597" })
hi(0, "MiniIndentscopeSymbol", { fg = "#6c6c7f" })
hi(0, "MiniIndentscopeSymbolOff", { fg = "#feb597" })
hi(0, "MiniJump", { sp = "#feb496", undercurl = true })
hi(0, "MiniJump2dDim", { fg = "#8e8ea5" })
hi(0, "MiniJump2dSpot", { bold = true, fg = "#feb597", nocombine = true })
hi(0, "MiniJump2dSpotAhead", { bg = "#1d1e2f", fg = "#a4d0c6", nocombine = true })
hi(0, "MiniJump2dSpotUnique", { bold = true, fg = "#e7bcc3", nocombine = true })
hi(0, "MiniMapNormal", { link = "NormalFloat" })
hi(0, "MiniMapSymbolCount", { link = "Special" })
hi(0, "MiniMapSymbolLine", { link = "Title" })
hi(0, "MiniMapSymbolView", { link = "Delimiter" })
hi(0, "MiniNotifyBorder", { link = "FloatBorder" })
hi(0, "MiniNotifyNormal", { link = "NormalFloat" })
hi(0, "MiniNotifyTitle", { link = "FloatTitle" })
hi(0, "MiniOperatorsExchangeFrom", { link = "IncSearch" })
hi(0, "MiniPickBorder", { link = "FloatBorder" })
hi(0, "MiniPickBorderBusy", { link = "DiagnosticFloatingWarn" })
hi(0, "MiniPickBorderText", { bg = "#1d1e2f" })
hi(0, "MiniPickHeader", { link = "DiagnosticFloatingHint" })
hi(0, "MiniPickIconDirectory", { link = "Directory" })
hi(0, "MiniPickIconFile", { link = "MiniPickNormal" })
hi(0, "MiniPickMatchCurrent", { link = "CursorLine" })
hi(0, "MiniPickMatchMarked", { link = "Visual" })
hi(0, "MiniPickMatchRanges", { fg = "#a4d0c6" })
hi(0, "MiniPickNormal", { link = "NormalFloat" })
hi(0, "MiniPickPreviewLine", { link = "CursorLine" })
hi(0, "MiniPickPreviewRegion", { link = "IncSearch" })
hi(0, "MiniPickPrompt", { bg = "#1d1e2f", bold = true })
hi(0, "MiniStarterCurrent", { nocombine = true })
hi(0, "MiniStarterFooter", { fg = "#8e8ea5" })
hi(0, "MiniStarterHeader", { link = "Title" })
hi(0, "MiniStarterInactive", { link = "Comment" })
hi(0, "MiniStarterItem", { link = "Normal" })
hi(0, "MiniStarterItemBullet", { link = "Delimiter" })
hi(0, "MiniStarterItemPrefix", { link = "WarningMsg" })
hi(0, "MiniStarterQuery", { link = "MoreMsg" })
hi(0, "MiniStarterSection", { fg = "#e7bcc3" })
hi(0, "MiniStatuslineDevinfo", { bg = "#23243b", fg = "#8e8ea5" })
hi(0, "MiniStatuslineFileinfo", { link = "MiniStatuslineDevinfo" })
hi(0, "MiniStatuslineFilename", { bg = "#1d1e2f", fg = "#6c6c7f" })
hi(0, "MiniStatuslineInactive", { link = "MiniStatuslineFilename" })
hi(0, "MiniStatuslineModeCommand", { bg = "#e770a2", bold = true, fg = "#181821" })
hi(0, "MiniStatuslineModeInsert", { bg = "#9fd0c6", bold = true, fg = "#181821" })
hi(0, "MiniStatuslineModeNormal", { bg = "#eabbc2", bold = true, fg = "#181821" })
hi(0, "MiniStatuslineModeOther", { bg = "#eabbc2", bold = true, fg = "#181821" })
hi(0, "MiniStatuslineModeReplace", { bg = "#21787d", bold = true, fg = "#181821" })
hi(0, "MiniStatuslineModeVisual", { bg = "#bdaaeb", bold = true, fg = "#181821" })
hi(0, "MiniSurround", { link = "IncSearch" })
hi(0, "MiniTablineCurrent", { bg = "#23243b", bold = true, fg = "#dedff3" })
hi(0, "MiniTablineFill", { link = "TabLineFill" })
hi(0, "MiniTablineHidden", { bg = "#1d1e2f", fg = "#8e8ea5" })
hi(0, "MiniTablineModifiedCurrent", { bg = "#dedff5", bold = true, fg = "#242538" })
hi(0, "MiniTablineModifiedHidden", { bg = "#8c8dab", fg = "#1d1f2b" })
hi(0, "MiniTablineModifiedVisible", { bg = "#dedff5", fg = "#1d1f2b" })
hi(0, "MiniTablineTabpagesection", { link = "Search" })
hi(0, "MiniTablineVisible", { bg = "#1d1e2f", fg = "#dedff3" })
hi(0, "MiniTestEmphasis", { bold = true })
hi(0, "MiniTestFail", { bold = true, fg = "#e274a2" })
hi(0, "MiniTestPass", { bold = true, fg = "#a4d0c6" })
hi(0, "MiniTrailspace", { bg = "#e770a2" })
hi(0, "ModeMsg", { fg = "#8e8ea5" })
hi(0, "ModesCopy", { bg = "#feb496" })
hi(0, "ModesDelete", { bg = "#e770a2" })
hi(0, "ModesInsert", { bg = "#9fd0c6" })
hi(0, "ModesReplace", { bg = "#21787d" })
hi(0, "ModesVisual", { bg = "#bdaaeb" })
hi(0, "MoreMsg", { fg = "#bdaae6" })
hi(0, "NavicIconsArray", { fg = "#feb597" })
hi(0, "NavicIconsBoolean", { fg = "#e7bcc3" })
hi(0, "NavicIconsClass", { fg = "#a4d0c6" })
hi(0, "NavicIconsConstant", { fg = "#feb597" })
hi(0, "NavicIconsConstructor", { fg = "#feb597" })
hi(0, "NavicIconsEnum", { fg = "#feb597" })
hi(0, "NavicIconsEnumMember", { fg = "#a4d0c6" })
hi(0, "NavicIconsEvent", { fg = "#feb597" })
hi(0, "NavicIconsField", { fg = "#a4d0c6" })
hi(0, "NavicIconsFile", { fg = "#6c6c7f" })
hi(0, "NavicIconsFunction", { fg = "#2b787c" })
hi(0, "NavicIconsInterface", { fg = "#a4d0c6" })
hi(0, "NavicIconsKey", { fg = "#bdaae6" })
hi(0, "NavicIconsKeyword", { fg = "#2b787c" })
hi(0, "NavicIconsMethod", { fg = "#bdaae6" })
hi(0, "NavicIconsModule", { fg = "#e7bcc3" })
hi(0, "NavicIconsNamespace", { fg = "#6c6c7f" })
hi(0, "NavicIconsNull", { fg = "#e274a2" })
hi(0, "NavicIconsNumber", { fg = "#feb597" })
hi(0, "NavicIconsObject", { fg = "#feb597" })
hi(0, "NavicIconsOperator", { fg = "#8e8ea5" })
hi(0, "NavicIconsPackage", { fg = "#6c6c7f" })
hi(0, "NavicIconsProperty", { fg = "#a4d0c6" })
hi(0, "NavicIconsString", { fg = "#feb597" })
hi(0, "NavicIconsStruct", { fg = "#a4d0c6" })
hi(0, "NavicIconsTypeParameter", { fg = "#a4d0c6" })
hi(0, "NavicIconsVariable", { fg = "#dedff3" })
hi(0, "NavicSeparator", { fg = "#8e8ea5" })
hi(0, "NavicText", { fg = "#8e8ea5" })
hi(0, "NeoTreeGitAdded", { fg = "#a4d0c6" })
hi(0, "NeoTreeGitConflict", { fg = "#bdaae6" })
hi(0, "NeoTreeGitDeleted", { fg = "#e274a2" })
hi(0, "NeoTreeGitIgnored", { fg = "#6c6c7f" })
hi(0, "NeoTreeGitModified", { fg = "#e7bcc3" })
hi(0, "NeoTreeGitRenamed", { fg = "#2b787c" })
hi(0, "NeoTreeGitUntracked", { fg = "#8e8ea5" })
hi(0, "NeoTreeTitleBar", { link = "StatusLineTerm" })
hi(0, "NeogitChangeAdded", { bold = true, fg = "#a4d0c6", italic = true })
hi(0, "NeogitChangeBothModified", { bold = true, fg = "#e7bcc3", italic = true })
hi(0, "NeogitChangeCopied", { bold = true, fg = "#8e8ea5", italic = true })
hi(0, "NeogitChangeDeleted", { bold = true, fg = "#e274a2", italic = true })
hi(0, "NeogitChangeModified", { bold = true, fg = "#e7bcc3", italic = true })
hi(0, "NeogitChangeNewFile", { bold = true, fg = "#bdaae6", italic = true })
hi(0, "NeogitChangeRenamed", { bold = true, fg = "#2b787c", italic = true })
hi(0, "NeogitChangeUpdated", { bold = true, fg = "#e7bcc3", italic = true })
hi(0, "NeogitDiffAddHighlight", { link = "DiffAdd" })
hi(0, "NeogitDiffContextHighlight", { bg = "#1d1e2f" })
hi(0, "NeogitDiffDeleteHighlight", { link = "DiffDelete" })
hi(0, "NeogitFilePath", { fg = "#a4d0c6", italic = true })
hi(0, "NeogitHunkHeader", { bg = "#1d1e2f" })
hi(0, "NeogitHunkHeaderHighlight", { bg = "#1d1e2f" })
hi(0, "NeorgHeading1Prefix", { link = "markdownH1Delimiter" })
hi(0, "NeorgHeading1Title", { link = "markdownH1" })
hi(0, "NeorgHeading2Prefix", { link = "markdownH2Delimiter" })
hi(0, "NeorgHeading2Title", { link = "markdownH2" })
hi(0, "NeorgHeading3Prefix", { link = "markdownH3Delimiter" })
hi(0, "NeorgHeading3Title", { link = "markdownH3" })
hi(0, "NeorgHeading4Prefix", { link = "markdownH4Delimiter" })
hi(0, "NeorgHeading4Title", { link = "markdownH4" })
hi(0, "NeorgHeading5Prefix", { link = "markdownH5Delimiter" })
hi(0, "NeorgHeading5Title", { link = "markdownH5" })
hi(0, "NeorgHeading6Prefix", { link = "markdownH6Delimiter" })
hi(0, "NeorgHeading6Title", { link = "markdownH6" })
hi(0, "NeorgMarkerTitle", { bold = true, fg = "#a4d0c6" })
hi(0, "NeotestAdapterName", { fg = "#bdaae6" })
hi(0, "NeotestBorder", { fg = "#3e3f4e" })
hi(0, "NeotestDir", { fg = "#a4d0c6" })
hi(0, "NeotestExpandMarker", { fg = "#3e3f4e" })
hi(0, "NeotestFailed", { fg = "#e274a2" })
hi(0, "NeotestFile", { fg = "#dedff3" })
hi(0, "NeotestFocused", { bg = "#3e3e53", fg = "#feb597" })
hi(0, "NeotestMarked", { bold = true, fg = "#e7bcc3" })
hi(0, "NeotestNamespace", { fg = "#feb597" })
hi(0, "NeotestPassed", { fg = "#2b787c" })
hi(0, "NeotestRunning", { fg = "#feb597" })
hi(0, "NeotestSkipped", { fg = "#8e8ea5" })
hi(0, "NeotestTarget", { fg = "#e274a2" })
hi(0, "NeotestTest", { fg = "#feb597" })
hi(0, "NeotestUnknown", { fg = "#8e8ea5" })
hi(0, "NeotestWatching", { fg = "#bdaae6" })
hi(0, "NeotestWinSelect", { fg = "#6c6c7f" })
hi(0, "NoiceCursor", { bg = "#dedff5", fg = "#505162" })
hi(0, "NonText", { fg = "#6c6c7f" })
hi(0, "Normal", { bg = "#181616", fg = "#dedff3" })
hi(0, "NormalFloat", { bg = "#1d1e2f" })
hi(0, "NormalNC", { link = "Normal" })
hi(0, "NotifyDEBUGBorder", { bg = "#1d1e2f", fg = "#6c6c7f" })
hi(0, "NotifyDEBUGIcon", { link = "NotifyDEBUGTitle" })
hi(0, "NotifyDEBUGTitle", { fg = "#6c6c7f" })
hi(0, "NotifyERRORBorder", { bg = "#1d1e2f", fg = "#e274a2" })
hi(0, "NotifyERRORIcon", { link = "NotifyERRORTitle" })
hi(0, "NotifyERRORTitle", { fg = "#e274a2" })
hi(0, "NotifyINFOBorder", { bg = "#1d1e2f", fg = "#a4d0c6" })
hi(0, "NotifyINFOIcon", { link = "NotifyINFOTitle" })
hi(0, "NotifyINFOTitle", { fg = "#a4d0c6" })
hi(0, "NotifyTRACEBorder", { bg = "#1d1e2f", fg = "#bdaae6" })
hi(0, "NotifyTRACEIcon", { link = "NotifyTRACETitle" })
hi(0, "NotifyTRACETitle", { fg = "#bdaae6" })
hi(0, "NotifyWARNBorder", { bg = "#1d1e2f", fg = "#feb597" })
hi(0, "NotifyWARNIcon", { link = "NotifyWARNTitle" })
hi(0, "NotifyWARNTitle", { fg = "#feb597" })
hi(0, "Number", { fg = "#feb597" })
hi(0, "NvimInternalError", { link = "ErrorMsg" })
hi(0, "NvimTreeEmptyFolderName", { fg = "#6c6c7f" })
hi(0, "NvimTreeFileDeleted", { fg = "#e274a2" })
hi(0, "NvimTreeFileDirty", { fg = "#e7bcc3" })
hi(0, "NvimTreeFileMerge", { fg = "#bdaae6" })
hi(0, "NvimTreeFileNew", { fg = "#a4d0c6" })
hi(0, "NvimTreeFileRenamed", { fg = "#2b787c" })
hi(0, "NvimTreeFileStaged", { fg = "#bdaae6" })
hi(0, "NvimTreeFolderIcon", { fg = "#8e8ea5" })
hi(0, "NvimTreeFolderName", { fg = "#a4d0c6" })
hi(0, "NvimTreeGitDeleted", { fg = "#e274a2" })
hi(0, "NvimTreeGitDirty", { fg = "#e7bcc3" })
hi(0, "NvimTreeGitIgnored", { fg = "#6c6c7f" })
hi(0, "NvimTreeGitMerge", { fg = "#bdaae6" })
hi(0, "NvimTreeGitNew", { fg = "#a4d0c6" })
hi(0, "NvimTreeGitRenamed", { fg = "#2b787c" })
hi(0, "NvimTreeGitStaged", { fg = "#bdaae6" })
hi(0, "NvimTreeImageFile", { fg = "#dedff3" })
hi(0, "NvimTreeNormal", { link = "Normal" })
hi(0, "NvimTreeOpenedFile", { bg = "#23243b", fg = "#dedff3" })
hi(0, "NvimTreeOpenedFolderName", { link = "NvimTreeFolderName" })
hi(0, "NvimTreeRootFolder", { bold = true, fg = "#a4d0c6" })
hi(0, "NvimTreeSpecialFile", { link = "NvimTreeNormal" })
hi(0, "NvimTreeWindowPicker", { link = "StatusLineTerm" })
hi(0, "Operator", { fg = "#8e8ea5" })
hi(0, "Pmenu", { bg = "#1d1e2f", fg = "#8e8ea5" })
hi(0, "PmenuExtra", { bg = "#1d1e2f", fg = "#6c6c7f" })
hi(0, "PmenuExtraSel", { bg = "#23243b", fg = "#8e8ea5" })
hi(0, "PmenuKind", { bg = "#1d1e2f", fg = "#a4d0c6" })
hi(0, "PmenuKindSel", { bg = "#23243b", fg = "#8e8ea5" })
hi(0, "PmenuSbar", { bg = "#1d1e2f" })
hi(0, "PmenuSel", { bg = "#23243b", fg = "#dedff3" })
hi(0, "PmenuThumb", { bg = "#6a6b87" })
hi(0, "PounceAccept", { bg = "#42293d", blend = 20, fg = "#e274a2" })
hi(0, "PounceAcceptBest", { bg = "#453838", blend = 20, fg = "#feb597" })
hi(0, "PounceGap", { link = "Search" })
hi(0, "PounceMatch", { link = "Search" })
hi(0, "PreCondit", { fg = "#bdaae6" })
hi(0, "PreProc", { link = "PreCondit" })
hi(0, "Question", { fg = "#feb597" })
hi(0, "QuickFixLine", { ctermfg = 14, fg = "#9af8e5" })
hi(0, "RedrawDebugClear", { bg = "#feb496", fg = "#181821" })
hi(0, "RedrawDebugComposed", { bg = "#21787d", fg = "#181821" })
hi(0, "RedrawDebugRecompose", { bg = "#e770a2", fg = "#181821" })
hi(0, "ReferencesCount", { fg = "#e7bcc3" })
hi(0, "ReferencesIcon", { fg = "#e7bcc3" })
hi(0, "Removed", { ctermfg = 9, fg = "#fbc0c5" })
hi(0, "Repeat", { fg = "#2b787c" })
hi(0, "SagaShadow", { bg = "#23243b" })
hi(0, "Search", { bg = "#dedff5", fg = "#181821" })
hi(0, "SignAdd", { fg = "#a4d0c6" })
hi(0, "SignChange", { fg = "#e7bcc3" })
hi(0, "SignColumn", { fg = "#dedff3" })
hi(0, "SignDelete", { fg = "#e274a2" })
hi(0, "Special", { fg = "#a4d0c6" })
hi(0, "SpecialComment", { fg = "#bdaae6" })
hi(0, "SpecialKey", { fg = "#a4d0c6" })
hi(0, "SpellBad", { sp = "#8c8dab", undercurl = true })
hi(0, "SpellCap", { sp = "#8c8dab", undercurl = true })
hi(0, "SpellLocal", { sp = "#8c8dab", undercurl = true })
hi(0, "SpellRare", { sp = "#8c8dab", undercurl = true })
hi(0, "Statement", { bold = true, fg = "#2b787c" })
hi(0, "StatusLine", { bg = "#1d1e2f", fg = "#8e8ea5" })
hi(0, "StatusLineNC", { bg = "#1b1c2b", blend = 60, fg = "#6c6c7f" })
hi(0, "StatusLineTerm", { bg = "#21787d", fg = "#181821" })
hi(0, "StatusLineTermNC", { bg = "#1c535a", blend = 60, fg = "#181821" })
hi(0, "StorageClass", { fg = "#a4d0c6" })
hi(0, "String", { fg = "#feb597" })
hi(0, "Structure", { fg = "#a4d0c6" })
hi(0, "Substitute", { link = "IncSearch" })
hi(0, "TabLine", { bg = "#1d1e2f", fg = "#8e8ea5" })
hi(0, "TabLineFill", { bg = "#1d1e2f" })
hi(0, "TabLineSel", { bg = "#23243b", bold = true, fg = "#dedff3" })
hi(0, "Tag", { fg = "#a4d0c6" })
hi(0, "TargetWord", { fg = "#bdaae6" })
hi(0, "TelescopeBorder", { bg = "#1d1e2f", fg = "#6c6c7f" })
hi(0, "TelescopeMatching", { fg = "#e7bcc3" })
hi(0, "TelescopeNormal", { link = "NormalFloat" })
hi(0, "TelescopePromptNormal", { link = "TelescopeNormal" })
hi(0, "TelescopePromptPrefix", { fg = "#8e8ea5" })
hi(0, "TelescopeSelection", { bg = "#23243b", fg = "#dedff3" })
hi(0, "TelescopeSelectionCaret", { bg = "#23243b", fg = "#e7bcc3" })
hi(0, "TelescopeTitle", { bold = true, fg = "#a4d0c6" })
hi(0, "Title", { bold = true, fg = "#a4d0c6" })
hi(0, "Todo", { bg = "#423843", blend = 20, fg = "#e7bcc3" })
hi(0, "TreesitterContext", { bg = "#23243b" })
hi(0, "TreesitterContextLineNumber", { bg = "#23243b", fg = "#e7bcc3" })
hi(0, "TroubleCount", { bg = "#1d1e2f", fg = "#bdaae6" })
hi(0, "TroubleNormal", { bg = "#1d1e2f", fg = "#dedff3" })
hi(0, "TroubleText", { fg = "#8e8ea5" })
hi(0, "Type", { fg = "#a4d0c6" })
hi(0, "Underlined", { fg = "#bdaae6", underline = true })
hi(0, "VertSplit", { fg = "#6c6c7f" })
hi(0, "VimwikiHR", { fg = "#8e8ea5" })
hi(0, "VimwikiHeader1", { link = "markdownH1" })
hi(0, "VimwikiHeader2", { link = "markdownH2" })
hi(0, "VimwikiHeader3", { link = "markdownH3" })
hi(0, "VimwikiHeader4", { link = "markdownH4" })
hi(0, "VimwikiHeader5", { link = "markdownH5" })
hi(0, "VimwikiHeader6", { link = "markdownH6" })
hi(0, "VimwikiHeaderChar", { fg = "#8e8ea5" })
hi(0, "VimwikiLink", { link = "markdownUrl" })
hi(0, "VimwikiList", { fg = "#bdaae6" })
hi(0, "VimwikiNoExistsLink", { fg = "#e274a2" })
hi(0, "Visual", { bg = "#3e3e53" })
hi(0, "WarningMsg", { bold = true, fg = "#feb597" })
hi(0, "WhichKey", { fg = "#bdaae6" })
hi(0, "WhichKeyDesc", { fg = "#feb597" })
hi(0, "WhichKeyFloat", { bg = "#1d1e2f" })
hi(0, "WhichKeyGroup", { fg = "#a4d0c6" })
hi(0, "WhichKeySeparator", { fg = "#8e8ea5" })
hi(0, "WhichKeyValue", { fg = "#e7bcc3" })
hi(0, "WildMenu", { link = "IncSearch" })
hi(0, "WinBar", { bg = "#1d1e2f", fg = "#8e8ea5" })
hi(0, "WinBarNC", { bg = "#1b1c2b", blend = 60, fg = "#6c6c7f" })
hi(0, "WinSeparator", { fg = "#6c6c7f" })
hi(0, "diffAdded", { link = "DiffAdd" })
hi(0, "diffChanged", { link = "DiffChange" })
hi(0, "diffRemoved", { link = "DiffDelete" })
hi(0, "healthError", { fg = "#e274a2" })
hi(0, "healthSuccess", { fg = "#a4d0c6" })
hi(0, "healthWarning", { fg = "#feb597" })
hi(0, "htmlArg", { fg = "#bdaae6" })
hi(0, "htmlBold", { bold = true })
hi(0, "htmlEndTag", { fg = "#8e8ea5" })
hi(0, "htmlH1", { link = "markdownH1" })
hi(0, "htmlH2", { link = "markdownH2" })
hi(0, "htmlH3", { link = "markdownH3" })
hi(0, "htmlH4", { link = "markdownH4" })
hi(0, "htmlH5", { link = "markdownH5" })
hi(0, "htmlItalic", { italic = true })
hi(0, "htmlLink", { link = "markdownUrl" })
hi(0, "htmlTag", { fg = "#8e8ea5" })
hi(0, "htmlTagN", { fg = "#dedff3" })
hi(0, "htmlTagName", { fg = "#a4d0c6" })
hi(0, "lCursor", { bg = "#dedff5", fg = "#171717" })
hi(0, "markdownDelimiter", { fg = "#8e8ea5" })
hi(0, "markdownH1", { bold = true, fg = "#bdaae6" })
hi(0, "markdownH1Delimiter", { link = "markdownH1" })
hi(0, "markdownH2", { bold = true, fg = "#a4d0c6" })
hi(0, "markdownH2Delimiter", { link = "markdownH2" })
hi(0, "markdownH3", { bold = true, fg = "#e7bcc3" })
hi(0, "markdownH3Delimiter", { link = "markdownH3" })
hi(0, "markdownH4", { bold = true, fg = "#feb597" })
hi(0, "markdownH4Delimiter", { link = "markdownH4" })
hi(0, "markdownH5", { bold = true, fg = "#2b787c" })
hi(0, "markdownH5Delimiter", { link = "markdownH5" })
hi(0, "markdownH6", { bold = true, fg = "#a4d0c6" })
hi(0, "markdownH6Delimiter", { link = "markdownH6" })
hi(0, "markdownLinkText", { link = "markdownUrl" })
hi(0, "markdownUrl", { fg = "#bdaae6", sp = "#bdaaeb", underline = true })
hi(0, "mkdCode", { fg = "#a4d0c6", italic = true })
hi(0, "mkdCodeDelimiter", { fg = "#e7bcc3" })
hi(0, "mkdCodeEnd", { fg = "#a4d0c6" })
hi(0, "mkdCodeStart", { fg = "#a4d0c6" })
hi(0, "mkdFootnotes", { fg = "#a4d0c6" })
hi(0, "mkdID", { fg = "#a4d0c6", underline = true })
hi(0, "mkdInlineURL", { link = "markdownUrl" })
hi(0, "mkdLink", { link = "markdownUrl" })
hi(0, "mkdLinkDef", { link = "markdownUrl" })
hi(0, "mkdListItemLine", { fg = "#dedff3" })
hi(0, "mkdRule", { fg = "#8e8ea5" })
hi(0, "mkdURL", { link = "markdownUrl" })

-- Terminal colors
local g = vim.g

g.terminal_color_0 = "#23243b"
g.terminal_color_1 = "#e770a2"
g.terminal_color_2 = "#21787d"
g.terminal_color_3 = "#feb496"
g.terminal_color_4 = "#9fd0c6"
g.terminal_color_5 = "#bdaaeb"
g.terminal_color_6 = "#eabbc2"
g.terminal_color_7 = "#dedff5"
g.terminal_color_8 = "#8c8dab"
g.terminal_color_9 = "#e770a2"
g.terminal_color_10 = "#21787d"
g.terminal_color_11 = "#feb496"
g.terminal_color_12 = "#9fd0c6"
g.terminal_color_13 = "#bdaaeb"
g.terminal_color_14 = "#eabbc2"
g.terminal_color_15 = "#dedff5"
