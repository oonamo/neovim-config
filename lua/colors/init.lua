---@class config.Colors
---@field register fun(name: string, handle?: fun(config.Color)): config.Color
---@field get_color fun(name: string): config.Color
---@field colors config.Color[]
local M = {}
M.colors = {}

---@class config.Color
---@field name string
---@field handle fun(self, flavour)
---@field new_color fun(self, name: string, handle): config.Color
---@field apply fun(self, flavour: string?): any
---@field add_flavour fun(self, flavour: string, handle?: fun(self, flavour)): self
---@field add_flavours fun(self, flavours: string[], handle?: fun(self, flavour)): self
---@field flavours table
---@field handles table
local Color = {}
Color.handles = {}

function Color:new_color(name, handle)
	if handle == nil then
		handle = function()
			vim.cmd.colorscheme(self.name)
		end
	end
	local color = { name = name, handle = handle, flavours = {} }
	setmetatable(color, { __index = self })
	return color
end

function Color:get_name()
	return self.name
end

function Color:add_flavour(flavour, handle)
	if handle == nil then
		handle = function()
			vim.cmd.colorscheme(self.name .. "-" .. flavour)
		end
	end
	self.flavours[flavour] = handle
	return self
end

function Color:add_flavours(flavours, handle)
	for _, flavour in ipairs(flavours) do
		self:add_flavour(flavour, handle)
	end
	return self
end

function Color:apply(flavour)
	if flavour and self.flavours[flavour] then
		local hndl = self.flavours[flavour]
		hndl(self, flavour)
		return
	end
	return self:handle(flavour)
end

function Color:add_transparency()
	return require("mini.colors").get_colorscheme():add_transparency()
end

-----------------------
--- Handles
-----------------------
---@param color config.Color
---@return fun()
function Color.handles.default_color(color)
	return function()
		vim.cmd.colorscheme(color.name)
	end
end

---Defualt Flavour Handler
---@param color config.Color
---@param flavour string
---@return fun()
function Color.handles.default_flavour(color, flavour)
	return function()
		vim.cmd.colorscheme(color.name .. "-" .. flavour)
	end
end

function M.get_color(name)
	return M.colors[name]
end

function M.register(name, handle)
	local color = Color:new_color(name, handle)
	M.colors[name] = color
	return color
end

function M.get_active(name)
	return M.get_color(vim.g.colors_name)
end

_G.Colors = M
