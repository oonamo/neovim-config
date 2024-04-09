return {
	"ray-x/lsp_signature.nvim",
	cond = function()
		return not vim.g.use_noice and not O.ui.signature == "custom"
	end,
	event = "LspAttach",
}
