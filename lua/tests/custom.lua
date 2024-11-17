local M = {}

-- M.base_30 = {
--   white = "#bbc2cf",
--   darker_black = "#22262e",
--   black = "#0b0d0f", --  nvim bg
--   black2 = "#2e323a",
--   one_bg = "#32363e", -- real bg of onedark
--   one_bg2 = "#3c4048",
--   one_bg3 = "#41454d",
--   grey = "#494d55",
--   grey_fg = "#53575f",
--   grey_fg2 = "#5d6169",
--   light_grey = "#676b73",
--   red = "#ff6b5a",
--   baby_pink = "#ff7665",
--   pink = "#ff75a0",
--   line = "#3b3f47", -- for lines like vertsplit
--   green = "#98be65",
--   vibrant_green = "#a9cf76",
--   nord_blue = "#47a5e5",
--   blue = "#51afef",
--   yellow = "#ECBE7B",
--   sun = "#f2c481",
--   purple = "#dc8ef3",
--   dark_purple = "#c678dd",
--   teal = "#4db5bd",
--   orange = "#ea9558",
--   cyan = "#46D9FF",
--   statusline_bg = "#2d3139",
--   lightbg = "#3a3e46",
--   pmenu_bg = "#98be65",
--   folder_bg = "#51afef",
-- }

M.base_16 = {
	-- base00 = '#000000', base01 = '#121212', base02 = '#222222', base03 = '#333333',
	-- base04 = '#999999', base05 = '#c1c1c1', base06 = '#999999', base07 = '#c1c1c1',
	-- base08 = '#5f8787', base09 = '#aaaaaa', base0A = '#e78a53', base0B = '#fbcb97',
	-- base0C = '#aaaaaa', base0D = '#888888', base0E = '#999999', base0F = '#444444'
	-- base00 = '#000000', base01 = '#121212', base02 = '#222222', base03 = '#333333',
	-- base04 = '#999999', base05 = '#c1c1c1', base06 = '#999999', base07 = '#c1c1c1',
	-- base08 = '#5f8787', base09 = '#aaaaaa', base0A = '#99bbaa', base0B = '#ddeecc',
	-- base0C = '#aaaaaa', base0D = '#888888', base0E = '#999999', base0F = '#444444'
	--  base00 = '#383838', base01 = '#404040', base02 = '#606060', base03 = '#6f6f6f',
	--  base04 = '#808080', base05 = '#dcdccc', base06 = '#c0c0c0', base07 = '#ffffff',
	--  base08 = '#dca3a3', base09 = '#dfaf8f', base0A = '#e0cf9f', base0B = '#5f7f5f',
	--  base0C = '#93e0e3', base0D = '#7cb8bb', base0E = '#dc8cc3', base0F = '#000000'
  --
}

require("mini.base16").setup({ palette = M.base_16 })

vim.defer_fn(function()
	vim.cmd.hi("clear")
	vim.cmd.colorscheme("neovim_dark")
end, 10000)
-- base00 = m.bg, -- Defaum. bg
-- base01 = m.bg_highlight, -- Lighter bg (status bar, line number, folding mks)
-- base02 = m.visual, -- Selection bg
-- base03 = m.comment, -- Comments, invisibm.s, line hl
-- base04 = m.fg_dark, -- Dark fg (status bars)
-- base05 = m.fg, -- Defaum. fg (caret, delimiters, Operators)
-- base06 = m.fg_dark, -- m.ght fg (not often used)
-- base07 = m.bg_highlight, -- Light bg (not often used)
-- base08 = m.green1, -- Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
-- base09 = m.orange, -- Integers, Boom.an, Constants, XML Attributes, Markup Link Url
-- base0A = m.magenta, -- Cm.sses, Markup Bold, Search Text Background
-- base0B = m.green, -- Strings, Inherited Cm.ss, Markup Code, Diff Inserted
-- base0C = m.magenta, -- Support, regex, escape chars
-- base0D = m.blue, -- Function, methods, headings
-- base0E = m.purple, -- Keywords
-- base0F = m.red, -- Deprecated, open/close embedded tags
