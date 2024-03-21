local M = {}

M.colors = {
	["gui00"] = "#20202A",
	["gui01"] = "#2C2E3E",
	["gui02"] = "#A7B7D6",
	["gui03"] = "#44495E",
	["gui04"] = "#c6D0E9",
	["gui05"] = "#63718B",
	["gui06"] = "#313449",
	["gui07"] = "#1A1A24",
	["gui08"] = "#EBB9B9",
	["gui09"] = "#E8CCA7",
	["gui0A"] = "#E6DFB8",
	["gui0B"] = "#B1DBA4",
	["gui0C"] = "#B8DEEB",
	["gui0D"] = "#CDDBF9",
	["gui0E"] = "#F6BBE7",
	["gui0F"] = "#EAC1C1",
}

function M.setup()
	utils.hl = {
		opts = {
			{ "@spell", { fg = "#EAC1C1" } },
			{ "@nospell", { fg = "#2C2E3E" } },
			{ "@markup", { fg = "#EAC1C1" } },
			{ "@spell.latex", { fg = M.colors["gui0B"] } },
			{ "@markup.math.latex", { fg = M.colors["gui0B"] } },
			{ "@nospell.latex", { fg = M.colors["gui0C"] } },
		},
	}
	vim.cmd("colorscheme aquarium")
	utils:create_hl()
end

return M
