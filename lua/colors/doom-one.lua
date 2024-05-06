local M = {}

function M.setup(flavour)
	vim.cmd.hi("clear")
	vim.o.background = flavour
	vim.g.disable_semantic_tokens = true
	-- Set :terminal colors
	-- Enable TS support
	-- vim.g.doom_one_enable_treesitter = true
	-- vim.g.doom_one_diagnostics_text_color = false
	-- Enable transparent background

	-- Pumblend transparency
	-- vim.g.doom_one_pumblend_enable = true
	-- vim.g.doom_one_pumblend_transparency = 3

	-- Plugins integration
	vim.g.doom_one_plugin_neorg = true
	-- vim.g.doom_one_plugin_barbar = false
	vim.g.doom_one_plugin_neogit = true
	vim.g.doom_one_plugin_nvim_tree = true

	vim.cmd.colorscheme("doom-one")
	-- utils.hl = {
	-- 	opts = {
	-- 		{ "markdownH1", { link = "Headline1" } },
	-- 		{ "markdownH2", { link = "Headline2" } },
	-- 		{ "markdownH3", { link = "Headline3" } },
	-- 		{ "markdownH4", { link = "Headline4" } },
	-- 		{ "markdownH5", { link = "Headline5" } },
	-- 		{ "markdownH6", { link = "Headline6" } },
	-- 		{ "DiffAdd", { link = "markdownH1" } },
	-- 		{ "DiffChange", { link = "markdownH2" } },
	-- 		{ "DiffDeleted", { link = "markdownH3" } },
	-- 	},
	-- }
	utils.hl = {
		opts = {
			{ "@markup.heading.1.markdown", { link = "NeorgHeading1Title" } },
			{ "@markup.heading.2.markdown", { link = "NeorgHeading2Title" } },
			{ "@markup.heading.3.markdown", { link = "NeorgHeading1Title" } },
			{ "@markup.heading.4.markdown", { link = "NeorgHeading1Title" } },
			{ "@markup.heading.5.markdown", { link = "NeorgHeading1Title" } },
			{ "@markup.heading.6.markdown", { link = "NeorgHeading1Title" } },
			-- { "@markup.heading.1.markdown", { link = "NeorgHeading1Title" } },
		},
	}
end

return M
