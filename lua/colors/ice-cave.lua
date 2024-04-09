local M = {}
local base000 = "#1B1D20"
local base00 = "#1e2124"
local base01 = "#25282B"
local base02 = "#36393e"
local base03 = "#4b4c54"
local base04 = "#505B64"
local l_gray2 = "#686f78"
local base05 = "#c6cfd1"
local base06 = "#c3a4b3"
local base07 = "#e26d5c"
local base08 = "#ed333b"
local base09 = "#e8a63b"
local base0A = "#4b8b51"
local base0B = "#8391A7"
local base0C = "#b3c3a4"
local base0D = "#566AB1"
local base0E = "#6DA2CF"
local base0F = "#a6b4e7"

function M.setup()
	vim.cmd.hi("clear")
	vim.cmd.colorscheme("ice-cave")
	utils.hl = {
		opts = {
			{ "Tabline", { fg = "#a6b4e7", bg = "#25282B" } },
			{ "TablineSel", { fg = "#c6cfd1", bg = "#25282B" } },
		},
	}
	utils:create_hl()
	vim.opt.cursorline = true
end

return M
