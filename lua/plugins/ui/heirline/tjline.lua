local M = {}
local conditions = require("heirline.conditions")
local heirline_utils = require("heirline.utils")
-- if TJ_STL_BG then
-- 	vim.api.nvim_set_hl(0, "StatusLine", { fg = utils.get_highlight("Normal").bg, bg = TJ_STL_BG })
-- end
-- local minimal_fg = vim.o.background == "light" and "white" or "black"
--
--
M.icons = {
	-- ✗   󰅖 󰅘 󰅚 󰅙 󱎘 
	close = "󰅙 ",
	dir = "󰉋 ",
	lsp = " ", --   
	vim = " ",
	debug = " ",
	err = "  ",
	warn = "  ",
	info = "  ",
	hint = "  ",
	hamburger = "≡",
}

M.space = {
	provider = " ",
}
M.align = {
	provider = "%=",
}

M.ViMode = {
	init = function(self)
		self.mode = vim.fn.mode(1) -- :h mode()
	end,
	static = {
		mode_names = { -- change the strings if you like it vvvvverbose!
			n = "NORMAL",
			no = "N?",
			nov = "N?",
			noV = "N?",
			["no\22"] = "N?",
			niI = "Ni",
			niR = "Nr",
			niV = "Nv",
			nt = "Nt",
			v = "VISUAL",
			vs = "Vs",
			V = "V-LINE",
			Vs = "Vs",
			["\22"] = "^V",
			["\22s"] = "^V",
			s = "S",
			S = "S_",
			["\19"] = "^S",
			i = "INSERT",
			ic = "Ic",
			ix = "Ix",
			R = "REPLACE",
			Rc = "Rc",
			Rx = "Rx",
			Rv = "Rv",
			Rvc = "Rv",
			Rvx = "Rv",
			c = "COMMAND",
			cv = "Ex",
			r = "...",
			rm = "M",
			["r?"] = "?",
			["!"] = "!",
			t = "TERMINAL",
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
		return " %2(" .. self.mode_names[self.mode] .. "%) "
	end,
	-- Same goes for the highlight. Now the foreground will change according to the current mode.
	hl = function(self)
		local mode = self.mode:sub(1, 1) -- get only the first mode character
		return { fg = self.mode_colors[mode], bold = true, bg = "none", italic = true }
	end,
	update = {
		"ModeChanged",
		pattern = "*:*",
		callback = vim.schedule_wrap(function()
			vim.cmd("redrawstatus")
		end),
	},
}

local FileName = {
	provider = [[%{%&bt==#''?'%t':(&bt==#'terminal'?'[Terminal] '.bufname()->substitute('^term://.\{-}//\d\+:\s*','',''):'%F')%} ]],
}

local GitDiff = {
	condition = function()
		return require("mini.diff").get_buf_data() ~= nil
	end,
	update = { "User", pattern = "MiniDiffUpdated" },
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

M.Ruler = {
	-- %l = current line number
	-- %L = number of lines in the buffer
	-- %c = column number
	-- %P = percentage through file of displayed window
	provider = "%7(%l/%3L%):%2c %P",
}
local diag_signs_default_text = { "E", "W", "I", "H" }
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
local LSPActive = {
	-- Update on "DiagnosticChanged" as nested update clause is ignored
	update = {
		"LspAttach",
		"LspDetach",
		"DiagnosticChanged",
		callback = vim.schedule_wrap(function(_)
			vim.cmd.redrawstatus()
		end),
	},
	init = function(self)
		self.has_conform, _ = pcall(require, "conform")
	end,
	condition = function(self)
		-- self.clients = vim.lsp.get_active_clients({ bufnr = 0 })
		self.clients = vim.lsp.get_clients({ bufnr = 0 })
		if self.has_conform then
			self.formatters = require("conform").list_formatters()
			return next(self.clients) ~= nil or next(self.formatters) ~= nil
		end
		self.formatters = {}
		return next(self.clients) ~= nil
	end,
	-- hl = { bg = "statusline_bg" },
	{
		provider = "[",
	},
	{
		provider = function(self)
			return vim.iter(self.clients)
				:map(function(server)
					return server.name
				end)
				:join(" ")
		end,
	},
	{
		provider = function(self)
			if next(self.formatters) ~= nil then
				return ", "
			end
			return ""
		end,
	},
	{
		provider = function(self)
			return vim.iter(self.formatters)
				:map(function(formatter)
					return formatter.name
				end)
				:join(" , ")
		end,
	},
	Diagnostics,
	{
		provider = "]",
	},
}

local FileType = {
	provider = function()
		return vim.bo.ft == "" and "" or vim.bo.ft:gsub("^%l", string.upper)
	end,
	update = { "BufEnter" },
}
local Info = { { provider = "(" }, FileType, GitInfo, GitDiff, { provider = ")" } }

return {
	M.ViMode,
	M.space,
	Info,
	M.align,
	FileName,
	M.align,
	LSPActive,
	M.Ruler,
}
