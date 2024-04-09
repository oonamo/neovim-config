local M = {}
function M.setup(flavour)
	vim.cmd.hi("clear")
	vim.o.background = flavour[1] or "dark"
	require("everforest").setup({
		background = flavour[2],
	})
	vim.opt.cursorline = true
	vim.cmd.colorscheme("everforest")
end
return M
