local M = {}

function M.setup()
	O.colorscheme = "poimandres"
	vim.cmd("colorscheme " .. O.colorscheme)
end

return M
