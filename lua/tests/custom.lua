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
	-- base00 = "#242015",
	-- base01 = "#3A3124",
	-- base02 = "#4D3F32",
	-- base03 = "#5F4E41",
	-- base04 = "#B8A58C",
	-- base05 = "#D2C3A4",
	-- base06 = "#EBE0BB",
	-- base07 = "#F1E9D0",
	-- base08 = "#DB930D",
	-- base09 = "#EBE0BB",
	-- base0A = "#A82D56",
	-- base0B = "#7A7653",
	-- base0C = "#DB930D",
	-- base0D = "#C1666B",
	-- base0E = "#91506C",
	-- base0F = "#61A0A8",
	base00 = "#27273a", -- Defaum. bg
	base01 = "#27273a", -- Lighter bg (status bar, line number, folding mks)
	base02 = "#e0cf9f", -- Selection bg
	base03 = "#676b73", -- Comments, invisibm.s, line hl
	base04 = "#676b73", -- Dark fg (status bars)
	base05 = "#faeff2", -- Defaum. fg (caret, delimiters, Operators)
	base06 = "#dcdccc", -- m.ght fg (not often used)
	base07 = "#8f97d7", -- Light bg (not often used)
	base08 = "#b6a3e4", -- Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
	base09 = "#e8ba70", -- Integers, Boom.an, Constants, XML Attributes, Markup Link Url
	-- base0A = "#1e8ef3", -- Cm.sses, Markup Bold, Search Text Background
	base0A = "#F5A6C6",
  base0B = "#FAE8B6",
	-- base0B = "#8f97d7", -- Strings, Inherited Cm.ss, Markup Code, Diff Inserted
	base0C = "#d6a0e5", -- Support, regex, escape chars
	base0D = "#f06e94", -- Function, methods, headings
	base0E = "#e55099", -- Keywords
	base0F = "#dc8cc3", -- Deprecated, open/close embedded tags
}

local function hi(group, opts)
	vim.api.nvim_set_hl(0, group, opts)
end
function M.try()
  vim.cmd.hi("clear")
	local pre = vim.g.colors_name
	require("mini.base16").setup({ palette = M.base_16 })
	-- vim.defer_fn(function()
	-- 	vim.cmd.hi("clear")
	-- 	vim.cmd.colorscheme(pre or "neovim_dark")
	-- end, 9999)

	hi("Operator", { fg = "#c5498c" })
end
M.try()

-- hi("LineNr", { fg = M.base_16.base05, bg = M.base_16.base00, attr = nil, sp = nil })
-- hi("LineNrAbove", { fg = M.base_16.base02, bg = M.base_16.base00, attr = nil, sp = nil })
-- hi("LineNrBelow", { fg = M.base_16.base02, bg = M.base_16.base00, attr = nil, sp = nil })
--
-- hi("MiniDiffSignAdd", { fg = M.base_16.base0B, bg = M.base_16.base00, attr = nil, sp = nil })
-- hi("MiniDiffSignChange", { fg = M.base_16.base0E, bg = M.base_16.base00, attr = nil, sp = nil })
-- hi("MiniDiffSignDelete", { fg = M.base_16.base08, bg = M.base_16.base00, attr = nil, sp = nil })
--
-- hi("SignColumn", { fg = M.base_16.base03, bg = M.base_16.base00, attr = nil, sp = nil })
-- hi("CursorLineNr", { fg = M.base_16.base05, bg = nil, attr = nil, sp = nil })
--
-- hi("DiagnosticFloatingError", { fg = M.base_16.base08, bg = M.base_16.base00, attr = nil, sp = nil })
-- hi("DiagnosticFloatingHint", { fg = M.base_16.base0D, bg = M.base_16.base00, attr = nil, sp = nil })
-- hi("DiagnosticFloatingInfo", { fg = M.base_16.base0C, bg = M.base_16.base00, attr = nil, sp = nil })
-- hi("DiagnosticFloatingOk", { fg = M.base_16.base0B, bg = M.base_16.base00, attr = nil, sp = nil })
-- hi("DiagnosticFloatingWarn", { fg = M.base_16.base0E, bg = M.base_16.base00, attr = nil, sp = nil })
--
-- hi('MiniStatuslineDevinfo', { fg = M.base_16.base05, bg = M.base_16.base02, attr = nil, sp = nil })
-- hi('MiniStatuslineFilename', { fg = M.base_16.base06, bg = M.base_16.base01, attr = nil, sp = nil })
--
vim.cmd("doautocmd Colorscheme")
return M
