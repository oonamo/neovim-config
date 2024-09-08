local fmt = string.format

local function hue2rgb(p, q, t)
	if t < 0 then
		t = t + 1
	end
	if t > 1 then
		t = t - 1
	end
	if t < 1 / 6 then
		return p + (q - p) * 6 * t
	end
	if t < 1 / 2 then
		return q
	end
	if t < 2 / 3 then
		return p + (q - p) * (2 / 3 - t) * 6
	end
	return p
end
local function hsl(h, s, l, a)
	h = h / 360
	s = s / 100
	l = l / 100

	local r, g, b

	if s == 0 then
		r, g, b = l, l, l -- achromatic
	else
		local q = l < 0.5 and l * (1 + s) or l + s - l * s
		local p = 2 * l - q
		r = hue2rgb(p, q, h + 1 / 3)
		g = hue2rgb(p, q, h)
		b = hue2rgb(p, q, h - 1 / 3)
	end

	if not a then
		a = 1
	end
	r, g, b = fmt("%d", r * 255), fmt("%d", g * 255), fmt("%d", b * 255)
	local rgb = "#" .. fmt("%0x", r) .. fmt("%0x", g) .. fmt("%0x", b)
	return rgb -- rgb
end

local dark = {
	bg0 = hsl(300, 6, 8),
	bg1 = hsl(300, 6, 14),
	bg2 = hsl(300, 8, 18),
	bg3 = hsl(300, 8, 36),

	vs0 = hsl(310, 12, 20),

	fg0 = hsl(0, 25, 80),
	fg1 = hsl(0, 25, 70),
	fg8 = hsl(0, 15, 65),
	fg9 = hsl(0, 10, 55),

	er0 = hsl(7, 55, 50),
	er9 = hsl(7, 55, 20),

	yl0 = hsl(40, 40, 60),
	yl8 = hsl(40, 40, 30),
	yl9 = hsl(40, 40, 20),

	sr0 = hsl(300, 40, 65),
	sr1 = hsl(300, 35, 55),
	sr9 = hsl(300, 35, 20),

	gr0 = hsl(150, 35, 60),
	gr9 = hsl(150, 35, 20),

	gb0 = hsl(260, 35, 60),
	gb1 = hsl(260, 35, 50),
	gb9 = hsl(260, 35, 20),

	gp0 = hsl(270, 50, 65),
	gp1 = hsl(270, 40, 55),
	gp9 = hsl(270, 35, 20),

	sa0 = hsl(340, 35, 65),
	sa1 = hsl(340, 35, 55),

	pi0 = hsl(310, 15, 60),
	pi1 = hsl(310, 15, 45),
}

local light = {
	bg0 = hsl(300, 8, 90),
	bg1 = hsl(300, 8, 86),
	bg2 = hsl(300, 8, 82),
	bg3 = hsl(300, 8, 64),

	vs0 = hsl(310, 15, 75),

	fg0 = hsl(0, 25, 35),
	fg1 = hsl(0, 25, 40),
	fg8 = hsl(0, 15, 45),
	fg9 = hsl(0, 10, 50),

	er0 = hsl(7, 55, 45),
	er9 = hsl(7, 45, 50),

	yl0 = hsl(40, 45, 45),
	yl8 = hsl(40, 45, 50),
	yl9 = hsl(40, 40, 55),

	sr0 = hsl(300, 45, 45),
	sr1 = hsl(300, 45, 50),
	sr9 = hsl(300, 35, 55),

	gr0 = hsl(150, 35, 45),
	gr9 = hsl(150, 35, 50),

	gb0 = hsl(260, 35, 45),
	gb1 = hsl(260, 35, 50),
	gb9 = hsl(260, 35, 55),

	gp0 = hsl(270, 50, 45),
	gp1 = hsl(270, 40, 50),
	gp9 = hsl(270, 35, 55),

	sa0 = hsl(340, 40, 50),
	sa1 = hsl(340, 35, 55),

	pi0 = hsl(310, 20, 45),
	pi1 = hsl(310, 15, 50),
}

local palette = dark

if vim.o.background == "light" then
	palette = light
end

-- LSP/Linters mistakenly show `undefined global` errors in the spec, they may
-- support an annotation like the following. Consult your server documentation.
local theme = {
	-- The following are the Neovim (as of 0.8.0-dev+100-g371dfb174) highlight
	-- groups, mostly used for styling UI elements.
	-- Comment them out and add your own properties to override the defaults.
	-- An empty definition `{}` will clear all styling, leaving elements looking
	-- like the 'Normal' group.
	-- To be able to link to a group, it must already be defined, so you may have
	-- to reorder items as you go.
	--
	-- See :h highlight-groups
	--
	Normal = { bg = palette.bg0, fg = palette.fg0 }, -- Normal text
	ColorColumn = { bg = palette.bg2 }, -- Columns set with 'colorcolumn'
	Conceal = { bg = palette.bg0, fg = palette.fg0 }, -- Placeholder characters substituted for concealed text (see 'conceallevel')
	Cursor = { bg = palette.fg0, fg = palette.bg0 }, -- Character under the cursor
	CurSearch = { bg = palette.sr0, fg = palette.bg0 }, -- Highlighting a search pattern under the cursor (see 'hlsearch')
	-- lCursor        { }, -- Character under the cursor when |language-mapping| is used (see 'guicursor')
	-- CursorIM       { }, -- Like Cursor, but used when in IME mode |CursorIM|
	CursorColumn = { bg = palette.bg2 }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
	CursorLine = { link = "CursorColumn" }, -- Screen-line at the cursor, when 'cursorline' is set. Low-priority if foreground (ctermfg OR guifg) is not set.
	Directory = { bold = true }, -- Directory names (and other special names in listings)
	DiffAdd = { bg = palette.gr9 }, -- Diff mode: Added line |diff.txt|
	DiffChange = { bg = palette.yl9 }, -- Diff mode: Changed line |diff.txt|
	DiffDelete = { bg = palette.er9 }, -- Diff mode: Deleted line |diff.txt|
	DiffText = { bg = palette.yl8 }, -- Diff mode: Changed text within a changed line |diff.txt|
	-- EndOfBuffer    { }, -- Filler lines (~) after the end of the buffer. By default, this is highlighted like |hl-NonText|.
	-- TermCursor     { }, -- Cursor in a focused terminal
	-- TermCursorNC   { }, -- Cursor in an unfocused terminal
	ErrorMsg = { fg = palette.er0 }, -- Error messages on the command line
	VertSplit = { fg = palette.fg1 }, -- Column separating vertically split windows
	Folded = { bg = palette.bg2 }, -- Line used for closed folds
	LineNr = { fg = palette.bg3 }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
	LineNrAbove = { link = "LineNr" }, -- Line number for when the 'relativenumber' option is set, above the cursor line
	LineNrBelow = { link = "LineNr" }, -- Line number for when the 'relativenumber' option is set, below the cursor line
	FoldColumn = { link = "LineNr" }, -- 'foldcolumn'
	SignColumn = { link = "LineNr" }, -- Column where |signs| are displayed
	IncSearch = { link = "CurSearch" }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
	Substitute = { bg = palette.sr9, fg = palette.sr0 }, -- |:substitute| replacement text highlighting
	CursorLineNr = { fg = palette.fg1, italic = true, bold = true }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
	-- CursorLineFold { }, -- Like FoldColumn when 'cursorline' is set for the cursor line
	-- CursorLineSign { }, -- Like SignColumn when 'cursorline' is set for the cursor line
	-- MatchParen     { }, -- Character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
	ModeMsg = { fg = palette.pi0 }, -- 'showmode' message (e.g., "-- INSERT -- ")
	MsgArea = { link = "ModeMsg" }, -- Area for messages and cmdline
	MsgSeparator = { link = "ModeMsg" }, -- Separator for scrolled messages, `msgsep` flag of 'display'
	MoreMsg = { link = "ModeMsg" }, -- |more-prompt|
	-- NonText        { }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text = e.g., ">" displayed when a double-wide character doesn't fit at the end of the line. See also |hl-EndOfBuffer|.
	NormalFloat = { bg = palette.bg2, fg = palette.fg0 }, -- Normal text in floating windows.
	FloatBorder = { fg = palette.fg1 }, -- Border of floating windows.
	FloatTitle = { fg = palette.fg0, bold = true }, -- Title of floating windows.
	NormalNC = { link = "Normal" }, -- normal text in non-current windows
	Pmenu = { bg = palette.bg3, fg = palette.fg0 }, -- Popup menu: Normal item.
	PmenuSel = { bg = palette.pi0, fg = palette.bg0 }, -- Popup menu: Selected item.
	-- PmenuKind      { }, -- Popup menu: Normal item "kind"
	-- PmenuKindSel   { }, -- Popup menu: Selected item "kind"
	-- PmenuExtra     { }, -- Popup menu: Normal item "extra text"
	-- PmenuExtraSel  { }, -- Popup menu: Selected item "extra text"
	-- PmenuSbar      { }, -- Popup menu: Scrollbar.
	-- PmenuThumb     { }, -- Popup menu: Thumb of the scrollbar.
	Question = { fg = palette.fg0 }, -- |hit-enter| prompt and yes/no questions
	QuickFixLine = { link = "Question" }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
	Search = { bg = palette.sr1, fg = palette.bg0 }, -- Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
	-- SpecialKey     { }, -- Unprintable characters: text displayed differently from what it really is. But not 'listchars' whitespace. |hl-Whitespace|
	SpellBad = { sp = palette.er0, undercurl = true }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
	SpellCap = { sp = palette.yl0, undercurl = true }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
	SpellLocal = { sp = palette.gr0, undercurl = true }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
	SpellRare = { sp = palette.sr0, undercurl = true }, -- Word that is recognized by the spellchecker as one that is hardly ever used. |spell| Combined with the highlighting used otherwise.
	StatusLine = { bg = palette.bg2 }, -- Status line of current window
	-- StatusLineNC   { }, -- Status lines of not-current windows. Note: If this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
	-- TabLine        { }, -- Tab pages line, not active tab page label
	-- TabLineFill    { }, -- Tab pages line, where there are no labels
	-- TabLineSel     { }, -- Tab pages line, active tab page label
	Title = { fg = palette.fg0, bold = true }, -- Titles for output from ":set all", ":autocmd" etc.
	Visual = { bg = palette.vs0 }, -- Visual mode selection
	VisualNOS = { link = "Visual" }, -- Visual mode selection when vim is "Not Owning the Selection".
	WarningMsg = { fg = palette.yl0 }, -- Warning messages
	-- Whitespace     { }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
	-- Winseparator   { }, -- Separator between window splits. Inherts from |hl-VertSplit| by default, which it will replace eventually.
	Nvimseparator = { fg = palette.sa0 }, -- Separator between window splits. Inherts from |hl-VertSplit| by default, which it will replace eventually.
	-- WildMenu       { }, -- Current match in 'wildmenu' completion
	-- WinBar         { }, -- Window bar of current window
	-- WinBarNC       { }, -- Window bar of not-current windows

	-- Common vim syntax groups used for all kinds of code and markup.
	-- Commented-out groups should chain up to their preferred = * group
	-- by default.
	--
	-- See :h group-name
	--
	-- Uncomment and edit if you want more specific syntax highlighting.

	Comment = { fg = palette.bg3, italic = true }, -- Any comment

	Constant = { fg = palette.gp1 }, -- (*) Any constant
	String = { fg = palette.gb0, italic = true }, --   A string constant: "this is a string"
	Character = { fg = palette.gb1, italic = true },
	Number = { fg = palette.gp0 }, --   A number constant: 234, 0xff
	Boolean = { fg = palette.gp1, bold = true }, --   A boolean constant: TRUE, false
	Float = { link = "Number" }, --   A floating point constant: 2.3e10

	Identifier = { fg = palette.fg0 }, -- (*) Any variable name
	Function = { fg = palette.fg9 }, --   Function name (also: methods for classes)

	Statement = { fg = palette.pi1 }, -- (*) Any statement
	Repeat = { fg = palette.pi1 }, --   for, do, while, etc.
	Conditional = { fg = palette.pi0 }, --   if, then, else, endif, switch, etc.
	Label = { fg = palette.pi1, bold = true }, --   case, default, etc.
	Operator = { link = "Repeat" }, --   "sizeof", "+", "*", etc.
	Keyword = { link = "Conditional" }, --   any other keyword
	Exception = { link = "Label" }, --   try, catch, throw

	PreProc = { fg = palette.pi0, bold = true }, -- (*) Generic Preprocessor
	Include = { link = "PreProc" }, --   Preprocessor #include
	Define = { fg = palette.pi1 }, --   Preprocessor #define
	Macro = { link = "PreProc" }, --   Same as Define
	PreCondit = { link = "PreProc" }, --   Preprocessor #if, #else, #endif, etc.

	Type = { fg = palette.sa0, italic = true, bold = true }, -- (*) int, long, char, etc.
	StorageClass = { fg = palette.sa1 }, --   static, register, volatile, etc.
	Structure = { link = "Type" }, --   struct, union, enum, etc.
	Typedef = { link = "StorageClass" }, --   A typedef

	Special = { link = "Constant" }, -- (*) Any special symbol
	SpecialChar = { link = "Constant" }, --   Special character in a constant
	Tag = { link = "Constant" }, --   You can use CTRL-] on this
	Delimiter = { fg = palette.fg8 }, --   Character that needs attention
	SpecialComment = { link = "String" }, --   Special things inside a comment (e.g. '\n')
	Debug = { link = "String" }, --   Debugging statements

	Underlined = { underline = true }, -- Text that stands out, HTML links
	-- Ignore         { }, -- Left blank, hidden |hl-Ignore| = NOTE: May be invisible here in template
	Error = { bg = palette.er0 }, -- Any erroneous construct
	-- Todo           { }, -- Anything that needs extra attention; mostly the keywords TODO FIXME and XXX

	-- These groups are for the native LSP client and diagnostic system. Some
	-- other LSP clients may use these groups, or use their own. Consult your
	-- LSP client's documentation.

	-- See :h lsp-highlight, some groups may not be listed, submit a PR fix to lush-template!
	--
	-- LspReferenceText            { } , -- Used for highlighting "text" references
	-- LspReferenceRead            { } , -- Used for highlighting "read" references
	-- LspReferenceWrite           { } , -- Used for highlighting "write" references
	-- LspCodeLens                 { } , -- Used to color the virtual text of the codelens. See |nvim_buf_set_extmark= |.
	-- LspCodeLensSeparator        { } , -- Used to color the seperator between two or more code lens.
	-- LspSignatureActiveParameter { } , -- Used to highlight the active parameter in the signature help. See |vim.lsp.handlers.signature_help= |.

	-- See :h diagnostic-highlights, some groups may not be listed, submit a PR fix to lush-template!
	--
	DiagnosticError = { fg = palette.er0 }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
	DiagnosticWarn = { fg = palette.yl0 }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
	DiagnosticInfo = { fg = palette.gb0 }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
	DiagnosticHint = { fg = palette.pi0 }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
	DiagnosticOk = { fg = palette.gr0 }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
	DiagnosticVirtualTextError = { link = "DiagnosticError" }, -- Used for "Error" diagnostic virtual text.
	DiagnosticVirtualTextWarn = { link = "DiagnosticWarn" }, -- Used for "Warn" diagnostic virtual text.
	DiagnosticVirtualTextInfo = { link = "DiagnosticInfo" }, -- Used for "Info" diagnostic virtual text.
	DiagnosticVirtualTextHint = { link = "DiagnosticHint" }, -- Used for "Hint" diagnostic virtual text.
	DiagnosticVirtualTextOk = { link = "DiagnosticOk" }, -- Used for "Ok" diagnostic virtual text.
	DiagnosticUnderlineError = { sp = palette.er0, undercurl = true }, -- Used to underline "Error" diagnostics.
	DiagnosticUnderlineWarn = { sp = palette.yl0, undercurl = true }, -- Used to underline "Warn" diagnostics.
	DiagnosticUnderlineInfo = { sp = palette.gb0, undercurl = true }, -- Used to underline "Info" diagnostics.
	DiagnosticUnderlineHint = { sp = palette.pi0, undercurl = true }, -- Used to underline "Hint" diagnostics.
	DiagnosticUnderlineOk = { sp = palette.gr0, undercurl = true }, -- Used to underline "Ok" diagnostics.
	-- DiagnosticFloatingError    { } , -- Used to color "Error" diagnostic messages in diagnostics float. See |vim.diagnostic.open_float= |
	-- DiagnosticFloatingWarn     { } , -- Used to color "Warn" diagnostic messages in diagnostics float.
	-- DiagnosticFloatingInfo     { } , -- Used to color "Info" diagnostic messages in diagnostics float.
	-- DiagnosticFloatingHint     { } , -- Used to color "Hint" diagnostic messages in diagnostics float.
	-- DiagnosticFloatingOk       { } , -- Used to color "Ok" diagnostic messages in diagnostics float.
	-- DiagnosticSignError        { } , -- Used for "Error" signs in sign column.
	-- DiagnosticSignWarn         { } , -- Used for "Warn" signs in sign column.
	-- DiagnosticSignInfo         { } , -- Used for "Info" signs in sign column.
	-- DiagnosticSignHint         { } , -- Used for "Hint" signs in sign column.
	-- DiagnosticSignOk           { } , -- Used for "Ok" signs in sign column.

	Added = { fg = palette.gr0 },
	Changed = { fg = palette.yl0 },
	Removed = { fg = palette.er0 },

	GitSignsAdd = { fg = palette.gr0 },
	GitSignsChange = { fg = palette.yl0 },
	GitSignsChangedelete = { fg = palette.sr0 },
	GitSignsDelete = { fg = palette.er0 },

	TodoBgNOTE = { fg = palette.pi0, bold = true },
	TodoBgTODO = { fg = palette.sa0, bold = true },
	TodoBgPERF = { fg = palette.gr0, bold = true },
	TodoBgHACK = { fg = palette.gb0, bold = true },
	TodoBgWARN = { fg = palette.er0, bold = true },
	TodoBgFIX = { fg = palette.yl0, bold = true },

	RainbowDelimiterRed = { fg = palette.fg9 },
	RainbowDelimiterYellow = { fg = palette.fg8 },
	RainbowDelimiterBlue = { fg = palette.sa0 },
	RainbowDelimiterGreen = { fg = palette.pi0 },
	RainbowDelimiterOrange = { fg = palette.sr0 },
	RainbowDelimiterViolet = { fg = palette.sr1 },
	RainbowDelimiterCyan = { fg = palette.fg1 },

	TelescopeSelection = { bg = palette.bg2 },
	TelescopeTitle = { fg = palette.sa0, bold = true },
	TelescopeMatching = { fg = palette.sr0 },

	IblScope = { fg = palette.sa0 },
	IblIndent = { fg = palette.pi1 },

	NvimTreeNormal = { bg = palette.bg1 },

	-- Tree-Sitter syntax groups.
	--
	-- See :h treesitter-highlight-groups, some groups may not be listed,
	-- submit a PR fix to lush-template!
	--
	-- Tree-Sitter groups are defined with an "@" symbol, which must be
	-- specially handled to be valid lua code, we do this via the special
	-- sym function. The following are all valid ways to call the sym function,
	-- for more details see https://www.lua.org/pil/5.html
	--
	-- sym("@text.literal")
	-- sym('@text.literal')
	-- sym"@text.literal"
	-- sym'@text.literal'
	--
	-- For more information see https://github.com/rktjmp/lush.nvim/issues/109

	-- sym"@text.literal"      { }, -- Comment
	-- sym"@text.reference"    { }, -- Identifier
	-- sym"@text.title"        { }, -- Title
	-- sym"@text.uri"          { }, -- Underlined
	-- sym"@text.underline"    { }, -- Underlined
	-- sym"@text.todo"         { }, -- Todo
	-- sym"@comment"           { }, -- Comment
	-- sym"@punctuation"       { }, -- Delimiter
	["@constant"] = { link = "Constant" }, -- Constant
	["@constant.builtin"] = { link = "Special" }, -- Special
	-- "@constant.macro"    { }, -- Define
	-- sym"@define"            { }, -- Define
	-- sym"@macro"             { }, -- Macro
	["@string"] = { link = "String" }, -- String
	["@string.escape"] = { link = "SpecialChar" }, -- SpecialChar
	["@string.special"] = { link = "SpecialChar" }, -- SpecialChar
	["@character"] = { link = "Character" }, -- Character
	["@character.special"] = { link = "SpecialChar" }, -- SpecialChar
	["@number"] = { link = "Number" }, -- Number
	["@boolean"] = { link = "Boolean" }, -- Boolean
	["@float"] = { link = "Float" }, -- Float
	["@function"] = { link = "Function" }, -- Function
	["@function.builtin"] = { link = "Special" }, -- Special
	["@function.macro"] = { link = "Macro" }, -- Macro
	["@parameter"] = { fg = palette.fg1 }, -- Identifier
	["@method"] = { link = "Function" }, -- Function
	["@field"] = { fg = palette.fg1 }, -- Identifier
	["@property"] = { fg = palette.fg1 }, -- Identifier
	["@constructor"] = { link = "Special" }, -- Special
	["@conditional"] = { link = "Conditional" }, -- Conditional
	["@repeat"] = { link = "Repeat" }, -- Repeat
	["@label"] = { link = "Label" }, -- Label
	["@operator"] = { link = "Operator" }, -- Operator
	["@keyword"] = { link = "Keyword" }, -- Keyword
	["@exception"] = { link = "Exception" }, -- Exception
	["@variable"] = { link = "Identifier" }, -- Identifier
	["@type"] = { link = "Type" }, -- Type
	["@type.definition"] = { link = "Typedef" }, -- Typedef
	["@storageclass"] = { link = "StorageClass" }, -- StorageClass
	["@structure"] = { link = "Structure" }, -- Structure
	-- sym"@namespace"         { }, -- Identifier
	["@include"] = { link = "Include" }, -- Include
	["@preproc"] = { link = "PreProc" }, -- PreProc
	["@debug"] = { link = "Debug" }, -- Debug
	-- sym"@tag"               { }, -- Tag

	["@type.builtin.cpp"] = { link = "Type" },
	["@keyword.repeat.cpp"] = { link = "Repeat" },
	["@keyword.conditional.cpp"] = { link = "Conditional" },
	["@keyword.import.cpp"] = { link = "Include" },
	["@keyword.directive.define.cpp"] = { link = "Define" },
}

for k, v in pairs(theme) do
	vim.api.nvim_set_hl(0, k, v)
end
