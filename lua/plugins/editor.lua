return {
	"nvim-treesitter/nvim-treesitter",
	lazy = vim.fn.argc(-1) == 0,
	build = function()
		vim.cmd("TSUpdate")
	end,
	init = function(plugin)
		require("lazy.core.loader").add_to_rtp(plugin)
		require("nvim-treesitter.query_predicates")
	end,
	event = { "BufWritePre", "BufReadPost", "BufNewFile", "VeryLazy" },
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
				disable = function(_, buf)
					local max_filesize = 100 * 1024 -- 100 KB
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end
				end,
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
					init_selection = "<C-i>",
					node_incremental = "<CR>",
					scope_incremental = false,
					node_decremental = "<BS>",
				},
			},
		})
	end,
	{
		"NeogitOrg/neogit",
		dependencies = {
			"sindrets/diffview.nvim", -- optional - Diff integration
		},
		config = true,
		cmd = "Neogit",
    keys = {
			{
				"<leader>gc",
        function()
          require("neogit").open()
        end,
        desc = "Commit",
			},
			{
				"<leader>gs",
        function()
          require("neogit").open()
        end,
        desc = "Status",
			},
    },
	},
}
