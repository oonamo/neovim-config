return {
	"stevearc/dressing.nvim",
	lazy = true,
	enabled = true,
	opts = {
		input = {
			enabled = true,
			insert_only = false,
			start_in_insert = false,
			prefer_width = 25,
			max_width = { 80, 0.5 },
			min_width = { 10, 0.2 },
			--- Set window transparency to 0.
			border = tools.ui.cur_border,
			-- win_options = {
			-- 	winblend = 0,
			-- },
			title_pos = "center",
		},
		select = {
			enabled = true,
			backend = { "fzf-lua", "builtin" },
			builtin = {
				relative = "editor",
			},
		},
	},
	init = function()
		---@diagnostic disable-next-line: duplicate-set-field
		vim.ui.select = function(...)
			require("lazy").load({ plugins = { "dressing.nvim" } })
			return vim.ui.select(...)
		end
		---@diagnostic disable-next-line: duplicate-set-field
		vim.ui.input = function(...)
			require("lazy").load({ plugins = { "dressing.nvim" } })
			return vim.ui.input(...)
		end
	end,
}
