return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",

		config = function()
			local config = require("nvim-treesitter.configs")
			config.setup({
				ensure_installed = { "lua", "javascript", "rust", "vim", "vimdoc" },
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				indent = { enable = true },
				autotag = { enable = true },
				matchup = {
					enable = true, -- mandatory, false will disable the whole extension
				},
			})
		end,
		event = { "BufReadPre", "BufNewFile" },
	},
}
