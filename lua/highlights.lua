local M = {}
function M.setup()
	if O.fn == nil then
		print("O.fn is nil")
		return
	end

	local colors = require("colors." .. O.fn)

	-- if colors.type == "base16" then
	-- 	colors.setup()
	-- 	colors.create_statusline()
	-- 	return
	-- end

	colors.setup()
	local c = colors.colors

	--- Highlights
	-- StatuslineAccent
	-- StatuslineInsertAccent
	-- StatuslineVisualAccent
	-- StatuslineReplaceAccent
	-- StatuslineCmdLineAccent
	-- StatuslineTerminalAccent
	-- HarpoonActive
	-- HarpoonInactive
	-- Statusline
	-- StatusBarLong
	-- StatusEmpty
	-- StatusLineExtra

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

	---Override Defaults
	if colors.setup_status ~= nil then
		colors.setup_status()
	end
end

return M
