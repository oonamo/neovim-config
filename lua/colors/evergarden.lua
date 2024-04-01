local utils = require("onam.utils")
local M = {}
function M.setup(flavour)
	vim.cmd.hi("clear")
	vim.o.background = "dark"
	vim.opt.cursorline = true
	require("evergarden").setup({
		constrast_dark = flavour,
	})
	utils.hl = {
		opts = {
			-- { "NoiceCursor", { fg = "#e0def4", bg = "#16141f" } },
			-- { "NoiceCursor", { fg = "#16141f", bg = "#e0def4" } },
			{ "NoiceCursor", { fg = "#f0f0f0", bg = "#f0f0f0" } },
		},
	}
	utils:create_hl()
	vim.cmd.colorscheme("evergarden")
end
return M
