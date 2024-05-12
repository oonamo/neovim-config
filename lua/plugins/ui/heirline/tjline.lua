local M = {}
local conditions = require("heirline.conditions")
-- local utils = require("heirline.utils")
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
	err = " ",
	warn = " ",
	info = " ",
	hint = " ",
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
		if O.ui.statusline.minimal then
			return { fg = self.mode_colors[mode], bold = true }
		end
		return { fg = self.mode_colors[mode], bold = true, bg = "none" }
	end,
	update = {
		"ModeChanged",
		pattern = "*:*",
		callback = vim.schedule_wrap(function()
			vim.cmd("redrawstatus")
		end),
	},
}

M.Git = {
	condition = conditions.is_git_repo,

	init = function(self)
		self.status_dict = vim.b.gitsigns_status_dict
		self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
	end,

	-- hl = function()
	-- 	-- if O.ui.tabline.minimal then
	-- 	-- 	return { fg = "fg" }
	-- 	-- end
	-- 	return { fg = "orange" }
	-- end,

	{ -- git branch name
		provider = function(self)
			return " " .. self.status_dict.head
		end,
		-- hl = function()
		-- 	-- if O.ui.statusline.minimal then
		-- 	-- 	return { fg = minimal_fg }
		-- 	-- end
		-- 	return { fg = "purple", bold = true, bg = "cyan" }
		-- end,
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

M.Ruler = {
	-- %l = current line number
	-- %L = number of lines in the buffer
	-- %c = column number
	-- %P = percentage through file of displayed window
	provider = "%7(%l/%3L%):%2c %P",
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
	condition = function(self)
		self.clients = vim.lsp.get_active_clients({ bufnr = 0 })
		return next(self.clients) ~= nil
	end,
	-- hl = { bg = "statusline_bg" },
	{
		provider = "[",
	},
	{
		provider = function(self)
			local names = {}
			for _, server in pairs(self.clients) do
				table.insert(names, server.name)
			end
			return table.concat(names, " ")
		end,
	},
	Diagnostics,
	{
		provider = "]",
	},
}

return {
	-- { fg = "fg", bg = utils.get_highlight("StatusLine").bg },
	-- { fg = "red", bg = "cyan" },
	-- {
	-- 	hl = function()
	-- 		if conditions.is_active() then
	-- 			return { fg = "fg", bg = "cyan" }
	-- 		end
	-- 		return { fg = "fg", bg = "bg" }
	-- 	end,
	-- },
	M.ViMode,
	-- { fg = "fg", bg = "cyan" },
	-- M.Diagnostics,
	M.space,
	M.Git,
	M.align,
	LSPActive,
	M.Ruler,
}
