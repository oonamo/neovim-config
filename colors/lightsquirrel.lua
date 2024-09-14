-- Made with 'mini.colors' module of https://github.com/echasnovski/mini.nvim

if vim.g.colors_name ~= nil then
	vim.cmd("highlight clear")
end
vim.g.colors_name = "lightsquirrel"

-- Highlight groups
local hi = vim.api.nvim_set_hl

hi(0, "@annotation", { fg = "#895f00", italic = true })
hi(0, "@attribute", { fg = "#1a3f5e" })
hi(0, "@attribute.builtin", { link = "Special" })
hi(0, "@boolean", { fg = "#862749" })
hi(0, "@character", { fg = "#862749" })
hi(0, "@character.special", { fg = "#895f00" })
hi(0, "@class", { fg = "#1a3f5e" })
hi(0, "@comment", { fg = "#705d48", italic = true })
hi(0, "@comment.error", { link = "DiagnosticError" })
hi(0, "@comment.note", { link = "DiagnosticInfo" })
hi(0, "@comment.todo", { link = "Todo" })
hi(0, "@comment.warning", { link = "DiagnosticWarn" })
hi(0, "@conditional", { fg = "#9c0012" })
hi(0, "@constant", { fg = "#862749" })
hi(0, "@constant.builtin", { fg = "#895f00" })
hi(0, "@constant.macro", { fg = "#1a3f5e" })
hi(0, "@constructor", { fg = "#895f00" })
hi(0, "@debug", { fg = "#895f00" })
hi(0, "@decorator", { fg = "#2f5e4f" })
hi(0, "@define", { fg = "#1a3f5e" })
hi(0, "@diff.delta", { link = "Changed" })
hi(0, "@diff.minus", { link = "Removed" })
hi(0, "@diff.plus", { link = "Added" })
hi(0, "@enum", { fg = "#685200" })
hi(0, "@enumMember", { fg = "#862749" })
hi(0, "@event", { fg = "#2f5e4f" })
hi(0, "@exception", { fg = "#9c0012" })
hi(0, "@field", { fg = "#2f5e4f" })
hi(0, "@float", { fg = "#862749" })
hi(0, "@function", { fg = "#395b23" })
hi(0, "@function.builtin", { fg = "#895f00" })
hi(0, "@function.call", { fg = "#395b23" })
hi(0, "@function.macro", { fg = "#1a3f5e" })
hi(0, "@include", { fg = "#1a3f5e" })
hi(0, "@interface", { fg = "#2f5e4f" })
hi(0, "@keyword", { fg = "#9c0012" })
hi(0, "@keyword.function", { fg = "#9c0012" })
hi(0, "@keyword.operator", { fg = "#9c0012" })
hi(0, "@keyword.return", { fg = "#9c0012" })
hi(0, "@label", { fg = "#9c0012" })
hi(0, "@lsp.mod.deprecated", { link = "DiagnosticDeprecated" })
hi(0, "@lsp.type.class", { link = "@type" })
hi(0, "@lsp.type.comment", { link = "@comment" })
hi(0, "@lsp.type.decorator", { link = "@attribute" })
hi(0, "@lsp.type.enum", { link = "@type" })
hi(0, "@lsp.type.enumMember", { link = "@constant" })
hi(0, "@lsp.type.event", { link = "@type" })
hi(0, "@lsp.type.function", { link = "@function" })
hi(0, "@lsp.type.interface", { link = "@type" })
hi(0, "@lsp.type.keyword", { link = "@keyword" })
hi(0, "@lsp.type.macro", { link = "@constant.macro" })
hi(0, "@lsp.type.method", { link = "@function.method" })
hi(0, "@lsp.type.modifier", { link = "@type.qualifier" })
hi(0, "@lsp.type.namespace", { link = "@module" })
hi(0, "@lsp.type.number", { link = "@number" })
hi(0, "@lsp.type.operator", { link = "@operator" })
hi(0, "@lsp.type.parameter", { link = "@variable.parameter" })
hi(0, "@lsp.type.property", { link = "@property" })
hi(0, "@lsp.type.regexp", { link = "@string.regexp" })
hi(0, "@lsp.type.string", { link = "@string" })
hi(0, "@lsp.type.struct", { link = "@type" })
hi(0, "@lsp.type.type", { link = "@type" })
hi(0, "@lsp.type.typeParameter", { link = "@type.definition" })
hi(0, "@lsp.type.variable", { link = "@variable" })
hi(0, "@macro", { fg = "#1a3f5e" })
hi(0, "@markup.heading", { link = "Title" })
hi(0, "@method", { fg = "#395b23" })
hi(0, "@method.call", { fg = "#395b23" })
hi(0, "@modifier", { fg = "#2f5e4f" })
hi(0, "@module.builtin", { link = "Special" })
hi(0, "@namespace", { fg = "#2e2e2e" })
hi(0, "@number", { fg = "#862749" })
hi(0, "@number.float", { link = "Float" })
hi(0, "@operator", { fg = "#895f00", italic = true })
hi(0, "@parameter", { fg = "#2f5e4f" })
hi(0, "@preproc", { fg = "#1a3f5e" })
hi(0, "@property", { fg = "#2f5e4f" })
hi(0, "@punctuation", { fg = "#895f00" })
hi(0, "@punctuation.bracket", { fg = "#895f00" })
hi(0, "@punctuation.delimiter", { fg = "#895f00" })
hi(0, "@punctuation.special", { fg = "#895f00" })
hi(0, "@regexp", { fg = "#895f00" })
hi(0, "@repeat", { fg = "#9c0012" })
hi(0, "@storageclass", { fg = "#895f00" })
hi(0, "@string", { fg = "#573857", italic = true })
hi(0, "@string.escape", { fg = "#895f00" })
hi(0, "@string.regex", { fg = "#395b23", italic = true })
hi(0, "@string.regexp", { link = "@string.special" })
hi(0, "@string.special", { fg = "#895f00" })
hi(0, "@string.special.url", { link = "Underlined" })
hi(0, "@struct", { fg = "#1a3f5e" })
hi(0, "@symbol", { fg = "#2f5e4f" })
hi(0, "@tag", { fg = "#895f00" })
hi(0, "@tag.builtin", { link = "Special" })
hi(0, "@tag.delimiter", { fg = "#895f00" })
hi(0, "@text", { fg = "#2e2e2e" })
hi(0, "@text.attribute", { fg = "#2f5e4f" })
hi(0, "@text.danger", { bg = "#6e4901", bold = true, fg = "#f2f2f2" })
hi(0, "@text.diff.add", { fg = "#395b23" })
hi(0, "@text.diff.delete", { fg = "#e64d00" })
hi(0, "@text.emphasis", { italic = true })
hi(0, "@text.environment", { fg = "#1a3f5e" })
hi(0, "@text.environment.name", { fg = "#685200" })
hi(0, "@text.literal", { fg = "#395b23", italic = true })
hi(0, "@text.math", { fg = "#895f00" })
hi(0, "@text.note", { fg = "#895f00" })
hi(0, "@text.reference", { fg = "#862749" })
hi(0, "@text.strike", { strikethrough = true })
hi(0, "@text.strong", { bold = true })
hi(0, "@text.title", { fg = "#395b23" })
hi(0, "@text.todo", { bold = true, fg = "#655032", italic = true })
hi(0, "@text.todo.checked", { bold = true, fg = "#895f00", italic = true })
hi(0, "@text.todo.unchecked", { bold = true, fg = "#655032", italic = true })
hi(0, "@text.underline", { underline = true })
hi(0, "@text.uri", { fg = "#2f5e4f", underline = true })
hi(0, "@text.warning", { bold = true, fg = "#9c0012" })
hi(0, "@type", { fg = "#685200" })
hi(0, "@type.builtin", { fg = "#685200" })
hi(0, "@type.definition", { fg = "#685200" })
hi(0, "@type.qualifier", { fg = "#685200" })
hi(0, "@typeParameter", { fg = "#685200" })
hi(0, "@variable", { fg = "#2e2e2e" })
hi(0, "@variable.builtin", { fg = "#895f00" })
hi(0, "@variable.parameter.builtin", { link = "Special" })
hi(0, "Added", { ctermfg = 10, fg = "#003a16" })
hi(0, "AlphaButtons", { fg = "#1a3f5e" })
hi(0, "AlphaFooter", { fg = "#705d48", italic = true })
hi(0, "AlphaHeader", { fg = "#395b23" })
hi(0, "AlphaHeaderLabel", { fg = "#885e01" })
hi(0, "AlphaShortcut", { fg = "#885e01" })
hi(0, "Boolean", { fg = "#862749" })
hi(0, "Changed", { ctermfg = 14, fg = "#005656" })
hi(0, "Character", { fg = "#862749" })
hi(0, "CmpItemAbbrDefault", { fg = "#2e2e2e" })
hi(0, "CmpItemAbbrDeprecatedDefault", { fg = "#705d48" })
hi(0, "CmpItemAbbrMatchDefault", { fg = "#2e2e2e" })
hi(0, "CmpItemAbbrMatchFuzzyDefault", { fg = "#2e2e2e" })
hi(0, "CmpItemKindClassDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindColorDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindConstantDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindConstructorDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindDefault", { fg = "#895f00" })
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
hi(0, "CmpItemMenuDefault", { fg = "#2e2e2e" })
hi(0, "ColorColumn", { bg = "#f2f2f2" })
hi(0, "Comment", { fg = "#705d48", italic = true })
hi(0, "Conceal", { fg = "#2f5e4f" })
hi(0, "Conditional", { fg = "#9c0012" })
hi(0, "Constant", { fg = "#862749" })
hi(0, "CurSearch", { bg = "#695200", fg = "#f2f2f2" })
hi(0, "Cursor", { reverse = true })
hi(0, "CursorColumn", { bg = "#ececec" })
hi(0, "CursorLine", { bg = "#cecece", ctermfg = 15 })
hi(0, "CursorLineFold", { bg = "#f2f2f2", fg = "#705d48" })
hi(0, "CursorLineNr", { bg = "#cecece", fg = "#685200" })
hi(0, "CursorLineSign", {})
hi(0, "DapUIBreakpointsCurrentLine", { bold = true, fg = "#395b23" })
hi(0, "DapUIBreakpointsDisabledLine", { bg = "#dedede", fg = "#ceb4a5" })
hi(0, "DapUIBreakpointsInfo", { bg = "#dedede", bold = true, fg = "#395b23" })
hi(0, "DapUIBreakpointsLine", { bg = "#dedede", fg = "#1a3f5e" })
hi(0, "DapUIBreakpointsPath", { bg = "#dedede", fg = "#1a3f5e" })
hi(0, "DapUICurrentFrameName", { bold = true, fg = "#395b23" })
hi(0, "DapUIDecoration", { bg = "#dedede", fg = "#1a3f5e" })
hi(0, "DapUIFloatBorder", { bg = "#dedede", fg = "#1a3f5e" })
hi(0, "DapUIFloatNormal", { bg = "#dedede", fg = "#2e2e2e" })
hi(0, "DapUIFrameName", { fg = "#2e2e2e" })
hi(0, "DapUILineNumber", { bg = "#dedede", fg = "#1a3f5e" })
hi(0, "DapUIModifiedValue", { bold = true, fg = "#1a3f5e" })
hi(0, "DapUINormal", { bg = "#dedede", fg = "#2e2e2e" })
hi(0, "DapUIPlayPause", { bg = "#dedede", bold = true, fg = "#395b23" })
hi(0, "DapUIPlayPauseNC", { bg = "#dedede", bold = true, fg = "#395b23" })
hi(0, "DapUIRestart", { bg = "#dedede", bold = true, fg = "#395b23" })
hi(0, "DapUIRestartNC", { bg = "#dedede", bold = true, fg = "#395b23" })
hi(0, "DapUIScope", { bg = "#dedede", fg = "#1a3f5e" })
hi(0, "DapUISource", { fg = "#862749" })
hi(0, "DapUIStepBack", { bg = "#dedede", fg = "#1a3f5e" })
hi(0, "DapUIStepBackNC", { bg = "#dedede", fg = "#1a3f5e" })
hi(0, "DapUIStepInto", { bg = "#dedede", fg = "#1a3f5e" })
hi(0, "DapUIStepIntoNC", { bg = "#dedede", fg = "#1a3f5e" })
hi(0, "DapUIStepOut", { bg = "#dedede", fg = "#1a3f5e" })
hi(0, "DapUIStepOutNC", { bg = "#dedede", fg = "#1a3f5e" })
hi(0, "DapUIStepOver", { bg = "#dedede", fg = "#1a3f5e" })
hi(0, "DapUIStepOverNC", { bg = "#dedede", fg = "#1a3f5e" })
hi(0, "DapUIStop", { bg = "#dedede", fg = "#9c0012" })
hi(0, "DapUIStopNC", { bg = "#dedede", fg = "#9c0012" })
hi(0, "DapUIStoppedThread", { bg = "#dedede", fg = "#1a3f5e" })
hi(0, "DapUIThread", { bg = "#dedede", bold = true, fg = "#395b23" })
hi(0, "DapUIType", { fg = "#862749" })
hi(0, "DapUIUnavailable", { bg = "#dedede", fg = "#ceb4a5" })
hi(0, "DapUIUnavailableNC", { bg = "#dedede", fg = "#ceb4a5" })
hi(0, "DapUIValue", { fg = "#2e2e2e" })
hi(0, "DapUIVariable", { fg = "#2e2e2e" })
hi(0, "DapUIWatchesEmpty", { bg = "#dedede", fg = "#9c0012" })
hi(0, "DapUIWatchesError", { bg = "#dedede", fg = "#9c0012" })
hi(0, "DapUIWatchesValue", { bg = "#dedede", bold = true, fg = "#395b23" })
hi(0, "Debug", { fg = "#895f00" })
hi(0, "Define", { fg = "#1a3f5e" })
hi(0, "Delimiter", { fg = "#895f00" })
hi(0, "DiagnosticDeprecated", { sp = "#421311", strikethrough = true })
hi(0, "DiagnosticError", { fg = "#9c0012" })
hi(0, "DiagnosticFloatingError", { fg = "#9c0012" })
hi(0, "DiagnosticFloatingHint", { fg = "#1a3f5e" })
hi(0, "DiagnosticFloatingInfo", { fg = "#a88a73" })
hi(0, "DiagnosticFloatingOk", { fg = "#2e2e2e" })
hi(0, "DiagnosticFloatingWarn", { fg = "#685200" })
hi(0, "DiagnosticHint", { fg = "#1a3f5e" })
hi(0, "DiagnosticInfo", { fg = "#a88a73" })
hi(0, "DiagnosticOk", { fg = "#2e2e2e" })
hi(0, "DiagnosticSignError", { fg = "#9c0012" })
hi(0, "DiagnosticSignHint", { fg = "#1a3f5e" })
hi(0, "DiagnosticSignInfo", { fg = "#a88a73" })
hi(0, "DiagnosticSignOk", { fg = "#2e2e2e" })
hi(0, "DiagnosticSignWarn", { fg = "#685200" })
hi(0, "DiagnosticUnderlineError", { sp = "#9c0012", underline = true })
hi(0, "DiagnosticUnderlineHint", { sp = "#263f55", underline = true })
hi(0, "DiagnosticUnderlineInfo", { sp = "#3c5b50", underline = true })
hi(0, "DiagnosticUnderlineOk", { sp = "#405832", underline = true })
hi(0, "DiagnosticUnderlineWarn", { sp = "#685200", underline = true })
hi(0, "DiagnosticVirtualTextError", { fg = "#9c0012" })
hi(0, "DiagnosticVirtualTextHint", { fg = "#1a3f5e" })
hi(0, "DiagnosticVirtualTextInfo", { fg = "#a88a73" })
hi(0, "DiagnosticVirtualTextOk", { fg = "#2e2e2e" })
hi(0, "DiagnosticVirtualTextWarn", { fg = "#685200" })
hi(0, "DiagnosticWarn", { fg = "#685200" })
hi(0, "DiffAdd", { bg = "#b5aa8d" })
hi(0, "DiffChange", { bg = "#b5aa8d" })
hi(0, "DiffDelete", { bg = "#ccaa6f", fg = "#f2f2f2" })
hi(0, "DiffText", { fg = "#375f2b", reverse = true })
hi(0, "DiffviewDim1", { fg = "#705d48", italic = true })
hi(0, "DiffviewNormal", { bg = "#dedede", fg = "#2e2e2e" })
hi(0, "Directory", { bold = true, fg = "#2f5e4f" })
hi(0, "Done", { bold = true, fg = "#895f00", italic = true })
hi(0, "EndOfBuffer", { fg = "#cecece" })
hi(0, "Error", { bold = true, fg = "#9c0012" })
hi(0, "ErrorMsg", { bold = true, fg = "#9c0012" })
hi(0, "Exception", { fg = "#9c0012" })
hi(0, "Field", { fg = "#2f5e4f" })
hi(0, "Float", { fg = "#862749" })
hi(0, "FloatBorder", { bg = "#dedede", fg = "#be9e8a" })
hi(0, "FloatShadow", { bg = "#ececec" })
hi(0, "FloatShadowThrough", { bg = "#ececec", blend = 100 })
hi(0, "FloatTitle", { bg = "#a9a69e", bold = true, fg = "#dedede" })
hi(0, "FoldColumn", { bg = "#f2f2f2", fg = "#705d48" })
hi(0, "Folded", { bg = "#f2f2f2", fg = "#705d48", italic = true })
hi(0, "Function", { fg = "#395b23" })
hi(0, "FzfLuaBorder", { bg = "#dedede", fg = "#be9e8a" })
hi(0, "FzfLuaBufName", { fg = "#862749" })
hi(0, "FzfLuaCursor", { reverse = true })
hi(0, "FzfLuaCursorLine", { bg = "#cecece", ctermfg = 15 })
hi(0, "FzfLuaCursorLineNr", { bg = "#cecece", fg = "#685200" })
hi(0, "FzfLuaHelpBorder", { bg = "#dedede", fg = "#be9e8a" })
hi(0, "FzfLuaHelpNormal", { bg = "#dedede", fg = "#2e2e2e" })
hi(0, "FzfLuaNormal", { bg = "#dedede", fg = "#2e2e2e" })
hi(0, "FzfLuaPathColNr", { fg = "#1a3f5e" })
hi(0, "FzfLuaPathLineNr", { fg = "#395b23" })
hi(0, "FzfLuaPreviewBorder", { bg = "#f2f2f2", fg = "#be9e8a" })
hi(0, "FzfLuaPreviewNormal", { bg = "#f2f2f2", fg = "#2e2e2e" })
hi(0, "FzfLuaScrollBorderEmpty", { bg = "#dedede", fg = "#be9e8a" })
hi(0, "FzfLuaScrollBorderFull", { bg = "#dedede", fg = "#be9e8a" })
hi(0, "FzfLuaScrollFloatEmpty", { bg = "#bccaca" })
hi(0, "FzfLuaScrollFloatFull", { bg = "#bcbab5" })
hi(0, "FzfLuaSearch", { bg = "#695200", fg = "#f2f2f2" })
hi(0, "FzfLuaTitle", { bg = "#a9a69e", bold = true, fg = "#dedede" })
hi(0, "GitSignsAdd", { fg = "#759c6b" })
hi(0, "GitSignsAddInline", { reverse = true })
hi(0, "GitSignsAddLn", { bg = "#b5aa8d" })
hi(0, "GitSignsAddLnInline", { reverse = true })
hi(0, "GitSignsAddNr", { bg = "#998f73", fg = "#2e2e2e" })
hi(0, "GitSignsAddPreview", { bg = "#b5aa8d" })
hi(0, "GitSignsChange", { fg = "#375f2b" })
hi(0, "GitSignsChangeDelete", { fg = "#806e35" })
hi(0, "GitSignsChangeDeleteLn", { bg = "#e1d6b8" })
hi(0, "GitSignsChangeDeleteNr", { bg = "#7d6e48", fg = "#ceb4a5" })
hi(0, "GitSignsChangeInline", { bg = "#615227", fg = "#ececec" })
hi(0, "GitSignsChangeLn", { bg = "#b5aa8d" })
hi(0, "GitSignsChangeLnInline", { bg = "#615227", fg = "#ececec" })
hi(0, "GitSignsChangeLnVirtline", { bg = "#615227", fg = "#ececec" })
hi(0, "GitSignsChangeNr", { bg = "#615227", fg = "#ceb4a5" })
hi(0, "GitSignsCurrentLineBlame", { fg = "#be9e8a" })
hi(0, "GitSignsDelete", { fg = "#f29182" })
hi(0, "GitSignsDeleteInline", { reverse = true })
hi(0, "GitSignsDeleteLnInline", { reverse = true })
hi(0, "GitSignsDeleteNr", { bg = "#ccaa6f", fg = "#2e2e2e" })
hi(0, "GitSignsDeletePreview", { bg = "#ccaa6f", fg = "#f2f2f2" })
hi(0, "GitSignsDeleteVirtLn", { bg = "#ccaa6f", fg = "#f2f2f2" })
hi(0, "GitSignsDeleteVirtLnInLine", { reverse = true })
hi(0, "GitSignsStagedAdd", { fg = "#759c6b" })
hi(0, "GitSignsStagedAddLn", { bg = "#b5aa8d" })
hi(0, "GitSignsStagedAddNr", { bg = "#998f73", fg = "#2e2e2e" })
hi(0, "GitSignsStagedChange", { fg = "#375f2b" })
hi(0, "GitSignsStagedChangeLn", { bg = "#b5aa8d" })
hi(0, "GitSignsStagedChangeNr", { bg = "#615227", fg = "#ceb4a5" })
hi(0, "GitSignsStagedChangedelete", { fg = "#806e35" })
hi(0, "GitSignsStagedChangedeleteLn", { bg = "#e1d6b8" })
hi(0, "GitSignsStagedChangedeleteNr", { bg = "#7d6e48", fg = "#ceb4a5" })
hi(0, "GitSignsStagedDelete", { fg = "#f29182" })
hi(0, "GitSignsStagedDeleteNr", { bg = "#ccaa6f", fg = "#2e2e2e" })
hi(0, "GitSignsStagedTopdelete", { fg = "#f29182" })
hi(0, "GitSignsStagedTopdeleteNr", { bg = "#ccaa6f", fg = "#2e2e2e" })
hi(0, "GitSignsTopdelete", { fg = "#f29182" })
hi(0, "GitSignsTopdeleteNr", { bg = "#ccaa6f", fg = "#2e2e2e" })
hi(0, "GitSignsUntracked", { fg = "#862749" })
hi(0, "GitSignsUntrackedLn", { bg = "#b5aa8d" })
hi(0, "GitSignsUntrackedNr", { fg = "#862749" })
hi(0, "GruvsquirrelCursorColumnFloat", { bg = "#d9d9d9" })
hi(0, "GruvsquirrelInclinePrefix", { bold = true, fg = "#f2f2f2" })
hi(0, "Identifier", { fg = "#2f5e4f" })
hi(0, "IncSearch", { bg = "#695200", fg = "#f2f2f2" })
hi(0, "InclineNormal", { bg = "#cecece", fg = "#505050" })
hi(0, "InclineNormalNC", { bg = "#cecece", fg = "#505050" })
hi(0, "Include", { fg = "#1a3f5e" })
hi(0, "Keyword", { fg = "#9c0012" })
hi(0, "KittyScrollbackNvimPasteWinFloatBorder", { bg = "#f2f2f2", fg = "#be9e8a" })
hi(0, "KittyScrollbackNvimPasteWinFloatTitle", { bg = "#f2f2f2", fg = "#2e2e2e" })
hi(0, "KittyScrollbackNvimPasteWinNormal", { bg = "#f2f2f2", fg = "#2e2e2e" })
hi(0, "Label", { fg = "#9c0012" })
hi(0, "LineNr", { fg = "#93775e" })
hi(0, "LineNrAbove", { fg = "#93775e" })
hi(0, "LineNrBelow", { fg = "#93775e" })
hi(0, "LspCodeLens", { bg = "#dedede", fg = "#2e2e2e", italic = true })
hi(0, "LspCodeLensSeparator", { bg = "#dedede", fg = "#2e2e2e", italic = true })
hi(0, "LspInfoBorder", { bg = "#dedede", fg = "#be9e8a" })
hi(0, "LspInfoFiletype", { fg = "#895f00" })
hi(0, "LspInfoList", { fg = "#2f5e4f" })
hi(0, "LspInfoTip", { fg = "#705d48", italic = true })
hi(0, "LspInfoTitle", { fg = "#685200" })
hi(0, "LspInlayHint", { bg = "#ececec", fg = "#be9e8a", italic = true })
hi(0, "LspReferenceRead", { bg = "#bcbab5", bold = true })
hi(0, "LspReferenceText", { bg = "#bcbab5", bold = true })
hi(0, "LspReferenceWrite", { bg = "#bcbab5", bold = true })
hi(0, "LspSignatureActiveParameter", { bold = true, fg = "#395b23" })
hi(0, "Macro", { fg = "#1a3f5e" })
hi(0, "MasonError", { bold = true, fg = "#9c0012" })
hi(0, "MasonHeader", { bg = "#695200", fg = "#f2f2f2" })
hi(0, "MasonHeaderSecondary", { bg = "#695200", fg = "#f2f2f2" })
hi(0, "MasonHeading", { bold = true })
hi(0, "MasonHighlight", { fg = "#2f5e4f" })
hi(0, "MasonHighlightBlock", { bg = "#bcbab5" })
hi(0, "MasonHighlightBlockBold", { bg = "#bcbab5", bold = true })
hi(0, "MasonHighlightBlockBoldSecondary", { bg = "#695200", bold = true, fg = "#f2f2f2" })
hi(0, "MasonHighlightBlockSecondary", { bg = "#806400" })
hi(0, "MasonHighlightSecondary", { fg = "#895f00" })
hi(0, "MasonLink", { fg = "#862749" })
hi(0, "MasonMuted", { fg = "#705d48", italic = true })
hi(0, "MasonMutedBlock", { bg = "#cecece", ctermfg = 15 })
hi(0, "MasonMutedBlockBold", { bg = "#cecece", bold = true })
hi(0, "MasonNormal", { bg = "#dedede", fg = "#2e2e2e" })
hi(0, "MasonWarning", { fg = "#895f00" })
hi(0, "MatchParen", { bold = true, fg = "#655032", reverse = true })
hi(0, "MiniCursorword", { underline = true })
hi(0, "ModeMsg", { bold = true, fg = "#685200" })
hi(0, "MoreMsg", { bold = true, fg = "#685200" })
hi(0, "MsgArea", { bg = "#ececec", fg = "#2e2e2e" })
hi(0, "MsgSeparator", { bg = "#dedede", fg = "#ececec" })
hi(0, "NeoTreeBufferNumber", { fg = "#895f00" })
hi(0, "NeoTreeCursorLine", { bg = "#cecece", ctermfg = 15 })
hi(0, "NeoTreeDimText", { fg = "#705d48" })
hi(0, "NeoTreeDirectoryIcon", { fg = "#1a3f5e" })
hi(0, "NeoTreeDirectoryName", { fg = "#1a3f5e" })
hi(0, "NeoTreeDotfile", { fg = "#705d48" })
hi(0, "NeoTreeEndOfBuffer", { fg = "#cecece" })
hi(0, "NeoTreeExpander", { fg = "#705d48" })
hi(0, "NeoTreeFadeText1", { fg = "#705d48" })
hi(0, "NeoTreeFadeText2", { fg = "#a88a73" })
hi(0, "NeoTreeFileIcon", { fg = "#1a3f5e" })
hi(0, "NeoTreeFileName", { fg = "#2e2e2e" })
hi(0, "NeoTreeFileNameOpened", { bold = true, fg = "#f2f2f2" })
hi(0, "NeoTreeFilterTerm", { bg = "#dedede", bold = true, fg = "#395b23" })
hi(0, "NeoTreeFloatBorder", { bg = "#f2f2f2", fg = "#be9e8a" })
hi(0, "NeoTreeFloatNormal", { bg = "#f2f2f2", fg = "#2e2e2e" })
hi(0, "NeoTreeFloatTitle", { bg = "#a9a69e", bold = true, fg = "#dedede" })
hi(0, "NeoTreeGitAdded", { fg = "#685200" })
hi(0, "NeoTreeGitConflict", { fg = "#895f00" })
hi(0, "NeoTreeGitDeleted", { fg = "#9c0012" })
hi(0, "NeoTreeGitIgnored", { fg = "#705d48" })
hi(0, "NeoTreeGitModified", { fg = "#685200" })
hi(0, "NeoTreeGitRenamed", { fg = "#862749" })
hi(0, "NeoTreeGitStaged", { fg = "#685200" })
hi(0, "NeoTreeGitUnstaged", { fg = "#895f00" })
hi(0, "NeoTreeGitUntracked", { fg = "#895f00", italic = true })
hi(0, "NeoTreeHiddenByName", { fg = "#705d48" })
hi(0, "NeoTreeIndentMarker", { fg = "#705d48" })
hi(0, "NeoTreeMessage", { fg = "#705d48", italic = true })
hi(0, "NeoTreeModified", { fg = "#685200" })
hi(0, "NeoTreeNormal", { bg = "#dedede", fg = "#2e2e2e" })
hi(0, "NeoTreeNormalNC", { bg = "#dedede", fg = "#2e2e2e" })
hi(0, "NeoTreePreview", { bg = "#695200", fg = "#f2f2f2" })
hi(0, "NeoTreeRootName", { bold = true, fg = "#862749" })
hi(0, "NeoTreeSignColumn", { fg = "#2e2e2e" })
hi(0, "NeoTreeStatusLine", { bg = "#cecece", fg = "#676767" })
hi(0, "NeoTreeStatusLineNC", { bg = "#cecece", fg = "#676767", italic = true })
hi(0, "NeoTreeSymbolicLinkTarget", { fg = "#1a3f5e" })
hi(0, "NeoTreeTabActive", { bold = true })
hi(0, "NeoTreeTabInactive", { bg = "#dedede", fg = "#be9e8a" })
hi(0, "NeoTreeTabSeparatorActive", { fg = "#f2f2f2" })
hi(0, "NeoTreeTabSeparatorInactive", { bg = "#cecece", fg = "#be9e8a" })
hi(0, "NeoTreeTitleBar", { bg = "#dedede", fg = "#be9e8a" })
hi(0, "NeoTreeVertSplit", { bg = "#cecece", fg = "#be9e8a" })
hi(0, "NeoTreeWinSeparator", { bg = "#cecece", fg = "#be9e8a" })
hi(0, "NeoTreeWindowsHidden", { fg = "#705d48" })
hi(0, "NonText", { fg = "#be9e8a" })
-- hi(0, "Normal", { bg = "#f2f2f2", fg = "#2e2e2e" })
hi(0, "Normal", { bg = "#f9f5d7", fg = "#282828" })
hi(0, "NormalFloat", { bg = "#dedede", fg = "#2e2e2e" })
hi(0, "NormalNC", { bg = "#f2f2f2", fg = "#2e2e2e" })
hi(0, "NotifyBackground", { bg = "#dedede", fg = "#2e2e2e" })
hi(0, "NotifyDEBUGBody", { bg = "#dedede", fg = "#2e2e2e" })
hi(0, "NotifyDEBUGBorder", { bg = "#dedede", fg = "#ceb4a5" })
hi(0, "NotifyDEBUGIcon", { bg = "#dedede", fg = "#505050" })
hi(0, "NotifyDEBUGTitle", { bg = "#dedede", fg = "#505050" })
hi(0, "NotifyERRORBody", { bg = "#dedede", fg = "#2e2e2e" })
hi(0, "NotifyERRORBorder", { bg = "#dedede", fg = "#ff5b4d" })
hi(0, "NotifyERRORIcon", { bg = "#dedede", fg = "#9c0012" })
hi(0, "NotifyERRORTitle", { bg = "#dedede", fg = "#9c0012" })
hi(0, "NotifyINFOBody", { bg = "#dedede", fg = "#2e2e2e" })
hi(0, "NotifyINFOBorder", { bg = "#dedede", fg = "#9eb47c" })
hi(0, "NotifyINFOIcon", { bg = "#dedede", fg = "#395b23" })
hi(0, "NotifyINFOTitle", { bg = "#dedede", fg = "#395b23" })
hi(0, "NotifyLogTime", { bg = "#dedede", fg = "#705d48", italic = true })
hi(0, "NotifyLogTitle", { bg = "#dedede", fg = "#895f00" })
hi(0, "NotifyTRACEBody", { bg = "#dedede", fg = "#2e2e2e" })
hi(0, "NotifyTRACEBorder", { bg = "#dedede", fg = "#f29182" })
hi(0, "NotifyTRACEIcon", { bg = "#dedede", fg = "#862749" })
hi(0, "NotifyTRACETitle", { bg = "#dedede", fg = "#862749" })
hi(0, "NotifyWARNBody", { bg = "#dedede", fg = "#2e2e2e" })
hi(0, "NotifyWARNBorder", { bg = "#dedede", fg = "#eed2a6" })
hi(0, "NotifyWARNIcon", { bg = "#dedede", fg = "#895f00" })
hi(0, "NotifyWARNTitle", { bg = "#dedede", fg = "#895f00" })
hi(0, "NullLsInfoBorder", { bg = "#dedede", fg = "#be9e8a" })
hi(0, "NullLsInfoHeader", { fg = "#685200" })
hi(0, "NullLsInfoSources", { fg = "#895f00" })
hi(0, "NullLsInfoTitle", { fg = "#2f5e4f" })
hi(0, "Number", { fg = "#862749" })
hi(0, "NvimInternalError", { bg = "#8d6301", ctermbg = 9, ctermfg = 9, fg = "#cb0000" })
hi(0, "NvimTreeBookmark", { fg = "#862749" })
hi(0, "NvimTreeClosedFolderIcon", { fg = "#1a3f5e" })
hi(0, "NvimTreeCursorColumn", { bg = "#ececec" })
hi(0, "NvimTreeCursorLine", { bg = "#cecece", ctermfg = 15 })
hi(0, "NvimTreeCursorLineNr", { bg = "#cecece", fg = "#685200" })
hi(0, "NvimTreeEmptyFolderName", { bold = true, fg = "#2f5e4f" })
hi(0, "NvimTreeEndOfBuffer", { fg = "#cecece" })
hi(0, "NvimTreeExecFile", { bold = true, fg = "#395b23" })
hi(0, "NvimTreeFileDeleted", { fg = "#9c0012" })
hi(0, "NvimTreeFileDirty", { fg = "#685200" })
hi(0, "NvimTreeFileIcon", { fg = "#2e2e2e" })
hi(0, "NvimTreeFileIgnored", { fg = "#705d48", italic = true })
hi(0, "NvimTreeFileMerge", { fg = "#862749" })
hi(0, "NvimTreeFileNew", { fg = "#685200" })
hi(0, "NvimTreeFileRenamed", { fg = "#862749" })
hi(0, "NvimTreeFileStaged", { fg = "#685200" })
hi(0, "NvimTreeFolderIcon", { fg = "#1a3f5e" })
hi(0, "NvimTreeFolderName", { fg = "#1a3f5e" })
hi(0, "NvimTreeGitDeleted", { fg = "#9c0012" })
hi(0, "NvimTreeGitDirty", { fg = "#685200" })
hi(0, "NvimTreeGitIgnored", { fg = "#705d48", italic = true })
hi(0, "NvimTreeGitMerge", { fg = "#862749" })
hi(0, "NvimTreeGitNew", { fg = "#685200" })
hi(0, "NvimTreeGitRenamed", { fg = "#862749" })
hi(0, "NvimTreeGitStaged", { fg = "#685200" })
hi(0, "NvimTreeImageFile", { fg = "#862749" })
hi(0, "NvimTreeIndentMarker", { fg = "#a88a73" })
hi(0, "NvimTreeLineNr", { fg = "#2e2e2e" })
hi(0, "NvimTreeLiveFilterPrefix", { bold = true, fg = "#1a3f5e" })
hi(0, "NvimTreeLiveFilterValue", { bold = true })
hi(0, "NvimTreeLspDiagnosticsError", { fg = "#9c0012" })
hi(0, "NvimTreeLspDiagnosticsHint", { fg = "#1a3f5e" })
hi(0, "NvimTreeLspDiagnosticsInformation", { fg = "#2f5e4f" })
hi(0, "NvimTreeLspDiagnosticsWarning", { fg = "#685200" })
hi(0, "NvimTreeNormal", { bg = "#dedede", fg = "#2e2e2e" })
hi(0, "NvimTreeNormalNC", { bg = "#dedede", fg = "#2e2e2e" })
hi(0, "NvimTreeOpenedFile", { bold = true, fg = "#f2f2f2" })
hi(0, "NvimTreeOpenedFolderIcon", { fg = "#1a3f5e" })
hi(0, "NvimTreeOpenedFolderName", { bold = true, fg = "#2f5e4f" })
hi(0, "NvimTreePopup", { bg = "#dedede", fg = "#2e2e2e" })
hi(0, "NvimTreeRootFolder", { bold = true, fg = "#862749" })
hi(0, "NvimTreeSignColumn", { fg = "#2e2e2e" })
hi(0, "NvimTreeSpecialFile", { bold = true, fg = "#895f00", underline = true })
hi(0, "NvimTreeStatusLine", { bg = "#cecece", fg = "#676767" })
hi(0, "NvimTreeStatusLineNC", { bg = "#cecece", fg = "#676767", italic = true })
hi(0, "NvimTreeSymlink", { fg = "#1a3f5e" })
hi(0, "NvimTreeVertSplit", { bg = "#cecece", fg = "#be9e8a" })
hi(0, "NvimTreeWinSeparator", { bg = "#cecece", fg = "#be9e8a" })
hi(0, "NvimTreeWindowPicker", { bg = "#ececec", bold = true, fg = "#395b23" })
hi(0, "Operator", { fg = "#895f00", italic = true })
hi(0, "Pmenu", { bg = "#dedede", fg = "#2e2e2e" })
hi(0, "PmenuSbar", { bg = "#dedede" })
hi(0, "PmenuSel", { bg = "#bccaca" })
hi(0, "PmenuThumb", { bg = "#bcbab5" })
hi(0, "PreProc", { fg = "#1a3f5e" })
hi(0, "Property", { fg = "#2f5e4f" })
hi(0, "Question", { bold = true, fg = "#685200" })
hi(0, "QuickFixLine", { bg = "#bccaca" })
hi(0, "RedrawDebugClear", { bg = "#af9652", ctermbg = 11, ctermfg = 0 })
hi(0, "RedrawDebugComposed", { bg = "#bcad56", ctermbg = 10, ctermfg = 0 })
hi(0, "RedrawDebugRecompose", { bg = "#eabb77", ctermbg = 9, ctermfg = 0 })
hi(0, "Removed", { ctermfg = 9, fg = "#490809" })
hi(0, "Repeat", { fg = "#9c0012" })
hi(0, "Search", { bg = "#283010", fg = "#f2f2f2" })
hi(0, "SignColumn", {})
hi(0, "Special", { fg = "#895f00" })
hi(0, "SpecialChar", { fg = "#895f00" })
hi(0, "SpecialComment", { fg = "#895f00" })
hi(0, "SpecialKey", { bg = "#dedede", bold = true, fg = "#395b23" })
hi(0, "SpellBad", { sp = "#9c0012", undercurl = true })
hi(0, "SpellCap", { sp = "#263f55", undercurl = true })
hi(0, "SpellLocal", { sp = "#003a16", undercurl = true })
hi(0, "SpellRare", { sp = "#c36ea1", undercurl = true })
hi(0, "Statement", { fg = "#2f5e4f" })
hi(0, "StatusLine", { bg = "#cecece", fg = "#676767" })
hi(0, "StatusLineNC", { bg = "#cecece", fg = "#676767", italic = true })
hi(0, "StorageClass", { fg = "#895f00" })
hi(0, "String", { fg = "#573857", italic = true })
hi(0, "Structure", { fg = "#1a3f5e" })
hi(0, "Substitute", { bg = "#283010", fg = "#f2f2f2" })
hi(0, "TabLine", { bg = "#dedede", bold = true, fg = "#676767" })
hi(0, "TabLineFill", { bg = "#dedede" })
hi(0, "TabLineSel", { fg = "#505050" })
hi(0, "Tag", { fg = "#895f00" })
hi(0, "TelescopeBorder", { bg = "#dedede", fg = "#be9e8a" })
hi(0, "TelescopeMatching", { bg = "#283010", fg = "#f2f2f2" })
hi(0, "TelescopeMultiIcon", { fg = "#862749" })
hi(0, "TelescopeMultiSelection", { fg = "#705d48" })
hi(0, "TelescopeNormal", { bg = "#dedede", fg = "#2e2e2e" })
hi(0, "TelescopePreviewBorder", { bg = "#f2f2f2", fg = "#be9e8a" })
hi(0, "TelescopePreviewLine", { bg = "#cecece", ctermfg = 15 })
hi(0, "TelescopePreviewMatch", { bg = "#283010", fg = "#f2f2f2" })
hi(0, "TelescopePreviewNormal", { bg = "#f2f2f2", fg = "#2e2e2e" })
hi(0, "TelescopePreviewTitle", { bg = "#a9a69e", bold = true, fg = "#dedede" })
hi(0, "TelescopePromptBorder", { bg = "#dedede", fg = "#be9e8a" })
hi(0, "TelescopePromptCounter", { fg = "#395b23" })
hi(0, "TelescopePromptNormal", { bg = "#dedede", fg = "#2e2e2e" })
hi(0, "TelescopePromptPrefix", { fg = "#1a3f5e" })
hi(0, "TelescopePromptTitle", { bg = "#a9a69e", bold = true, fg = "#dedede" })
hi(0, "TelescopeResultsBorder", { bg = "#dedede", fg = "#be9e8a" })
hi(0, "TelescopeResultsClass", { fg = "#395b23" })
hi(0, "TelescopeResultsComment", { fg = "#705d48", italic = true })
hi(0, "TelescopeResultsConstant", { fg = "#862749" })
hi(0, "TelescopeResultsDiffAdd", { bg = "#b5aa8d" })
hi(0, "TelescopeResultsDiffChange", { bg = "#b5aa8d" })
hi(0, "TelescopeResultsDiffDelete", { bg = "#ccaa6f", fg = "#f2f2f2" })
hi(0, "TelescopeResultsDiffUntracked", { fg = "#862749" })
hi(0, "TelescopeResultsField", { fg = "#395b23" })
hi(0, "TelescopeResultsFunction", { fg = "#395b23" })
hi(0, "TelescopeResultsIdentifier", { fg = "#2f5e4f" })
hi(0, "TelescopeResultsLineNr", { fg = "#93775e" })
hi(0, "TelescopeResultsMethod", { fg = "#862749" })
hi(0, "TelescopeResultsNormal", { bg = "#dedede", fg = "#2e2e2e" })
hi(0, "TelescopeResultsNumber", { fg = "#862749" })
hi(0, "TelescopeResultsOperator", { fg = "#895f00", italic = true })
hi(0, "TelescopeResultsSpecialComment", { fg = "#895f00" })
hi(0, "TelescopeResultsStruct", { fg = "#1a3f5e" })
hi(0, "TelescopeResultsTitle", { bg = "#a9a69e", bold = true, fg = "#dedede" })
hi(0, "TelescopeResultsVariable", { fg = "#895f00" })
hi(0, "TelescopeSelection", { bg = "#bcbab5" })
hi(0, "TelescopeSelectionCaret", { fg = "#9c0012" })
hi(0, "TelescopeTitle", { bg = "#a9a69e", bold = true, fg = "#dedede" })
hi(0, "Title", { fg = "#395b23" })
hi(0, "Todo", { bold = true, fg = "#655032", italic = true })
hi(0, "Type", { fg = "#685200" })
hi(0, "Typedef", { fg = "#685200" })
hi(0, "Underlined", { fg = "#2f5e4f", underline = true })
hi(0, "UndotreeBranch", { fg = "#862749" })
hi(0, "UndotreeFirstNode", { fg = "#395b23" })
hi(0, "UndotreeHead", { fg = "#2f5e4f" })
hi(0, "UndotreeHelp", { fg = "#705d48", italic = true })
hi(0, "UndotreeHelpKey", { fg = "#395b23" })
hi(0, "UndotreeHelpTitle", { fg = "#685200" })
hi(0, "UndotreeNext", { fg = "#685200" })
hi(0, "UndotreeNode", { bold = true, fg = "#685200" })
hi(0, "UndotreeNodeCurrent", { fg = "#2f5e4f" })
hi(0, "UndotreeSavedBig", { bold = true, fg = "#655032", reverse = true })
hi(0, "UndotreeSavedSmall", { bold = true, fg = "#9c0012" })
hi(0, "UndotreeSeq", { fg = "#705d48", italic = true })
hi(0, "UndotreeTimeStamp", { fg = "#395b23" })
hi(0, "Variable", { fg = "#2e2e2e" })
hi(0, "VertSplit", { bg = "#cecece", fg = "#be9e8a" })
hi(0, "Visual", { bg = "#bcbab5" })
hi(0, "VisualNOS", { bg = "#bcbab5" })
hi(0, "WarningMsg", { fg = "#895f00" })
hi(0, "Whitespace", { fg = "#be9e8a" })
hi(0, "WildMenu", { bg = "#bccaca" })
hi(0, "WinBar", { bg = "#dedede", bold = true, fg = "#676767" })
hi(0, "WinBarNC", { bg = "#dedede", fg = "#505050" })
hi(0, "WinSeparator", { bg = "#cecece", fg = "#be9e8a" })
hi(0, "ZenBg", { bg = "#dedede" })
hi(0, "diffAdded", { fg = "#395b23" })
hi(0, "diffBDiffer", { fg = "#862749" })
hi(0, "diffChanged", { fg = "#1a3f5e" })
hi(0, "diffComment", { fg = "#705d48", italic = true })
hi(0, "diffCommon", { fg = "#862749" })
hi(0, "diffDiffer", { fg = "#862749" })
hi(0, "diffFile", { fg = "#395b23" })
hi(0, "diffIdentical", { fg = "#862749" })
hi(0, "diffIndexLine", { fg = "#862749" })
hi(0, "diffIsA", { fg = "#862749" })
hi(0, "diffLine", { fg = "#1a3f5e" })
hi(0, "diffNewFile", { fg = "#395b23" })
hi(0, "diffNoEOL", { fg = "#862749" })
hi(0, "diffOldFile", { fg = "#e64d00" })
hi(0, "diffOnly", { fg = "#862749" })
hi(0, "diffRemoved", { fg = "#e64d00" })
hi(0, "diffSubname", { fg = "#1a3f5e" })
hi(0, "gitcommitArrow", { fg = "#705d48", italic = true })
hi(0, "gitcommitBlank", { bg = "#6e4901", bold = true, fg = "#f2f2f2" })
hi(0, "gitcommitBranch", { fg = "#862749" })
hi(0, "gitcommitComment", { fg = "#705d48", italic = true })
hi(0, "gitcommitDiscardedArrow", { fg = "#705d48", italic = true })
hi(0, "gitcommitDiscardedFile", { fg = "#2f5e4f", underline = true })
hi(0, "gitcommitDiscardedType", { fg = "#9c0012" })
hi(0, "gitcommitFile", { fg = "#2f5e4f", underline = true })
hi(0, "gitcommitHash", { fg = "#2f5e4f" })
hi(0, "gitcommitHeader", { fg = "#395b23" })
hi(0, "gitcommitNoBranch", { fg = "#895f00" })
hi(0, "gitcommitNoChanges", { fg = "#1a3f5e" })
hi(0, "gitcommitOnBranch", { fg = "#705d48", italic = true })
hi(0, "gitcommitSelectedArrow", { fg = "#705d48", italic = true })
hi(0, "gitcommitSelectedFile", { fg = "#2f5e4f", underline = true })
hi(0, "gitcommitSelectedType", { fg = "#9c0012" })
hi(0, "gitcommitSummary", { fg = "#9c0012" })
hi(0, "gitcommitTrailerToken", { fg = "#9c0012" })
hi(0, "gitcommitType", { fg = "#9c0012" })
hi(0, "gitcommitUnmergedArrow", { fg = "#705d48", italic = true })
hi(0, "gitcommitUnmergedFile", { fg = "#2f5e4f", underline = true })
hi(0, "gitcommitUnmergedType", { fg = "#9c0012" })
hi(0, "gitcommitUntrackedFile", { fg = "#2f5e4f", underline = true })
hi(0, "lCursor", { reverse = true })
hi(0, "netrwBak", { bg = "#f2f2f2", fg = "#705d48", italic = true })
hi(0, "netrwClassify", { fg = "#395b23" })
hi(0, "netrwCmdSep", { fg = "#895f00" })
hi(0, "netrwComma", { fg = "#705d48", italic = true })
hi(0, "netrwComment", { fg = "#705d48", italic = true })
hi(0, "netrwCompress", { bg = "#f2f2f2", fg = "#705d48", italic = true })
hi(0, "netrwCoreDump", { bold = true, fg = "#9c0012" })
hi(0, "netrwData", { bg = "#f2f2f2", fg = "#705d48", italic = true })
hi(0, "netrwDateSep", { fg = "#895f00" })
hi(0, "netrwDir", { bold = true, fg = "#2f5e4f" })
hi(0, "netrwExe", { fg = "#1a3f5e" })
hi(0, "netrwGray", { bg = "#f2f2f2", fg = "#705d48", italic = true })
hi(0, "netrwHdr", { bg = "#f2f2f2", fg = "#2e2e2e" })
hi(0, "netrwHelpCmd", { fg = "#395b23" })
hi(0, "netrwHide", { fg = "#705d48", italic = true })
hi(0, "netrwHidePat", { fg = "#2f5e4f" })
hi(0, "netrwHideSep", { fg = "#705d48", italic = true })
hi(0, "netrwLex", { bg = "#f2f2f2", fg = "#2e2e2e" })
hi(0, "netrwLib", { bg = "#b5aa8d" })
hi(0, "netrwLink", { fg = "#895f00" })
hi(0, "netrwList", { fg = "#2f5e4f" })
hi(0, "netrwMakefile", { bg = "#b5aa8d" })
hi(0, "netrwMarkFile", { bg = "#dedede", bold = true, fg = "#676767" })
hi(0, "netrwObj", { bg = "#f2f2f2", fg = "#705d48", italic = true })
hi(0, "netrwPix", { fg = "#895f00" })
hi(0, "netrwPlain", { bg = "#f2f2f2", fg = "#2e2e2e" })
hi(0, "netrwQHTopic", { fg = "#862749" })
hi(0, "netrwSpecFile", { bg = "#f2f2f2", fg = "#705d48", italic = true })
hi(0, "netrwSymLink", { bold = true, fg = "#685200" })
hi(0, "netrwTags", { bg = "#f2f2f2", fg = "#705d48", italic = true })
hi(0, "netrwTilde", { bg = "#f2f2f2", fg = "#705d48", italic = true })
hi(0, "netrwTimeSep", { fg = "#895f00" })
hi(0, "netrwTmp", { bg = "#f2f2f2", fg = "#705d48", italic = true })
hi(0, "netrwTreeBar", { fg = "#895f00" })
hi(0, "netrwVersion", { fg = "#2f5e4f" })
hi(0, "netrwYacc", { bg = "#f2f2f2", fg = "#2e2e2e" })

-- Terminal colors
local g = vim.g

g.terminal_color_0 = "#f2f2f2"
g.terminal_color_1 = "#9c0012"
g.terminal_color_2 = "#405832"
g.terminal_color_3 = "#685200"
g.terminal_color_4 = "#3c5b50"
g.terminal_color_5 = "#7a364b"
g.terminal_color_6 = "#263f55"
g.terminal_color_7 = "#2e2e2e"
g.terminal_color_8 = "#685f55"
g.terminal_color_9 = "#d65e33"
g.terminal_color_10 = "#005c45"
g.terminal_color_11 = "#5e3100"
g.terminal_color_12 = "#194290"
g.terminal_color_13 = "#524ad0"
g.terminal_color_14 = "#006868"
g.terminal_color_15 = "#636175"