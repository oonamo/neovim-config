local c
if vim.o.bg == "light" then
  c = {
    color00 = "#eeeeee",
    color01 = "#af0000",
    color02 = "#008700",
    color03 = "#5f8700",
    color04 = "#0087af",
    color05 = "#878787",
    color06 = "#005f87",
    color07 = "#444444",
    color08 = "#bcbcbc",
    color09 = "#d70000",
    color10 = "#d70087",
    color11 = "#8700af",
    color12 = "#d75f00",
    color13 = "#d75f00",
    color14 = "#005faf",
    color15 = "#005f87",
    color16 = "#0087af",
    color17 = "#008700",
    cursor_fg = "#eeeeee",
    cursor_bg = "#005f87",
    cursorline = "#e4e4e4",
    cursorcolumn = "#e4e4e4",
    cursorlinenr_fg = "#af5f00",
    cursorlinenr_bg = "#eeeeee",
    popupmenu_fg = "#444444",
    popupmenu_bg = "#d0d0d0",
    search_fg = "#444444",
    search_bg = "#ffff5f",
    incsearch_fg = "#ffff5f",
    incsearch_bg = "#444444",
    linenumber_fg = "#b2b2b2",
    linenumber_bg = "#eeeeee",
    vertsplit_fg = "#005f87",
    vertsplit_bg = "#eeeeee",
    statusline_active_fg = "#e4e4e4",
    statusline_active_bg = "#005f87",
    statusline_inactive_fg = "#444444",
    statusline_inactive_bg = "#d0d0d0",
    todo_fg = "#00af5f",
    todo_bg = "#eeeeee",
    error_fg = "#af0000",
    error_bg = "#ffd7ff",
    matchparen_bg = "#c6c6c6",
    matchparen_fg = "#005f87",
    visual_fg = "#eeeeee",
    visual_bg = "#0087af",
    folded_fg = "#0087af",
    folded_bg = "#afd7ff",
    wildmenu_fg = "#444444",
    wildmenu_bg = "#ffff00",
    spellbad = "#ffafd7",
    spellcap = "#ffffaf",
    spellrare = "#afff87",
    spelllocal = "#d7d7ff",
    diffadd_fg = "#008700",
    diffadd_bg = "#afffaf",
    diffdelete_fg = "#af0000",
    diffdelete_bg = "#ffd7ff",
    difftext_fg = "#0087af",
    difftext_bg = "#ffffd7",
    diffchange_fg = "#444444",
    diffchange_bg = "#ffd787",
    tabline_bg = "#005f87",
    tabline_active_fg = "#444444",
    tabline_active_bg = "#e4e4e4",
    tabline_inactive_fg = "#eeeeee",
    tabline_inactive_bg = "#0087af",
    buftabline_bg = "#005f87",
    buftabline_current_fg = "#444444",
    buftabline_current_bg = "#e4e4e4",
    buftabline_active_fg = "#eeeeee",
    buftabline_active_bg = "#005faf",
    buftabline_inactive_fg = "#eeeeee",
    buftabline_inactive_bg = "#0087af",
  }
else
  c = {
    color00 = "#1c1c1c",
    color01 = "#af005f",
    color02 = "#5faf00",
    color03 = "#d7af5f",
    color04 = "#5fafd7",
    color05 = "#808080",
    color06 = "#d7875f",
    color07 = "#d0d0d0",
    color08 = "#585858",
    color09 = "#5faf5f",
    color10 = "#afd700",
    color11 = "#af87d7",
    color12 = "#ffaf00",
    color13 = "#ff5faf",
    color14 = "#00afaf",
    color15 = "#5f8787",
    color16 = "#5fafd7",
    color17 = "#d7af00",
    cursor_fg = "#1c1c1c",
    cursor_bg = "#c6c6c6",
    cursorline = "#303030",
    cursorcolumn = "#303030",
    cursorlinenr_fg = "#ffff00",
    cursorlinenr_bg = "#1c1c1c",
    popupmenu_fg = "#c6c6c6",
    popupmenu_bg = "#303030",
    search_fg = "#000000",
    search_bg = "#00875f",
    incsearch_fg = "#00875f",
    incsearch_bg = "#000000",
    linenumber_fg = "#585858",
    linenumber_bg = "#1c1c1c",
    vertsplit_fg = "#5f8787",
    vertsplit_bg = "#1c1c1c",
    statusline_active_fg = "#1c1c1c",
    statusline_active_bg = "#5f8787",
    statusline_inactive_fg = "#bcbcbc",
    statusline_inactive_bg = "#3a3a3a",
    todo_fg = "#ff8700",
    todo_bg = "#1c1c1c",
    error_fg = "#af005f",
    error_bg = "#5f0000",
    matchparen_bg = "#4e4e4e",
    matchparen_fg = "#c6c6c6",
    visual_fg = "#000000",
    visual_bg = "#8787af",
    folded_fg = "#d787ff",
    folded_bg = "#5f005f",
    wildmenu_fg = "#1c1c1c",
    wildmenu_bg = "#afd700",
    spellbad = "#5f0000",
    spellcap = "#5f005f",
    spellrare = "#005f00",
    spelllocal = "#00005f",
    diffadd_fg = "#87d700",
    diffadd_bg = "#005f00",
    diffdelete_fg = "#af005f",
    diffdelete_bg = "#5f0000",
    difftext_fg = "#5fffff",
    difftext_bg = "#008787",
    diffchange_fg = "#d0d0d0",
    diffchange_bg = "#005f5f",
    tabline_bg = "#262626",
    tabline_active_fg = "#121212",
    tabline_active_bg = "#00afaf",
    tabline_inactive_fg = "#bcbcbc",
    tabline_inactive_bg = "#585858",
    buftabline_bg = "#262626",
    buftabline_current_fg = "#121212",
    buftabline_current_bg = "#00afaf",
    buftabline_active_fg = "#00afaf",
    buftabline_active_bg = "#585858",
    buftabline_inactive_fg = "#bcbcbc",
    buftabline_inactive_bg = "#585858",
  }
end

local function hi(...) vim.api.nvim_set_hl(0, ...) end

require("mini.base16").setup({
  palette = {
    base00 = c.color00, -- default bg
    base01 = c.linenumber_bg, -- line number bg
    base02 = c.statusline_active_bg, -- statusline bg, selection bg
    base03 = c.linenumber_fg, -- line number fg, comments
    base04 = c.statusline_active_fg, -- statusline fg
    base05 = c.color07, -- default fg
    base06 = c.color08, -- light fg (not often used)
    base07 = c.color10, -- light bg (not often used)
    base08 = c.color06, -- statements, identifiers
    base09 = c.color03, -- integers, booleans, constants
    base0A = c.search_fg, -- classes, search highlights
    base0B = c.color03, -- strings
    base0C = c.color14, -- builtins
    base0D = c.color07, -- functions
    base0E = c.color14, -- keywords
    base0F = c.color16, -- punctuation, regex, indentscope
  },
})

-- require("mini.hues").apply_palette(palette)

-- stylua: ignore start
hi("Cursor",                   { fg = c.cursor_fg, bg = c.cursor_bg                           })
hi("LineNr",                   { fg = c.linenumber_fg                                         })
hi("Search",                   { fg = c.search_fg, bg = c.search_bg                           })
hi("IncSearch",                { fg = c.incsearch_fg, bg = c.incsearch_bg                     })
hi("StatusLine",               { fg = c.statusline_active_fg, bg = c.statusline_active_bg     })
hi("StatusLineNC",             { fg = c.statusline_inactive_fg, bg = c.statusline_inactive_bg })
hi("Visual",                   { fg = c.visual_fg, bg = c.visual_bg                           })
hi("MatchParen",               { fg = c.matchparen_fg, bg = c.matchparen_bg                   })
hi("CursorLine",               { bg = c.cursorline                                            })
hi("CursorLineNr",             { fg = c.cursorlinenr_fg, bg = c.cursorlinenr_bg               })
hi("Pmenu",                    { fg = c.popupmenu_fg, bg = c.popupmenu_bg                     })
hi("PmenuSel",                 { fg = c.popupmenu_fg, bg = c.popupmenu_bg, reverse = true     })
hi("Number",                   { fg = c.color13                                               })
hi("Boolean",                  { fg = c.color17, bold = true                                  })
hi("Statement",                { fg = c.color10                                               })
hi("Operator",                 { fg = c.color14                                               })
hi("Conditional",              { fg = c.color11, bold = true                                  })
hi("Label",                    { fg = c.color14                                               })
hi("PreProc",                  { fg = c.color14                                               })
hi("Include",                  { fg = c.color09                                               })
hi("Define",                   { fg = c.color14                                               })
hi("Macro",                    { fg = c.color14                                               })
hi("Type",                     { fg = c.color10, bold = true                                  })
hi("StorageClass",             { fg = c.color06, bold = true                                  })
hi("Structure",                { fg = c.color14, bold = true                                  })
hi("Typedef",                  { fg = c.color10, bold = true                                  })

hi("MiniHipatternsTodo",       { fg = c.todo_fg, bg = c.todo_bg, bold = true                  })

hi("DiagnosticError",          { fg = c.error_fg, bg = c.error_bg                             })
hi("DiagnosticWarn",           { fg = c.todo_fg, bg = c.todo_bg                               })

hi("DiagnosticUnderlineError", { fg = c.error_fg, bg = c.error_bg, undercurl = true           })
hi("DiagnosticUnderlineWarn",  { fg = c.todo_fg, bg = c.todo_bg, undercurl = true             })

hi("DiffAdd",                  { fg = c.diffadd_fg, bg = c.diffadd_bg                         })
hi("DiffChange",               { fg = c.diffchange_fg, bg = c.diffchange_bg                   })
hi("DiffDelete",               { fg = c.diffdelete_fg, bg = c.diffdelete_bg                   })
hi("DiffText",                 { fg = c.difftext_fg, bg = c.difftext_bg                       })

hi("MiniDiffOverAdd",          { link = "DiffAdd"                                             })
hi("MiniDiffOverChange",       { link = "DiffChange"                                          })
hi("MiniDiffOverDelete",       { link = "DiffDelete"                                          })

hi("MiniDiffSignDelete",       { fg = c.diffdelete_fg                                         })
hi("MiniDiffSignChange",       { fg = c.diffchange_fg                                         })
hi("MiniDiffSignAdd",          { fg = c.diffadd_fg                                            })

hi("BlinkCmpLabelMatch",       { fg = c.color14, bold = true                                  })

-- stylua: ignore end

vim.g.colors_name = "paper"
