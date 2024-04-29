-- local Hydra = require("hydra")
local fn = require("onam.fn")

-- local hint = [[
--     _c_: Compile
--     _v_: View
--     _i_: Inverse Search
--     _q_: Quit
-- ]]

-- Hydra({
-- 	name = "VimTex",
-- 	hint = hint,
-- 	config = {
-- 		color = "pink",
-- 		invoke_on_body = true,
-- 		hint = {
-- 			border = "rounded",
-- 		},
-- 	},
-- 	mode = "n",
-- 	body = "<leader>vt",
-- 	heads = {
-- 		{ "c", ":VimtexCompile<cr>", { desc = "Compile" } },
-- 		{ "v", ":VimtexView<cr>", { desc = "View" } },
-- 		{ "i", ":VimtexInverseSearch<cr>", { desc = "Inverse Search" } },
-- 		{ "<Esc>", nil, { exit = true } },
-- 		{ "q", nil, { exit = true } },
-- 	},
-- })
local M = {}
function M.open()
	vim.ui.select({
		"View",
		"Compile",
		"Errors",
		"Reload",
		"Inverse Search",
		"Toc",
		"Words",
		"Log",
		"Info",
	}, { prompt = "Select:" }, function(choice)
		fn.switch(choice, {
			["View"] = function()
				vim.cmd("VimtexView")
			end,
			["Compile"] = function()
				vim.cmd("VimtexCompile")
			end,
			["Inverse Search"] = function()
				vim.cmd("VimtexInverseSearch")
			end,
			["Reload"] = function()
				vim.cmd("VimtexReload")
			end,
			["Errors"] = function()
				vim.cmd("VimtexErrors")
			end,
			["Toc"] = function()
				vim.cmd("VimtexToc")
			end,
			["Words"] = function()
				vim.cmd("VimtexCountWords")
			end,
			["Log"] = function()
				vim.cmd("VimtexLog")
			end,
			["Info"] = function()
				vim.cmd("VimtexInfo")
			end,
		})
	end)
end
return M
