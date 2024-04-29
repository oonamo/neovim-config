local M = {}

function M.setup(flavour)
	vim.o.background = flavour
	vim.cmd.colorscheme("dracula-mini")
end

return M
