local conditions = require("heirline.conditions")
local components = require("plugins.ui.heirline.components")
local chad = require("plugins.ui.heirline.chad")

local chadline = {
	chad.ViMode,
	-- M.space,
	chad.FileNameBlock,
	chad.space,
	chad.Git,
	chad.space,
	chad.grapple,
	chad.space,
	chad.Diagnostics,
	chad.space,
	chad.align,
	chad.WorkDir,
	chad.Ruler,
}

local function get_status()
	-- if vim.bo.filetype == "markdown" or vim.g.neovide then
	-- 	return writerStatus
	-- end
	if O.ui.statusline.chad then
		return chadline
	end
	if O.ui.statusline.tj then
		return require("plugins.ui.heirline.tjline")
	end
	if O.ui.statusline.everybody then
		return require("plugins.ui.heirline.everybody_wants_this_line")
	end
end

local StatusLine = {
	hl = function()
		if conditions.is_active() then
			return "StatusLine"
		else
			return "StatusLineNC"
		end
	end,
	fallthrough = false,
	get_status(),
}

local Winbar = components.Winbar
-- if TJ_STL_BG then
-- 	vim.api.nvim_set_hl(0, "StatusLine", { fg = utils.get_single_hl("Normal").background, bg = TJ_STL_BG })
-- end
return { statusline = StatusLine, winbar = Winbar }
