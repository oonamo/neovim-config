local M = {}

function M.setup()
	O.colorscheme = "miasma"
	vim.cmd("colorscheme " .. O.colorscheme)
end

return M
