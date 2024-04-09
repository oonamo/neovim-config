local M = {}

function M.setup(flavour)
	vim.cmd.hi("clear")
	if flavour == "dayfox" or flavour == "dawnfox" then
		vim.o.background = "light"
	else
		vim.o.background = "dark"
	end
	if flavour == "terafox" then
		vim.opt.cursorline = false
	else
		vim.opt.cursorline = true
	end
	vim.cmd.colorscheme(flavour)
end

return M
