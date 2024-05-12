local M = {}

function M.setup()
	vim.cmd.colorscheme("flesh-and-blood")
	-- utils.change_hl_attribute("StatusLine", "reverse", tru)
	utils.hl = {
		opts = {
			{ "Statusline", { bg = "#1e1e1e", fg = "#646a70" } },
		},
	}
	utils:create_hl()
end

return M
