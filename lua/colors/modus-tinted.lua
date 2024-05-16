local M = {}

function M.setup(flavour)
	vim.o.background = flavour
	vim.cmd.colorscheme("modus-tinted")
end

return M
