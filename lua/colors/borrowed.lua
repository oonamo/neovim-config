local M = {}

function M.setup(flavour)
	vim.o.background = "dark"
	vim.cmd.colorscheme(flavour)
end

return M
