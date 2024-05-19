--TODO:
-- split utils into seperate files depending on the
-- usecase
local api = vim.api
local fmt = string.format

_G.utils = {
	_functions = {},
}

-- USAGE

-- utils.inspect(utils._functions)

-- or

-- :lua utils.inspect(utils._functions)
---@vararg any

function utils.inspect(...)
	local objects, v = {}, nil
	for i = 1, select("#", ...) do
		v = select(i, ...)
		table.insert(objects, vim.inspect(v))
	end

	print(table.concat(objects, "\n"))
	return ...
end

function utils.always(val)
	return function()
		return val
	end
end
function utils.trim(s)
	return (s:gsub("^%s*(.-)%s*$", "%1"))
end

---@class BlockingKey
---@field keys keys[]
local blockingKey = {}

---@class keys
---@field mode table|string
---@field lhs string
---@field rhs string
---@field opts table

---@param keys keys
function utils.blocking_keys(keys)
	vim.keymap.set(keys.mode, keys.lhs, keys.rhs, keys.opts)
	table.insert(blockingKey, keys)
end

function utils.delete_blocking_keys()
	for _, v in ipairs(blockingKey) do
		vim.keymap.del(v.mode, v.lhs)
	end
end

function utils.enable_blocking_keys()
	for _, v in ipairs(blockingKey) do
		vim.keymap.set(v.mode, v.lhs, v.rhs, v.opts)
	end
end

function utils.create(f)
	table.insert(utils._functions, f)
	return #utils._functions
end

function utils.execute(id, args)
	utils._functions[id](args)
end

---@class Autocommand
---@field events string[] list of autocommand events
---@field targets string[]? list of autocommand patterns
---@field modifiers string[]? e.g. nested, once
---@field exec boolean?
---@field command string | function
---@field desc string|nil
---@field once boolean|nil

---@param name string group name
---@param autocmds Autocommand[]
---@param noclear? boolean
function utils.augroup(name, autocmds, noclear)
	api.nvim_create_augroup(name, {
		clear = noclear or false,
	})

	for _, c in ipairs(autocmds) do
		local command = c.command
		local desc = c.desc or ""
		local once = c.once or false
		if type(command) == "string" then
			api.nvim_create_autocmd(c.events, {
				group = name,
				pattern = c.targets,
				command = command,
				desc = desc,
				once = once,
			})
		elseif type(command) == "function" then
			api.nvim_create_autocmd(c.events, {
				group = name,
				pattern = c.targets,
				callback = command,
				desc = desc,
				once = once,
			})
		end
	end
end

-- command factory
-- USAGE utils.command("MyCommand", my_fn)
-- @param name string
-- @param fn vim command or lua function
function utils.command(name, fn)
	if type(fn) == "function" then
		local fn_id = utils.create(fn)
		fn = fmt("lua utils.execute(%s)", fn_id)
	end
	vim.cmd(fmt("command! %s %s", name, fn))
end

---@class UtilHighlightItem
---@field name string
---@field opts table

---@class UtilHighlight
---@field opts table
utils.hl = {}

function utils:create_hl()
	if utils.hl.opts == nil then
		return
	end
	for _, hl in pairs(utils.hl.opts) do
		vim.api.nvim_set_hl(0, hl[1], hl[2])
	end
end

---@class UtilStatusline
---@field opts table
utils.statuscolors = {}

function utils:create_statusline()
	if utils.statuscolors.opts == nil then
		return
	end
	for _, hl in pairs(utils.statuscolors.opts) do
		vim.api.nvim_set_hl(0, hl[1], hl[2])
	end
end

utils.pmenu = {}

function utils:create_pmenu()
	if utils.pmenu.opts == nil then
		return
	end
	for _, hl in pairs(utils.pmenu.opts) do
		vim.api.nvim_set_hl(0, hl[1], hl[2])
	end
end

---@param color string
---@return number, number, number
local function to_rgb(color)
	if color == nil then
		return 0, 0, 0
	end
	return tonumber(color:sub(2, 3), 16), tonumber(color:sub(4, 5), 16), tonumber(color:sub(6, 7), 16)
end

---@param color number
---@return number
local function clamp_color(color)
	return math.max(math.min(color, 255), 0)
end

---@param color string
---@param percent number
---@param property string|nil
---@return string
function utils.brighten(color, percent, property)
	local ok, hl = pcall(vim.api.nvim_get_hl_by_name, color, true)
	if not ok then
		-- vim.notify("Invalid color: " .. color)
		return "#000000"
	end
	local result = {}
	for k, v in pairs(vim.api.nvim_get_hl_by_name(color, true)) do
		if type(v) == "boolean" then
			result[k] = v
		else
			result[k] = string.format("#%06x", v)
		end
	end
	local r, g, b = to_rgb(result[property or "foreground"])
	---@diagnostic disable-next-line: param-type-mismatch
	r = clamp_color(math.floor(tonumber(r * (100 + percent) / 100)))
	---@diagnostic disable-next-line: param-type-mismatch
	g = clamp_color(math.floor(tonumber(g * (100 + percent) / 100)))
	---@diagnostic disable-next-line: param-type-mismatch
	b = clamp_color(math.floor(tonumber(b * (100 + percent) / 100)))
	-- r, g, b = r < 255 and r or 255, g < 255 and g or 255, b < 255 and b or 255
	-- local rgb = "#" .. fmt("%0x", r) .. fmt("%0x", g) .. fmt("%0x", b)
	local rgb = "#" .. string.format("%02x%02x%02x", r, g, b)
	-- while not utils.valid_rgb_str(rgb) do
	-- 	rgb = rgb .. "0"
	-- 	if #rgb > 7 then
	-- 		print("could not create hl for", color)
	-- 		return "#000000"
	-- 	end
	-- end
	return rgb
end

function utils.hue2rgb(p, q, t)
	if t < 0 then
		t = t + 1
	end
	if t > 1 then
		t = t - 1
	end
	if t < 1 / 6 then
		return p + (q - p) * 6 * t
	end
	if t < 1 / 2 then
		return q
	end
	if t < 2 / 3 then
		return p + (q - p) * (2 / 3 - t) * 6
	end
	return p
end

function utils.hsl_to_rgb(h, s, l)
	local r, g, b
	if s > 1 then
		s = s / 100
	end
	if l > 1 then
		l = l / 100
	end
	if s == 0 then
		r, g, b = l, l, l
	else
		local q
		if l < 0.5 then
			q = l * (1 + s)
		else
			q = l + s - l * s
		end
		local p = 2 * l - q
		r = utils.hue2rgb(p, q, h + 1 / 3)
		g = utils.hue2rgb(p, q, h)
		b = utils.hue2rgb(p, q, h - 1 / 3)
	end
	-- return r, g, b
	-- Return as string
	r, g, b = fmt("%d", r * 255), fmt("%d", g * 255), fmt("%d", b * 255)
	local rgb = "#" .. fmt("%0x", r) .. fmt("%0x", g) .. fmt("%0x", b)
	return rgb -- rgb
end

---@class Highlight
---@field forground? string
---@field background? string
---@field special? table

---@return string|nil, string|nil, Highlight|nil
function utils.get_hl(name)
	local ok, hl = pcall(vim.api.nvim_get_hl_by_name, name, true)
	if not ok then
		return nil, nil, nil
	end
	return utils.format_color(hl.foreground), utils.format_color(hl.background), hl
end

function utils.create_fzf_lua_hls()
	local function get_attibutes(hl_name, attr)
		local _, _, hl = utils.get_hl(hl_name)
		if not hl then
			return "NONE"
		end
		return hl[attr]
	end
	utils.hl = {
		opts = {
			-- { "FzfLuaNormal", { link = "TelescopeNormal" } }, -- FzfLuaNormal 	hls.normal 	Main win fg/bg
			-- { "FzfLuaBorder", { link = "TelescopeBorder" } }, -- FzfLuaBorder 	hls.border 	Main win border
			-- { "FzfLuaTitle", { link = "TelescopeTitle" } }, -- FzfLuaTitle 	hls.title 	Main win title
			-- { "FzfLuaPreviewNormal", { link = "TelescopePreviewNormal" } }, -- FzfLuaPreviewNormal 	hls.preview_normal 	Builtin preview fg/bg
			-- { "FzfLuaPreviewBorder", { link = "TelescopePreviewBorder" } }, -- FzfLuaPreviewBorder 	hls.preview_border 	Builtin preview border
			-- { "FzfLuaPreviewTitle", { link = "TelescopePreviewTitle" } }, -- FzfLuaPreviewTitle 	hls.preview_title 	Builtin preview title
			-- { "FzfLuaCursor", { link = "Cursor" } }, -- FzfLuaCursor 	hls.cursor 	Builtin preview Cursor
			-- { "FzfLuaCursorLine", { link = "CursorLine" } }, -- FzfLuaCursorLine 	hls.cursorline 	Builtin preview Cursorline
			-- { "FzfLuaCursorLineNr", { link = "CursorLineNr" } }, -- FzfLuaCursorLineNr 	hls.cursorlinenr 	Builtin preview CursorLineNr
			-- { "FzfLuaSearch", { link = "IncSearch" } }, -- FzfLuaSearch 	hls.search 	Builtin preview search matches
			-- { "FzfLuaScrollBorderEmpty", { link = "FzfLuaBorder" } }, -- FzfLuaScrollBorderEmpty 	hls.scrollborder_e 	Builtin preview border scroll empty
			-- { "FzfLuaScrollBorderFull", { link = "FzfLuaBorder" } }, -- FzfLuaScrollBorderFull 	hls.scrollborder_f 	Builtin preview border scroll full
			-- { "FzfLuaScrollFloatEmpty", { link = "PmenuSbar" } }, -- FzfLuaScrollFloatEmpty 	hls.scrollfloat_e 	Builtin preview float scroll empty
			-- { "FzfLuaScrollFloatFull", { link = "PmenuThumb" } }, -- FzfLuaScrollFloatFull 	hls.scrollfloat_f 	Builtin preview float scroll full
			-- { "FzfLuaHelpNormal", { link = "FzfLuaNormal" } }, -- FzfLuaHelpNormal 	hls.help_normal 	Help win fg/bg
			-- { "FzfLuaHelpBorder", { link = "FzfLuaBorder" } }, -- FzfLuaHelpBorder 	hls.help_border 	Help win border
			-- { "FzfLuaHeaderBind", { link = "TelescopeResultsNormal" } }, -- FzfLuaHeaderBind 	hls.header_bind 	Header keybind
			-- { "FzfLuaHeaderText", { link = "TelescopeResultsTitle" } }, -- FzfLuaHeaderText 	hls.header_text 	Header text
			{ "FzfLuaBufFlagAlt", {} },
			{ "FzfLuaBufFlagCur", {} },
			{ "FzfLuaBufName", {} },
			{ "FzfLuaBufNr", {} },
			{ "FzfLuaBufLineNr", { link = "LineNr" } },
			{ "FzfLuaCursor", { link = "None" } },
			{ "FzfLuaHeaderBind", { link = "Special" } },
			{ "FzfLuaHeaderText", { link = "Special" } },
			{ "FzfLuaTabMarker", { link = "Keyword" } },
			{ "FzfLuaTabTitle", { link = "Title" } },
			{ "FzfLuaNormal", { link = "TelescopeNormal" } },
			{ "FzfLuaTitle", { link = "TelescopeTitle" } },
			{ "FzfLuaScrollFloatEmpty", { link = "PmenuSbar" } },
			-- fzf-lua is configured to only pass down the .fg attribute.
			{ "FzfLuaColorsFg", { fg = get_attibutes("Normal", "foreground") } },
			{ "FzfLuaColorsFgSel", { link = "FzfLuaColorsFg" } },
			{ "FzfLuaColorsBg", { fg = get_attibutes("StatusLine", "background") } },
			{ "FzfLuaColorsBgSel", { link = "FzfLuaColorsBg" } },
			{ "FzfLuaColorsHl", { link = "Directory" } },
			{ "FzfLuaColorsHlSel", { link = "FzfLuaColorsHl" } },
			{ "FzfLuaColorsInfo", { fg = get_attibutes("DiagnosticInfo", "foreground") } },
			{ "FzfLuaColorsPrompt", { fg = get_attibutes("TelescopePromptBorder", "foreground") } },
			{ "FzfLuaColorsPointer", { fg = get_attibutes("TelescopeResultsBorder", "foreground") } },
			{ "FzfLuaColorsMarker", { fg = get_attibutes("TelescopeResultsBorder", "foreground") } },
			{ "FzfLuaColorsSpinner", { link = "FzfLuaColorsInfo" } },
			{ "FzfLuaColorsHeader", { link = "FzfLuaColorsHl" } },
		},
	}
	utils:create_hl()
end

---@param rgb string
---@return boolean
function utils.valid_rgb_str(rgb)
	return #rgb == 7
end

function utils.create_virt_diagnostics_hl()
	local diagnostics = {
		"DiagnosticVirtualTextError",
		"DiagnosticVirtualTextWarn",
		"DiagnosticVirtualTextInfo",
		"DiagnosticVirtualTextHint",
	}
	-- local percent = vim.o.background == "light" and 55 or -55
	local percent = -55
	for _, diagnostic in ipairs(diagnostics) do
		local fg, bg, hl = utils.get_hl(diagnostic)
		if not bg and hl then
			bg = utils.brighten(diagnostic, percent)
			while not utils.valid_rgb_str(bg) do
				bg = bg .. "0"
				if #bg > 7 then
					print("could not create hl for", diagnostic)
				end
			end
			hl.bg = bg
			vim.api.nvim_set_hl(0, diagnostic, hl)
		end
	end
end

function utils.format_color(color)
	if color == nil then
		return
	end
	return fmt("#%06x", color)
end

utils.get_path_root = function(path)
	if path == "" then
		return
	end

	local root = vim.b.path_root
	if root ~= nil then
		return root
	end

	local root_items = {
		".git",
	}

	root = vim.fs.find(root_items, {
		path = path,
		upward = true,
		type = "directory",
	})[1]
	if root == nil then
		return nil
	end

	root = vim.fs.dirname(root)
	vim.b.path_root = root

	return root
end

local remote_cache = {}
local branch_cache = {}

function utils.get_git_remote_name(root)
	if root == nil then
		return
	end

	local remote = remote_cache[root]
	if remote ~= nil then
		return remote
	end

	-- see https://stackoverflow.com/a/42543006
	-- "basename" "-s" ".git" "`git config --get remote.origin.url`"
	local cmd = table.concat({ "git", "config", "--get remote.origin.url" }, " ")
	remote = vim.fn.system(cmd)

	if vim.v.shell_error ~= 0 then
		return nil
	end

	remote = vim.fs.basename(remote)
	if remote == nil then
		return
	end

	remote = vim.fn.fnamemodify(remote, ":r")
	remote_cache[root] = remote

	return remote
end

utils.set_git_branch = function(root)
	local cmd = table.concat({ "git", "-C", root, "branch --show-current" }, " ")
	local branch = vim.fn.system(cmd)
	if branch == nil then
		return nil
	end
	branch = branch:gsub("\n", "")
	branch_cache[root] = branch

	return branch
end

utils.get_git_branch = function(root)
	if root == nil then
		return
	end
	local branch = branch_cache[root]
	if branch ~= nil then
		return branch
	end
	return utils.set_git_branch(root)
end

function utils.change_hl_attribute(highlight, attribute, value)
	local _, _, hl = utils.get_hl(highlight)
	hl[attribute] = value
	if hl ~= nil then
		vim.api.nvim_set_hl(0, highlight, hl)
	end
end

function utils.reverse_hl(highlight, swap_fg, swap_bg)
	local fg, bg, hl = utils.get_hl(highlight)
	if hl == nil then
		return
	end
	if swap_fg and not swap_bg then
		hl.foreground = bg or "NONE"
		hl.background = "NONE"
	elseif swap_bg and not swap_fg then
		hl.background = fg or "NONE"
		hl.foreground = "NONE"
	else
		hl.background = bg or "NONE"
		hl.foreground = fg or "NONE"
	end
	vim.api.nvim_set_hl(0, highlight, hl)
end

utils.diagnostics_available = function()
	local clients = vim.lsp.buf_get_clients(0)
	local diagnostics = vim.lsp.protocol.Methods.textDocument_publishDiagnostics

	for _, cfg in pairs(clients) do
		if cfg.supports_method(diagnostics) then
			return true
		end
	end

	return false
end

function utils.get_single_hl(name)
	local ok, hl = pcall(vim.api.nvim_get_hl_by_name, name, true)
	if ok then
		return hl
	end
	return nil
end

---@param hl string
---@param attr string
---@return boolean
function utils.hl_not_nil(hl, attr)
	local _, _, hi = utils.get_hl(hl)
	if hi == nil then
		return false
	end
	return hi[attr] ~= nil
end

return utils
