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
			indent = {
				enable = true,
				disable = function(_, buf)
					local max_filesize = 100 * 1024 -- 100 KB
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end
				end,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<CR>",
					node_incremental = "<CR>",
					scope_incremental = false,
					node_decremental = "<BS>",
				},
			},
		})
	end,
}
