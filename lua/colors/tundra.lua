local M = {}

function M.setup(flavour)
	vim.cmd.hi("clear")
	vim.g.tundra_biome = flavour
	vim.o.background = "dark"
	vim.cmd.colorscheme("tundra")
end
return M
