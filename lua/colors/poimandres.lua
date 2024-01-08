local M = {}

function M.setup()
	O.colorscheme = "poimandres"
	vim.opt.background = "dark"
	vim.cmd("colorscheme " .. O.colorscheme)
end

return M
