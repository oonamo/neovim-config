local M = {}
function M.setup(flavour)
	vim.cmd.hi("clear")
	vim.opt.cursorline = true
	if flavour == "dawn" then
		vim.o.background = "light"
	elseif flavour == "prime" then
		require("colors.prime-pine").setup()
		require("colors.prime-pine").setup_pmenu()
		return
	else
		vim.o.background = "dark"
	end
	require("rose-pine").setup({
		variant = flavour,
	})
	vim.cmd("colorscheme rose-pine")
end

return M
