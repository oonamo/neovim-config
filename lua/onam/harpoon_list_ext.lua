-- Extension to show current harpoon list in winbar or statusline
local harpoon = require("harpoon")
local fn = vim.fn
local api = vim.api

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
local config_opts = {}

function M.setup_autocmds()
	--==============================================================================
	-- Harpoon
	-- =============================================================================
	-- Executes on harpoon select
	-- vim.api.nvim_create_autocmd("User", {
	-- 	pattern = "HarpoonListSelect",
	-- 	group = "HarpoonStatus",
	-- 	callback = function(event)
	-- 		-- Update_harpoon(event)
	-- 		vim.schedule(function()
	-- 			M.Update_harpoon(event)
	-- 		end)
	-- 	end,
	-- })
	utils.augroup("HarpoonStatus", {
		{
			events = { "User" },
			targets = {
				"HarpoonListSelect",
				"HarpoonListChange",
				"HarpoonListAdd",
				"HarpoonListRemove",
				"HarpoonListClear",
			},
			command = function(event)
				M.Update_harpoon(event)
			end,
		},
		{
			events = { "VimEnter" },
			targets = { "*" },
			command = function()
				Init_harpoon()
			end,
		},
	})
	-- Executes on harpoon:append() or harpoon:prepend()
	-- vim.api.nvim_create_autocmd("User", {
	-- 	pattern = "HarpoonListChange",
	-- 	group = "HarpoonStatus",
	-- 	callback = function(event)
	-- 		-- Update_harpoon(event)
	-- 		vim.schedule(function()
	-- 			M.Update_harpoon(event)
	-- 		end)
	-- 	end,
	-- })
	--
	-- -- Executes on Harpoon UI Leave
	-- vim.api.nvim_create_autocmd("User", {
	-- 	pattern = "HarpoonBufLeave",
	-- 	group = "HarpoonStatus",
	-- 	callback = function(event)
	-- 		vim.schedule(function()
	-- 			M.Update_harpoon(event)
	-- 		end)
	-- 	end,
	-- })
	--
	-- vim.api.nvim_create_autocmd("BufLeave, WinLeave, BufWinLeave, BufWriteCmd", {
	-- 	pattern = "__harpooon-menu__*",
	-- 	group = "HarpoonStatus",
	-- 	callback = function(event)
	-- 		vim.schedule(function()
	-- 			M.Update_harpoon(event)
	-- 		end)
	-- 	end,
	-- })
	--
	-- vim.api.nvim_create_autocmd("VimEnter", {
	-- 	group = "HarpoonStatus",
	-- 	pattern = "*",
	-- 	callback = function()
	-- 		Init_harpoon()
	-- 	end,
	-- })
	--
	-- vim.api.nvim_create_autocmd("User", {
	-- 	group = "HarpoonStatus",
	-- 	pattern = "HarpoonListAdd",
	-- 	callback = function(event)
	-- 		vim.schedule(function()
	-- 			M.Update_harpoon(event)
	-- 		end)
	-- 	end,
	-- })
	--
	-- vim.api.nvim_create_autocmd("User", {
	-- 	group = "HarpoonStatus",
	-- 	pattern = "HarpoonListRemove",
	-- 	callback = function(event)
	-- 		vim.schedule(function()
	-- 			M.remove_harpoon_item(event.data)
	-- 		end)
	-- 	end,
	-- })
	-- vim.api.nvim_create_autocmd("User", {
	-- 	group = "HarpoonStatus",
	-- 	pattern = "HarpoonNavigate",
	-- 	callback = function(event)
	-- 		vim.schedule(function()
	-- 			Cachedlist = event.data.list
	-- 		end)
	-- 	end,
	-- })
	function Init_harpoon()
		Cachedlist = harpoon:list()
	end
end

function M.Update_harpoon(event)
	Cachedlist = event.data.list
	vim.opt.winbar = M.harpoon_list_as_statusline(config_opts)
	vim.cmd("redrawtabline")
	vim.cmd("redrawstatus")
end

function M.add_harpoon_item(list)
	table.insert(Cachedlist.items, list.item)
	vim.cmd("redrawtabline")
end

function M.remove_harpoon_item(list)
	table.remove(Cachedlist.items, list.idx)
	vim.cmd("redrawtabline")
end

---@param opts Opts
function M.setup_tabline(opts)
	config_opts = opts
	M.setup_autocmds()
	vim.api.nvim_create_autocmd({ "BufEnter", "VimEnter" }, {
		pattern = "*",
		callback = function()
			vim.opt.winbar = M.harpoon_list_as_statusline(opts)
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

function M.harpoon_list_as_statusline(opts)
	local file_name = fn.fnamemodify(api.nvim_buf_get_name(0), ":p:.")
	local inactive = ""
	local active = ""
	local modifier = ""

	if Cachedlist == nil then
		return ""
	end
	if Cachedlist.items == nil then
		return ""
	end
	if #Cachedlist.items > (opts.max_full_length_items or 4) then
		modifier = ":t"
	end
	for i, item in ipairs(Cachedlist.items) do
		if item.value ~= file_name then
			inactive = inactive
				.. string.format("%%#%s#", M.numbered_highlights(i, opts.inactive_highlight or "Comment", opts))
				.. i
				.. opts.num_separator
				.. fn.fnamemodify(item.value, modifier)
				.. (opts.separator or "")
		else
			if opts.show_active then
				--FIX: Redundant to have the active harpoon item in the statusline
				active = " %#HarpoonActive# " .. i .. " " .. item.value
			end
		end
	end

	return active .. inactive
end

return M
