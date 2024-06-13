return {
	-- TODO: Change once merged
	"oonamo/patana.nvim",
	lazy = false,
	priority = 1000,
	init = function()
		vim.o.background = "light"
	end,
	config = function()
		vim.cmd.colorscheme("patana")
	end,
}
