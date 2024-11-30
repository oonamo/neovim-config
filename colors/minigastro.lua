if vim.g.colors_name ~= "" then
	vim.cmd.hi("clear")
end

vim.g.colors_name = "gastrodom"

require("mini.base16").setup({
	palette = {
		base00 = "#3a3346", -- Defaum. bg
		base01 = "#2e2836", -- Lighter bg (status bar, line number, folding mks)
		base02 = "#4c3d6f", -- Selection bg
		base03 = "#7d7f93", -- Comments, invisibm.s, line hl
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
	},
})
-- require("mini.hues").setup({
--   background = "#3a3346",
--   foreground = "#a1a7c2"
-- })
