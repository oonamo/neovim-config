return {
	"stevearc/oil.nvim",
	opts = {},
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").set_icon({
				norg = { icon = "", color = "#ff9e64", name = "Norg" },
			})
		end,
	},
	config = function()
		require("oil").setup()
		-- vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
		vim.keymap.set("n", "<leader>e", "<cmd>Oil<cr>", { desc = "Open oil" })
	end,
}
