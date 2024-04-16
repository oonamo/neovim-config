local M = {}
function M.setup(fn, flavour)
	local utils = require("onam.utils")
	local colors = require("colors." .. fn)

	colors.setup(flavour)
	local c = colors.colors
	if not c then
		c = {}
	end

	if vim.g.neovide and c.bg then
		vim.api.nvim_set_hl(0, "Normal", { bg = c.bg })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = c.bg })
	end

	---Override Defaults
	if colors.setup_status ~= nil then
		colors.setup_status(flavour)
	end

	if colors.setup_pmenu ~= nil then
		colors.setup_pmenu(flavour)
	end

	vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = "#ff0000" })
	vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = "#ffff00" })
	vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { undercurl = true, sp = "#00ffff" })
	vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl = true, sp = "#00ff00" })

	utils.create_virt_diagnostics_hl()
end

return M
