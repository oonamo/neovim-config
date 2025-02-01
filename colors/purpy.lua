-- COLOR
-- created on https://nvimcolors.com

-- Clear existing highlights and reset syntax
vim.cmd('highlight clear')
vim.cmd('syntax reset')

-- Basic UI elements
vim.cmd('highlight Normal guibg=#130022 guifg=#e5fff4')
vim.cmd('highlight NonText guibg=#130022 guifg=#130022')
vim.cmd('highlight CursorLine guibg=#3e314b')
vim.cmd('highlight LineNr guifg=#7c808b')
vim.cmd('highlight CursorLineNr guifg=#e5fff4')
vim.cmd('highlight SignColumn guibg=#130022')
vim.cmd('highlight StatusLine gui=bold guibg=#454d49 guifg=#a6b3b5')
vim.cmd('highlight StatusLineNC gui=bold guibg=#454d49 guifg=#76807f')
vim.cmd('highlight Directory guifg=#00d873')
vim.cmd('highlight Search guibg=#623872 guifg=#e5fff4')
vim.cmd('highlight Visual guibg=#3a6678')
vim.cmd('highlight CurSearch guibg=#f4f0f0 guifg=#130022')
vim.cmd('highlight IncSearch gui=None guibg=#f4f0f0 guifg=#130022')
vim.cmd('highlight MatchParen guibg=#623872 guifg=#e5fff4')
vim.cmd('highlight Pmenu guibg=#42334e guifg=#e5fff4')
vim.cmd('highlight PmenuSel guibg=#737080 guifg=#e5fff4')
vim.cmd('highlight PmenuSbar guibg=#737080 guifg=#e5fff4')
vim.cmd('highlight VertSplit guifg=#454d49')
vim.cmd('highlight MoreMsg guifg=#cfb7ff')
vim.cmd('highlight Question guifg=#cfb7ff')
vim.cmd('highlight Title guifg=#cfcfff')

-- Syntax highlighting
vim.cmd('highlight Comment guifg=#7c808b gui=italic')
vim.cmd('highlight Constant guifg=#ffdf18')
vim.cmd('highlight Identifier guifg=#cfcfff')
vim.cmd('highlight Statement guifg=#e5fff4')
vim.cmd('highlight PreProc guifg=#e5fff4')
vim.cmd('highlight Type guifg=#ffc9c9 gui=None')
vim.cmd('highlight Special guifg=#cfb7ff')

-- Refined syntax highlighting
vim.cmd('highlight String guifg=#a4ffa4')
vim.cmd('highlight Number guifg=#ffdf18')
vim.cmd('highlight Boolean guifg=#bdafff')
vim.cmd('highlight Function guifg=#ffa5a5')
vim.cmd('highlight Keyword guifg=#e7aaff gui=italic')

-- Html syntax highlighting
vim.cmd('highlight Tag guifg=#cfcfff')
vim.cmd('highlight @tag.delimiter guifg=#cfb7ff')
vim.cmd('highlight @tag.attribute guifg=#ffa5a5')

-- Messages
vim.cmd('highlight ErrorMsg guifg=#ff8c8c')
vim.cmd('highlight Error guifg=#ff8c8c')
vim.cmd('highlight DiagnosticError guifg=#ff8c8c')
vim.cmd('highlight DiagnosticVirtualTextError guibg=#2b0e2d guifg=#ff8c8c')
vim.cmd('highlight WarningMsg guifg=#ffec9d')
vim.cmd('highlight DiagnosticWarn guifg=#ffec9d')
vim.cmd('highlight DiagnosticVirtualTextWarn guibg=#2b182e guifg=#ffec9d')
vim.cmd('highlight DiagnosticInfo guifg=#aaeeff')
vim.cmd('highlight DiagnosticVirtualTextInfo guibg=#221838 guifg=#aaeeff')
vim.cmd('highlight DiagnosticHint guifg=#bfffff')
vim.cmd('highlight DiagnosticVirtualTextHint guibg=#241a38 guifg=#bfffff')
vim.cmd('highlight DiagnosticOk guifg=#acffac')

-- Common plugins
vim.cmd('highlight CopilotSuggestion guifg=#7c808b') -- Copilot suggestion
vim.cmd('highlight TelescopeSelection guibg=#3a6678') -- Telescope selection

vim.g.colors_name = "purpy"
vim.o.background = "dark"
