local M = {}

function M.setup()
	O.colorscheme = "everforest"
	vim.opt.background = "light"
	vim.cmd("colorscheme " .. O.colorscheme)
end

return M
