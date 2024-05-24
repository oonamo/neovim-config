local conditions = require("heirline.conditions")
local heirline_utils = require("heirline.utils")

local M = {}
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
	Error = tools.ui.icons["x"],
	Warn = tools.ui.icons["up_tri"],
	Info = tools.ui.icons["info_i"],
	Hint = tools.ui.icons["info_i"],
}

local diag_signs_default_text = { "E", "W", "I", "H" }

local diag_severity_map = {
	[1] = "ERROR",
	[2] = "WARN",
	[3] = "INFO",
	[4] = "HINT",
	ERROR = 1,
	WARN = 2,
	INFO = 3,
	HINT = 4,
}

local Align = { provider = "%=" }
local Diagnostics = {
	condition = conditions.has_diagnostics,
	update = { "DiagnosticChanged", "BufEnter" },
	on_click = {
		callback = function()
			require("trouble").toggle({ mode = "document_diagnostics" })
		end,
		name = "heirline_diagnostics",
	},
	static = {
		error_icon = M.icons.Error,
		warn_icon = M.icons.Warn,
		info_icon = M.icons.Info,
		hint_icon = M.icons.Hint,
		get_sign = function(severity)
			local diag_config = vim.diagnostic.config()
			local signs_text = diag_config
				and diag_config.signs
				and type(diag_config.signs) == "table"
				and diag_config.signs.text
			return signs_text and (signs_text[severity] or signs_text[diag_severity_map[severity]])
				or (diag_signs_default_text[severity] or diag_signs_default_text[diag_severity_map[severity]])
		end,
	},
	init = function(self)
		self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
		self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
		self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
		self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
	end,
	{
		provider = function(self)
			-- 0 is just another output, we can decide to print it or not!
			return self.errors > 0 and ((self.error_icon or "E ") .. self.errors .. " ")
		end,
		hl = function()
			return { fg = heirline_utils.get_highlight("DiagnosticError").fg, bg = "bg" }
		end,
	},
	{
		provider = function(self)
			return self.warnings > 0 and ((self.warn_icon or "W ") .. self.warnings .. " ")
		end,
		hl = function()
			return { fg = heirline_utils.get_highlight("DiagnosticWarning").fg, bg = "bg" }
		end,
	},
	{
		provider = function(self)
			return self.info > 0 and ((self.info_icon or "I ") .. self.info .. " ")
		end,
		hl = function()
			return { fg = heirline_utils.get_highlight("DiagnosticInfo").fg, bg = "bg" }
		end,
	},
	{
		provider = function(self)
			return self.hints > 0 and ((self.hint_icon or "H ") .. self.hints)
		end,
		hl = function()
			return { fg = heirline_utils.get_highlight("DiagnosticHint").fg, bg = "bg" }
		end,
	},
}
local FileName = {
	provider = [[%{%&bt==#''?'%t':(&bt==#'terminal'?'[Terminal] '.bufname()->substitute('^term://.\{-}//\d\+:\s*','',''):'%F')%} ]],
}
local Mode = {
	init = function(self)
		self.mode = vim.fn.mode(1)
	end,
	static = {
		modes = {
			["n"] = "NO",
			["no"] = "OP",
			["nov"] = "OC",
			["noV"] = "OL",
			["no\x16"] = "OB",
			["\x16"] = "VB",
			["niI"] = "IN",
			["niR"] = "RE",
			["niV"] = "RV",
			["nt"] = "NT",
			["ntT"] = "TM",
			["v"] = "VI",
			["vs"] = "VI",
			["V"] = "VL",
			["Vs"] = "VL",
			["\x16s"] = "VB",
			["s"] = "SE",
			["S"] = "SL",
			["\x13"] = "SB",
			["i"] = "IN",
			["ic"] = "IC",
			["ix"] = "IX",
			["R"] = "RE",
			["Rc"] = "RC",
			["Rx"] = "RX",
			["Rv"] = "RV",
			["Rvc"] = "RC",
			["Rvx"] = "RX",
			["c"] = "CO",
			["cv"] = "CV",
			["r"] = "PR",
			["rm"] = "PM",
			["r?"] = "P?",
			["!"] = "SH",
			["t"] = "TE",
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
	provider = function(self)
		local mode_str = (self.mode == "n" and (vim.bo.ro or not vim.bo.mod)) and "RO" or self.modes[self.mode]
		return string.format(" %s ", mode_str)
	end,
	hl = function(self)
		local mode = self.mode:sub(1, 1) -- get only the first mode character
		return { bg = self.mode_colors[mode], fg = "bg", bold = true }
	end,
}

local FileType = {
	provider = function()
		return vim.bo.ft == "" and "" or vim.bo.ft:gsub("^%l", string.upper)
	end,
	update = { "BufEnter" },
}

local GitDiff = {
	condition = function()
		return require("mini.diff").get_buf_data() ~= nil
	end,
	init = function(self)
		if package.loaded["mini.diff"] == nil then
			return
		end
		local stats = require("mini.diff").get_buf_data()
		if stats and stats.summary then
			self.add = stats.summary.add
			self.change = stats.summary.change
			self.delete = stats.summary.delete
		end
	end,
	static = {
		should_render = function(val)
			if val and val > 0 then
				return true
			end
			return false
		end,
	},
	{
		provider = function(self)
			if
				not self.should_render(self.add)
				and not self.should_render(self.change)
				and not self.should_render(self.delete)
			then
				return ""
			end
			return ", "
		end,
	},
	{
		provider = function(self)
			if self.should_render(self.add) then
				return "+" .. self.add
			end
			return ""
		end,
		hl = function()
			return { fg = heirline_utils.get_highlight("GitSignsAdd").fg, bg = "bg" }
		end,
	},
	{
		provider = function(self)
			if self.should_render(self.change) then
				return "~" .. self.change
			end
			return ""
		end,
		hl = function()
			return { fg = heirline_utils.get_highlight("GitSignsChange").fg, bg = "bg" }
		end,
	},
	{
		provider = function(self)
			if self.should_render(self.delete) then
				return "-" .. self.delete
			end
			return ""
		end,
		hl = function()
			return { fg = heirline_utils.get_highlight("GitSignsDelete").fg, bg = "bg" }
		end,
	},
}

-- TODO Use vim.b.minidiff_summary_string
-- vim.b.minidiff_summary
local GitInfo = {
	condition = function()
		return require("mini.diff").get_buf_data() ~= nil
	end,
	init = function(self)
		self.root = utils.get_path_root(vim.api.nvim_buf_get_name(0))
		self.branch = utils.get_git_branch(self.root)
		self.remote = utils.get_git_remote_name(self.root)
	end,
	update = { "BufEnter" },
	{
		provider = ", ",
	},
	{
		provider = function(self)
			if self.branch == nil then
				return ""
			end
			return "#" .. self.branch
		end,
		hl = { fg = "cyan", bg = "bg" },
	},
	{
		provider = function(self)
			if self.remote == nil then
				return ""
			end
			return string.format(":(%s)", self.remote:gsub("%s+", ""))
		end,
	},
}

local Padding = { provider = " " }
local Pos = { provider = [[%{%&ru?"%l:%c ":""%}]] }
local Truncate = { provider = "%<" }
local WordCount = {
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
}

local Info = { { provider = "(" }, FileType, GitInfo, GitDiff, { provider = ")" } }
return { statusline = { Mode, Padding, FileName, Info, Align, Truncate, Diagnostics, Padding, Pos } }
