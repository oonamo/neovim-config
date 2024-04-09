return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
		init = function(plugin)
			require("lazy.core.loader").add_to_rtp(plugin)
			require("nvim-treesitter.query_predicates")
		end,
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
					"latex",
					"org",
				},
				auto_install = true,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
					disable = { "latex" },
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
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<leader>is",
						node_incremental = "<leader>ii",
						scope_incremental = false,
						node_decremental = "<bs>",
					},
				},
			})
		end,
	},
	-- {
	-- 	"windwp/nvim-ts-autotag",
	-- 	events = { "BufReadPost", "BufNewFile", "BufWritePre" },
	-- 	ft = {
	-- 		"html",
	-- 		"javascript",
	-- 		"typescript",
	-- 		"javascriptreact",
	-- 		"typescriptreact",
	-- 		"svelte",
	-- 		"vue",
	-- 		"tsx",
	-- 		"jsx",
	-- 		"rescript",
	-- 		"xml",
	-- 		"php",
	-- 		"markdown",
	-- 		"glimmer",
	-- 	},
	-- 	opts = {},
	-- },
}
