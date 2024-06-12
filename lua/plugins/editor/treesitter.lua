return {
	"nvim-treesitter/nvim-treesitter",
	build = function()
		vim.cmd("TSUpdate")
	end,
	config = function()
		require("nvim-treesitter.query_predicates")
		local config = require("nvim-treesitter.configs")
		config.setup({
			ensure_installed = {
				"lua",
				"javascript",
				"c",
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
			},
			indent = { enable = true },
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
}
