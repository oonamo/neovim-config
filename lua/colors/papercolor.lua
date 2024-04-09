local M = {}

M.setup = function(flavour)
	vim.cmd.hi("clear")
	vim.o.background = flavour
	vim.cmd.colorscheme("PaperColor")
end

return M
