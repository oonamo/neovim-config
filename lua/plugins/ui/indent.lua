return {
	{
		"echasnovski/mini.indentscope",
		event = "VeryLazy",
		cond = function()
			return O.ui.indent.mini == true
		end,
		config = function()
			require("mini.indentscope").setup({
				draw = {
					animation = require("mini.indentscope").gen_animation.none(),
				},
				symbol = "│",
			})
			vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { link = "NonText" })
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		cond = function()
			return O.ui.indent.lines == true
		end,
		event = "VeryLazy",
		opts = {
			exclude = {
				filetypes = {
					"help",
					"terminal",
					"lazy",
					"lspinfo",
					"TelescopePrompt",
					"TelescopeResults",
					"mason",
				},
				buftypes = { "terminal" },
			},
			indent = {
				char = "|",
				tab_char = " ",
			},
			scope = {
				enabled = true,
				char = "|",
				highlight = "NonText",
				show_start = true,
				show_end = false,
			},
		},
		config = function(_, opts)
			require("ibl").setup(opts)

			vim.cmd.highlight("clear @ibl.scope.underline.1")
			vim.cmd.highlight("link @ibl.scope.underline.1 Visual")
		end,
	},
}
