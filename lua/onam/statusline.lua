if vim.g.use_lualine == false then
	vim.opt.cmdheight = 1
	-- local autocmds = require("onam.autocmds")
	-- autocmds.setup_status_cmds()
	return
end
local fn = vim.fn
local api = vim.api
local harpoon = require("harpoon")

--@alias event {}
--@alias CachedList {items: {value: string, index: number}[]}
CachedList = {}

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

--TODO: Not working
-- local function keys()
-- 	local key = ""
-- 	return key
-- end

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

--==============================================================================
-- Harpoon
-- =============================================================================
-- Executes on harpoon select
vim.api.nvim_create_autocmd("User", {
	pattern = "HarpoonListSelect",
	group = "HarpoonStatus",
	callback = function(event)
		-- Update_harpoon(event)
		vim.schedule(function()
			Update_harpoon(event)
		end)
	end,
})
-- Executes on harpoon:append() or harpoon:prepend()
vim.api.nvim_create_autocmd("User", {
	pattern = "HarpoonListChange",
	group = "HarpoonStatus",
	callback = function(event)
		-- Update_harpoon(event)
		vim.schedule(function()
			Update_harpoon(event)
		end)
	end,
})

-- Executes on Harpoon UI Leave
vim.api.nvim_create_autocmd("User", {
	pattern = "HarpoonBufLeave",
	group = "HarpoonStatus",
	callback = function(event)
		vim.schedule(function()
			Update_harpoon(event)
		end)
	end,
})

vim.api.nvim_create_autocmd("BufLeave, WinLeave, BufWinLeave, BufWriteCmd", {
	pattern = "__harpooon-menu__*",
	group = "HarpoonStatus",
	callback = function(event)
		vim.schedule(function()
			Update_harpoon(event)
		end)
	end,
})
vim.api.nvim_create_autocmd("VimEnter", {
	group = "HarpoonStatus",
	pattern = "*",
	callback = function()
		Init_harpoon()
	end,
})

function Init_harpoon()
	Cachedlist = harpoon:list("cmd")
end

function Update_harpoon(event)
	Cachedlist = event.data.list
	vim.cmd("redrawstatus")
end

local function harpoon_list()
	local file_name = fn.fnamemodify(api.nvim_buf_get_name(0), ":p:.")
	local inactive = ""
	local active = ""
	local modifier = ""

	if Cachedlist.items == nil then
		return ""
	end
	if #Cachedlist.items > 4 then
		modifier = ":t"
	end
	for i, item in ipairs(Cachedlist.items) do
		if item.value ~= file_name then
			inactive = inactive .. " %=%#HarpoonInactive# " .. i .. " " .. fn.fnamemodify(item.value, modifier)
		else
			--FIX: Redundant to have the active harpoon item in the statusline
			-- active = " %#HarpoonActive# " .. i .. " " .. item.value
		end
	end

	return active .. inactive
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
	return table.concat({
		"%#Statusline#",
		update_mode_colors(),
		mode(),
		"%#StatusBarLong#",
		filepath(),
		filename(),
		macro(),
		"%#StatusEmpty#",
		" ",
		-- "%=",
		harpoon_list(),
		"%=%#StatusLineExtra#",
		filetype(),
		lineinfo(),
	})
end

function Statusline.inactive()
	return table.concat({ "%#StatusLine#", update_mode_colors(), mode(), "%#Normal# " })
end

function Statusline.short()
	return "%#StatusLineNC#   NvimTree"
end

if vim.g.use_custom_statusline == true then
	-- WARN: should be rose-pine, replace if you want with nord
	if vim.g.colors_name == "-pine" then
		Statusline.pine = function()
			return table.concat({
				mode(),
				" %f %m %= %l:%c ♥ ",
			})
		end
		utils.augroup("Statusline", {
			{
				events = { "WinEnter,BufEnter" },
				targets = { "*" },
				command = "setlocal statusline=%!v:lua.Statusline.pine()",
			},
		})
	else
		utils.augroup("Statusline", {
			{
				events = { "WinEnter,BufEnter,VimEnter" },
				targets = { "*" },
				command = "setlocal statusline=%!v:lua.Statusline.active()",
			},
			-- {
			-- 	events = { "WinLeave,BufLeave" },
			-- 	targets = { "*" },
			-- 	command = "setlocal statusline=%!v:lua.Statusline.inactive()",
			-- },
			{

				events = { "WinEnter,BufEnter" },

				targets = { "NeoTree" },
				command = "setlocal statusline=%!v:lua.Statusline.short()",
			},
			{
				events = { "CmdlineEnter", "CmdlineChanged", "BufWritePre" },
				targets = { "*" },
				command = "set cmdheight=1",
			},
			{
				events = { "CmdlineLeave", "BufWritePost", "InsertLeave" },
				targets = { "*" },
				command = "set cmdheight=0 | redrawstatus!",
			},
		})
	end
end
