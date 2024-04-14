local M = {}

function M.setup()
	vim.cmd.hi("clear")
	vim.opt.cursorline = true
	utils.hl = {
		opts = {
			{ "Directory", { fg = "#6A9955" } },
		},
	}
	vim.cmd.colorscheme("darkplus")
	utils:create_hl()
end

return M
