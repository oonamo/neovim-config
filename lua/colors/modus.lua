local M = {}

function M.setup(flavour)
	vim.cmd.hi("clear")
	if flavour == "operandi" then
		vim.o.background = "light"
	else
		vim.o.background = "dark"
	end
	vim.cmd.colorscheme("modus-" .. flavour)
end
return M
