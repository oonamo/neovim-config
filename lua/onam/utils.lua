--TODO:
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

---@param name string group name
---@param autocmds Autocommand[]
---@param noclear? boolean
function utils.augroup(name, autocmds, noclear)
	api.nvim_create_augroup(name, {
		clear = noclear or false,
	})

	for _, c in ipairs(autocmds) do
		local command = c.command
		if type(command) == "string" then
			api.nvim_create_autocmd(c.events, {
				group = name,
				pattern = c.targets,
				command = command,
			})
		elseif type(command) == "function" then
			api.nvim_create_autocmd(c.events, {
				group = name,
				pattern = c.targets,
				callback = command,
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
		vim.notify("Invalid color: " .. color)
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
	r = clamp_color(math.floor(tonumber(r * (100 + percent) / 100)))
	g = clamp_color(math.floor(tonumber(g * (100 + percent) / 100)))
	b = clamp_color(math.floor(tonumber(b * (100 + percent) / 100)))

	local rgb = "#" .. fmt("%0x", r) .. fmt("%0x", g) .. fmt("%0x", b)
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

return utils
