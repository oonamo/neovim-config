local M = {}

M.colors = {}

function M.setup()
	O = { colorscheme = "rusticated", fn = "rusticated" }
	utils.hl = {
		opts = {},
	}

	vim.opt.background = "light"
end

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

function M.setup_status()
	utils.statuscolors = {
		opts = {
			{ "StatusLineExtra", { link = "MatchParen" } },
			{ "StatuslineAccent", { link = "DiffAdd" } },
			{ "StatuslineInsertAccent", { link = "StorageClass" } },
			{ "StatuslineVisualAccent", { link = "Define" } },
			{ "StatuslineReplaceAccent", { link = "Define" } },
			{ "StatuslineCmdLineAccent", { link = "Define" } },
			{ "StatuslineTerminalAccent", { link = "Define" } },
			{ "StatusEmpty", { link = "StatusLine" } },
			{ "StatusBarLong", { link = "StatusLine" } },
			{ "HarpoonInactive", { link = "CursorLine" } },
		},
	}

	utils:create_statusline()
end

return M
