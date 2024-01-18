local M = {}

function M.setup()
	O.colorscheme = "oxocarbon"
	vim.opt.background = "dark"
	vim.cmd("colorscheme " .. O.colorscheme)
end

return M
