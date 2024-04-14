local M = {}

function M.setup()
	vim.cmd.hi("clear")
	vim.o.background = "dark"
	vim.cmd.colorscheme("darkrose")
end

return M
