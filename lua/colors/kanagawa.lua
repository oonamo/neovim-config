-- utils.add_flavour("kana*", {
-- 	name = "kanagawa",
-- 	flavours = { "kanagawa-wave", "kanagawa-dragon", "kanagawa-lotus" },
-- })

local M = {}
M.flavours = {
	pattern = "kana*",
	name = "kanagawa",
	flavours = { "kanagawa-wave", "kanagawa-dragon", "kanagawa-lotus" },
}

M.setup = function(flavour)
	vim.cmd.hi("clear")
	vim.opt.cursorline = true
	if not flavour then
		flavour = "kanagawa"
		vim.o.background = "dark"
	else
		if flavour == "lotus" then
			vim.o.background = "light"
		end
		flavour = "kanagawa-" .. flavour
	end
	vim.cmd("colorscheme " .. (flavour or "kanagawa"))
end
return M
