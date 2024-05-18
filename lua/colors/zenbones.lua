local M = {}

function M.setup(flavour)
	vim.o.background = flavour
	vim.cmd.colorscheme("zenbones")
	utils.change_hl_attribute("normal", "background", "#ffffff")
end

return M
