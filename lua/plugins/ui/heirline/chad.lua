local M = {}
local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
local minimal_fg = vim.o.background == "light" and "white" or "black"
local default = { left = "", right = "" }
local function ChadSeps(highlight)
	return {
		condition = function()
			return O.ui.statusline.chad == true
		end,
		provider = function()
			return default.right
		end,
		hl = highlight,
	}
end
M.icons = {
	-- ✗   󰅖 󰅘 󰅚 󰅙 󱎘 
	close = "󰅙 ",
	dir = "󰉋 ",
	lsp = " ", --   
	vim = " ",
	debug = " ",
	err = " ",
	warn = " ",
	info = " ",
	hint = " ",
	hamburger = "≡",
}

M.ViMode = {
	init = function(self)
		self.mode = vim.fn.mode(1) -- :h mode()
		self.icon = "󰈚"
		local path = vim.api.nvim_buf_get_name(0)
		local name = (path == "" and "Empty ") or path:match("([^/\\]+)[/\\]*$")
		if name ~= "Empty " then
			local devicons_present, devicons = pcall(require, "nvim-web-devicons")

			if devicons_present then
				local ft_icon = devicons.get_icon(name)
				self.icon = (ft_icon ~= nil and ft_icon) or self.icon
			end
		end
	end,
	static = {
		mode_names = { -- change the strings if you like it vvvvverbose!
			n = "Normal",
			no = "N?",
			nov = "N?",
			noV = "N?",
			["no\22"] = "N?",
			niI = "Ni",
			niR = "Nr",
			niV = "Nv",
			nt = "Nt",
			v = "Visual",
			vs = "Vs",
			V = "V_",
			Vs = "Vs",
			["\22"] = "^V",
			["\22s"] = "^V",
			s = "S",
			S = "S_",
			["\19"] = "^S",
			i = "Insert",
			ic = "Ic",
			ix = "Ix",
			R = "R",
			Rc = "Rc",
			Rx = "Rx",
			Rv = "Rv",
			Rvc = "Rv",
			Rvx = "Rv",
			c = "Command",
			cv = "Ex",
			r = "...",
			rm = "M",
			["r?"] = "?",
			["!"] = "!",
			t = "Term",
		},
		mode_colors = {
			n = "cyan",
			i = "green",
			v = "cyan",
			V = "cyan",
			["\22"] = "cyan",
			c = "orange",
			s = "purple",
			S = "purple",
			["\19"] = "purple",
			R = "orange",
			r = "orange",
			["!"] = "red",
			t = "red",
		},
	},
	-- We can now access the value of mode() that, by now, would have been
	-- computed by `init()` and use it to index our strings dictionary.
	-- note how `static` fields become just regular attributes once the
	-- component is instantiated.
	-- To be extra meticulous, we can also add some vim statusline syntax to
	-- control the padding and make sure our string is always at least 2
	-- characters long. Plus a nice Icon.
	provider = function(self)
		return "  " .. self.mode_names[self.mode]
	end,
	-- Same goes for the highlight. Now the foreground will change according to the current mode.
	hl = function(self)
		local mode = self.mode:sub(1, 1) -- get only the first mode character
		return { bg = self.mode_colors[mode], fg = "bg", bold = true }
	end,
	update = {
		"ModeChanged",
		pattern = "*:*",
		callback = vim.schedule_wrap(function()
			vim.cmd("redrawstatus")
		end),
	},
	ChadSeps(function(self)
		return { fg = self.mode_colors[self.mode:sub(1, 1)], bg = "gray", bold = true }
	end),
	-- ChadSeps({ fg = "gray", bg = "gray" }),
	ChadSeps({ fg = "gray", bg = "bright_bg" }),
	-- ChadSeps({ bg = "bright_bg", fg = "gray" }),
}

M.mode_block = {
	init = function(self)
		self.mode = vim.fn.mode(1)
	end,
	static = {
		mode_colors = {
			n = "cyan",
			i = "green",
			v = "cyan",
			V = "cyan",
			["\22"] = "cyan",
			c = "orange",
			s = "purple",
			S = "purple",
			["\19"] = "purple",
			R = "orange",
			r = "orange",
			["!"] = "red",
			t = "red",
		},
	},
	provider = "█",
	hl = function(self)
		local mode = self.mode:sub(1, 1) -- get only the first mode character
		return { fg = self.mode_colors[mode], bold = true }
	end,
	update = {
		"ModeChanged",
		pattern = "*:*",
		callback = vim.schedule_wrap(function()
			vim.cmd("redrawstatus")
		end),
	},
}

M.FileNameBlock = {
	{
		condition = function()
			return package.loaded["incline"] == nil
		end,
	},
	init = function(self)
		self.filename = vim.api.nvim_buf_get_name(0)
	end,
	hl = { bg = "bright_bg", fg = "white" },
	-- ChadSeps({ fg = "bright_bg", bg = "bg" }),
}

M.FileIcon = {
	init = function(self)
		local filename = self.filename
		local extension = vim.fn.fnamemodify(filename, ":e")
		self.icon, self.icon_color =
			require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
	end,
	provider = function(self)
		return self.icon and (self.icon .. " ")
	end,
	hl = function(self)
		return { fg = self.icon_color }
	end,
	-- condition = function()
	-- 	return O.ui.statusline.fancy
	-- end,
}

M.FileName = {
	provider = function(self)
		local filename = vim.fn.fnamemodify(self.filename, ":.")
		if filename == "" then
			return "[No Name]"
		end
		-- now, if the filename would occupy more than 1/4th of the available
		-- space, we trim the file path to its initials
		-- See Flexible Components section below for dynamic truncation
		if not conditions.width_percent_below(#filename, 0.25) then
			filename = vim.fn.fnamemodify(filename, ":t")
		end
		return filename
	end,
	-- hl = function()
	-- 	-- if O.ui.statusline.minimal then
	-- 	-- 	return { fg = minimal_fg }
	-- 	-- end
	-- 	return { fg = utils.get_highlight("Directory").fg }
	-- end,
}

M.block = {
	provider = "█",
	hl = { fg = utils.get_highlight("Folded").fg, bg = utils.get_highlight("Folded").bg },
}

M.FileFlags = {
	{
		condition = function()
			return vim.bo.modified
		end,
		provider = "[+]",
		-- hl = { fg = "green" },
	},
	{
		condition = function()
			return not vim.bo.modifiable or vim.bo.readonly
		end,
		provider = "",
		-- hl = { fg = "orange" },
	},
}

M.FileNameModifer = {
	hl = function()
		if vim.bo.modified then
			-- use `force` because we need to override the child's hl foreground
			-- return { fg = "cyan", bold = true, force = true }
		end
	end,
}

M.FileNameBlock = utils.insert(
	-- M.FileIcon,
	{
		condition = function()
			return package.loaded["incline"] == nil
		end,
	},
	M.FileNameBlock,
	-- M.Space,
	utils.insert(M.FileNameModifer, M.FileName), -- a new table where FileName is a child of FileNameModifier
	-- M.FileFlags,
	{ provider = "%<" }, -- this means that the statusline is cut here when there's not enough space
	-- ChadSeps({ bg = "bg", fg = "white" })
	-- ChadSeps({ bg = "bright_bg", fg = "white" })
	-- ChadSeps({ fg = "bright_bg", bg = "bright_bg" }),
	ChadSeps({ fg = "bright_bg", bg = "bg" })
)

M.FilledFileType = {
	provider = function()
		return " " .. M.icons.hamburger .. " " .. vim.bo.filetype
	end,
	hl = { bg = "purple", bold = true, fg = minimal_fg },
}

M.FileType = {
	provider = function()
		return string.upper(vim.bo.filetype)
	end,
	hl = { fg = utils.get_highlight("Type").fg, bold = true }, -- get_highlight "Type",
}

M.FileEncoding = {
	provider = function()
		local enc = (vim.bo.fenc ~= "" and vim.bo.fenc) or vim.o.enc -- :h 'enc'
		return enc ~= "utf-8" and enc:upper()
	end,
}

M.FileFormat = {
	provider = function()
		local fmt = vim.bo.fileformat
		return fmt ~= "unix" and fmt:upper()
	end,
}

M.FileSize = {
	provider = function()
		-- stackoverflow, compute human readable file size
		local suffix = { "b", "k", "M", "G", "T", "P", "E" }
		local fsize = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
		fsize = (fsize < 0 and 0) or fsize
		if fsize < 1024 then
			return fsize .. suffix[1]
		end
		local i = math.floor((math.log(fsize) / math.log(1024)))
		return string.format("%.2g%s", fsize / math.pow(1024, i), suffix[i + 1])
	end,
}

M.FileLastModified = {
	provider = function()
		local ftime = vim.fn.getftime(vim.api.nvim_buf_get_name(0))
		return (ftime > 0) and os.date("%c", ftime)
	end,
}

M.Ruler = {
	-- %l = current line number
	-- %L = number of lines in the buffer
	-- %c = column number
	-- %P = percentage through file of displayed window
	provider = "%7(%l/%3L%):%2c %P",
}
M.space = {
	provider = " ",
}
M.align = {
	provider = "%=",
}

M.LSPActive = {
	condition = conditions.lsp_attached,
	update = { "LspAttach", "LspDetach" },

	-- You can keep it simple,
	-- provider = " [LSP]",

	-- Or complicate things a bit and get the servers names
	provider = function()
		local names = {}
		for i, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
			table.insert(names, server.name)
		end
		return "  " .. table.concat(names, " ")
	end,
	hl = { fg = "orange", bold = true },
}

M.Diagnostics = {
	condition = conditions.has_diagnostics,
	update = { "DiagnosticChanged", "BufEnter" },
	on_click = {
		callback = function()
			require("trouble").toggle({ mode = "document_diagnostics" })
		end,
		name = "heirline_diagnostics",
	},
	static = {
		error_icon = M.icons.err,
		warn_icon = M.icons.warn,
		info_icon = M.icons.info,
		hint_icon = M.icons.hint,
	},
	init = function(self)
		self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
		self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
		self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
		self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
	end,
	-- {
	-- 	provider = "![",
	-- },
	{
		provider = function(self)
			-- 0 is just another output, we can decide to print it or not!
			return self.errors > 0 and ((O.ui.statusline.fancy and self.error_icon or "E ") .. self.errors .. " ")
		end,
		hl = "DiagnosticError",
	},
	{
		provider = function(self)
			return self.warnings > 0 and ((O.ui.statusline.fancy and self.warn_icon or "W ") .. self.warnings .. " ")
		end,
		hl = "DiagnosticWarn",
	},
	{
		provider = function(self)
			return self.info > 0 and ((O.ui.statusline.fancy and self.info_icon or "I ") .. self.info .. " ")
		end,
		hl = "DiagnosticInfo",
	},
	{
		provider = function(self)
			return self.hints > 0 and ((O.ui.statusline.fancy and self.hint_icon or "H ") .. self.hints)
		end,
		hl = "DiagnosticHint",
	},
	-- {
	-- 	provider = "]",
	-- },
}

M.Git = {
	condition = conditions.is_git_repo,

	init = function(self)
		self.status_dict = vim.b.gitsigns_status_dict
		self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
	end,

	hl = function()
		-- if O.ui.tabline.minimal then
		-- 	return { fg = "fg" }
		-- end
		return { fg = "orange" }
	end,

	{ -- git branch name
		provider = function(self)
			return " " .. self.status_dict.head
		end,
		hl = function()
			-- if O.ui.statusline.minimal then
			-- 	return { fg = minimal_fg }
			-- end
			return { fg = "purple", bold = true }
		end,
	},
}
M.SearchCount = {
	condition = function()
		return vim.v.hlsearch ~= 0 and vim.o.cmdheight == 0
	end,
	init = function(self)
		local ok, search = pcall(vim.fn.searchcount)
		if ok and search.total then
			self.search = search
		end
	end,
	provider = function(self)
		local search = self.search
		return string.format("[%d/%d]", search.current, math.min(search.total, search.maxcount))
	end,
}
M.Spell = {
	condition = function()
		return vim.wo.spell
	end,
	provider = "SPELL ",
	hl = { bold = true, fg = "orange" },
}
M.SearchCount = {
	condition = function()
		return vim.v.hlsearch ~= 0 and vim.o.cmdheight == 0
	end,
	init = function(self)
		local ok, search = pcall(vim.fn.searchcount)
		if ok and search.total then
			self.search = search
		end
	end,
	provider = function(self)
		local search = self.search
		return string.format("[%d/%d]", search.current, math.min(search.total, search.maxcount))
	end,
}

M.MacroRec = {
	condition = function()
		return vim.fn.reg_recording() ~= "" and vim.o.cmdheight == 0
	end,
	provider = " ",
	hl = { fg = "orange", bold = true },
	utils.surround({ "[", "]" }, nil, {
		provider = function()
			return vim.fn.reg_recording()
		end,
		hl = { fg = "green", bold = true },
	}),
	update = {
		"RecordingEnter",
		"RecordingLeave",
	},
}

M.ShowCmd = {
	condition = function()
		return vim.o.cmdheight == 0
	end,
	provider = ":%3.5(%S%)",
}

M.WorkDir = {
	init = function(self)
		self.icon = (vim.fn.haslocaldir(0) == 1 and "l" or "g") .. " "
		local cwd = vim.fn.getcwd(0)
		self.cwd = vim.fn.fnamemodify(cwd, ":~")
		if not conditions.width_percent_below(#self.cwd, 0.27) then
			self.cwd = vim.fn.pathshorten(self.cwd)
		end
	end,
	hl = { fg = "blue", bold = true },
	on_click = {
		callback = function()
			vim.cmd("Oil")
		end,
		name = "heirline_workdir",
	},
	flexible = 1,
	{
		provider = function(self)
			local trail = self.cwd:sub(-1) == "\\" and "" or "\\"
			return self.icon .. self.cwd .. trail .. " "
		end,
	},
	{
		provider = function(self)
			local cwd = vim.fn.pathshorten(self.cwd)
			local trail = self.cwd:sub(-1) == "\\" and "" or "\\"
			return self.icon .. cwd .. trail .. " "
		end,
	},
	{
		provider = "",
	},
}

M.HelpFilename = {
	condition = function()
		return vim.bo.filetype == "help"
	end,
	provider = function()
		local filename = vim.api.nvim_buf_get_name(0)
		return vim.fn.fnamemodify(filename, ":t")
	end,
	hl = "Directory",
}

M.grapple = {
	condition = function()
		if not package.loaded["grapple"] then
			return false
		end
		return true
	end,
	provider = function()
		return require("grapple").statusline()
	end,
	hl = function()
		-- if O.ui.statusline.minimal then
		-- 	return { fg = minimal_fg, bold = true }
		-- end
		return { fg = "fg", bold = true }
	end,
	update = { "BufEnter" },
}

M.wordcount = {
	init = function(self)
		local wc = vim.fn.wordcount()
		if wc.visual_words and wc.visual_chars then
			local raw_count = vim.fn.line(".") - vim.fn.line("v")
			raw_count = raw_count < 0 and raw_count - 0 or raw_count + 1
			self.linecount = tostring(math.abs(raw_count))
			self.wordcount = wc.visual_words
			-- self.charcount = wc.visual_chars
		else
			self.linecount = tostring(vim.fn.line("."))
			self.wordcount = wc.words
			-- self.charcount = wc.chars
		end
		self.bytecount = wc.bytes or 0
	end,
	static = {
		icon = M.icons.hamburger,
	},
	{
		provider = function(self)
			return self.icon .. " "
		end,
		hl = { fg = "blue" },
	},
	{
		provider = function(self)
			return self.bytecount .. "b "
		end,
	},
	{
		provider = function(self)
			return self.linecount .. " lines "
		end,
	},
	{
		provider = function(self)
			return self.wordcount .. " words "
		end,
	},
	-- {
	-- 	provider = function(self)
	-- 		return self.charcount .. " chars "
	-- 	end,
	-- },
}

M.SpaceCount = {
	provider = vim.o.shiftwidth .. " spaces ",
}

M.TerminalName = {
	-- icon = ' ', -- 
	{
		provider = function()
			local tname, _ = vim.api.nvim_buf_get_name(0):gsub(".*:", "")
			return " " .. tname
		end,
		hl = { fg = "blue", bold = true },
	},
	{ provider = " - " },
	{
		provider = function()
			return vim.b.term_title
		end,
	},
	-- {
	-- 	provider = function()
	-- 		local id = require("terminal"):current_term_index()
	-- 		return " " .. (id or "Exited")
	-- 	end,
	-- 	hl = { bold = true, fg = "blue" },
	-- },
}

M.Winbar = {
	fallthrough = false,
	{
		condition = function()
			return conditions.buffer_matches({ buftype = { "terminal" } })
		end,
		utils.surround({ "", "" }, "red", {
			M.FileType,
			M.Space,
			M.TerminalName,
			M.CloseButton,
		}),
	},
	utils.surround({ "", "" }, "bright_bg", {
		fallthrough = false,
		{
			condition = conditions.is_not_active,
			{
				hl = { fg = "bright_fg", force = true },
				M.FileNameBlock,
			},
			M.CloseButton,
		},
		{
			-- provider = "      ",
			{ provider = "%<" },
			M.Align,
			M.FileNameBlock,
			M.CloseButton,
		},
	}),
}

M.Navic = {
	condition = function()
		return require("nvim-navic").is_available()
	end,
	static = {
		-- create a type highlight map
		type_hl = {
			File = "Directory",
			Module = "@include",
			Namespace = "@namespace",
			Package = "@include",
			Class = "@structure",
			Method = "@method",
			Property = "@property",
			Field = "@field",
			Constructor = "@constructor",
			Enum = "@field",
			Interface = "@type",
			Function = "@function",
			Variable = "@variable",
			Constant = "@constant",
			String = "@string",
			Number = "@number",
			Boolean = "@boolean",
			Array = "@field",
			Object = "@type",
			Key = "@keyword",
			Null = "@comment",
			EnumMember = "@field",
			Struct = "@structure",
			Event = "@keyword",
			Operator = "@operator",
			TypeParameter = "@type",
		},
		-- bit operation dark magic, see below...
		enc = function(line, col, winnr)
			return bit.bor(bit.lshift(line, 16), bit.lshift(col, 6), winnr)
		end,
		-- line: 16 bit (65535); col: 10 bit (1023); winnr: 6 bit (63)
		dec = function(c)
			local line = bit.rshift(c, 16)
			local col = bit.band(bit.rshift(c, 6), 1023)
			local winnr = bit.band(c, 63)
			return line, col, winnr
		end,
	},
	init = function(self)
		local data = require("nvim-navic").get_data() or {}
		local children = {}
		-- create a child for each level
		for i, d in ipairs(data) do
			-- encode line and column numbers into a single integer
			local pos = self.enc(d.scope.start.line, d.scope.start.character, self.winnr)
			local child = {
				{
					provider = d.icon,
					hl = self.type_hl[d.type],
				},
				{
					-- escape `%`s (elixir) and buggy default separators
					provider = d.name:gsub("%%", "%%%%"):gsub("%s*->%s*", ""),
					-- highlight icon only or location name as well
					-- hl = self.type_hl[d.type],

					on_click = {
						-- pass the encoded position through minwid
						minwid = pos,
						callback = function(_, minwid)
							-- decode
							local line, col, winnr = self.dec(minwid)
							vim.api.nvim_win_set_cursor(vim.fn.win_getid(winnr), { line, col })
						end,
						name = "heirline_navic",
					},
				},
			}
			-- add a separator only if needed
			if #data > 1 and i < #data then
				table.insert(child, {
					provider = " > ",
					hl = { fg = "bright_fg" },
				})
			end
			table.insert(children, child)
		end
		-- instantiate the new child, overwriting the previous one
		self.child = self:new(children, 1)
	end,
	-- evaluate the children containing navic components
	provider = function(self)
		return self.child:eval()
	end,
	hl = { fg = "gray" },
	update = "CursorMoved",
}

return M
-- M.ViMode,
-- -- M.space,
-- M.FileNameBlock,
-- M.space,
-- M.Git,
-- M.space,
-- M.grapple,
-- M.space,
-- M.Diagnostics,
-- M.space,
-- M.align,
-- M.WorkDir,
-- M.Ruler,
