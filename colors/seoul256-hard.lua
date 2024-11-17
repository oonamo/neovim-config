-- Made with 'mini.colors' module of https://github.com/echasnovski/mini.nvim

if vim.g.colors_name ~= nil then vim.cmd('highlight clear') end
vim.g.colors_name = "seoul256-hard"

-- Highlight groups
local hi = vim.api.nvim_set_hl

hi(0, "ALEErrorSign", { bg = "#616161", ctermbg = 241, ctermfg = 161, fg = "#e12672" })
hi(0, "ALEWarningSign", { bg = "#616161", ctermbg = 241, ctermfg = 174, fg = "#e09b99" })
hi(0, "Boolean", { ctermfg = 247, fg = "#999abd" })
hi(0, "Character", { ctermfg = 174, fg = "#e09b99" })
hi(0, "CocFloating", { bg = "#4b4b4b", ctermbg = 239, ctermfg = 253, fg = "#d9d9d9" })
hi(0, "ColorColumn", { bg = "#565656", ctermbg = 240 })
hi(0, "Comment", { ctermfg = 65, fg = "#719872" })
hi(0, "Conceal", { bg = "#565656", ctermbg = 240, ctermfg = 255, fg = "#e9e9e9" })
hi(0, "Conditional", { ctermfg = 146, fg = "#98bede" })
hi(0, "Constant", { ctermfg = 73, fg = "#6fbcbd" })
hi(0, "Cursor", { bg = "#d9d9d9", ctermbg = 253, ctermfg = 241, fg = "#616161" })
hi(0, "CursorColumn", { bg = "#565656", ctermbg = 240 })
hi(0, "CursorLine", { bg = "#565656", ctermbg = 240 })
hi(0, "CursorLineNr", { bg = "#565656", bold = true, ctermbg = 240, ctermfg = 167, fg = "#be7572" })
hi(0, "Define", { ctermfg = 173, fg = "#e19972" })
hi(0, "Delimiter", { ctermfg = 137, fg = "#be9873" })
hi(0, "DiffAdd", { bg = "#006f00", ctermbg = 22 })
hi(0, "DiffChange", { ctermbg = 242 })
hi(0, "DiffDelete", { bg = "#9a7372", bold = true, ctermbg = 244 })
hi(0, "DiffText", { bg = "#730b00", ctermbg = 88 })
hi(0, "Directory", { ctermfg = 187, fg = "#dfdebd" })
hi(0, "Error", { bg = "#730b00", ctermbg = 88, ctermfg = 253, fg = "#d9d9d9" })
hi(0, "ErrorMsg", { bg = "#730b00", ctermbg = 88, ctermfg = 253, fg = "#d9d9d9" })
hi(0, "Exception", { ctermfg = 161, fg = "#e12672" })
hi(0, "ExtraWhitespace", { bg = "#565656", ctermbg = 240 })
hi(0, "Float", { ctermfg = 222, fg = "#ffde99" })
hi(0, "FoldColumn", { bg = "#6b6b6b", ctermbg = 242, ctermfg = 144, fg = "#bdbc98" })
hi(0, "Folded", { bg = "#6b6b6b", ctermbg = 242, ctermfg = 246, fg = "#999872" })
hi(0, "Function", { ctermfg = 187, fg = "#dfdebd" })
hi(0, "GitGutterAdd", { bg = "#6b6b6b", ctermbg = 242, ctermfg = 108, fg = "#98bc99" })
hi(0, "GitGutterChange", { bg = "#6b6b6b", ctermbg = 242, ctermfg = 104, fg = "#719cdf" })
hi(0, "GitGutterChangeDelete", { bg = "#6b6b6b", ctermbg = 242, ctermfg = 175, fg = "#e17899" })
hi(0, "GitGutterDelete", { bg = "#6b6b6b", ctermbg = 242, ctermfg = 161, fg = "#e12672" })
hi(0, "Identifier", { ctermfg = 217, fg = "#ffbfbd" })
hi(0, "Ignore", { bg = "#616161", ctermbg = 241, ctermfg = 242 })
hi(0, "IncSearch", { bg = "#6b6b6b", ctermbg = 242, ctermfg = 220, fg = "#ffdd00" })
hi(0, "Include", { ctermfg = 173, fg = "#e19972" })
hi(0, "IndentGuidesEven", { bg = "#6b6b6b", ctermbg = 242 })
hi(0, "IndentGuidesOdd", { bg = "#565656", ctermbg = 240 })
hi(0, "Keyword", { ctermfg = 175, fg = "#e17899" })
hi(0, "LazyBold", { bold = true })
hi(0, "LazyItalic", { italic = true })
hi(0, "LineNr", { bg = "#6b6b6b", ctermbg = 242, ctermfg = 246, fg = "#999872" })
hi(0, "Macro", { ctermfg = 173, fg = "#e19972" })
hi(0, "MatchParen", { bold = true, ctermbg = 242 })
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
hi(0, "NonText", { ctermfg = 243, fg = "#727272" })
hi(0, "Normal", { bg = "#616161", ctermbg = 241, ctermfg = 253, fg = "#d9d9d9" })
hi(0, "NormalFloat", { bg = "#565656", ctermbg = 240 })
hi(0, "Number", { ctermfg = 222, fg = "#ffde99" })
hi(0, "Operator", { ctermfg = 186, fg = "#dedd99" })
hi(0, "Pmenu", { bg = "#6b6b6b", ctermbg = 242, ctermfg = 253, fg = "#d9d9d9" })
hi(0, "PmenuSbar", { bg = "#719872", ctermbg = 65 })
hi(0, "PmenuSel", { bg = "#9a7372", blend = 0, ctermbg = 244, ctermfg = 253, fg = "#d9d9d9" })
hi(0, "PmenuThumb", { bg = "#007173", ctermbg = 23 })
hi(0, "PreCondit", { ctermfg = 173, fg = "#e19972" })
hi(0, "PreProc", { ctermfg = 143, fg = "#bdbb72" })
hi(0, "Question", { ctermfg = 179, fg = "#dfbc72" })
hi(0, "Repeat", { ctermfg = 104, fg = "#719cdf" })
hi(0, "Search", { bg = "#007299", ctermbg = 24, ctermfg = 253, fg = "#d9d9d9" })
hi(0, "SignColumn", { bg = "#616161", ctermbg = 241, ctermfg = 173, fg = "#e19972" })
hi(0, "SignifySignAdd", { bg = "#6b6b6b", ctermbg = 242, ctermfg = 108, fg = "#98bc99" })
hi(0, "SignifySignChange", { bg = "#6b6b6b", ctermbg = 242, ctermfg = 104, fg = "#719cdf" })
hi(0, "SignifySignDelete", { bg = "#6b6b6b", ctermbg = 242, ctermfg = 161, fg = "#e12672" })
hi(0, "Special", { ctermfg = 216, fg = "#ffbd98" })
hi(0, "SpecialKey", { ctermfg = 243, fg = "#727272" })
hi(0, "SpellBad", { ctermfg = 168, sp = "#ffc0b9", undercurl = true })
hi(0, "SpellCap", { ctermfg = 110, sp = "#fce094", undercurl = true })
hi(0, "SpellLocal", { ctermfg = 153, sp = "#b3f6c0", undercurl = true })
hi(0, "SpellRare", { ctermfg = 218, sp = "#8cf8f7", undercurl = true })
hi(0, "Statement", { bold = true, ctermfg = 108, fg = "#98bc99" })
hi(0, "StatusLine", { bg = "#dfdebd", ctermbg = 187, ctermfg = 244, fg = "#9a7372" })
hi(0, "StatusLineNC", { bg = "#dfdebd", ctermbg = 187, ctermfg = 243, fg = "#757575" })
hi(0, "StatusLineTerm", { bg = "#dfdebd", bold = true, ctermbg = 187, ctermfg = 244, fg = "#9a7372", reverse = true })
hi(0, "StatusLineTermNC", { bg = "#dfdebd", bold = true, ctermbg = 187, ctermfg = 243, fg = "#757575", reverse = true })
hi(0, "String", { ctermfg = 249, fg = "#98bcbd" })
hi(0, "StringDelimiter", { ctermfg = 137, fg = "#be9873" })
hi(0, "Structure", { ctermfg = 116, fg = "#97dddf" })
hi(0, "TabLine", { ctermbg = 243, ctermfg = 252, fg = "#d1d0d1" })
hi(0, "TabLineFill", { ctermfg = 243, fg = "#757575" })
hi(0, "TabLineSel", { bg = "#007173", bold = true, ctermbg = 23, ctermfg = 187, fg = "#dfdebd" })
hi(0, "Title", { bold = true, ctermfg = 251, fg = "#e0bebc" })
hi(0, "Todo", { bg = "#4b4b4b", bold = true, ctermbg = 239, ctermfg = 161, fg = "#e12672" })
hi(0, "Type", { ctermfg = 179, fg = "#dfbc72" })
hi(0, "Underlined", { ctermfg = 251, fg = "#e0bebc", underline = true })
hi(0, "VertSplit", { bg = "#4b4b4b", ctermbg = 239, ctermfg = 239, fg = "#4b4b4b" })
hi(0, "Visual", { bg = "#007173", ctermbg = 23, ctermfg = 0 })
hi(0, "VisualNOS", { bg = "#007173", ctermbg = 23 })
hi(0, "WarningMsg", { ctermfg = 179, fg = "#dfbc72" })
hi(0, "WildMenu", { bg = "#dedc00", ctermbg = 184, ctermfg = 244, fg = "#9a7372" })
hi(0, "ZenBg", { bg = "#616161", ctermbg = 241, ctermfg = 241, fg = "#616161" })
hi(0, "diffAdded", { ctermfg = 108, fg = "#98bc99" })
hi(0, "diffLine", { link = "Constant" })
hi(0, "diffRemoved", { ctermfg = 174, fg = "#e09b99" })
hi(0, "lCursor", { bg = "#d9d9d9", ctermbg = 253, ctermfg = 241, fg = "#616161" })
hi(0, "rubyArrayDelimiter", { ctermfg = 67, fg = "#7299bc" })
hi(0, "rubyBlockParameterList", { ctermfg = 186, fg = "#dedd99" })
hi(0, "rubyClass", { ctermfg = 31, fg = "#0099bd" })
hi(0, "rubyCurlyBlockDelimiter", { ctermfg = 144, fg = "#bdbc98" })
hi(0, "rubyPredefinedIdentifier", { ctermfg = 230, fg = "#ffffdf" })
hi(0, "rubyRegexp", { ctermfg = 186, fg = "#dedd99" })
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
