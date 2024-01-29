return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"windwp/nvim-ts-autotag",
		},
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		build = ":TSUpdate",
		config = function()
			local config = require("nvim-treesitter.configs")
			config.setup({
				ensure_installed = {
					"lua",
					"javascript",
					"norg",
					"rust",
					"vim",
					"vimdoc",
					"markdown",
					"markdown_inline",
				},
				auto_install = true,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				indent = { enable = true },
				autotag = {
					enable = true,
					enable_rename = true,
					enable_close = true,
					enable_close_on_slash = true,
				},
				matchup = {
					enable = true, -- mandatory, false will disable the whole extension
				},
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = { "BufReadPre", "BufNewFile" },
		config = function(_, opts)
			local treesitter = require("treesitter-context")
			treesitter.setup(opts)

			vim.keymap.set("n", "[c", function()
				treesitter.prev_context()
			end)
		end,
		opts = {
			max_lines = 2,
		},
	},
	{
		"windwp/nvim-ts-autotag",
		events = { "BufReadPost", "BufNewFile", "BufWritePre" },
		opts = {},
	},
}
