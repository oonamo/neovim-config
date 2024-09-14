local conditions = require("heirline.conditions")
local htils = require("heirline.utils")

local align = { provider = "%=" }
local space = { provider = " " }

local function get_hl(name, property)
	local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
	if hl[property] then
		return hl[property]
	elseif hl.fg then
		return hl.fg
	elseif hl.bg then
		return hl.bg
	else
		return get_hl("StatusLine", property)
	end
end

local Git = {
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
		hl = { fg = "change", bold = true },
	},
	{
		provider = function(self)
			if self.changes.add > 0 then
				return "+" .. self.changes.add .. " "
			end
			return ""
		end,
		hl = { fg = "add" },
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

local file_name = {
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
}

local wordcount = {
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
	-- {
	-- 	provider = function(self)
	-- 		return self.charcount .. " chars "
	-- 	end,
	-- },
}

local diagnostics = {
	condition = conditions.has_diagnostics,
	update = { "DiagnosticChanged", "BufEnter" },
	static = {
		error_icon = function(self)
			if self.error_sign and self.error_sign ~= "" then
				return self.error_sign
			end
			local error = vim.fn.sign_getdefined("DiagnosticSignError")
			if error and error[1].text then
				self.error_sign = error[1].text
			else
				self.error_sign = ""
			end
			return self.error_sign
		end,
		warn_icon = function(self)
			if self.warn_sign and self.warn_sign ~= "" then
				return self.warn_sign
			end
			local warn = vim.fn.sign_getdefined("DiagnosticSignWarn")
			if warn and warn[1].text then
				self.warn_sign = warn[1].text
			else
				self.warn_sign = ""
			end
			return self.warn_sign
		end,
		info_icon = function(self)
			if self.info_sign and self.info_sign ~= "" then
				return self.info_sign
			end
			local info = vim.fn.sign_getdefined("DiagnosticSignInfo")
			if info and info[1].text then
				self.info_sign = info[1].text
			else
				self.info_sign = ""
			end
			return self.info_sign
		end,
		hint_icon = function(self)
			if self.hint_sign and self.hint_sign ~= "" then
				return self.hint_sign
			end
			local hint = vim.fn.sign_getdefined("DiagnosticSignHint")
			if hint and hint[1].text then
				self.hint_sign = hint[1].text
			else
				self.hint_sign = ""
			end
			return self.hint_sign
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
			-- return self.errors > 0 and ((O.ui.statusline.fancy and self.error_icon or "E ") .. self.errors .. " ")
			return self.errors > 0 and self:error_icon() .. self.errors .. " "
		end,
		hl = {
			fg = "error",
		},
	},
	{
		provider = function(self)
			return self.warnings > 0 and self:warn_icon() .. self.warnings .. " "
		end,
		hl = {
			fg = "warn",
		},
	},
	{
		provider = function(self)
			return self.info > 0 and self:info_icon() .. self.info .. " "
		end,
		hl = {
			fg = "info",
		},
	},
	{
		provider = function(self)
			return self.hints > 0 and self:hint_icon() .. self.hints .. " "
		end,
		hl = {
			fg = "hint",
		},
	},
}

local Overseer = {
	condition = function()
		return package.loaded.overseer
	end,
	init = function(self)
		local tasks = require("overseer.task_list").list_tasks({ unique = true })
		local tasks_by_status = require("overseer.util").tbl_group_by(tasks, "status")
		self.tasks = tasks_by_status
	end,
	{
		condition = function(self)
			return self.tasks["CANCELED"]
		end,
		provider = function(self)
			return "C: " .. #self.tasks["CANCELED"]
		end,
		hl = function()
			return { fg = htils.get_highlight("OverseerCANCELED").fg }
		end,
	},
	{
		condition = function(self)
			return self.tasks["FAILURE"]
		end,
		provider = function(self)
			return "F: " .. #self.tasks["FAILURE"]
		end,
		hl = function()
			return { fg = htils.get_highlight("OverseerFAILURE").fg }
		end,
	},
	{
		condition = function(self)
			return self.tasks["RUNNING"]
		end,
		provider = function(self)
			return "R: " .. #self.tasks["RUNNING"]
		end,
		hl = function()
			return { fg = htils.get_highlight("OverseerRUNNING").fg }
		end,
	},
	{
		condition = function(self)
			return self.tasks["SUCCESS"]
		end,
		provider = function(self)
			return "S: " .. #self.tasks["SUCCESS"]
		end,
		hl = function()
			return { fg = htils.get_highlight("OverseerSUCCESS").fg }
		end,
	},
}

local macro_recording = {
	condition = function()
		return vim.fn.reg_recording() ~= "" and vim.o.cmdheight == 0
	end,
	update = { "RecordingEnter", "RecordingLeave" },
	provider = function(self)
		return " @ " .. vim.fn.reg_recording()
	end,
	hl = { fg = "green", bold = true },
}

local show_cmd = {
	provider = "%0.5(%S%)",
}

local search_count = {
	condition = function(self)
		local search_count = vim.fn.searchcount({ recompute = 1, maxcount = -1 })
		local active = false
		if vim.v.hlsearch and vim.v.hlsearch == 1 and search_count.total > 0 then
			active = true
		end
		if not active then
			return
		end
		self.count = search_count
		return true
	end,
	provider = function(self)
		return self.count.current .. "/" .. self.count.total
	end,
	hl = {
		fg = "orange",
	},
}

local cmd_info = {
	condition = function()
		return vim.o.cmdheight == 0
	end,
	search_count,
	space,
	macro_recording,
	-- space,
	-- show_cmd,
}

local signature = {
	update = {
		"TextChangedI",
		"CursorMoved",
		"CursorMovedI",
		"InsertEnter",
		"BufEnter",
		"CursorHold",
	},
	condition = function()
		return package.loaded.lsp_signature
	end,
	init = function(self)
		self.sig = nil
		self.label1 = nil
		self.label2 = nil
		self.sig = require("lsp_signature").status_line(80)
		if self.sig.range ~= nil then
			if self.sig.range["start"] and self.sig.range["end"] then
				self.label1 = self.sig.label:sub(1, self.sig.range.start - 1)
				self.label2 = self.sig.label:sub(self.sig.range["end"] + 1)
			end
		end
	end,
	{
		{
			provider = function(self)
				if self.label1 then
					return self.label1
				end
				return ""
			end,
			hl = { fg = "fg", bg = get_hl("CursorLine", "bg") },
		},
		{
			provider = function(self)
				return self.sig.hint
			end,
			hl = { fg = "yellow", bg = get_hl("CursorLine", "bg") },
		},
		{
			provider = function(self)
				if self.label2 then
					return self.label2
				end
				return ""
			end,
			hl = { fg = "fg", bg = get_hl("CursorLine", "bg") },
		},
	},
}

local ruler = {
	condition = function()
		return vim.g.enable_ruler
	end,
	provider = "%7(%l/%3L%):%2c %P",
}

local NormalStatusLine = {
	Git,
	Overseer,
	align,
	file_name,
	space,
	signature,
	align,
	cmd_info,
	diagnostics,
	space,
	ruler,
}

local NoteStatus = {
	condition = function()
		return vim.bo.ft == "markdown"
	end,
	Git,
	align,
	file_name,
	align,
	cmd_info,
	space,
	wordcount,
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
	NoteStatus,
	NormalStatusLine,
}
