local M = {}
local conditions = require("heirline.conditions")

M.mode = {
	init = function(self)
		self.mode = vim.api.nvim_get_mode().mode
	end,
	static = {
		aliases = {
			["n"] = "Normal",
			["no"] = "O-Pending",
			["nov"] = "O-Pending",
			["noV"] = "O-Pending",
			["no\x16"] = "O-Pending",
			["niI"] = "Normal",
			["niR"] = "Normal",
			["niV"] = "Normal",
			["nt"] = "Normal",
			["ntT"] = "Normal",
			["v"] = "Visual",
			["vs"] = "Visual",
			["V"] = "V-Line",
			["Vs"] = "V-Line",
			["\x16"] = "V-Block",
			["\x16s"] = "V-Block",
			["s"] = "Select",
			["S"] = "S-Line",
			["\x13"] = "S-Block",
			["i"] = "Insert",
			["ic"] = "Insert",
			["ix"] = "Insert",
			["R"] = "Replace",
			["Rc"] = "Replace",
			["Rx"] = "Replace",
			["Rv"] = "V-Replace",
			["Rvc"] = "V-Replace",
			["Rvx"] = "V-Replace",
			["c"] = "Command",
			["cv"] = "Ex",
			["ce"] = "Ex",
			["r"] = "Replace",
			["rm"] = "More",
			["r?"] = "Confirm",
			["!"] = "Shell",
			["t"] = "Terminal",
		},
	},
	provider = function(self)
		local alias = self.aliases[self.mode] or self.aliases[self.mode:gsub(1, 1)]
		if not alias then
			return "NOR"
		end
		return alias:sub(1, 3):upper()
	end,
	update = { "ModeChanged" },
	hl = {
		bg = "bg",
		fg = "fg",
		bold = true,
	},
}

M.fileinfo = {
	provider = function()
		return vim.fn.expand("%:~:.")
	end,
	update = { "BufEnter" },
}

M.filetype = {
	init = function(self)
		self.ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
	end,
	static = {
		aliases = {
			cpp = "C++",
		},
	},
	provider = function(self)
		local up = self.ft:sub(1, 1):upper()
		if #self.ft == 1 then
			return up
		end

		return self.aliases[self.ft] or up .. self.ft:sub(2, #self.ft)
	end,
	update = { "BufEnter" },
}

local idx = 1
M.spinner = {
	init = function(self)
		self.lsp = self.lsp or { progress = {} }

		-- update lsp progress
		local orig_handler = vim.lsp.handlers["$/progress"]
		vim.lsp.handlers["$/progress"] = function(_, msg, info)
			local progress, id = self.lsp.progress, ("%s.%s"):format(info.client_id, msg.token)
			progress[id] = progress[id] and utils.extend_tbl(progress[id], msg.value) or msg.value
			self.lsp.progress[id] = msg.value
			if progress[id].kind == "end" then
				vim.defer_fn(function()
					self.lsp.progress[id] = nil
					utils.trigger_event("User HeirlineComponentsUpdateLspProgress")
				end, 100)
			end
			utils.trigger_event("User HeirlineComponentsUpdateLspProgress")
			orig_handler(_, msg, info)
		end
	end,
	provider = function(self)
		local _, Lsp = next(self.lsp.progress)
		if self.lsp and Lsp and Lsp.title then
			idx = idx + 1 > #self.spinner and 1 or idx + 1
			return ("%s"):format(self.spinner[idx - 1 > 0 and idx - 1 or 1])
				.. " "
				.. table.concat({
					Lsp.title or "",
					Lsp.message or "",
					Lsp.percentage and ("(" .. Lsp.percentage .. "%%)") or "",
				}, " ")
		end
	end,
	static = {
		spinner = {
			"⣶",
			"⣧",
			"⣏",
			"⡟",
			"⠿",
			"⢻",
			"⣹",
			"⣼",
		},
	},
	update = {
		"User",
		pattern = { "HeirlineComponentsUpdateLspProgress" },
		callback = vim.schedule_wrap(function()
			vim.cmd.redrawstatus()
		end),
	},
}

M.lsp = {
	condition = function()
		return vim.lsp.buf_is_attached(0)
	end,
	init = function(self)
		self.client = vim.lsp.get_clients({ bufnr = 0 })[1]
		self.data = {}
	end,
	provider = function(self)
		if self.client then
			local msg = ""
			msg = ("[%s:%s]"):format(
				self.client.name,
				self.client.root_dir and vim.fn.fnamemodify(self.client.root_dir, ":t") or "single"
			)
			return "   %-20s" .. msg
		end
	end,
	update = { "LspProgress", "LspAttach", "LspDetach", "BufEnter" },
}

M.gitinfo = {
	condition = function()
		return vim.b.minigit_summary ~= nil
	end,
	init = function(self)
		self.status = vim.b.minigit_summary or {}
		if vim.b.minidiff_summary and vim.b.minidiff_summary.add then
			self.changes = vim.b.minidiff_summary
		else
			self.changes = {
				add = 0,
				change = 0,
				delete = 0,
			}
		end
	end,
	{
		provider = function(self)
			return (self.status.head_name or "") .. " "
		end,
		hl = { fg = "fg", bold = true, bg = "bg" },
	},
	{
		provider = function(self)
			if self.changes.add > 0 then
				return "+" .. self.changes.add .. " "
			end
			return ""
		end,
		hl = { fg = "add", bg = "bg" },
	},
	{
		provider = function(self)
			if self.changes.change > 0 then
				return "~" .. self.changes.change .. " "
			end
			return ""
		end,
		hl = { fg = "change" },
	},
	{
		provider = function(self)
			if self.changes.delete > 0 then
				return "-" .. self.changes.delete .. " "
			end
			return ""
		end,
		hl = { fg = "del" },
	},
}

M.diagnostics = {
	condition = conditions.has_diagnostics,
	update = { "DiagnosticChanged", "BufEnter" },
	init = function(self)
		self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
		self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
		self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
		self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
	end,
	{
		provider = function(self)
			-- 0 is just another output, we can decide to print it or not!
			-- return self.errors > 0 and ((O.ui.statusline.fancy and self.error_icon or "E ") .. self.errors .. " ")
			return self.errors > 0 and " " .. self.errors or ""
		end,
		hl = {
			fg = "error",
		},
	},
	{
		provider = function(self)
			return self.warnings > 0 and " " .. self.warnings or ""
		end,
		hl = {
			fg = "warn",
		},
	},
	{
		provider = function(self)
			return self.info > 0 and " " .. self.info or ""
		end,
		hl = {
			fg = "info",
		},
	},
	{
		provider = function(self)
			return self.hints > 0 and " " .. self.hints or ""
		end,
		hl = {
			fg = "hint",
		},
	},
}

M.eol = {
	provider = (not vim.uv.os_uname().sysname:find("Windows")) and ":" or "(Dos)",
	update = { "BufEnter" },
}

local hasgui = vim.fn.has("gui_running")
M.encoding = {
	static = {
		encodings = {
			["utf-8"] = "U",
			["utf-16"] = "U16",
			["utf-32"] = "U32",
		},
	},
	provider = function(self)
		return string.format(
			" %s%s%s",
			hasgui == 0 and "U" or "",
			self.encodings[vim.o.encoding] or "U",
			self.encodings[vim.bo.fileencoding] or "U"
		)
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
		icon = "",
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

local status = {
	M.mode,
	M.encoding,
	M.eol,
	{ provider = [[%{(&modified&&&readonly?'%*':(&modified?'**':(&readonly?'%%':'--')))}- T%{tabpagenr()}  ]] },
	M.fileinfo,
	{ provider = "   %M   (L%l,C%c)  " },
	M.gitinfo,
	{ provider = " %=" },
	{ provider = [[ %{!empty(bufname()) ? '(' : ''}]] },
	M.filetype,
	M.diagnostics,
	{ provider = [[%{!empty(bufname()) ? ')' : ''}]] },
	-- M.spinner,
	M.lsp,
	{ provier = "%=%=" },
}

local writing = {
	condition = function()
		return vim.bo.ft == "markdown"
	end,
	M.mode,
	M.encoding,
	M.eol,
	{ provider = [[%{(&modified&&&readonly?'%*':(&modified?'**':(&readonly?'%%':'--')))}- T%{tabpagenr()}  ]] },
	M.fileinfo,
	{ provider = "   %M   (L%l,C%c)  " },
	M.gitinfo,
	{ provider = " %=" },
	{ provider = [[ %{!empty(bufname()) ? '(' : ''}]] },
	M.filetype,
	{ provider = [[%{!empty(bufname()) ? ')' : ''}]] },
	M.wordcount,
}

return {
	hl = function()
		if conditions.is_active() then
			return "StatusLine"
		else
			return "StatusLineNC"
		end
	end,
	fallthrough = false,
	writing,
	status,
}
