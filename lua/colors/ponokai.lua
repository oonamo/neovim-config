local M = {}

function M.setup(flavour)
	vim.g.ponokai_style = flavour
	vim.cmd.colorscheme("ponokai")
end

return M
