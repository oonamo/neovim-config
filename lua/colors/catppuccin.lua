local M = {}

function M.setup(flavour)
	vim.cmd.hi("clear")
	vim.cmd.colorscheme("catppuccin-" .. flavour)
end

return M
