local M = {}

function M.setup(flavour)
	vim.cmd.colorscheme("kanagawa-" .. flavour)
end

return M
