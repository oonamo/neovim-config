local M = {}
M.hl = {}

---@param hl string
---@param v table
---@return string
local function get_hl(hl, v)
	if M.hl[hl] then
		return M.hl[hl]
	end
	local new_hl = v
	if v.fg and v.fg:sub(1, 1) ~= "#" then
		local fg = vim.api.nvim_get_hl(0, {
			name = v.fg,
		})
		new_hl.fg = fg.fg
	end
	if v.bg and v.bg:sub(1, 1) ~= "#" then
		local bg = vim.api.nvim_get_hl(0, {
			name = v.bg,
		})
		new_hl.bg = bg.bg
	end
	vim.api.nvim_set_hl(0, "status" .. hl, new_hl)
	M.hl[hl] = "status" .. hl
	return M.hl[hl]
end

---@param hl string
---@param value any
---@param hl_keys table
---@return string
local function stl_format(hl, value, hl_keys)
	local mod_hl = get_hl(hl, hl_keys)
	return string.format("%%#%s#%s", mod_hl, value)
end

function M.make_his(hl_list)
	for k, v in pairs(hl_list) do
		vim.api.nvim_set_hl(0, "status" .. k, v)
	end
end

M.modes = {
	["n"] = "NOR",
	["no"] = "OPE",
	["nov"] = "OPE",
	["noV"] = "OPE",
	["no\x16"] = "OPE",
	["niI"] = "NOR",
	["niR"] = "NOR",
	["niV"] = "NOR",
	["nt"] = "NOR",
	["ntT"] = "NOR",
	["v"] = "VIS",
	["vs"] = "VIS",
	["V"] = "V-LIN",
	["Vs"] = "V-LIN",
	["\x16"] = "V-BlO",
	["\x16s"] = "V-BLO",
	["s"] = "SEL",
	["S"] = "S-LIN",
	["\x13"] = "S-BLO",
	["i"] = "INS",
	["ic"] = "INS",
	["ix"] = "INS",
	["R"] = "REP",
	["Rc"] = "REP",
	["Rx"] = "REP",
	["Rv"] = "V-REP",
	["Rvc"] = "V-REP",
	["Rvx"] = "V-REP",
	["c"] = "CMD",
	["cv"] = "EX",
	["ce"] = "EX",
	["r"] = "REP",
	["rm"] = "MOR",
	["r?"] = "CONF",
	["!"] = "SHELL",
	["t"] = "TER",
}

function M.mode()
	local vim_mode = vim.api.nvim_get_mode().mode
	local mode = M.modes[vim_mode] or M.modes[vim_mode:sub(1, 1)] or "UNK"
	return mode
end

function M.diagnostic()
	if #vim.diagnostic.get(0) > 0 then
		local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
		local error_format = stl_format("error", " " .. errors, {
			fg = "DiagnosticError",
			bg = "StatusLine",
		})
		local err = errors > 0 and error_format .. " " or ""

		local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
		local warn_format = stl_format("warn", " " .. warnings, {
			fg = "DiagnosticWarn",
			bg = "StatusLine",
		})
		local warn = warnings > 0 and warn_format .. " " or ""

		local hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
		local hint_format = stl_format("hint", " " .. hints, {
			fg = "DiagnosticHint",
			bg = "StatusLine",
		})
		local hint = hints > 0 and hint_format .. " " or ""

		local infos = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
		local info_format = stl_format("info", " " .. infos, {
			fg = "DiagnosticInfo",
			bg = "StatusLine",
		})
		local info = infos > 0 and info_format .. " " or ""
		return err .. warn .. hint .. info .. "%#StatusLine# "
	end
	return ""
end

function M.diff()
	local summary = vim.b.minidiff_summary
	if not summary or not summary.source_name then
		return ""
	end
	local add = summary.add
	local change = summary.change
	local delete = summary.delete

	local add_format = ""
	local delete_format = ""
	local change_format = ""

	if add and add > 0 then
		add_format = stl_format("add", "+" .. add, {
			fg = "diffAdded",
			bg = "StatusLine",
		})
	end
	if delete and delete > 0 then
		delete_format = stl_format("delete", "-" .. delete, {
			fg = "diffRemoved",
			bg = "StatusLine",
		})
	end
	if change and change > 0 then
		change_format = stl_format("change", "~" .. change, {
			fg = "diffChanged",
			bg = "StatusLine",
		})
	end
	return add_format .. " " .. change_format .. " " .. delete_format .. " %#StatusLine# "
end

local function build()
	return {
		-- M.mode(),
		"%=%f%=",
		M.diff(),
		M.diagnostic(),
		"%l|%c",
	}
end

function M.statusline()
	local components = build()
	local statusline = ""
	for _, component in ipairs(components) do
		statusline = statusline .. component
	end
	return statusline
end

vim.api.nvim_create_autocmd("Colorscheme", {
	group = vim.api.nvim_create_augroup("Statusline", { clear = true }),
	callback = function()
		M.hls = {}
	end,
})

vim.opt.statusline = "%!v:lua.require('statusline').statusline()"

return M
