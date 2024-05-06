local conditions = require("heirline.conditions")
local components = require("plugins.ui.heirline.components")
local simple = require("plugins.ui.heirline.simple")
local chad = require("plugins.ui.heirline.chad")

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
	hl = { bg = "bg", fg = "fg" },
	condition = function()
		return vim.bo.filetype == "markdown"
	end,
	-- components.mode_block,
	-- components.ViMode,
	-- chad.ViMode,
	-- chad.FileNameBlock,
	-- chad.space,
	simple.FilePath,
	simple.trunc,
	-- components.space,
	-- components.Git,
	-- components.space,
	-- components.FileNameBlock,
	components.space,
	components.grapple,
	components.align,
	-- components.Spell,
	components.space,
	components.wordcount,
	-- components.space,
	-- components.SpaceCount,
	-- components.FileEncoding,
}
-- local brighter_fg = utils.brighten("Normal", 30, "background")
-- print(brighter_fg)
local minimalStatusLine = {
	hl = { bg = "bg", fg = "fg" },
	components.ViMode,
	components.space,
	components.Git,
	components.space,
	components.FileNameBlock,
	simple.FilePath,
	simple.trunc,
	components.space,
	-- components.grapple,
	components.space,
	components.Diagnostics,
	components.align,
	components.FileSize,
	components.space,
	components.Ruler,
	components.space,
	components.FilledFileType,

	-- components.space,
	-- components.Git,
	-- components.space,
	-- simple.FilePath,
	-- simple.trunc,
	-- components.FileNameModifer,
	-- components.align,
	-- components.wordcount,
}

local simpleStatusLine = {
	components.space,
	components.Git,
	components.space,
	simple.FilePath,
	simple.trunc,
	components.space,
	components.grapple,
	components.FileNameModifer,
	components.align,
	components.wordcount,
}

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
	if vim.bo.filetype == "markdown" or vim.g.neovide then
		return writerStatus
	end
	if O.ui.statusline.fancy then
		return defaultStatus
	end
	if O.ui.statusline.minimal then
		return minimalStatusLine
	end
	if O.ui.statusline.simple then
		return simpleStatusLine
	end
	if O.ui.statusline.chad then
		return chadline
	end
	if O.ui.statusline.tj then
		return require("plugins.ui.heirline.tjline")
	end
	if O.ui.statusline.ibh then
		return require("plugins.ui.heirline.ibhagan")
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
	writerStatus,
	get_status(),
}

local Winbar = components.Winbar
-- if TJ_STL_BG then
-- 	vim.api.nvim_set_hl(0, "StatusLine", { fg = utils.get_single_hl("Normal").background, bg = TJ_STL_BG })
-- end
return { statusline = StatusLine, winbar = Winbar }
