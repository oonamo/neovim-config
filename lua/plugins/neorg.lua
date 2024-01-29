return {
	"nvim-neorg/neorg",
	dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
	ft = "norg",
	cmd = { "Neorg" },
	opts = {
		load = {
			["core.defaults"] = {},
			["core.keybinds"] = {},
			["core.completion"] = {
				config = {
					engine = "nvim-cmp",
				},
			},
			["core.concealer"] = {},
			["core.dirman"] = {
				config = {
					workspaces = {
						-- ["notes"] = "~/notes",
						["school"] = "~/Documents/School",
						["projects"] = "~/Documents/Projects",
					},
				},
			},
		},
	},
	build = ":Neorg sync-parsers",
}
