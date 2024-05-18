local M = {}

function M.setup(flavour)
	vim.o.background = flavour
	vim.cmd.colorscheme("modus-tinted")
	utils.hl = {
		opts = {
			{ "WinBar", { link = "Normal" } },
		},
	}
	utils:create_hl()
end

return M
