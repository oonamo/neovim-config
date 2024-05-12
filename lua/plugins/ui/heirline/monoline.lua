local separator_types = {
	slant = {
		left_side = {
			before = "",
			after = "",
		},
		right_side = {
			before = "",
			after = "",
		},
	},
	circle = {
		left_side = {
			before = "",
			after = " ",
		},
		right_side = {
			before = " ",
			after = "",
		},
	},
	block = {
		left_side = {
			before = "█",
			after = "█ ",
		},
		right_side = {
			before = " █",
			after = "█",
		},
	},
}

local separators = separator_types.slant
---@param highlight string|function|table
---@param right boolean|nil
---@param after boolean|nil
local function seps(highlight, right, after)
	return {
		provider = function()
			if right then
				if after then
					return separators.right_side.after
				end
				return separators.right_side.before
			end
			if after then
				return separators.left_side.after
			end
			return separators.right_side.after
		end,
		hl = highlight,
	}
end

local function smart_sep(right_side, left, right)
	return {
		{
			provider = function()
				if right_side then
					return separators.right_side.after
				end
				return separators.left_side.after
			end,
			hl = { fg = left, bg = "bright_bg" },
		},
		{
			provider = function()
				if right_side then
					return separators.right_side.after
				end
				return separators.left_side.after
			end,
			hl = { fg = "bright_bg", bg = right },
		},
	}
end

local Git = {
	static = {
		icon = "",
	},
	provider = function(self)
		local result = ""
		if vim.b.gitsigns_head then
			result = result .. vim.b.gitsigns_head
		elseif vim.g.gitsigns_head then
			result = result .. vim.g.gitsigns_head
			-- table.insert(result, vim.g.gitsigns_head)
		end
		if vim.b.gitsigns_status then
			result = result .. vim.b.gitsigns_status
			-- table.insert(result, vim.b.gitsigns_status)
		end
		if #result == 0 then
			return ""
		end
		return result .. " " .. self.icon
	end,
	hl = { fg = "bright_bg", bg = "gray" },
	-- smart_sep(false, "gray", "blue"),
	seps({ fg = "gray", bg = "bright_bg" }, false, true),
	-- seps({ fg = "bright_bg", bg = "gray" }, false, true),
}

local Path = {
	provider = function()
		local full_path = vim.fn.expand("%:p")
		local path = full_path
		local cwd = vim.fn.getcwd()
		if path == "" then
			path = cwd
		end
		local stats = vim.loop.fs_stat(path)
		if stats and stats.type == "directory" then
			return vim.fn.fnamemodify(path, ":~")
		end

		if full_path:sub(1, #cwd) == cwd then
			path = vim.fn.expand("%:.")
		else
			path = vim.fn.expand("%:~")
		end

		if #path < (vim.fn.winwidth(0) / 4) then
			return "%f"
		end
		return vim.fn.pathshorten(path)
	end,
	hl = function(self)
		return { fg = "text", bg = self.active_color[2] }
	end,
	seps(function(self)
		return { fg = self.active_color[2], bg = "bright_bg" }
	end, false, true),
	seps({ fg = "bright_bg", bg = "gray" }, false, true),
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
	hl = function(self)
		return { bg = self.active_color[2] }
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

local LSPActive = {
	-- Update on "DiagnosticChanged" as nested update clause is ignored
	-- update = {
	-- 	"LspAttach",
	-- 	"LspDetach",
	-- 	"DiagnosticChanged",
	-- 	callback = vim.schedule_wrap(function(_)
	-- 		vim.cmd.redrawstatus()
	-- 	end),
	-- },
	condition = function(self)
		self.clients = vim.lsp.get_active_clients({ bufnr = 0 })
		return next(self.clients) ~= nil
	end,
	hl = function(self)
		return { fg = "bright_bg", bg = self.active_color[2] }
	end,
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
	-- seps({ fg = "cyan", bg = "bright_bg" }, true, true),
	-- seps({ fg = "bright_bg", bg = "green" }, true, true),
}

local Align = { provider = "%=", hl = { fg = "fg", bg = "bg" } }

local Ruler = {
	provider = "%7(%l/%3L%):%2c %P",
	hl = { fg = "bright_bg", bg = "gray" },
	-- smart_sep("gray"
	seps({ fg = "gray", bg = "bright_bg" }, true, true),
	seps(function(self)
		return { fg = "bright_bg", bg = self.active_color[2] }
	end, true, true),
}

local StatusLine = {
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
			s = "SELECT",
			S = "S-LINE",
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
			n = { "bg", "bright_fg" },
			i = { "green", "red" },
			v = { "cyan", "purple" },
			V = { "cyan", "purple" },
			["\22"] = { "cyan", "purple" },
			c = { "orange", "gray" },
			s = { "purple", "cyan" },
			S = { "purple", "cyan" },
			["\19"] = { "purple", "cyan" },
			R = { "orange", "gray" },
			r = { "orange", "gray" },
			["!"] = { "red", "bright_bg" },
			t = { "red", "bright_bg" },
		},
	},
	-- We can now access the value of mode() that, by now, would have been
	-- computed by `init()` and use it to index our strings dictionary.
	-- note how `static` fields become just regular attributes once the
	-- component is instantiated.
	-- To be extra meticulous, we can also add some vim statusline syntax to
	--
	-- control the padding and make sure our string is always at least 2
	-- characters long. Plus a nice Icon.
	provider = function(self)
		return self.mode_names[self.mode]
	end,
	-- Same goes for the highlight. Now the foreground will change according to the current mode.
	hl = function(self)
		self.active_color = self.mode_colors[self.mode:sub(1, 1)]
		-- local mode = self.mode:sub(1, 1) -- get only the first mode character
		return { bg = self.active_color[1], fg = "text", bold = true }
	end,
	update = {
		"ModeChanged",
		pattern = "*:*",
		callback = vim.schedule_wrap(function()
			vim.cmd("redrawstatus")
		end),
	},
	seps(function(self)
		return { fg = self.active_color[1], bg = "bright_bg", bold = true }
	end, false, true),
	-- ChadSeps({ fg = "gray", bg = "gray" }),
	seps(function(self)
		return { fg = "bright_bg", bg = self.active_color[2] }
	end, false, true),
	{
		Path,
	},
	{
		Git,
	},
	{
		seps({ fg = "bright_bg", bg = "bg" }, false, true),
	},
	{ Align },
	smart_sep(true, "bg", "gray"),
	-- { seps({ fg = "bg", bg = "bright_bg" }, true, true) },
	-- { seps({ fg = "bright_bg", bg = "gray" }, true, true) },
	{ Ruler },
	{ LSPActive },
}

return {
	statusline = {
		StatusLine,
		-- ViMode,
		-- Git,
		-- Path,
		-- seps({ fg = "bright_bg", bg = "bg" }, false, true),
		-- Align,
		-- seps({ fg = "bg", bg = "bright_bg" }, true, true),
		-- seps({ fg = "bright_bg", bg = "gray" }, true, true),
		-- Ruler,
		-- LSPActive,
	},
}
