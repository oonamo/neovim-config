return {
	"Exafunction/codeium.vim",
	event = "BufEnter",
	init = function()
		vim.g.codeium_render = true
	end,
}
