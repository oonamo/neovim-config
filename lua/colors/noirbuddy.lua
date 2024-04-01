local M = {}
M.colors = {
	bg = "#121212",
}

function M.setup()
	vim.cmd.hi("clear")
	vim.opt.cursorline = true
	require("noirbuddy").setup()
end

return M
