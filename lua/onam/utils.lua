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
				command = function()
					vim.cmd(command)
				end,
			})
		else
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

return utils
