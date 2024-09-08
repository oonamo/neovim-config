-- Made with 'mini.colors' module of https://github.com/echasnovski/mini.nvim

if vim.g.colors_name ~= nil then vim.cmd('highlight clear') end
vim.g.colors_name = "oh-lucy-evening-light"

-- Highlight groups
local hi = vim.api.nvim_set_hl

hi(0, "@annotation", { fg = "#5f4e00" })
hi(0, "@attribute", { fg = "#231e19" })
hi(0, "@boolean", { fg = "#47365a" })
hi(0, "@character", { fg = "#5f4e00" })
hi(0, "@character.special", { fg = "#5f4e00" })
hi(0, "@comment", { fg = "#918892", italic = true })
hi(0, "@conditional", { fg = "#82003d" })
hi(0, "@constant", { fg = "#47365a" })
hi(0, "@constant.builtin", { fg = "#47365a" })
hi(0, "@constant.macro", { fg = "#1b465b" })
hi(0, "@constructor", { fg = "#231e19" })
hi(0, "@define", { fg = "#82003d" })
hi(0, "@error", { bg = "#dad9e1", bold = true, fg = "#b33136" })
hi(0, "@exception", { fg = "#82003d" })
hi(0, "@field", { fg = "#231e19" })
hi(0, "@float", { fg = "#47365a" })
hi(0, "@function", { fg = "#005031" })
hi(0, "@function.builtin", { fg = "#005031" })
hi(0, "@function.call", { fg = "#005031" })
hi(0, "@function.macro", { fg = "#1b465b" })
hi(0, "@include", { fg = "#82003d" })
hi(0, "@keyword", { fg = "#82003d" })
hi(0, "@keyword.function", { fg = "#82003d" })
hi(0, "@keyword.operator", { fg = "#82003d" })
hi(0, "@keyword.return", { fg = "#82003d" })
hi(0, "@label", { fg = "#47365a" })
hi(0, "@method", { fg = "#005031" })
hi(0, "@method.call", { fg = "#005031" })
hi(0, "@namespace", { fg = "#1b465b" })
hi(0, "@none", { fg = "#812d3c" })
hi(0, "@number", { fg = "#47365a" })
hi(0, "@operator", { fg = "#82003d" })
hi(0, "@parameter", { fg = "#231e19" })
hi(0, "@parameter.reference", { fg = "#231e19" })
hi(0, "@preproc", { fg = "#82003d" })
hi(0, "@property", { fg = "#231e19" })
hi(0, "@punctuation.bracket", { fg = "#6c615d" })
hi(0, "@punctuation.delimiter", { fg = "#6c615d" })
hi(0, "@punctuation.special", { fg = "#6c615d" })
hi(0, "@repeat", { fg = "#82003d" })
hi(0, "@storageclass", { fg = "#1b465b" })
hi(0, "@string", { fg = "#5f4e00" })
hi(0, "@string.escape", { fg = "#563774" })
hi(0, "@string.regex", { fg = "#5f4e00" })
hi(0, "@symbol", { fg = "#231e19" })
hi(0, "@tag", { fg = "#82003d" })
hi(0, "@tag.delimiter", { fg = "#6c615d" })
hi(0, "@text", { fg = "#231e19" })
hi(0, "@text.emphasis", { italic = true })
hi(0, "@text.literal", { fg = "#5f4e00" })
hi(0, "@text.strong", { fg = "#5f4e00" })
hi(0, "@text.title", { bold = true, fg = "#231e19" })
hi(0, "@text.underline", { underline = true })
hi(0, "@text.uri", { fg = "#5f4e00", underline = true })
hi(0, "@todo", { bold = true, fg = "#812d3c" })
hi(0, "@type", { fg = "#1b465b" })
hi(0, "@type.builtin", { fg = "#82003d" })
hi(0, "@type.definition", { fg = "#82003d" })
hi(0, "@type.qualifier", { fg = "#82003d" })
hi(0, "@variable", { fg = "#231e19" })
hi(0, "@variable.builtin", { fg = "#47365a" })
hi(0, "Added", { ctermfg = 10, fg = "#003a16" })
hi(0, "Bold", { bold = true })
hi(0, "Boolean", { fg = "#563774" })
hi(0, "BufferCurrent", { bg = "#c7c3c7", fg = "#231e19" })
hi(0, "BufferCurrentIndex", { bg = "#dad9e1", fg = "#231e19" })
hi(0, "BufferCurrentMod", { bg = "#dad9e1", fg = "#5f4e00" })
hi(0, "BufferCurrentSign", { bg = "#dad9e1", fg = "#1b465b" })
hi(0, "BufferCurrentTarget", { bg = "#dad9e1", bold = true, fg = "#82003d" })
hi(0, "BufferInactive", { bg = "#dfdde5", fg = "#7e727c" })
hi(0, "BufferInactiveIndex", { bg = "#dfdde5", fg = "#7e727c" })
hi(0, "BufferInactiveMod", { bg = "#dfdde5", fg = "#5f4e00" })
hi(0, "BufferInactiveSign", { bg = "#dfdde5", fg = "#7e727c" })
hi(0, "BufferInactiveTarget", { bg = "#dfdde5", bold = true, fg = "#82003d" })
hi(0, "BufferLineBackground", { bg = "#dad9e1", fg = "#231e19" })
hi(0, "BufferLineBufferVisible", { bg = "#dad9e1", fg = "#231e19" })
hi(0, "BufferLineCloseButton", { bg = "#dad9e1", fg = "#231e19" })
hi(0, "BufferLineCloseButtonVisible", { bg = "#dad9e1", fg = "#231e19" })
hi(0, "BufferLineDuplicate", { bg = "#dad9e1", fg = "#231e19" })
hi(0, "BufferLineDuplicateVisible", { bg = "#dad9e1", fg = "#231e19" })
hi(0, "BufferLineFill", { bg = "#dfdde5", bold = true, fg = "#231e19" })
hi(0, "BufferLineModified", { bg = "#dad9e1", fg = "#231e19" })
hi(0, "BufferLineModifiedVisible", { bg = "#dad9e1", fg = "#231e19" })
hi(0, "BufferLineSeparator", { bg = "#dad9e1", fg = "#231e19" })
hi(0, "BufferLineTab", { bg = "#dad9e1", fg = "#231e19" })
hi(0, "BufferVisible", { bg = "#dad9e1", fg = "#231e19" })
hi(0, "BufferVisibleIndex", { bg = "#dad9e1", fg = "#231e19" })
hi(0, "BufferVisibleMod", { bg = "#dad9e1", fg = "#5f4e00" })
hi(0, "BufferVisibleSign", { bg = "#dad9e1", fg = "#005031" })
hi(0, "BufferVisibleTarget", { bg = "#dad9e1", bold = true, fg = "#82003d" })
hi(0, "Changed", { ctermfg = 14, fg = "#005656" })
hi(0, "Character", { fg = "#5f4e00" })
hi(0, "CmpDocumentation", { fg = "#231e19" })
hi(0, "CmpDocumentationBorder", { fg = "#7e727c" })
hi(0, "CmpItemAbbr", { fg = "#231e19" })
hi(0, "CmpItemAbbrDefault", { fg = "#231e19" })
hi(0, "CmpItemAbbrDeprecated", { fg = "#918892" })
hi(0, "CmpItemAbbrDeprecatedDefault", { fg = "#918892" })
hi(0, "CmpItemAbbrMatch", { fg = "#1b465b" })
hi(0, "CmpItemAbbrMatchDefault", { fg = "#231e19" })
hi(0, "CmpItemAbbrMatchFuzzy", { fg = "#1b465b" })
hi(0, "CmpItemAbbrMatchFuzzyDefault", { fg = "#231e19" })
hi(0, "CmpItemKind", { fg = "#005031" })
hi(0, "CmpItemKindClass", { fg = "#82003d" })
hi(0, "CmpItemKindClassDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindColorDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindConstant", { fg = "#812d3c" })
hi(0, "CmpItemKindConstantDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindConstructor", { fg = "#5f4e00" })
hi(0, "CmpItemKindConstructorDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindDefault", { fg = "#6c615d" })
hi(0, "CmpItemKindEnum", { fg = "#1b465b" })
hi(0, "CmpItemKindEnumDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindEnumMember", { fg = "#812d3c" })
hi(0, "CmpItemKindEnumMemberDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindEventDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindField", { fg = "#231e19" })
hi(0, "CmpItemKindFieldDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindFileDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindFolderDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindFunctionDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindInterfaceDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindKeyword", { fg = "#47365a" })
hi(0, "CmpItemKindKeywordDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindMethod", { fg = "#1b465b" })
hi(0, "CmpItemKindMethodDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindModuleDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindOperator", { fg = "#82003d" })
hi(0, "CmpItemKindOperatorDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindProperty", { fg = "#231e19" })
hi(0, "CmpItemKindPropertyDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindReferenceDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindSnippetDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindStruct", { fg = "#1b465b" })
hi(0, "CmpItemKindStructDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindTextDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindTypeParameterDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindUnitDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindValueDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindVariabl", { fg = "#231e19" })
hi(0, "CmpItemKindVariableDefault", { link = "CmpItemKind" })
hi(0, "CmpItemMenu", { fg = "#47365a" })
hi(0, "CmpItemMenuDefault", { fg = "#231e19" })
hi(0, "CodeActionMenuDetailsDisabled", { fg = "#918892" })
hi(0, "CodeActionMenuDetailsLabel", { fg = "#5f4e00" })
hi(0, "CodeActionMenuDetailsPreferred", { fg = "#005031" })
hi(0, "CodeActionMenuDetailsTitle", { fg = "#231e19" })
hi(0, "CodeActionMenuDetailsUndefined", { fg = "#918892" })
hi(0, "CodeActionMenuMenuDisabled", { fg = "#918892" })
hi(0, "CodeActionMenuMenuIndex", { fg = "#1b465b" })
hi(0, "CodeActionMenuMenuKind", { fg = "#005031" })
hi(0, "CodeActionMenuMenuSelection", { fg = "#1b465b" })
hi(0, "CodeActionMenuMenuTitle", { fg = "#231e19" })
hi(0, "CodeActionMenuWarningMessageBorder", { fg = "#82003d" })
hi(0, "CodeActionMenuWarningMessageText", { fg = "#753b00" })
hi(0, "ColorColumn", { bg = "#cbcbd2" })
hi(0, "Comment", { fg = "#918892", italic = true })
hi(0, "Conceal", { fg = "#231e19" })
hi(0, "Conditional", { fg = "#82003d" })
hi(0, "Constant", { fg = "#47365a" })
hi(0, "CurSearch", { bg = "#4e3c00", ctermbg = 11, ctermfg = 0, fg = "#eef1f9" })
hi(0, "Cursor", { bg = "#dad9e1", fg = "#5f4e00" })
hi(0, "CursorColumn", {})
hi(0, "CursorLine", { bg = "#cbcbd2" })
hi(0, "CursorLineNr", { bg = "#dad9e1", bold = true, fg = "#231e19" })
hi(0, "DashboardCenter", { fg = "#231e19" })
hi(0, "DashboardFooter", { fg = "#5f4e00" })
hi(0, "DashboardHeader", { fg = "#005031" })
hi(0, "Debug", { fg = "#231e19" })
hi(0, "Define", { fg = "#1b465b" })
hi(0, "Delimiter", { fg = "#6c615d" })
hi(0, "DiagnosticDeprecated", { sp = "#421311", strikethrough = true })
hi(0, "DiagnosticError", { ctermfg = 9, fg = "#b33136" })
hi(0, "DiagnosticFloatingError", { fg = "#b33136" })
hi(0, "DiagnosticFloatingHint", { fg = "#1b465b" })
hi(0, "DiagnosticFloatingInfo", { fg = "#5f4e00" })
hi(0, "DiagnosticFloatingWarn", { fg = "#753b00" })
hi(0, "DiagnosticHint", { ctermfg = 12, fg = "#1b465b" })
hi(0, "DiagnosticInfo", { ctermfg = 14, fg = "#5f4e00" })
hi(0, "DiagnosticOk", { ctermfg = 10, fg = "#003a16" })
hi(0, "DiagnosticSignError", { bg = "#dad9e1", fg = "#b33136" })
hi(0, "DiagnosticSignHint", { bg = "#dad9e1", fg = "#1b465b" })
hi(0, "DiagnosticSignInfo", { bg = "#dad9e1", fg = "#5f4e00" })
hi(0, "DiagnosticSignWarn", { bg = "#dad9e1", fg = "#753b00" })
hi(0, "DiagnosticUnderlineError", { sp = "#421311", underline = true })
hi(0, "DiagnosticUnderlineHint", { sp = "#00324c", underline = true })
hi(0, "DiagnosticUnderlineInfo", { sp = "#005656", underline = true })
hi(0, "DiagnosticUnderlineOk", { sp = "#003a16", underline = true })
hi(0, "DiagnosticUnderlineWarn", { sp = "#4e3c00", underline = true })
hi(0, "DiagnosticVirtualTextError", { fg = "#b33136" })
hi(0, "DiagnosticVirtualTextHint", { fg = "#7e727c" })
hi(0, "DiagnosticVirtualTextInfo", { fg = "#5f4e00" })
hi(0, "DiagnosticVirtualTextWarn", { fg = "#753b00" })
hi(0, "DiagnosticWarn", { ctermfg = 11, fg = "#753b00" })
hi(0, "DiffAdd", { bg = "#77bf86", ctermbg = 10, ctermfg = 0, fg = "#005031" })
hi(0, "DiffAdded", { fg = "#005031" })
hi(0, "DiffChange", { bg = "#9a9ea5", fg = "#005031" })
hi(0, "DiffDelete", { bold = true, ctermfg = 9, fg = "#82003d" })
hi(0, "DiffFile", { fg = "#47365a" })
hi(0, "DiffRemoved", { fg = "#82003d" })
hi(0, "DiffText", { bg = "#3f9b9a", ctermbg = 14, ctermfg = 0, fg = "#231e19" })
hi(0, "DiffViewNormal", { bg = "#dfdde5", fg = "#7e727c" })
hi(0, "DiffviewFilePanelDeletion", { fg = "#b33136" })
hi(0, "DiffviewFilePanelInsertion", { fg = "#085000" })
hi(0, "DiffviewStatusAdded", { fg = "#085000" })
hi(0, "DiffviewStatusDeleted", { fg = "#b33136" })
hi(0, "DiffviewStatusModified", { fg = "#0a5767" })
hi(0, "DiffviewStatusRenamed", { fg = "#0a5767" })
hi(0, "DiffviewVertSplit", { bg = "#dad9e1" })
hi(0, "Directory", { ctermfg = 14, fg = "#231e19" })
hi(0, "Error", { bg = "#dad9e1", bold = true, ctermbg = 9, ctermfg = 0, fg = "#82003d" })
hi(0, "ErrorMsg", { bg = "#b33136", bold = true, ctermfg = 9, fg = "#c7c3c7" })
hi(0, "Exception", { fg = "#231e19" })
hi(0, "Float", { fg = "#812d3c" })
hi(0, "FloatBorder", { fg = "#7e727c" })
hi(0, "FloatShadow", { bg = "#9a9ea5", blend = 80, ctermbg = 0 })
hi(0, "FloatShadowThrough", { bg = "#9a9ea5", blend = 100, ctermbg = 0 })
hi(0, "FlutterWidgetGuides", { fg = "#7e727c" })
hi(0, "FoldColumn", { bg = "#dad9e1", fg = "#a9a0a8" })
hi(0, "Folded", { bg = "#c7c3c7", fg = "#231e19" })
hi(0, "Function", { ctermfg = 14, fg = "#005031" })
hi(0, "GitGutterAdd", { fg = "#085000" })
hi(0, "GitGutterChange", { fg = "#0a5767" })
hi(0, "GitGutterDelete", { fg = "#b33136" })
hi(0, "GitSignsAdd", { bg = "#dad9e1", fg = "#005031" })
hi(0, "GitSignsChange", { bg = "#dad9e1", fg = "#0a5767" })
hi(0, "GitSignsDelete", { bg = "#dad9e1", fg = "#82003d" })
hi(0, "Identifier", { ctermfg = 12, fg = "#231e19" })
hi(0, "Ignore", { fg = "#6c615d" })
hi(0, "IncSearch", { bg = "#812d3c", fg = "#dad9e1" })
hi(0, "Include", { fg = "#1b465b" })
hi(0, "IndentBlanklineChar", { fg = "#cbcbd2" })
hi(0, "IndentBlanklineContextChar", { fg = "#7e727c" })
hi(0, "IndentBlanklineSpaceChar", { fg = "#231e19" })
hi(0, "IndentBlanklineSpaceCharBlankline", { fg = "#5f4e00" })
hi(0, "IndentGuidesEven", { fg = "#231e19" })
hi(0, "IndentGuidesOdd", { fg = "#918892" })
hi(0, "Italic", { italic = true })
hi(0, "Keyword", { fg = "#82003d" })
hi(0, "Label", { fg = "#82003d" })
hi(0, "LineNr", { bg = "#dad9e1", fg = "#a9a0a8" })
hi(0, "LspDiagnosticsDefaultError", { fg = "#b33136" })
hi(0, "LspDiagnosticsDefaultHint", { fg = "#1b465b" })
hi(0, "LspDiagnosticsDefaultInformation", { fg = "#5f4e00" })
hi(0, "LspDiagnosticsDefaultWarning", { fg = "#5f4e00" })
hi(0, "LspDiagnosticsError", { fg = "#b33136" })
hi(0, "LspDiagnosticsFloatingError", { fg = "#b33136" })
hi(0, "LspDiagnosticsFloatingHint", { fg = "#1b465b" })
hi(0, "LspDiagnosticsFloatingInformation", { fg = "#5f4e00" })
hi(0, "LspDiagnosticsFloatingWarning", { fg = "#753b00" })
hi(0, "LspDiagnosticsHint", { fg = "#1b465b" })
hi(0, "LspDiagnosticsInformation", { fg = "#5f4e00" })
hi(0, "LspDiagnosticsSignError", { fg = "#b33136" })
hi(0, "LspDiagnosticsSignHint", { fg = "#1b465b" })
hi(0, "LspDiagnosticsSignInformation", { fg = "#5f4e00" })
hi(0, "LspDiagnosticsSignWarning", { fg = "#753b00" })
hi(0, "LspDiagnosticsUnderlineError", { underline = true })
hi(0, "LspDiagnosticsUnderlineHint", { underline = true })
hi(0, "LspDiagnosticsUnderlineInformation", { underline = true })
hi(0, "LspDiagnosticsUnderlineWarning", { underline = true })
hi(0, "LspDiagnosticsVirtualTextHint", { fg = "#7e727c" })
hi(0, "LspDiagnosticsVirtualTextInformation", { fg = "#5f4e00" })
hi(0, "LspDiagnosticsVirtualTextWarning", { fg = "#753b00" })
hi(0, "LspDiagnosticsWarning", { fg = "#753b00" })
hi(0, "LspReferenceRead", { bold = true })
hi(0, "LspReferenceText", { bold = true })
hi(0, "LspReferenceWrite", { bold = true })
hi(0, "Macro", { fg = "#1b465b" })
hi(0, "MatchParen", { bg = "#dfdde5", bold = true, fg = "#231e19" })
hi(0, "MatchParenCur", { underline = true })
hi(0, "MatchWord", { underline = true })
hi(0, "MatchWordCur", { underline = true })
hi(0, "MiniDiffSignAdd_stl", { link = "StatusLine" })
hi(0, "MiniDiffSignChange_stl", { link = "StatusLine" })
hi(0, "MiniDiffSignDelete_stl", { link = "StatusLine" })
hi(0, "MiniIconsAzure", { fg = "#1b465b" })
hi(0, "MiniIconsBlue", { fg = "#3a6e96" })
hi(0, "MiniIconsCyan", { fg = "#0a5767" })
hi(0, "MiniIconsGreen", { fg = "#085000" })
hi(0, "MiniIconsGrey", { fg = "#b5b1b5" })
hi(0, "MiniIconsOrange", { fg = "#753b00" })
hi(0, "MiniIconsPurple", { fg = "#47365a" })
hi(0, "MiniIconsRed", { fg = "#b33136" })
hi(0, "MiniIconsYellow", { fg = "#5f4e00" })
hi(0, "ModeMsg", { bg = "#dad9e1", ctermfg = 10, fg = "#231e19" })
hi(0, "MoreMsg", { ctermfg = 14, fg = "#753b00" })
hi(0, "MsgArea", { bg = "#dad9e1", fg = "#231e19" })
hi(0, "MsgSeparator", { bg = "#dad9e1", fg = "#231e19" })
hi(0, "NERDTreeBookmark", { fg = "#812d3c" })
hi(0, "NERDTreeBookmarkName", { fg = "#812d3c" })
hi(0, "NERDTreeBookmarksHeader", { fg = "#82003d" })
hi(0, "NERDTreeBookmarksLeader", { fg = "#1b465b" })
hi(0, "NERDTreeCWD", { fg = "#82003d" })
hi(0, "NERDTreeClosable", { fg = "#82003d" })
hi(0, "NERDTreeCurrentNode", { fg = "#918892" })
hi(0, "NERDTreeDir", { fg = "#1b465b" })
hi(0, "NERDTreeDirSlash", { fg = "#918892" })
hi(0, "NERDTreeExecFile", { fg = "#005031" })
hi(0, "NERDTreeFile", { fg = "#231e19" })
hi(0, "NERDTreeFlags", { fg = "#82003d" })
hi(0, "NERDTreeHelpCommand", { fg = "#5f4e00" })
hi(0, "NERDTreeHelpKey", { fg = "#231e19" })
hi(0, "NERDTreeHelpTitle", { fg = "#47365a" })
hi(0, "NERDTreeIgnore", { fg = "#918892" })
hi(0, "NERDTreeLinkDir", { fg = "#47365a" })
hi(0, "NERDTreeLinkFile", { fg = "#005031" })
hi(0, "NERDTreeLinkTarget", { fg = "#1b465b" })
hi(0, "NERDTreeNodeDelimiters", { fg = "#918892" })
hi(0, "NERDTreeOpenable", { fg = "#918892" })
hi(0, "NERDTreePart", { fg = "#812d3c" })
hi(0, "NERDTreePartFile", { fg = "#1b465b" })
hi(0, "NERDTreeRO", { fg = "#812d3c" })
hi(0, "NERDTreeToggleOff", { fg = "#812d3c" })
hi(0, "NERDTreeToggleOn", { fg = "#005031" })
hi(0, "NERDTreeUp", { fg = "#5f4e00" })
hi(0, "NeogitBranch", { fg = "#47365a" })
hi(0, "NeogitDiffAdd", { bg = "#dfdde5", fg = "#085000" })
hi(0, "NeogitDiffAddHighlight", { bg = "#dfdde5", fg = "#085000" })
hi(0, "NeogitDiffContext", { bg = "#dad9e1", fg = "#383838" })
hi(0, "NeogitDiffContextHighlight", { bg = "#dad9e1", fg = "#383838" })
hi(0, "NeogitDiffDelete", { bg = "#dfdde5", fg = "#b33136" })
hi(0, "NeogitDiffDeleteHighlight", { bg = "#dfdde5", fg = "#b33136" })
hi(0, "NeogitHunkHeader", { bg = "#dfdde5", fg = "#383838" })
hi(0, "NeogitHunkHeaderHighlight", { bg = "#dfdde5", fg = "#383838" })
hi(0, "NeogitRemote", { fg = "#47365a" })
hi(0, "NonText", { fg = "#7e727c" })
hi(0, "Normal", { bg = "#dad9e1", fg = "#231e19" })
hi(0, "NormalFloat", { bg = "#dfdde5" })
hi(0, "NormalNC", { bg = "#dad9e1", fg = "#231e19" })
hi(0, "Number", { fg = "#812d3c" })
hi(0, "NvimInternalError", { bg = "#cb0000", ctermbg = 9, ctermfg = 9, fg = "#cb0000" })
hi(0, "NvimTreeCursorLine", { bg = "#cbcbd2", fg = "#a9a0a8" })
hi(0, "NvimTreeEmptyFolderName", { fg = "#5f4e00", italic = true })
hi(0, "NvimTreeEndOfBuffer", { fg = "#7e727c" })
hi(0, "NvimTreeExecFile", { fg = "#005031" })
hi(0, "NvimTreeFolderIcon", { fg = "#918892" })
hi(0, "NvimTreeFolderName", { fg = "#231e19" })
hi(0, "NvimTreeGitDeleted", { fg = "#b33136" })
hi(0, "NvimTreeGitDirty", { fg = "#085000" })
hi(0, "NvimTreeGitMerge", { fg = "#0a5767" })
hi(0, "NvimTreeGitNew", { fg = "#085000" })
hi(0, "NvimTreeGitRenamed", { fg = "#0a5767" })
hi(0, "NvimTreeGitStaged", { fg = "#085000" })
hi(0, "NvimTreeImageFile", { fg = "#47365a" })
hi(0, "NvimTreeIndentMarker", { fg = "#918892" })
hi(0, "NvimTreeNormal", { bg = "#dfdde5", fg = "#231e19" })
hi(0, "NvimTreeNormalNC", { bg = "#dfdde5" })
hi(0, "NvimTreeOpenedFolderName", { fg = "#231e19", italic = true })
hi(0, "NvimTreeRootFolder", { bold = true, fg = "#5f4e00" })
hi(0, "NvimTreeSpecialFile", { fg = "#812d3c" })
hi(0, "NvimTreeSymlink", { fg = "#5f4e00" })
hi(0, "NvimTreeVertSplit", { fg = "#dfdde5" })
hi(0, "OilChange", { bold = true })
hi(0, "OilCopy", { bold = true })
hi(0, "OilCreate", { bold = true })
hi(0, "OilDelete", { bold = true })
hi(0, "OilDir", {})
hi(0, "OilDirIcon", {})
hi(0, "OilLinkTarget", {})
hi(0, "OilMove", { bold = true })
hi(0, "Operator", { fg = "#231e19" })
hi(0, "Pmenu", { bg = "#dfdde5", fg = "#231e19" })
hi(0, "PmenuSbar", { bg = "#c7c3c7" })
hi(0, "PmenuSel", { bg = "#dfdde5", blend = 0, fg = "#a9a0a8" })
hi(0, "PmenuThumb", { bg = "#dfdde5" })
hi(0, "PreCondit", { fg = "#1b465b" })
hi(0, "PreProc", { fg = "#1b465b" })
hi(0, "Question", { ctermfg = 14, fg = "#005031" })
hi(0, "QuickFixLine", { ctermfg = 14, fg = "#753b00" })
hi(0, "RedrawDebugClear", { bg = "#b09652", ctermbg = 11, ctermfg = 0 })
hi(0, "RedrawDebugComposed", { bg = "#77bf86", ctermbg = 10, ctermfg = 0 })
hi(0, "RedrawDebugRecompose", { bg = "#ffaaa2", ctermbg = 9, ctermfg = 0 })
hi(0, "Removed", { ctermfg = 9, fg = "#421311" })
hi(0, "Repeat", { fg = "#82003d" })
hi(0, "Search", { bg = "#812d3c", ctermbg = 11, ctermfg = 0, fg = "#a9a0a8" })
hi(0, "SignColumn", { bg = "#dad9e1", fg = "#9a9ea5" })
hi(0, "Special", { ctermfg = 14, fg = "#6c615d" })
hi(0, "SpecialChar", { fg = "#5f4e00" })
hi(0, "SpecialComment", { fg = "#47365a" })
hi(0, "SpecialKey", { bold = true, fg = "#6c615d" })
hi(0, "SpellBad", { fg = "#82003d", sp = "#421311", underline = true })
hi(0, "SpellCap", { fg = "#812d3c", sp = "#4e3c00", underline = true })
hi(0, "SpellLocal", { fg = "#005031", sp = "#003a16", underline = true })
hi(0, "SpellRare", { fg = "#47365a", sp = "#005656", underline = true })
hi(0, "StartifyBracket", { fg = "#231e19" })
hi(0, "StartifyEndOfBuffer", { fg = "#7e727c" })
hi(0, "StartifyFile", { fg = "#1b465b" })
hi(0, "StartifyFooter", { fg = "#47365a" })
hi(0, "StartifyHeader", { fg = "#1b465b" })
hi(0, "StartifyNumber", { fg = "#82003d" })
hi(0, "StartifyPath", { fg = "#918892" })
hi(0, "StartifySection", { fg = "#47365a" })
hi(0, "StartifySelect", { fg = "#918892" })
hi(0, "StartifySlash", { fg = "#918892" })
hi(0, "StartifySpecial", { fg = "#5f4e00" })
hi(0, "StartifyVar", { fg = "#918892" })
hi(0, "Statement", { bold = true, fg = "#82003d" })
hi(0, "StatusLine", { bg = "#6c615d", fg = "#dfdde5" })
hi(0, "StatusLineNC", { bg = "#6c615d", fg = "#dfdde5" })
hi(0, "StatusLineSeparator", { fg = "#dfdde5" })
hi(0, "StatusLineTerm", { bg = "#dfdde5", fg = "#005031" })
hi(0, "StatusLineTermNC", { bg = "#dfdde5", fg = "#6c615d" })
hi(0, "StorageClass", { fg = "#1b465b" })
hi(0, "String", { ctermfg = 10, fg = "#5f4e00" })
hi(0, "Structure", { fg = "#005031" })
hi(0, "Substitute", { bg = "#812d3c", fg = "#7e727c" })
hi(0, "TabLine", { fg = "#a9a0a8" })
hi(0, "TabLineFill", { fg = "#a9a0a8" })
hi(0, "TabLineSel", { bold = true, fg = "#231e19" })
hi(0, "Tag", { fg = "#6c615d" })
hi(0, "TelescopeBorder", { bg = "#dad9e1", fg = "#231e19" })
hi(0, "TelescopeMatching", { fg = "#1b465b" })
hi(0, "TelescopePromptPrefix", { fg = "#005031" })
hi(0, "TelescopeSelection", { bg = "#dfdde5", fg = "#a9a0a8" })
hi(0, "TermCursor", { bg = "#424341", fg = "#231e19", reverse = true })
hi(0, "TermCursorNC", { bg = "#424341", fg = "#231e19" })
hi(0, "Title", { bold = true, fg = "#6c615d" })
hi(0, "Todo", { bold = true, fg = "#5f4e00" })
hi(0, "TroubleCode", { fg = "#753b00" })
hi(0, "TroubleCount", { fg = "#82003d" })
hi(0, "TroubleError", { bg = "#a9a0a8", fg = "#82003d" })
hi(0, "TroubleFile", { fg = "#5f4e00" })
hi(0, "TroubleFoldIcon", { fg = "#1b465b" })
hi(0, "TroubleHint", { fg = "#753b00" })
hi(0, "TroubleIndent", { fg = "#918892" })
hi(0, "TroubleInformation", { fg = "#231e19" })
hi(0, "TroubleLocation", { fg = "#231e19" })
hi(0, "TroubleNormal", { fg = "#231e19" })
hi(0, "TroublePreview", { fg = "#82003d" })
hi(0, "TroubleSignError", { fg = "#82003d" })
hi(0, "TroubleSignHint", { fg = "#005031" })
hi(0, "TroubleSignInformation", { fg = "#231e19" })
hi(0, "TroubleSignOther", { fg = "#005031" })
hi(0, "TroubleSignWarning", { fg = "#753b00" })
hi(0, "TroubleSource", { fg = "#1b465b" })
hi(0, "TroubleText", { fg = "#231e19" })
hi(0, "TroubleTextError", { fg = "#82003d" })
hi(0, "TroubleTextHint", { fg = "#231e19" })
hi(0, "TroubleTextInformation", { fg = "#1b465b" })
hi(0, "TroubleTextWarning", { fg = "#753b00" })
hi(0, "TroubleWarning", { fg = "#753b00" })
hi(0, "Type", { fg = "#1b465b" })
hi(0, "Typedef", { fg = "#1b465b" })
hi(0, "Variable", { fg = "#231e19" })
hi(0, "VertSplit", { fg = "#cec8d1" })
hi(0, "Visual", { bg = "#cbcbd2", bold = true, ctermbg = 15, ctermfg = 0 })
hi(0, "VisualNOS", { bg = "#827182", fg = "#a291a3" })
hi(0, "WarningMsg", { bg = "#dad9e1", ctermfg = 11, fg = "#753b00" })
hi(0, "WhichKey", { fg = "#1b465b" })
hi(0, "WhichKeyDesc", { fg = "#231e19" })
hi(0, "WhichKeyFloat", { bg = "#dfdde5" })
hi(0, "WhichKeyGroup", { fg = "#47365a" })
hi(0, "WhichKeySeperator", { fg = "#82003d" })
hi(0, "Whitespace", { fg = "#7e727c" })
hi(0, "WildMenu", { fg = "#231e19" })
hi(0, "WinBar", { bg = "#eef1f9", bold = true, fg = "#4f5257" })
hi(0, "WinBarNC", { bg = "#eef1f9", fg = "#4f5257" })
hi(0, "cmakeArguments", { fg = "#231e19" })
hi(0, "cmakeCommand", { fg = "#231e19" })
hi(0, "cmakeGeneratorExpressions", { fg = "#47365a" })
hi(0, "cmakeKWproject", { fg = "#47365a" })
hi(0, "cmakeKWuse_mangled_mesa", { fg = "#231e19", italic = true })
hi(0, "cmakeKWvariable_watch", { fg = "#231e19" })
hi(0, "cmakeVariable", { fg = "#231e19" })
hi(0, "debugBreakpoint", { fg = "#82003d", reverse = true })
hi(0, "debugPc", { bg = "#231e19" })
hi(0, "lCursor", { bg = "#424341", fg = "#231e19" })
hi(0, "markdownBlockquote", { fg = "#383838" })
hi(0, "markdownBold", { bold = true, fg = "#231e19" })
hi(0, "markdownCode", { fg = "#812d3c" })
hi(0, "markdownCodeBlock", { fg = "#812d3c" })
hi(0, "markdownCodeDelimiter", { fg = "#005031" })
hi(0, "markdownCodeError", { fg = "#b33136" })
hi(0, "markdownCodeSpecial", { fg = "#812d3c" })
hi(0, "markdownH1", { fg = "#231e19" })
hi(0, "markdownH2", { fg = "#231e19" })
hi(0, "markdownH3", { fg = "#231e19" })
hi(0, "markdownH4", { fg = "#231e19" })
hi(0, "markdownH5", { fg = "#231e19" })
hi(0, "markdownH6", { fg = "#231e19" })
hi(0, "markdownHeadingDelimiter", { fg = "#231e19" })
hi(0, "markdownHeadingRule", { fg = "#383838" })
hi(0, "markdownId", { fg = "#47365a" })
hi(0, "markdownIdDeclaration", { fg = "#231e19" })
hi(0, "markdownIdDelimiter", { fg = "#7e727c" })
hi(0, "markdownItalic", { italic = true })
hi(0, "markdownLinkDelimiter", { fg = "#7e727c" })
hi(0, "markdownLinkText", { fg = "#231e19" })
hi(0, "markdownListMarker", { fg = "#82003d" })
hi(0, "markdownOrderedListMarker", { fg = "#82003d" })
hi(0, "markdownRule", { fg = "#383838" })
hi(0, "markdownUrl", { fg = "#47365a", underline = true })
hi(0, "markdownUrlTitleDelimiter", { fg = "#231e19" })
hi(0, "pythonBoolean", { fg = "#231e19" })
hi(0, "pythonConditional", { fg = "#82003d" })
hi(0, "pythonException", { fg = "#47365a" })
hi(0, "pythonFunction", { fg = "#005031" })
hi(0, "pythonInclude", { fg = "#82003d" })
hi(0, "pythonOperator", { fg = "#82003d" })
hi(0, "pythonStatement", { fg = "#231e19" })

-- No terminal colors defined
