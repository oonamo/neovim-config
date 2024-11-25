local M = {}
M.hl = {}

---@class status.Data
---@field buf number
---@field fname string

---@param hl string
---@param v table
---@return string
local function get_hl(hl, v)
	if M.hl[hl] then
		return M.hl[hl]
	end
	local new_hl = v
	if v.fg then
		if type(v.fg) == "table" then
			local key = v.fg.key
			local hi = v.fg.hi
			local tmp = vim.api.nvim_get_hl(0, {
				name = hi,
			})
			new_hl.fg = tmp[key]
		elseif v.fg:sub(1, 1) ~= "#" then
			local fg = vim.api.nvim_get_hl(0, {
				name = v.fg,
			})
			new_hl.fg = fg.fg
		end
	end
	if v.bg then
		if type(v.bg) == "table" then
			local key = v.bg.key
			local hi = v.bg.hi
			local tmp = vim.api.nvim_get_hl(0, {
				name = hi,
			})
			new_hl.bg = tmp[key]
		elseif v.bg:sub(1, 1) ~= "#" then
			local bg = vim.api.nvim_get_hl(0, {
				name = v.bg,
			})
			new_hl.bg = bg.bg
		end
	end
	vim.api.nvim_set_hl(0, "status" .. hl, new_hl)
	M.hl[hl] = "status" .. hl
	return M.hl[hl]
end

---@param hl string
---@param value any
---@param hl_keys table
---@param reset boolean?
---@return string
local function stl_format(hl, value, hl_keys, reset)
	local mod_hl = get_hl(hl, hl_keys)
	return string.format("%%#%s#%s%s", mod_hl, value, reset and "%#Statusline#" or "")
end

function M.make_his(hl_list)
	for k, v in pairs(hl_list) do
		vim.api.nvim_set_hl(0, "status" .. k, v)
	end
end

local function cb_to_co(cb)
	return coroutine.create(cb)
end

local Gitinfo = {}

local function gitinfo(data)
	if not Gitinfo.head then
		local co = coroutine.running()
		vim.system({ "git", "config", "--get", "init.defaultBranch" }, { text = true }, function(result)
			coroutine.resume(co, #result.stdout > 0 and vim.trim(result.stdout) or nil)
		end)
		Gitinfo.head = coroutine.yield()
	end

	local part = stl_format("gitinfo", Gitinfo.head, {
		fg = "Special",
		bg = "StatusLine",
	})

	return part
end

local function diff_info(data)
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
			bold = true,
		})
	end
	if delete and delete > 0 then
		delete_format = stl_format("delete", "-" .. delete, {
			fg = "diffRemoved",
			bg = "StatusLine",
			bold = true,
		})
	end
	if change and change > 0 then
		change_format = stl_format("change", "~" .. change, {
			fg = "diffChanged",
			bg = "StatusLine",
			bold = true,
		})
	end
	return add_format .. " " .. change_format .. " " .. delete_format .. " %#StatusLine# "
end

local function grapple_info()
	if not package.loaded["grapple"] then
		return ""
	end

	local statusline = require("grapple").statusline()
	return statusline
end

local function filestatus() end

local default_status = function()
	return {
		[[%<%f]],
		" ",
		grapple_info(),
		-- gitinfo(),
		[[%h%m%r%=]],
		diff_info(),
		"%-14.(%l,%c%V%) %P",
	}
end

M.build = function()
	---@type status.Data
	local data = {
		buf = vim.api.nvim_get_current_buf(),
		fname = vim.api.nvim_buf_get_name(0),
	}
	local components = default_status(data)
	local statusline = ""
	for _, component in ipairs(components) do
		statusline = statusline .. component
	end
	return statusline
end

vim.opt.statusline = "%!v:lua.require('minimal_status').build()"

return M
