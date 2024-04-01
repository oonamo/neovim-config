local conditions = require("heirline.conditions")
local components = require("plugins.ui.heirline.components")

local defaultStatus = {
	hl = { bg = "bg", fg = "fg" },
	components.mode_block,
	components.space,
	components.Git,
	components.space,
	components.space,
	components.FileNameBlock,
	components.space,
	components.MacroRec,
	components.space,
	components.grapple,
	components.space,
	components.Diagnostics,
	components.align,
	components.space,
	components.LSPActive,
	components.space,
	components.SearchCount,
	components.space,
	components.FileType,
	components.space,
	components.Ruler,
	components.space,
	-- components.mode_block,
}

local writerStatus = {
	components.mode_block,
	components.space,
	components.Git,
	components.space,
	components.FileNameBlock,
	components.space,
	components.grapple,
	components.align,
	components.Spell,
	components.space,
	components.wordcount,
	components.space,
	components.SpaceCount,
}

local function get_status()
	if vim.bo.filetype == "markdown" then
		return writerStatus
	else
		return defaultStatus
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

return { statusline = StatusLine, winbar = Winbar }
