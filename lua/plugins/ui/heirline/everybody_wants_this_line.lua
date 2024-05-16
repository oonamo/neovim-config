local conditions = require("heirline.conditions")
-- local utils = require("heirline.utils")
-- local minimal_fg = vim.o.background == "light" and "white" or "black"

-- local seps = " │ "

local function Seps(hl)
	return {
		provider = " | ",
		hl = { fg = hl.fg, bg = hl.bg and true or "bg" },
	}
end

local Align = {
	provider = "%=",
}

local Buffer = {
	init = function(self)
		self.filename = vim.api.nvim_buf_get_name(0)
	end,
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
	hl = function()
		-- if O.ui.statusline.minimal then
		-- 	return { fg = minimal_fg }
		-- end
		return { fg = "fg", bg = "bg" }
	end,
	Seps({ fg = "gray" }),
}

local function round(v)
	if tostring(v):find("%.") == nil then
		return math.floor(v)
	else
		local dec = tonumber(tostring(v):match("%.%d+"))
		if dec >= 0.5 then
			return math.ceil(v)
		else
			return math.floor(v)
		end
	end
end

local BufSize = {
	static = {
		size_map = {
			[0] = { "B", "gray" },
			[1] = { "KB", "gray" },
			[2] = { "MB", "red" },
		},
	},
	provider = function(self)
		local size = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
		size = size > 0 and size or 0
		-- bytes
		if size < 1000 then
			self.size = 0
			return size
		elseif size >= 1000 and size <= 1000000 then
			self.size = 1
			size = round(size * 10 ^ -3 * 100) / 100
			return size
		end
		self.size = 2
		size = round(size * 10 ^ -6 * 100) / 100
		return size
	end,
	{
		provider = function(self)
			return self.size_map[self.size][1]
		end,
		hl = function(self)
			return { fg = self.size_map[self.size][2], bg = "bg" }
		end,
	},
	Seps({ fg = "gray" }),
}

local Ruler = {
	condition = function()
		return vim.bo.filetype ~= "markdown"
	end,
	-- %l = current line number
	-- %L = number of lines in the buffer
	-- %c = column number
	-- %P = percentage through file of displayed window
	{
		provider = "↓",
		hl = { fg = "gray", bg = "bg" },
	},
	{
		provider = "%P, ",
	},
	{
		provider = "→",
		hl = { fg = "gray", bg = "bg" },
	},
	{
		provider = "%c, %L",
	},
	{
		provider = "LOC",
		hl = { fg = "gray", bg = "bg" },
	},
	-- provider = "%P, %c, %LLOC",
}

local Wordcount = {
	condition = function()
		return vim.bo.filetype == "markdown"
	end,
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
		icon = "≡",
	},
	{
		provider = function(self)
			return self.linecount
		end,
	},
	{
		provider = function(self)
			return " LINES " .. self.icon .. " "
		end,
		hl = { fg = "gray", bg = "bg" },
	},
	{
		provider = function(self)
			return self.wordcount
		end,
	},
	{
		provider = " WORDS ",
		hl = { fg = "gray", bg = "bg" },
	},
}

local Diagnostics = {
	-- Since this is nested inside LSPActive the events aren't called
	-- update = { "LspAttach", "DiagnosticChanged", "BufEnter" },
	static = {
		-- error_icon = vim.fn.sign_getdefined("DiagnosticSignError")[1].text,
		-- warn_icon = vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text,
		-- info_icon = vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text,
		-- hint_icon = vim.fn.sign_getdefined("DiagnosticSignHint")[1].text,
		error_icon = "E",
		warn_icon = "W",
		info_icon = "I",
		hint_icon = "H",
	},
	condition = function()
		return #vim.diagnostic.get(0) > 0
	end,
	init = function(self)
		self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
		self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
		self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
		self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
	end,
	{
		provider = function(self)
			return self.errors > 0 and string.format(" %s:%s", self.error_icon, self.errors)
		end,
		hl = { fg = "red", bold = true },
	},
	{
		provider = function(self)
			return self.warnings > 0 and string.format(" %s:%s", self.warn_icon, self.warnings)
		end,
		hl = { fg = "yellow", bold = true },
	},
	{
		provider = function(self)
			return self.info > 0 and string.format(" %s:%s", self.info_icon, self.info)
		end,
		hl = { fg = "green", bold = true },
	},
	{
		provider = function(self)
			return self.hints > 0 and string.format(" %s:%s", self.hint_icon, self.hints)
		end,
		hl = { fg = "purple", bold = true },
	},
}

local Netrw = {
	condition = function()
		return vim.bo.filetype == "netrw"
	end,
	Align,
	{
		provider = function()
			return vim.uv.cwd()
		end,
	},
	Align,
}

local Help = {
	condition = function()
		return vim.bo.filetype == "help"
	end,
	Align,
	{
		provider = function()
			local filename = vim.api.nvim_buf_get_name(0)
			return vim.fn.fnamemodify(filename, ":t")
		end,
	},
	Align,
}

local defaultStatus = {
	Buffer,
	BufSize,
	Ruler,
	Align,
	Diagnostics,
	Align,
}

local specialStatus = {
	condition = function()
		return conditions.buffer_matches({
			buftype = { "minifiles", "help", "netrw" },
		})
	end,
	Netrw,
	Help,
	Align,
}

local markdownStatus = {
	condition = function()
		return vim.bo.filetype == "markdown"
	end,
	Buffer,
	BufSize,
	Wordcount,
	Align,
	Diagnostics,
	Align,
}

return {
	fallthrough = false,
	specialStatus,
	markdownStatus,
	defaultStatus,
}
