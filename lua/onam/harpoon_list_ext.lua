-- Extension to show current harpoon list in winbar or statusline
local harpoon = require("harpoon")
local fn = vim.fn
local api = vim.api
local has, webdevicons = pcall(require, "nvim-web-devicons")

---@class M
---@field setup_autocmds function
---@field Update_harpoon function
---@field get_harpoon_list function
---@field numbered_highlights function
---@field harpoon_list_as_statusline function
local M = {}

---@class Opts
---@field separator string?
---@field num_separator string?
---@field show_active boolean?
---@field max_full_length_items number?
---@field inactive_highlight string?
---@field numbered_highlights table?
---@field harpoon_list_as_statusline boolean?
---@field harpoon_list_as_winbar boolean?
---@field harpoon_list_as_tabline boolean?
---@field use_full_path boolean?
---@field background_highlight string?
---@field enable_icons boolean?
---@field keys table?
local default_opts = {
	separator = "  |  ",
	num_separator = "  ",
	show_active = true,
	max_full_length_items = 6,
	inactive_highlight = "BufferInactive",
	active_highlight = "BufferVisible",
	background_highlight = "BufferInactive",
	bold_active = true,
	numbered_highlights = {
		enabled = false,
		groups = {},
	},
	use_full_path = false,
	harpoon_list_as_statusline = false,
	harpoon_list_as_winbar = false,
	harpoon_list_as_tabline = false,
	enable_icons = true,
	use_only_file_name = false,
	keys = {},
}

---@type Opts
local user_opts = {}

function M.setup_autocmds()
	--==============================================================================
	-- Harpoon
	-- =============================================================================
	-- Executes on harpoon select
	-- vim.api.nvim_create_autocmd("User", {
	utils.augroup("HarpoonStatus", {
		{
			events = { "User" },
			targets = {
				"HarpoonListSelect",
				"HarpoonListChange",
				"HarpoonListClear",
				"HarpoonListAdd",
			},
			command = function()
				M.Update_harpoon()
			end,
		},
		{
			events = { "User" },
			targets = {
				"HarpoonListRemove",
			},
			command = function(event)
				M.remove_harpoon_item(event.data.item)
			end,
		},
		{
			events = { "VimEnter" },
			targets = { "*" },
			command = function()
				Init_harpoon()
			end,
		},
		{
			events = { "BufEnter" },
			targets = { "*" },
			command = function()
				Init_harpoon()
			end,
		},
	})
	function Init_harpoon()
		Cachedlist = harpoon:list()
	end
end

function M.Update_harpoon()
	-- Cachedlist = event.data.list
	Cachedlist = harpoon:list()
	vim.opt.winbar = M.harpoon_list_as_statusline(user_opts)
	vim.cmd("redrawtabline")
	vim.cmd("redrawstatus")
end

function M.add_harpoon_item(item)
	table.insert(Cachedlist.items, item)
	vim.cmd("redrawtabline")
end

function M.remove_harpoon_item(item)
	table.remove(Cachedlist.items, item.idx)
	vim.cmd("redrawtabline")
end

function M.format_key(index)
	if index > #user_opts.keys then
		return index
	end
	return user_opts.keys[index]
end

---@param opts Opts
function M.setup_tabline(opts)
	user_opts = vim.tbl_deep_extend("force", default_opts, opts or {})
	M.setup_autocmds()
	vim.api.nvim_create_autocmd({ "BufEnter", "VimEnter" }, {
		pattern = "*",
		callback = function()
			local bar = M.harpoon_list_as_statusline(user_opts)
			vim.opt.winbar = bar
		end,
	})
end

function M.numbered_highlights(i, highlight, opts)
	if opts.numbered_highlights == nil then
		return highlight
	end
	if opts.numbered_highlights.enabled == true then
		local idx = i % #opts.numbered_highlights.groups
		if idx == 0 then
			idx = #opts.numbered_highlights.groups
		end
		return opts.numbered_highlights.groups[idx]
	else
		return highlight
	end
end

---@param opts Opts
function M.harpoon_list_as_statusline(opts)
	local file_name = fn.fnamemodify(api.nvim_buf_get_name(0), ":.")
	local inactive = ""
	local active = ""
	local modifier = ""

	if Cachedlist == nil then
		return ""
	end

	if Cachedlist.items == nil then
		return ""
	end

	if #Cachedlist.items > (opts.max_full_length_items or 3) and not opts.use_full_path then
		modifier = ":t"
	end

	for i, item in ipairs(Cachedlist.items) do
		local formatted_icon = ""
		if opts.enable_icons then
			if has then
				local icon, hl = webdevicons.get_icon_by_filetype(fn.fnamemodify(item.value, ":e"), nil)
				icon = icon or ""
				hl = hl or ""
				formatted_icon = "%#" .. hl .. "# " .. icon .. " "
			end
		end
		if fn.fnamemodify(item.value, ":.") ~= file_name then
			inactive = inactive
				.. formatted_icon
				.. string.format("%%#%s#", M.numbered_highlights(i, opts.inactive_highlight, opts))
				.. M.format_key(i)
				.. opts.num_separator
				.. fn.fnamemodify(item.value, modifier)
				.. (opts.separator or "")
		else
			if opts.show_active then
				active = formatted_icon
					.. "%#"
					.. opts.active_highlight
					.. "#"
					.. fn.fnamemodify(item.value, modifier)
					.. "%#"
					.. opts.inactive_highlight
					.. "#"
					.. (opts.separator or "")
			end
		end
	end
	return active .. inactive
end

return M
