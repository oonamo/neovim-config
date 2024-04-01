return {
	"ray-x/lsp_signature.nvim",
	cond = not vim.g.use_noice,
	event = "LspAttach",
}
