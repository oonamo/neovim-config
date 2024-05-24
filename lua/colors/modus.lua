local M = {}

function M.setup(flavour)
	vim.o.background = flavour == "vivendi" and "light" or "dark"
	vim.cmd.colorscheme("modus_" .. flavour)
end
