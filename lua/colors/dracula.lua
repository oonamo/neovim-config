local M = {}

function M.setup(flavour)
	vim.o.background = flavour
	vim.cmd.colorscheme("dracula-mini")
	if flavour == "light" then
		vim.api.nvim_set_hl(0, "StatusLine", { bg = "#4e6799", fg = "#faf3dc" })
	end
end

return M
