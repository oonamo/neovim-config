local harpoon = require("harpoon")
local fn = vim.fn
local api = vim.api
local M = {}
function M.setup_autocmds()
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
				M.Update_harpoon(event)
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
				M.Update_harpoon(event)
			end)
		end,
	})

	-- Executes on Harpoon UI Leave
	vim.api.nvim_create_autocmd("User", {
		pattern = "HarpoonBufLeave",
		group = "HarpoonStatus",
		callback = function(event)
			vim.schedule(function()
				M.Update_harpoon(event)
			end)
		end,
	})

	vim.api.nvim_create_autocmd("BufLeave, WinLeave, BufWinLeave, BufWriteCmd", {
		pattern = "__harpooon-menu__*",
		group = "HarpoonStatus",
		callback = function(event)
			vim.schedule(function()
				M.Update_harpoon(event)
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
end

function M.Update_harpoon(event)
	Cachedlist = event.data.list
end

function M.harpoon_list_as_statusline()
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

return M
