-- local palette = require("mini.base16").mini_palette("#282828", "#fbf1c7", 100)
-- require("mini.base16").setup(
--     {
--         palette = palette,
--         name = "minischeme",
--         use_cterm = true
--     }
-- )
-- require("mini.base16").setup({
--   palette = {
--     base00 = "#080808", -- default bg
--     base01 = "#121212", -- line number bg
--     base02 = "#444444", -- statusline bg, selection bg
--     base03 = "#767676", -- line number fg, comments
--     base04 = "#eeeeee", -- statusline fg
--     base05 = "#eeeeee", -- default fg
--     base06 = "#eeeeee", -- light fg (not often used)
--     base07 = "#eeeeee", -- light bg (not often used)
--     base08 = "#ffd7ff", -- statements, identifiers
--     base09 = "#d7afff", -- integers, booleans, constants
--     base0A = "#ffffd7", -- classes, search highlights
--     base0B = "#afd787", -- strings
--     base0C = "#afd7ff", -- builtins
--     base0D = "#d7ffff", -- functions
--     base0E = "#afffaf", -- keywords
--     base0F = "#8a8a8a", -- punctuation, regex, indentscope
--   },
-- })

require("mini.base16").setup {
  palette = {
    base00 = "#000000",
    base01 = "#111111",
    base02 = "#333333",
    base03 = "#bbbbbb",
    base04 = "#dddddd",
    base05 = "#ffffff",
    base06 = "#ffffff",
    base07 = "#ffffff",
    base09 = "#ff2222",
    base08 = "#ff9922",
    base0A = "#ff22ff",
    base0B = "#22ff22",
    base0C = "#4444ff",
    base0D = "#22ffff",
    base0E = "#ffff22",
    base0F = "#999999",
  },
  use_cterm = false,
}

vim.api.nvim_set_hl(0, "ColorColumn", { link = "StatusLine" })
vim.cmd("doautocmd Colorscheme")
