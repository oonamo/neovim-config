vim.g.use_custom_snippets = true
vim.g.use_lualine = false
vim.g.use_custom_statusline = false
vim.g.use_custom_winbar = false
vim.g.use_FZF = true
vim.g.use_noice = false
vim.g.no_cmd_height = false

O.ui = {
	statusline = {
		minimal = false,
		fancy = false,
		simple = false,
		chad = true,
		tj = false,
		ibh = false,
		org = { active = false, monochrome = false },
	},
	tabline = {
		minimal = false,
		fancy = false,
	},
	indent = {
		mini = true,
		lines = false,
	},
	signature = "custom",
	tree = {
		neotree = false,
		nvimtree = true,
		oil = true,
	},
	incline = true,
}
O.lsp = {
	cmp = false,
	coq = true,
}
