local M = {}

function M.setup(flavour)
	vim.cmd.hi("clear")
	if flavour == "light" then
		vim.o.background = "light"
		flavour = "one-light"
	else
		vim.o.background = "dark"
		flavour = "onedark"
	end
	vim.cmd.colorscheme("base16-" .. flavour)
end
return M
