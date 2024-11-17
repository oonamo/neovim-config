-- Made with 'mini.colors' module of https://github.com/echasnovski/mini.nvim

if vim.g.colors_name ~= nil then vim.cmd('highlight clear') end
vim.g.colors_name = "seoul256-mix-light"

-- Highlight groups
local hi = vim.api.nvim_set_hl

hi(0, "ALEErrorSign", { bg = "#e9e9e9", ctermbg = 255, ctermfg = 161, fg = "#e12672" })
hi(0, "ALEWarningSign", { bg = "#e9e9e9", ctermbg = 255, ctermfg = 167, fg = "#be7572" })
hi(0, "Boolean", { ctermfg = 175, fg = "#e17899" })
hi(0, "Character", { ctermfg = 175, fg = "#e17899" })
hi(0, "CocFloating", { bg = "#d9d9d9", ctermbg = 253, ctermfg = 241, fg = "#616161" })
hi(0, "ColorColumn", { bg = "#d9d9d9", ctermbg = 253 })
hi(0, "Comment", { ctermfg = 65, fg = "#719872" })
hi(0, "Conceal", { bg = "#ffffff", ctermbg = 231, ctermfg = 239, fg = "#4b4b4b" })
hi(0, "Conditional", { ctermfg = 31, fg = "#0099bd" })
hi(0, "Constant", { ctermfg = 23, fg = "#007173" })
hi(0, "Cursor", { bg = "#616161", ctermbg = 241, ctermfg = 255, fg = "#e9e9e9" })
hi(0, "CursorColumn", { bg = "#e1e1e1", ctermbg = 254 })
hi(0, "CursorLine", { bg = "#e1e1e1", ctermbg = 254 })
hi(0, "CursorLineNr", { bg = "#e1e1e1", bold = true, ctermbg = 254, ctermfg = 167, fg = "#be7572" })
hi(0, "Define", { ctermfg = 167, fg = "#be7572" })
hi(0, "Delimiter", { ctermfg = 130, fg = "#9a7200" })
hi(0, "DiffAdd", { bg = "#bcddbd", ctermbg = 151 })
hi(0, "DiffChange", { bg = "#dfdfff", ctermbg = 189 })
hi(0, "DiffDelete", { bg = "#e0bebc", bold = true, ctermbg = 251 })
hi(0, "DiffText", { bg = "#ffdfdf", ctermbg = 224 })
hi(0, "Directory", { ctermfg = 244, fg = "#9a7372" })
hi(0, "Error", { bg = "#e09b99", ctermbg = 174, ctermfg = 255, fg = "#f1f1f1" })
hi(0, "ErrorMsg", { bg = "#e17899", ctermbg = 175, ctermfg = 255, fg = "#f1f1f1" })
hi(0, "Exception", { ctermfg = 161, fg = "#e12672" })
hi(0, "ExtraWhitespace", { bg = "#d9d9d9", ctermbg = 253 })
hi(0, "Float", { ctermfg = 244, fg = "#9a7372" })
hi(0, "FoldColumn", { bg = "#d9d9d9", ctermbg = 253, ctermfg = 130, fg = "#9a7200" })
hi(0, "Folded", { bg = "#d9d9d9", ctermbg = 253, ctermfg = 246, fg = "#999872" })
hi(0, "Function", { ctermfg = 94, fg = "#727100" })
hi(0, "GitGutterAdd", { bg = "#d9d9d9", ctermbg = 253, ctermfg = 65, fg = "#719872" })
hi(0, "GitGutterChange", { bg = "#d9d9d9", ctermbg = 253, ctermfg = 104, fg = "#719cdf" })
hi(0, "GitGutterChangeDelete", { bg = "#d9d9d9", ctermbg = 253, ctermfg = 175, fg = "#e17899" })
hi(0, "GitGutterDelete", { bg = "#d9d9d9", ctermbg = 253, ctermfg = 161, fg = "#e12672" })
hi(0, "Identifier", { ctermfg = 139, fg = "#9a7599" })
hi(0, "Ignore", { bg = "#e9e9e9", ctermbg = 255, ctermfg = 252, fg = "#d1d0d1" })
hi(0, "IncSearch", { bg = "#565656", ctermbg = 240, ctermfg = 220, fg = "#ffdd00" })
hi(0, "Include", { ctermfg = 167, fg = "#be7572" })
hi(0, "IndentGuidesEven", { bg = "#e1e1e1", ctermbg = 254 })
hi(0, "IndentGuidesOdd", { bg = "#f1f1f1", ctermbg = 255 })
hi(0, "Keyword", { ctermfg = 175, fg = "#e17899" })
hi(0, "LazyBold", { bold = true })
hi(0, "LazyItalic", { italic = true })
hi(0, "LineNr", { bg = "#d9d9d9", ctermbg = 253, ctermfg = 246, fg = "#999872" })
hi(0, "Macro", { ctermfg = 167, fg = "#be7572" })
hi(0, "MatchParen", { bg = "#d1d0d1", bold = true, ctermbg = 252 })
hi(0, "MiniHipatternsFixmeBody", { link = "MiniHipatternsFixme" })
hi(0, "MiniHipatternsFixmeColon", { link = "MiniHipatternsFixme" })
hi(0, "MiniHipatternsHackBody", { link = "MiniHipatternsHack" })
hi(0, "MiniHipatternsHackColon", { link = "MiniHipatternsHack" })
hi(0, "MiniHipatternsNoteBody", { link = "MiniHipatternsNote" })
hi(0, "MiniHipatternsNoteColon", { link = "MiniHipatternsNote" })
hi(0, "MiniHipatternsTodoBody", { link = "MiniHipatternsTodo" })
hi(0, "MiniHipatternsTodoColon", { link = "MiniHipatternsTodo" })
hi(0, "MiniPickCursor", { blend = 100, nocombine = true })
hi(0, "ModeMsg", { ctermfg = 173, fg = "#e19972" })
hi(0, "MoreMsg", { ctermfg = 173, fg = "#e19972" })
hi(0, "NonText", { ctermfg = 250, fg = "#bdbdbd" })
hi(0, "Normal", { bg = "#e9e9e9", ctermbg = 255, ctermfg = 241, fg = "#616161" })
hi(0, "NormalFloat", { bg = "#e1e1e1", ctermbg = 254 })
hi(0, "Number", { ctermfg = 244, fg = "#9a7372" })
hi(0, "Operator", { ctermfg = 167, fg = "#be7572" })
hi(0, "Pmenu", { bg = "#d9d9d9", ctermbg = 253, ctermfg = 241, fg = "#616161" })
hi(0, "PmenuSbar", { bg = "#719872", ctermbg = 65 })
hi(0, "PmenuSel", { bg = "#9a7372", blend = 0, ctermbg = 244, ctermfg = 253, fg = "#d9d9d9" })
hi(0, "PmenuThumb", { bg = "#007173", ctermbg = 23 })
hi(0, "PreCondit", { ctermfg = 167, fg = "#be7572" })
hi(0, "PreProc", { ctermfg = 94, fg = "#727100" })
hi(0, "Question", { ctermfg = 124, fg = "#9b1300" })
hi(0, "Repeat", { ctermfg = 67, fg = "#7299bc" })
hi(0, "Search", { bg = "#70bddf", ctermbg = 74, ctermfg = 255, fg = "#f1f1f1" })
hi(0, "SignColumn", { bg = "#e9e9e9", ctermbg = 255, ctermfg = 173, fg = "#e19972" })
hi(0, "SignifySignAdd", { bg = "#d9d9d9", ctermbg = 253, ctermfg = 65, fg = "#719872" })
hi(0, "SignifySignChange", { bg = "#d9d9d9", ctermbg = 253, ctermfg = 104, fg = "#719cdf" })
hi(0, "SignifySignDelete", { bg = "#d9d9d9", ctermbg = 253, ctermfg = 161, fg = "#e12672" })
hi(0, "Special", { ctermfg = 173, fg = "#e19972" })
hi(0, "SpecialKey", { ctermfg = 250, fg = "#bdbdbd" })
hi(0, "SpellBad", { ctermfg = 125, sp = "#590008", undercurl = true })
hi(0, "SpellCap", { ctermfg = 25, sp = "#6b5300", undercurl = true })
hi(0, "SpellLocal", { ctermfg = 31, sp = "#005523", undercurl = true })
hi(0, "SpellRare", { ctermfg = 96, sp = "#007373", undercurl = true })
hi(0, "Statement", { bold = true, ctermfg = 66, fg = "#719899" })
hi(0, "StatusLine", { bg = "#dfdebd", ctermbg = 187, ctermfg = 244, fg = "#9a7372" })
hi(0, "StatusLineNC", { bg = "#565656", ctermbg = 240, ctermfg = 253, fg = "#d9d9d9" })
hi(0, "StatusLineTerm", { bg = "#dfdebd", bold = true, ctermbg = 187, ctermfg = 244, fg = "#9a7372", reverse = true })
hi(0, "StatusLineTermNC", { bg = "#565656", bold = true, ctermbg = 240, ctermfg = 253, fg = "#d9d9d9", reverse = true })
hi(0, "String", { ctermfg = 30, fg = "#009799" })
hi(0, "StringDelimiter", { ctermfg = 130, fg = "#9a7200" })
hi(0, "Structure", { ctermfg = 23, fg = "#007173" })
hi(0, "TabLine", { bg = "#c8c8c8", ctermbg = 251, ctermfg = 242 })
hi(0, "TabLineFill", { ctermfg = 253, fg = "#d9d9d9" })
hi(0, "TabLineSel", { bg = "#719899", bold = true, ctermbg = 66, ctermfg = 187, fg = "#dfdebd" })
hi(0, "Title", { bold = true, ctermfg = 124, fg = "#9b1300" })
hi(0, "Todo", { bg = "#ffffff", bold = true, ctermbg = 231, ctermfg = 125, fg = "#bf2172" })
hi(0, "Type", { ctermfg = 130, fg = "#9a7200" })
hi(0, "Underlined", { ctermfg = 175, fg = "#e17899", underline = true })
hi(0, "VertSplit", { bg = "#d1d0d1", ctermbg = 252, ctermfg = 252, fg = "#d1d0d1" })
hi(0, "Visual", { bg = "#bcdede", ctermbg = 152, ctermfg = 15 })
hi(0, "VisualNOS", { bg = "#bcdede", ctermbg = 152 })
hi(0, "WarningMsg", { ctermfg = 124, fg = "#9b1300" })
hi(0, "WildMenu", { bg = "#dedc00", ctermbg = 184, ctermfg = 244, fg = "#9a7372" })
hi(0, "ZenBg", { bg = "#e9e9e9", ctermbg = 255, ctermfg = 255, fg = "#e9e9e9" })
hi(0, "diffAdded", { ctermfg = 65, fg = "#719872" })
hi(0, "diffLine", { link = "Constant" })
hi(0, "diffRemoved", { ctermfg = 167, fg = "#be7572" })
hi(0, "lCursor", { bg = "#616161", ctermbg = 241, ctermfg = 255, fg = "#e9e9e9" })
hi(0, "rubyArrayDelimiter", { ctermfg = 38, fg = "#00bddf" })
hi(0, "rubyBlockParameterList", { ctermfg = 130, fg = "#9a7200" })
hi(0, "rubyClass", { ctermfg = 31, fg = "#0099bd" })
hi(0, "rubyCurlyBlockDelimiter", { ctermfg = 246, fg = "#999872" })
hi(0, "rubyPredefinedIdentifier", { ctermfg = 88, fg = "#730b00" })
hi(0, "rubyRegexp", { ctermfg = 246, fg = "#999872" })
hi(0, "rubyRegexpDelimiter", { ctermfg = 175, fg = "#e17899" })

-- Terminal colors
local g = vim.g

g.terminal_color_0 = "#1f1f28"
g.terminal_color_1 = "#d8616b"
g.terminal_color_2 = "#98bb6c"
g.terminal_color_3 = "#dca561"
g.terminal_color_4 = "#7e9cd8"
g.terminal_color_5 = "#9c86bf"
g.terminal_color_6 = "#7fb4ca"
g.terminal_color_7 = "#c8c3a6"
g.terminal_color_8 = "#363646"
g.terminal_color_9 = "#d8616b"
g.terminal_color_10 = "#98bb6c"
g.terminal_color_11 = "#dca561"
g.terminal_color_12 = "#7e9cd8"
g.terminal_color_13 = "#9c86bf"
g.terminal_color_14 = "#7fb4ca"
g.terminal_color_15 = "#dcd7ba"
