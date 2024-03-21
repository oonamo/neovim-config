return {
	"stevearc/dressing.nvim",
	lazy = true,
	enabled = true,
	opts = {
		input = {
			enable = true,
			--- Set window transparency to 0.
			win_options = {
				winblend = 0,
			},
			title_pos = "center",
		},
		select = {
			backend = { "fzf-lua", "fzf", "builtin" },
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
