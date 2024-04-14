local M = {}

function M.setup(flavour)
	vim.cmd.hi("clear")
	vim.o.background = "dark"
	-- print("vim.o.background: " .. vim.o.background)
	vim.cmd.colorscheme("horizon")
end

return M
