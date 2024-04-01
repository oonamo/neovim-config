return {
	"j-hui/fidget.nvim",
	event = "LspAttach",
	cond = not vim.g.use_noice,
	config = function()
		require("fidget").setup()
	end,
}
