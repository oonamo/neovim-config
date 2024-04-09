local M = {}

function M.setup(flavour)
	vim.o.background = flavour
	vim.cmd.hi("clear")
	vim.opt.cursorline = true
	--[[ require("NeoSolarized").setup({
        style = 
    }) ]]
	vim.cmd.colorscheme("NeoSolarized")
end

return M
