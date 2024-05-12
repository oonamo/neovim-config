local M = {}

function M.setup(flavour)
	vim.o.background = flavour[1]
	vim.g.gruvbox_material_background = flavour[2]
	vim.cmd.colorscheme("gruvbox-material")
end

return M
