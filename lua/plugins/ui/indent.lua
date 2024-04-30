return {
	{
		"echasnovski/mini.indentscope",
		event = "VeryLazy",
		cond = function()
			return O.ui.indent.mini == true
		end,
		config = function()
			require("mini.indentscope").setup({
				-- draw = {
				-- 	animation = require("mini.indentscope").gen_animation.none(),
				-- },
				symbol = "│",
				options = { try_as_border = true },
			})
			if utils.get_hl("NonText") then
				vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { link = "NonText" })
			else
				local fg, _, _ = utils.get_hl("Normal")
				if fg == nil then
					fg = "#ffffff"
				end
				vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = fg })
			end
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		cond = false,
		main = "ibl",
		event = "UIEnter",
		opts = {
			exclude = {
				filetypes = {
					"dbout",
					"neo-tree-popup",
					"log",
					"gitcommit",
					"txt",
					"help",
					"NvimTree",
					"git",
					"flutterToolsOutline",
					"undotree",
					"markdown",
					"norg",
					"org",
					"orgagenda",
				},
			},
			indent = {
				char = "│", -- ▏┆ ┊ 
				tab_char = "│",
			},
			scope = {
				char = "▎",
				-- highlight = {
				-- 	"RainbowDelimiterRed",
				-- 	"RainbowDelimiterYellow",
				-- 	"RainbowDelimiterBlue",
				-- 	"RainbowDelimiterOrange",
				-- 	"RainbowDelimiterGreen",
				-- 	"RainbowDelimiterViolet",
				-- 	"RainbowDelimiterCyan",
				-- },
			},
		},
		config = function(_, opts)
			require("ibl").setup(opts)
			local hooks = require("ibl.hooks")
			hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
			hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
		end,
	},
}
