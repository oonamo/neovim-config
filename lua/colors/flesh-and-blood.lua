local M = {}
local utils = require("onam.utils")
M.colors = {
	bg = "#181818",
}

M.setup = function()
	O.colorscheme = "flesh-and-blood"
	-- utils.hl = {
	-- 	opts = {
	-- 		{ "markdownH1", "Title" },
	-- 		{ "markdownH2", "Title" },
	-- 		{ "markdownH3", "Title" },
	-- 		{ "markdownH4", "Title" },
	-- 		{ "markdownH5", "Title" },
	-- 		{ "markdownH6", "Title" },
	-- 	},
	-- }

	utils:create_hl()
	O.fn = "flesh-and-blood"
	vim.cmd("colorscheme flesh-and-blood")
end

return M
