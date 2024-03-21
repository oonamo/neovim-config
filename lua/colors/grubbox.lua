local M = {}
M.colors = {
	bg = "#282828",
}

function M.setup()
	O.colorscheme = "gruvbox-material"
	vim.opt.background = "dark"
	vim.cmd("colorscheme " .. O.colorscheme)
end

return M
