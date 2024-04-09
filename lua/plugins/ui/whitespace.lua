return {
	"mcauley-penney/visual-whitespace.nvim",
	config = true,
	cond = function()
		return vim.version().minor >= 10
	end,
}
