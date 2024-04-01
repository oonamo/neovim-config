return {
	"anuvyklack/hydra.nvim",
	dependencies = { "ibhagwan/fzf-lua" },
	config = function()
		if vim.bo.filetype == "cpp" or vim.bo.filetype == "oil" or vim.bo.filetype == "arduino" then
			local hydra = require("onam.helpers.arduino_helper").hydra()
		end
	end,
	lazy = true,
	keys = { { "<leader>ih" } },
}
