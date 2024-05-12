local M = {}

function M.setup(flavour)
	vim.o.background = flavour
	vim.cmd.colorscheme("PaperColorSlim")
end

return M
