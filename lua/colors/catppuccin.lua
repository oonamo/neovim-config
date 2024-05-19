local M = {}

function M.setup(flavour)
	if flavour == "latte" then
		vim.o.background = "light"
	else
		vim.o.background = "dark"
	end
	require("catppuccin").setup({
		flavour = flavour,
	})
	vim.cmd.colorscheme("catppuccin")
end

return M
