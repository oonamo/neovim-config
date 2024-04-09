local M = {}
function M.setup(fn, flavour)
	local utils = require("onam.utils")
	local colors = require("colors." .. fn)

	colors.setup(flavour)
	local c = colors.colors
	if not c then
		c = {}
	end

	-- if O.ui.statusline.custom == true then
	-- 	utils.statuscolors = {
	-- 		opts = {
	-- 			{ "StatusLineExtra", { fg = c.bg, bg = c.red } },
	-- 			{ "StatuslineAccent", { bg = c.yellow, fg = "#27272a" } },
	-- 			{ "StatuslineInsertAccent", { link = "CurSearch" } },
	-- 			{ "StatuslineVisualAccent", { bg = c.cyan, fg = "#27272a" } },
	-- 			{ "StatuslineCmdLineAccent", { bg = c.magenta, fg = "#27272a" } },
	-- 			{ "StatusCmdLine", { bg = c.magenta, fg = "#27272a" } },
	-- 			{ "StatuslineReplaceAccent", { bold = true, fg = c.green } },
	-- 			{ "StatusEmpty", { bg = c.bg, blend = 10 } },
	-- 			{ "StatusBarLong", { bg = c.bg, blend = 10, fg = "#ffffff" } },
	-- 			{ "HarpoonActive", { bg = c.magenta, blend = 10, fg = "#000000" } },
	-- 			{ "HarpoonInactive", { bg = c.green, blend = 10, fg = "#000000" } },
	-- 		},
	-- 	}
	-- 	utils:create_statusline()
	-- end

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
	-- require("heirline.utils").on_colorscheme(require("heirline-components.all").hl.get_colors())
end

return M
