local M = {}
M.hl = {}

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
}

function M.mode()
	local vim_mode = vim.api.nvim_get_mode().mode
	local mode = M.modes[vim_mode] or M.modes[vim_mode:sub(1, 1)] or "UNK"
	return mode
end

function M.diagnostic()
	if #vim.diagnostic.get(0) > 0 then
		local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
		local error_format = stl_format("error", errors, {
			fg = "DiagnosticError",
			bg = "StatusLine",
		})
		local err = errors > 0 and " E " .. error_format or ""

		local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
		local warn_format = stl_format("warn", warnings, {
			fg = "DiagnositcWarn",
			bg = "StatusLine",
		})
		local warn = warnings > 0 and " W " .. warn_format or ""

		local hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
		local hint_format = stl_format("hint", hints, {
			fg = "DiagnosticHint",
			bg = "StatusLine",
		})
		local hint = hints > 0 and " H " .. hint_format or ""

		local infos = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
		local info_format = stl_format("info", infos, {
			fg = "DiagnosticInfo",
			bg = "StatusLine",
		})
		local info = infos > 0 and " I " .. info_format or ""
		return err .. warn .. hint .. info .. "%#StatusLine# "
	end
	return ""
end

local function build()
	return {
		M.mode(),
		M.diagnostic(),
		"%=%f%=",
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
