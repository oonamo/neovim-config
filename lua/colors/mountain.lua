local M = {}

function M.setup()
	vim.o.background = "dark"
	vim.cmd.hi("clear")
	vim.cmd.colorscheme("mountain")
end
return M
