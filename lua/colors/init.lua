---Returns the name of a package
---@param source string
---@return string?
---@return table?
local function package_name(source)
	-- ie oonamo/command-pal.nvim
	local repo_owner, repo_name = source:match("(.*)/(.*)")
	local ok, theme = pcall(require, repo_name)
	if ok then
		return repo_name, theme
	end
	ok, theme = pcall(require, repo_owner)
	if ok then
		return repo_owner, theme
	end
	local name = repo_name:match("(.*).nvim")
	if not name then
		name = repo_name:match("(.*).vim")
	end
	if not name then
		name = repo_name:match("vim-(.*)")
	end
	if not name then
		return nil, nil
	end
	ok, theme = pcall(require, name)
	if ok then
		return name, theme
	end
end

---@class config.Colors
---@field register fun(name: string, handle?: fun(config.Color), source?: string): config.Color
---@field get_color fun(name: string): config.Color
---@field colors config.Color[]
local M = {}
M.colors = {}

---@class config.Color
---@field name string
---@field handle fun(self, flavour)
---@field new_color fun(self, name: string, handle, source: string): config.Color
---@field apply fun(self, flavour: string?): any
---@field add_flavour fun(self, flavour: string, handle?: fun(self, flavour)): self
---@field add_flavours fun(self, flavours: string[], handle?: fun(self, flavour)): self
---@field set_source fun(self, source: string): self
---@field set_spec fun(self, spec: table|fun, override?: boolean): self
---@field get_name fun(self): string
---@field flavours table
---@field handles table
---@field spec table
---@field before_fn fun(self)
local Color = {}
Color.handles = {}

function Color:new_color(name, handle, source)
	handle = handle or function()
		vim.cmd.colorscheme(name)
	end
	local color = { name = name, handle = handle, flavours = {}, spec = {} }
	if source then
		color.spec = { source }
	end
	color.spec.config = function(_, opts)
		M.config = true
		if M.get_color(name).before_fn then
			M.get_color(name):before_fn()
			M.before = true
		end
		if opts and source then
			-- HACK: Only works for github repos
			local _, scheme = package_name(source)
			if scheme and type(scheme) == "table" then
				-- TODO: log on setup_ok == false
				local setup_ok, _ = pcall(scheme.setup, opts)
			end
		end
		M.get_color(name):apply(opts.variant)
	end
	setmetatable(color, self)
	self.__index = self
	-- setmetatable(color, { __index = self })
	return color
end

function Color:set_source(source)
	self.spec = self.spec or {}
	self.spec[1] = source
	return self
end

function Color:set_spec(spec, override)
	local hndl, src, opts = self.spec.config, self.spec[1], self.spec.opts
	self.spec = spec
	if not override then
		self.spec.config = hndl
		self.spec[1] = src
		if type(opts) == "table" then
			vim.tbl_extend("force", opts or {}, self.spec.opts or {})
		end
	end
	return self
end

function Color:get_name()
	return self.name
end

---@param name string
---@param flavour? string
function Color:set_variant_name(name, flavour)
	if name then
		self.spec = self.spec or {}
		if not self.spec.opts then
			self.spec.opts = {}
		elseif type(self.spec.opts) == "function" then
			return
		end
		self.spec.opts[name] = flavour or self.name
		self.variant = name
	end
	return self
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
	if self.before_fn then
		self:before_fn()
	end
	M.applied = true
	if flavour and self.flavours[flavour] then
		local hndl = self.flavours[flavour]
		hndl(self, flavour)
		M.found_flavour = true
		if self._apply_override then
			self._apply_override()
		end
		return
	end
	M.found_flavour = false
	local res = self:handle(flavour)
	if self._apply_override then
		self._apply_override()
	end
	return res
end

function Color:before(fn)
	self.before_fn = fn
	return self
end

function Color:add_transparency()
	return require("mini.colors").get_colorscheme():add_transparency()
end

function Color:override(hls, fn)
	self._apply_override = function()
		local hl = vim.api.nvim_set_hl
		for k, v in pairs(hls) do
			hl(0, k, v)
		end
		if fn then
			fn(self)
		end
	end
	return self
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

------------------------
--- Colors
------------------------
---@param name string
---@return config.Color
function M.get_color(name)
	return M.colors[name]
end

---@param name string
---@param handle fun(color: config.Color, flavour: string)
---@param source string
---@return config.Color
function M.register(name, handle, source)
	local color = Color:new_color(name, handle, source)
	M.colors[name] = color
	return color
end

---@return config.Color|nil
function M.get_active()
	return M.get_color(vim.g.colors_name)
end

---Sets the active color. If colors have not been loaded, updates the lazy spec
---@param name string
---@param opts any
function M.set_active(name, opts)
	if vim.g.loaded_colors then
		M.get_color(name):set_variant_name(opts):apply(opts)
	elseif M.colors[name] then
		M.colors[name].spec.lazy = false
		M.colors[name].spec.priority = 1000
		M.get_color(name):set_variant_name("variant", opts)
		-- Color.set_variant_name(M.colors[name], "variant", opts)
	else
		vim.notify("colorscheme does not exist")
	end
end

function M.specs()
	local specs = {}
	for _, v in pairs(M.colors) do
		table.insert(specs, v.spec)
	end
	return specs
end

_G.Colors = M
