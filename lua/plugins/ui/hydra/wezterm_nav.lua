local M = {}
local function move_direction(direction)
	local command = { "wezterm", "cli", "activate-pane-direction" }
	table.insert(command, direction)
	return vim.fn.system(command)
end
local hint = [[
__h__: left
__j__: down
__k__: up
__l__: right
]]
