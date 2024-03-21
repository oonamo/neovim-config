if vim.g.use_lualine == true or vim.g.use_default_statusline == true or vim.g.use_custom_statusline == false then
	-- local autocmds = require("onam.autocmds")
	-- autocmds.setup_status_cmds()
	return
end

local fn = vim.fn
local api = vim.api

local opts = {
	---@type string | "simple" | "lualine"
	style = "simple",
	enabled_modules = {
		"modes",
		"macros",
		"file",
		"filetype",
		"fileformat",
		"fileencoding",
		"progress",
		"location",
		"diagnostics",
	},
}

---@enum Mode
local modes = {
	["n"] = "NORMAL",
	["no"] = "NORMAL",
	["v"] = "VISUAL",
	["V"] = "VISUAL LINE",
	[""] = "VISUAL BLOCK",

	["s"] = "SELECT",

	["S"] = "SELECT LINE",
	[""] = "SELECT BLOCK",
	["i"] = "INSERT",
	["ic"] = "INSERT",
	["R"] = "REPLACE",
	["Rv"] = "VISUAL REPLACE",
	["c"] = "COMMAND",
	["cv"] = "VIM EX",
	["ce"] = "EX",
	["r"] = "PROMPT",
	["rm"] = "MOAR",
	["r?"] = "CONFIRM",
	["!"] = "SHELL",
	["t"] = "TERMINAL",
}

--@return string
local function mode()
	local current_mode = api.nvim_get_mode().mode
	return string.format(" %s ", modes[current_mode]):upper()
end

local function update_mode_colors()
	local current_mode = api.nvim_get_mode().mode
	local mode_color = "%#StatuslineAccent#"
	if current_mode == "n" then
		mode_color = "%#StatuslineAccent#"
	elseif current_mode == "i" or current_mode == "ic" then
		mode_color = "%#StatuslineInsertAccent#"
	elseif current_mode == "v" or current_mode == "V" or current_mode == "" then
		mode_color = "%#StatuslineVisualAccent#"
	elseif current_mode == "R" then
		mode_color = "%#StatuslineReplaceAccent#"
	elseif current_mode == "c" then
		mode_color = "%#StatuslineCmdLineAccent#"
	elseif current_mode == "t" then
		mode_color = "%#StatuslineTerminalAccent#"
	end

	return mode_color
end

local function filepath()
	local fpath = fn.fnamemodify(fn.expand("%"), ":~:.:h")
	if fpath == "" or fpath == "." then
		return " "
	end

	return string.format(" %%<%s/", fpath)
end

local function filename()
	local fname = fn.expand("%:t")
	if fname == "" then
		return ""
	end
	return fname .. " "
end

local function filetype()
	return string.format(" %s ", vim.bo.filetype):upper()
end

local function lineinfo()
	if vim.bo.filetype == "alpha" then
		return ""
	end
	return " %P %l:%c "
end

local function lsp()
	local count = {}
	local levels = {
		errors = "Error",
		warnings = "Warn",
		info = "Info",
		hints = "Hint",
	}

	for k, level in pairs(levels) do
		count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
	end

	local errors = ""
	local warnings = ""
	local hints = ""
	local info = ""

	if count["errors"] ~= 0 then
		errors = " %#DiagnosticSignError# " .. count["errors"]
	end
	if count["warnings"] ~= 0 then
		warnings = " %#DiagnosticSignWarn# " .. count["warnings"]
	end
	if count["hints"] ~= 0 then
		hints = " %#DiagnosticSignHint# " .. count["hints"]
	end
	if count["info"] ~= 0 then
		info = " %#DiagnosticSignInfo# " .. count["info"]
	end

	return errors .. warnings .. hints .. info .. "%#Normal#"
end

local function macro()
	if vim.fn.reg_recording() ~= "" then
		return "%#Macro#@recording " .. vim.fn.reg_recording() .. " "
	end
	return ""
end

Statusline = {}

local Modules = {
	["modes"] = mode,
	["mode_color"] = update_mode_colors,
	["macros"] = macro,
	["filename"] = filename,
	["filepath"] = filepath,
	["filetype"] = filetype,
	["location"] = lineinfo,
	["diagnostics"] = lsp,
}

--- Highlights
-- StatuslineAccent
-- StatuslineInsertAccent
-- StatuslineVisualAccent
-- StatuslineReplaceAccent
-- StatuslineCmdLineAccent
-- StatuslineTerminalAccent
-- HarpoonActive
-- HarpoonInactive
-- Statusline
-- StatusBarLong
-- StatusEmpty
-- StatusLineExtra
Statusline.active = function()
	return Statusline.builder(opts)
end

function Statusline.inactive()
	return table.concat({ "%#StatusLine#", update_mode_colors(), mode(), "%#Normal# " })
end

function Statusline.short()
	return "%#StatusLineNC#   NvimTree"
end

Statusline.builder = function(local_opts)
	if local_opts.style == "simple" then
		return table.concat({
			"%#Statusline#",
			update_mode_colors(),
			mode(),
			"%#CursorLine# ",
			filepath(),
			filename(),
			lsp(),
			"%=%#StatusLineExtra#",
			filetype(),
			lineinfo(),
		})
	end
	local enabled_modules = local_opts.enabled_modules
	local statusline = ""
	local mods = {}
	for _, module in ipairs(enabled_modules) do
		if Modules[module] ~= nil then
			table.insert(mods, Modules[module]())
		end
	end
	statusline = table.concat(mods)
	return statusline
end

utils.augroup("Statusline", {
	{
		events = { "WinEnter,BufEnter,VimEnter" },
		targets = { "*" },
		command = "set statusline=%!v:lua.Statusline.active()",
		exec = true,
	},
})

-- if vim.g.use_custom_statusline == true then
-- 	utils.augroup("Statusline", {
-- 		{
-- 			events = { "WinEnter,BufEnter,VimEnter" },
-- 			targets = { "*" },
-- 			command = "setlocal statusline=%!v:lua.Statusline.active()",
-- 		},
-- 		-- {
-- 		-- 	events = { "WinLeave,BufLeave" },
-- 		-- 	targets = { "*" },
-- 		-- 	command = "setlocal statusline=%!v:lua.Statusline.inactive()",
-- 		-- },
-- 		{
--
-- 			events = { "WinEnter,BufEnter" },
--
-- 			targets = { "NeoTree" },
-- 			command = "setlocal statusline=%!v:lua.Statusline.short()",
-- 		},
-- 		{
-- 			events = { "CmdlineEnter", "CmdlineChanged", "BufWritePre" },
-- 			targets = { "*" },
-- 			command = "set cmdheight=1",
-- 		},
-- 		{
-- 			events = { "CmdlineLeave", "BufWritePost", "InsertLeave" },
-- 			targets = { "*" },
-- 			command = "set cmdheight=0 | redrawstatus!",
-- 		},
-- 	})
-- end
