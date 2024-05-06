local M = {}

function M.setup(flavour)
	vim.o.background = flavour
	vim.cmd.colorscheme("onenord")
end

return M
