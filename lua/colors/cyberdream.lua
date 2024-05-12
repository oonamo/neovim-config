local M = {}

function M.setup(flavour)
	vim.o.background = flavour
	require("cyberdream").setup({
		theme = { variant = flavour },
	})
	vim.cmd.colorscheme("cyberdream")
end

return M
