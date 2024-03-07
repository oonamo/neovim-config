local M = {}
function M.setup(light)
	if O.fn == nil then
		print("O.fn is nil")
		return
	end

	if light then
		vim.opt.background = "light"
	else
		vim.opt.background = "dark"
	end

	local colors = require("colors." .. O.fn)
	colors.setup()
	local c = colors.colors
	if vim.g.use_custom_statusline == true then
		utils.statuscolors = {
			opts = {
				{ "StatusLineExtra", { fg = c.bg, bg = c.red } },
				{ "StatuslineAccent", { bg = c.yellow, fg = "#27272a" } },
				{ "StatuslineInsertAccent", { link = "CurSearch" } },
				{ "StatuslineVisualAccent", { bg = c.cyan, fg = "#27272a" } },
				{ "StatuslineCmdLineAccent", { bg = c.magenta, fg = "#27272a" } },
				{ "StatusCmdLine", { bg = c.magenta, fg = "#27272a" } },
				{ "StatuslineReplaceAccent", { bold = true, fg = c.green } },
				{ "StatusEmpty", { bg = c.bg, blend = 10 } },
				{ "StatusBarLong", { bg = c.bg, blend = 10, fg = "#ffffff" } },
				{ "HarpoonActive", { bg = c.magenta, blend = 10, fg = "#000000" } },
				{ "HarpoonInactive", { bg = c.green, blend = 10, fg = "#000000" } },
			},
		}

		utils:create_statusline()
	end

	---Override Defaults
	if colors.setup_status ~= nil then
		colors.setup_status()
	end

	if colors.setup_pmenu ~= nil then
		colors.setup_pmenu()
	end
	vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = "#ff0000" })
	vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = "#ffff00" })
	vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { undercurl = true, sp = "#00ffff" })
	vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl = true, sp = "#00ff00" })
end

return M
