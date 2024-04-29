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
}
