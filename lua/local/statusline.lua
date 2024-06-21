---@param str string
---@param hl string
---@param hl_end? string
local function hl_str(str, hl, hl_end)
	local str = "%#" .. hl .. "#" .. str
	if hl_end then
		str = str .. "%#" .. hl_end .. "#"
	end
	return str
end

local mode = {
	mode = {
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
	init = function(self)
		self.mode = vim.fn.mode()
	end,
	provider = function(self)
		return hl_str(self.name, self.mode_colors[self.mode])
	end,
	update = {
		"ModeChanged",
		pattern = "*:*",
		callback = vim.schedule_wrap(function()
			vim.cmd("redrawstatus")
		end),
	},
}
