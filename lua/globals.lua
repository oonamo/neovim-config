-- source https://github.com/mcauley-penney/nvim/blob/main/lua/globals.lua
local sev = vim.diagnostic.severity

local borders = {
	none = { "", "", "", "", "", "", "", "" },
	invis = { " ", " ", " ", " ", " ", " ", " ", " " },
	thin = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
	edge = { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" }, -- Works in Kitty, Wezterm
}

local icons = {
	branch = "",
	bullet = "•",
	o_bullet = "○",
	check = "✔",
	d_chev = "∨",
	ellipses = "…",
	file = "╼",
	hamburger = "≡",
	lock = "",
	r_chev = ">",
	ballot_x = " ",
	up_tri = " ",
	info_i = " ",
	v_border = "▐",
	v_pipe = "▎",
	right = "",
	left = "",
	up = "",
	down = "",
	ArrowCircleDown = "",
	ArrowCircleLeft = "",
	ArrowCircleRight = "",
	ArrowCircleUp = "",
	BoldArrowDown = "",
	BoldArrowLeft = "",
	BoldArrowRight = "",
	BoldArrowUp = "",
	BoldClose = "",
	BoldDividerLeft = "",
	BoldDividerRight = "",
	BoldLineLeft = "▎",
	BoldLineMiddle = "┃",
	BoldLineDashedMiddle = "┋",
	BookMark = "",
	BoxChecked = " ",
	Bug = " ",
	Stacks = "",
	Scopes = "",
	Watches = "󰂥",
	DebugConsole = " ",
	Calendar = " ",
	Check = "",
	ChevronRight = "",
	ChevronShortDown = "",
	ChevronShortLeft = "",
	ChevronShortRight = "",
	ChevronShortUp = "",
	Circle = " ",
	Close = "󰅖",
	CloudDownload = " ",
	Code = "",
	Comment = "",
	Dashboard = "",
	DividerLeft = "",
	DividerRight = "",
	DoubleChevronRight = "»",
	Ellipsis = "",
	EmptyFolder = " ",
	EmptyFolderOpen = " ",
	File = " ",
	FileSymlink = "",
	Files = " ",
	FindFile = "󰈞",
	FindText = "󰊄",
	Fire = "",
	Folder = "󰉋 ",
	FolderOpen = " ",
	FolderSymlink = " ",
	Forward = " ",
	Gear = " ",
	History = " ",
	Lightbulb = " ",
	LineLeft = "▏",
	LineMiddle = "│",
	List = " ",
	Lock = " ",
	NewFile = " ",
	Note = " ",
	Package = " ",
	Pencil = "󰏫 ",
	Plus = " ",
	Project = " ",
	Search = " ",
	SignIn = " ",
	SignOut = " ",
	Tab = "󰌒 ",
	Table = " ",
	Target = "󰀘 ",
	Telescope = " ",
	Text = " ",
	Tree = "",
	Triangle = "󰐊",
	TriangleShortArrowDown = "",
	TriangleShortArrowLeft = "",
	TriangleShortArrowRight = "",
	TriangleShortArrowUp = "",
	kind = {
		Array = " ",
		Boolean = " ",
		Class = " ",
		Color = " ",
		Constant = " ",
		Constructor = " ",
		Enum = " ",
		EnumMember = " ",
		Event = " ",
		Field = " ",
		File = " ",
		Folder = "󰉋 ",
		Function = " ",
		Interface = " ",
		Key = " ",
		Keyword = " ",
		Method = " ",
		-- Module = " ",
		Module = " ",
		Namespace = " ",
		Null = "󰟢 ",
		Number = " ",
		Object = " ",
		Operator = " ",
		Package = " ",
		Property = " ",
		Reference = " ",
		Snippet = " ",
		String = " ",
		Struct = " ",
		Text = " ",
		TypeParameter = " ",
		Unit = " ",
		Value = " ",
		Variable = " ",
	},
	--  ballot_x = '✘',
	--  up_tri = '▲',
	--  info_i = '¡',
	x = "✘ ",
	LineAdded = "",
	LineModified = "",
	LineRemoved = "",
	FileDeleted = "",
	FileIgnored = "◌",
	FileRenamed = "",
	FileStaged = "S",
	FileUnmerged = "",
	FileUnstaged = "",
	FileUntracked = "U",
	Diff = "",
	Repo = "",
	Octoface = "",
	Branch = "",
}

_G.tools = {
	ui = {
		cur_border = borders.thin,
		borders = borders,
		icons = icons,
		lsp_signs = {
			-- [sev.ERROR] = { name = "Error", sym = icons["ballot_x"] },
			[sev.ERROR] = { name = "Error", sym = icons["x"] },
			[sev.WARN] = { name = "Warn", sym = icons["up_tri"] },
			[sev.INFO] = { name = "Info", sym = icons["info_i"] },
			[sev.HINT] = { name = "Hint", sym = icons["info_i"] },
		},
	},
}

_G.Config = {
	leader_group_clues = {
		{ mode = "n", keys = "<Leader>b", desc = "+Build" },
		{ mode = "n", keys = "<Leader>v", desc = "+Variable" },
		{ mode = "n", keys = "<Leader>d", desc = "+Debug" },
		{ mode = "n", keys = "<Leader>f", desc = "+Find" },
		{ mode = "n", keys = "<Leader>g", desc = "+Git" },
		{ mode = "n", keys = "<Leader>L", desc = "+Lua" },
		{ mode = "n", keys = "<Leader>o", desc = "+Obsidian" },
		{ mode = "n", keys = "<Leader>x", desc = "+Trouble" },
		{ mode = "n", keys = "<Leader>Lc", postkeys = "<leader>L", desc = "+Change" },
		{ mode = "n", keys = "<Leader>gd", desc = "+GitDiff" },
		{ mode = "n", keys = "<Leader>ga", desc = "+GitAdd" },
		{ mode = "n", keys = "<Leader>p", desc = "+Pick" },
		{ mode = "n", keys = "<Leader>pe", desc = "+Extras" },
		{ mode = "n", keys = "<Leader>pel", desc = "+List" },
	},
	submodes = {
		{ mode = "n", keys = "]b", postkeys = "]" },
		{ mode = "n", keys = "]w", postkeys = "]" },

		{ mode = "n", keys = "[b", postkeys = "[" },
		{ mode = "n", keys = "[w", postkeys = "[" },

		{ mode = "n", keys = "<leader>bd", postkeys = "<leader>b" },
	},
}
