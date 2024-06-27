return {
	"NLKNguyen/papercolor-theme",
	-- priority = 1000,
	-- lazy = false,
	config = function()
		vim.o.background = "light"
		vim.cmd.colorscheme("PaperColor")
	end,
}
