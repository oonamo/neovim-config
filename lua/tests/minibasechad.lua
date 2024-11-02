local M = {}
local utils = require("tests.utils")

---@param name string
---@param theme table
---@param base30 table
---@param override? fun(table, table): table
function M.gencolorscheme(name, theme, base30, override)
	require("mini.base16").setup({ palette = theme })
	M.minioverrides()
	for _, v in ipairs(M.clearhi()) do
		vim.api.nvim_set_hl(0, v, {})
	end
	for k, v in pairs(M.getminipick(theme, base30)) do
		vim.api.nvim_set_hl(0, k, v)
	end
	for k, v in pairs(M.gettreesitter(theme, base30)) do
		vim.api.nvim_set_hl(0, k, v)
	end
	for k, v in pairs(M.getsemantictokens(theme, base30)) do
		vim.api.nvim_set_hl(0, k, v)
	end
	for k, v in pairs(M.getcmp(theme, base30)) do
		vim.api.nvim_set_hl(0, k, v)
	end
	for k, v in pairs(M.getdefaults(theme, base30)) do
		vim.api.nvim_set_hl(0, k, v)
	end
	for k, v in pairs(M.getstatusline(theme, base30)) do
		vim.api.nvim_set_hl(0, k, v)
	end
	for k, v in pairs(M.getrendermarkdown(theme, base30)) do
		vim.api.nvim_set_hl(0, k, v)
	end

	local overrides = override and type(override) == "function" and override(theme, base30) or {}

	for k, v in pairs(overrides) do
		vim.api.nvim_set_hl(0, k, v)
	end
	require("mini.colors").get_colorscheme(nil, { new_name = name }):compress():add_cterm_attributes():write()
end

function M.minioverrides()
	for _, v in ipairs({ "Add", "Change", "Delete" }) do
		local hl = vim.api.nvim_get_hl(0, { name = "MiniDiffSign" .. v })
		if not vim.tbl_isempty(hl) then
			vim.api.nvim_set_hl(0, "MiniDiffSign" .. v, { fg = hl.fg })
		end
	end

	---Trys to set DiagnosticSign hls from a basename
	---If it has a link such as DiagnosticFloat, it returns that link
	---@param effective_name string Name to find hl
	local function try_diagnostics(effective_name)
		for _, v in ipairs({ "Error", "Warn", "Info", "Hint", "Ok" }) do
			local hl = vim.api.nvim_get_hl(0, { name = effective_name .. v, link = true })
			if not vim.tbl_isempty(hl) then
				if hl.link ~= nil then
					-- Remove the "Error"/"Warn"..etc portion of the link
					return hl.link:sub(0, -(#v + 1))
				end
				vim.api.nvim_set_hl(0, effective_name .. v, { fg = hl.fg })
			end
		end
	end

	local effective_name = "DiagnosticSign"
	effective_name = try_diagnostics(effective_name)
	if effective_name then
		try_diagnostics(effective_name)
	end
end

function M.clearhi()
	return {
		"SignColumn",
		"CursorLine",
		"LineNr",
		"LineNrAbove",
		"LineNrBelow",
    "@markup.quote",
	}
end

function M.gettreesitter(theme, base30)
	return {
		["@variable"] = { fg = theme.base05 },
		["@variable.builtin"] = { fg = theme.base09 },
		["@variable.parameter"] = { fg = theme.base08 },
		["@variable.member"] = { fg = theme.base08 },
		["@variable.member.key"] = { fg = theme.base08 },

		["@module"] = { fg = theme.base08 },
		-- ["@module.builtin"] = { fg = theme.base08 },

		["@constant"] = { fg = theme.base08 },
		["@constant.builtin"] = { fg = theme.base09 },
		["@constant.macro"] = { fg = theme.base08 },

		["@string"] = { fg = theme.base0B },
		["@string.regex"] = { fg = theme.base0C },
		["@string.escape"] = { fg = theme.base0C },
		["@character"] = { fg = theme.base08 },
		-- ["@character.special"] = { fg = theme.base08 },
		["@number"] = { fg = theme.base09 },
		["@number.float"] = { fg = theme.base09 },

		["@annotation"] = { fg = theme.base0F },
		["@attribute"] = { fg = theme.base0A },
		["@error"] = { fg = theme.base08 },

		["@keyword.exception"] = { fg = theme.base08 },
		["@keyword"] = { fg = theme.base0E },
		["@keyword.function"] = { fg = theme.base0E },
		["@keyword.return"] = { fg = theme.base0E },
		["@keyword.operator"] = { fg = theme.base0E },
		["@keyword.import"] = { link = "Include" },
		["@keyword.conditional"] = { fg = theme.base0E },
		["@keyword.conditional.ternary"] = { fg = theme.base0E },
		["@keyword.repeat"] = { fg = theme.base0A },
		["@keyword.storage"] = { fg = theme.base0A },
		["@keyword.directive.define"] = { fg = theme.base0E },
		["@keyword.directive"] = { fg = theme.base0A },

		["@function"] = { fg = theme.base0D },
		["@function.builtin"] = { fg = theme.base0D },
		["@function.macro"] = { fg = theme.base08 },
		["@function.call"] = { fg = theme.base0D },
		["@function.method"] = { fg = theme.base0D },
		["@function.method.call"] = { fg = theme.base0D },
		["@constructor"] = { fg = theme.base0C },

		["@operator"] = { fg = theme.base05 },
		["@reference"] = { fg = theme.base05 },
		["@punctuation.bracket"] = { fg = theme.base0F },
		["@punctuation.delimiter"] = { fg = theme.base0F },
		["@symbol"] = { fg = theme.base0B },
		["@tag"] = { fg = theme.base0A },
		["@tag.attribute"] = { fg = theme.base08 },
		["@tag.delimiter"] = { fg = theme.base0F },
		["@text"] = { fg = theme.base05 },
		["@text.emphasis"] = { fg = theme.base09 },
		["@text.strike"] = { fg = theme.base0F, strikethrough = true },
		["@type.builtin"] = { fg = theme.base0A },
		["@definition"] = { sp = theme.base04, underline = true },
		["@scope"] = { bold = true },
		["@property"] = { fg = theme.base08 },

		-- markup
		["@markup.heading"] = { fg = theme.base0D },
		["@markup.raw"] = { fg = theme.base09 },
		["@markup.link"] = { fg = theme.base08 },
		["@markup.link.url"] = { fg = theme.base09, underline = true },
		["@markup.link.label"] = { fg = theme.base0C },
		["@markup.list"] = { fg = theme.base08 },
		["@markup.strong"] = { bold = true },
		["@markup.underline"] = { underline = true },
		["@markup.italic"] = { italic = true },
		["@markup.strikethrough"] = { strikethrough = true },
		["@markup.quote"] = { bg = base30.black2 },

		["@markup.heading.1.markdown"] = { link = "markdownH1" },
		["@markup.heading.2.markdown"] = { link = "markdownH2" },
		["@markup.heading.3.markdown"] = { link = "markdownH3" },
		["@markup.heading.4.markdown"] = { link = "markdownH4" },
		["@markup.heading.5.markdown"] = { link = "markdownH5" },
		["@markup.heading.6.markdown"] = { link = "markdownH6" },
		["@markup.heading.1.marker.markdown"] = { link = "markdownH1Delimiter" },
		["@markup.heading.2.marker.markdown"] = { link = "markdownH2Delimiter" },
		["@markup.heading.3.marker.markdown"] = { link = "markdownH3Delimiter" },
		["@markup.heading.4.marker.markdown"] = { link = "markdownH4Delimiter" },
		["@markup.heading.5.marker.markdown"] = { link = "markdownH5Delimiter" },
		["@markup.heading.6.marker.markdown"] = { link = "markdownH6Delimiter" },

		["@comment"] = { fg = base30.grey_fg },
		["@comment.todo"] = { fg = base30.grey, bg = base30.white },
		["@comment.warning"] = { fg = base30.black2, bg = theme.base09 },
		["@comment.note"] = { fg = base30.black, bg = base30.blue },
		["@comment.danger"] = { fg = base30.black2, bg = base30.red },

		["@diff.plus"] = { fg = base30.green },
		["@diff.minus"] = { fg = base30.red },
		["@diff.delta"] = { fg = base30.light_grey },
	}
end

function M.getsemantictokens(theme, _)
	return {
		["@lsp.type.class"] = { link = "Structure" },
		["@lsp.type.decorator"] = { link = "Function" },
		["@lsp.type.enum"] = { link = "Type" },
		["@lsp.type.enumMember"] = { link = "Constant" },
		["@lsp.type.function"] = { link = "@function" },
		["@lsp.type.interface"] = { link = "Structure" },
		["@lsp.type.macro"] = { link = "@macro" },
		["@lsp.type.method"] = { link = "@function.method" },
		["@lsp.type.namespace"] = { link = "@module" },
		["@lsp.type.parameter"] = { link = "@variable.parameter" },
		["@lsp.type.property"] = { link = "@property" },
		["@lsp.type.struct"] = { link = "Structure" },
		["@lsp.type.type"] = { link = "@type" },
		["@lsp.type.typeParamater"] = { link = "TypeDef" },
		["@lsp.type.variable"] = { link = "@variable" },
		["@event"] = { fg = theme.base08 },
		["@modifier"] = { fg = theme.base08 },
		["@regexp"] = { fg = theme.base0F },
	}
end

function M.getcmp(theme, base30)
	return {
		CmpItemKindConstant = { fg = theme.base09 },
		CmpItemKindFunction = { fg = theme.base0D },
		CmpItemKindIdentifier = { fg = theme.base08 },
		CmpItemKindField = { fg = theme.base08 },
		CmpItemKindVariable = { fg = theme.base0E },
		CmpItemKindSnippet = { fg = base30.red },
		CmpItemKindText = { fg = theme.base0B },
		CmpItemKindStructure = { fg = theme.base0E },
		CmpItemKindType = { fg = theme.base0A },
		CmpItemKindKeyword = { fg = theme.base07 },
		CmpItemKindMethod = { fg = theme.base0D },
		CmpItemKindConstructor = { fg = base30.blue },
		CmpItemKindFolder = { fg = theme.base07 },
		CmpItemKindModule = { fg = theme.base0A },
		CmpItemKindProperty = { fg = theme.base08 },
		CmpItemKindEnum = { fg = base30.blue },
		CmpItemKindUnit = { fg = theme.base0E },
		CmpItemKindClass = { fg = base30.teal },
		CmpItemKindFile = { fg = theme.base07 },
		CmpItemKindInterface = { fg = base30.green },
		CmpItemKindColor = { fg = base30.white },
		CmpItemKindReference = { fg = theme.base05 },
		CmpItemKindEnumMember = { fg = base30.purple },
		CmpItemKindStruct = { fg = theme.base0E },
		CmpItemKindValue = { fg = base30.cyan },
		CmpItemKindEvent = { fg = base30.yellow },
		CmpItemKindOperator = { fg = theme.base05 },
		CmpItemKindTypeParameter = { fg = theme.base08 },
		CmpItemKindCopilot = { fg = base30.green },
		CmpItemKindCodeium = { fg = base30.vibrant_green },
		CmpItemKindTabNine = { fg = base30.baby_pink },
		CmpItemKindSuperMaven = { fg = base30.yellow },
		CmpItemAbbr = { fg = base30.white },
		CmpItemAbbrMatch = { fg = base30.blue, bold = true },
		CmpDoc = { bg = base30.black },
		CmpDocBorder = { fg = base30.grey_fg },
		CmpPmenu = { bg = base30.black },
		PmenuSel = { bg = base30.pmenu_bg, fg = base30.black },
		Pmenu = { link = "CmpPmenu" },
		CmpSel = { link = "PmenuSel", bold = true },
		CmpBorder = { fg = base30.grey_fg },
		FloatBorder = { link = "CmpBorder" },
	}
end

function M.getminipick(_, colors)
	return {
		MiniPickBorder = { fg = colors.darker_black, bg = colors.darker_black },
		MiniPickBorderBusy = { fg = colors.yellow, bg = colors.darker_black },
		-- MiniPickBorderText = { fg = colors.white, bg = colors.black2 },
		MiniPickBorderText = { bg = colors.red, fg = colors.black },
		-- MiniPickCursor = { },
		-- MiniPickIconDirectory = {},
		-- MiniPickIconFile = {},
		MiniPickHeader = { fg = colors.black, bg = colors.red },
		-- MiniPickMatchCurrent = {},
		-- MiniPickMatchMarked = {},
		-- MiniPickMatchRanges = {},
		MiniPickNormal = { bg = colors.darker_black },
		-- MiniPickPreviewLine = {},
		-- MiniPickPreviewRegion = {},
		MiniPickPrompt = { fg = colors.white, bg = colors.black2 },
	}
end

function M.getdefaults(theme, base30)
	return {
		Added = { fg = base30.green },
		Removed = { fg = base30.red },
		Changed = { fg = base30.yellow },
		MatchWord = { bg = base30.grey, fg = base30.white },
		Pmenu = { bg = base30.one_bg },
		PmenuSbar = { bg = base30.one_bg },
		PmenuSel = { bg = base30.pmenu_bg, fg = base30.black },
		PmenuThumb = { bg = base30.grey },
		MatchParen = { link = "MatchWord" },
		Comment = { fg = base30.light_grey },
		CursorLineNr = { fg = base30.white },
		LineNr = { fg = base30.grey },
		LineNrAbove = { fg = base30.grey },
		LineNrBelow = { fg = base30.grey },
		FloatBorder = { fg = base30.blue },
		FloatTitle = { fg = base30.white, bg = base30.grey },
		NormalFloat = { bg = base30.darker_black },
		NvimInternalError = { fg = base30.red },
		WinSeparator = { fg = base30.line },
		Normal = { fg = theme.base05, bg = theme.base00 },
		DevIconDefault = { fg = base30.red },
		Debug = { fg = theme.base08 },
		Directory = { fg = theme.base0D },
		Error = { fg = theme.base00, bg = theme.base08 },
		ErrorMsg = { fg = theme.base08, bg = theme.base00 },
		Exception = { fg = theme.base08 },
		FoldColumn = { bg = "none" },
		Folded = { fg = base30.light_grey, bg = base30.black2 },
		IncSearch = { fg = theme.base01, bg = theme.base09 },
		Macro = { fg = theme.base08 },
		ModeMsg = { fg = theme.base0B },
		MoreMsg = { fg = theme.base0B },
		Question = { fg = theme.base0D },
		Search = { fg = theme.base01, bg = theme.base0A },
		Substitute = { fg = theme.base01, bg = theme.base0A },
		SpecialKey = { fg = theme.base03 },
		TooLong = { fg = theme.base08 },
		Visual = { bg = theme.base02 },
		VisualNOS = { fg = theme.base08 },
		WarningMsg = { fg = theme.base08 },
		WildMenu = { fg = theme.base08, bg = theme.base0A },
		Title = { fg = theme.base0D },
		Conceal = { bg = "NONE" },
		Cursor = { fg = theme.base00, bg = theme.base05 },
		NonText = { fg = theme.base03 },
		SignColumn = { fg = theme.base03 },
		ColorColumn = { bg = base30.black2 },
		CursorColumn = { bg = theme.base01 },
		CursorLine = { bg = base30.black2 },
		QuickFixLine = { bg = theme.base01 },
		healthSuccess = { bg = base30.green, fg = base30.black },
		WinBar = { bg = "NONE" },
		WinBarNC = { bg = "NONE" },
		markdownDelimiter = { fg = base30.one_bg },
		markdownH1 = { fg = base30.dark_purple, bold = true },
		markdownH1Delimiter = { link = "markdownH1" },
		markdownH2 = { fg = base30.blue, bold = true },
		markdownH2Delimiter = { link = "markdownH2" },
		markdownH3 = { fg = base30.green, bold = true },
		markdownH3Delimiter = { link = "markdownH3" },
		markdownH4 = { fg = base30.yellow, bold = true },
		markdownH4Delimiter = { link = "markdownH4" },
		markdownH5 = { fg = base30.red, bold = true },
		markdownH5Delimiter = { link = "markdownH5" },
		markdownH6 = { fg = base30.orange, bold = true },
		markdownH6Delimiter = { link = "markdownH6" },
		markdownLinkText = { link = "markdownUrl" },
		markdownUrl = { fg = base30.dark_purple, sp = base30.dark_purple, underline = true },
	}
end

function M.getstatusline(_, base30)
	return {
		StatusLine = { bg = base30.statusline_bg },
	}
end

function M.getrendermarkdown(_, base30)
	return {
		RenderMarkdownH1Bg = { bg = utils.blend(base30.dark_purple, base30.black, 20 / 100) },
		RenderMarkdownH2Bg = { bg = utils.blend(base30.blue, base30.black, 20 / 100) },
		RenderMarkdownH3Bg = { bg = utils.blend(base30.green, base30.black, 20 / 100) },
		RenderMarkdownH4Bg = { bg = utils.blend(base30.yellow, base30.black, 20 / 100) },
		RenderMarkdownH5Bg = { bg = utils.blend(base30.red, base30.black, 20 / 100) },
		RenderMarkdownH6Bg = { bg = utils.blend(base30.orange, base30.black, 20 / 100) },
	}
end

return M
