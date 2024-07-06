---@class Component
---@field init? fun(self)
---@field str string | fun(self): string
---@field cache_cmp_str? string
---@field last_update_buf? number
---@field buf_update? boolean

local M = {}

local function group_hl(str, hl)
	return "%#" .. hl .. "#" .. (str or "")
end

---@type Component
local modes = {
	modes = {
		colors = {
			n = "Character",
			i = "Function",
			v = "Boolean",
			V = "Boolean",
			t = "Constant",
			r = "Identifier",
			c = "Conditional",
		},
	},
	init = function(self)
		self.mode = vim.fn.mode(1)
	end,
	str = function(self)
		local mode = self.mode:sub(1, 1)
		local hl = "Comment"
		if self.modes.colors[mode] then
			hl = self.modes.colors[mode]
		end
		return group_hl("● ", hl)
	end,
}

---@type Component
local Git = {
	buf_update = true,
	init = function(self)
		self.root = utils.get_path_root(vim.api.nvim_buf_get_name(0))
		self.branch = utils.get_git_branch(self.root)
		self.remote = utils.get_git_remote_name(self.root)
	end,
	str = function(self)
		local str = ""
		if self.branch ~= nil then
			str = str .. group_hl("#" .. self.branch, "Special")
		end
		if self.remote ~= nil then
			-- str = str .. group_hl(string.format(":(%s)", self.remote:gsub("%s+", "")), "")
			str = str .. string.format(":(%s)", self.remote:gsub("%s+", ""))
		end
		return str
	end,
}

---@type Component
local diff = {
	init = function(self)
		self.provider = vim.b.minidiff_summary_string
	end,
	str = function(self)
		if self.provider ~= nil and self.provider ~= "" then
			return self.provider
		end
		return ""
	end,
}

---@type Component
local filename = {
	str = function()
		return " %t%m%r"
	end,
}

---@type Component
local filetype = {
	str = function()
		return "%y"
	end,
}

---@type Component
local ruler = {
	str = function()
		return "%l/%L"
	end,
}

---@type Component
local align = {
	str = function()
		return "%="
	end,
}

---@type Component
local harpoon = {
    buf_update = true,
	init = function(self)
		self.list = require("harpoon"):list().items
        self.buf_name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":~:.")
	end,
	str = function(self)
		local inactive = "-"
		local active = ""
		for i, v in ipairs(self.list) do
			if v.value == self.buf_name then
				active = tostring(i)
				break
			end
		end
		return (active ~= "" and active or inactive) .. "/" .. tostring(#self.list)
	end,
}

local space = {
	str = " ",
}

local stl_hl = {
	str = "%#Statusline#",
}

---@type Component[]
local stl_parts = {
	stl_hl,
	modes,
    Git,
	diff,
	space,
	harpoon,
	filename,
	filetype,
	align,
	ruler,
}

M.cur_buf = vim.api.nvim_get_current_buf()

vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		M.cur_buf = vim.api.nvim_get_current_buf()
	end,
})

function M.statusline()
	local str = " "
	for _, v in ipairs(stl_parts) do
		local comp_str = ""
		if v.buf_update == true then
			if v.last_update_buf == M.cur_buf then
                goto set_str
			end
		end
		if v.init ~= nil then
			v:init()
		end
		if type(v.str) == "function" then
			comp_str = (v:str() and v:str() or "")
			-- str = str .. (v:str() and v:str() or "")
		elseif type(v.str) == "string" then
			comp_str = v.str or "" --[[@as string]]
		end
		v.cache_cmp_str = comp_str .. "%#Statusline#"
		v.last_update_buf = M.cur_buf

        ::set_str::
		str = str .. v.cache_cmp_str
	end
	return str
end

vim.o.statusline = "%!v:lua.require('onam.statusline').statusline()"

return M
