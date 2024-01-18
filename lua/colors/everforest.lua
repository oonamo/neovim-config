local M = {}

function M.setup()
	O.colorscheme = "everforest"
	vim.opt.background = "dark"
	vim.cmd("colorscheme " .. O.colorscheme)
end

return M
