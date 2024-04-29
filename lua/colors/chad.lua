local M = {}

function M.setup(theme)
	local present, base46 = pcall(require, "base46")
	if not present then
		print("not present")
		return
	end
	vim.cmd.hi("clear")
	vim.o.background = "light"
	local theme_opts = {
		base = "base46",
		theme = theme,
		transparency = false,
	}
	base46.load_theme(theme_opts)
end

return M
