return {
	"echasnovski/mini.indentscope",
	config = function()
		require("mini.indentscope").setup({
			draw = {
				animation = require("mini.indentscope").gen_animation.none(),
			},
			symbol = "│",
		})
		vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { link = "NonText" })
	end,
}
