return {
	"stevearc/oil.nvim",
	opts = {},
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		config = function()
			if G.__color_loaded then
				require("nvim-web-devicons").set_icon({
					norg = { icon = "", color = "#ff9e64", name = "Norg" },
				})
			else
				require("onam.color_switcher").setup_persistence()
				G.__color_loaded = true
			end
		end,
	},
	config = function()
		require("oil").setup()
		vim.keymap.set("n", "<leader>e", "<cmd>Oil<cr>", { desc = "Open oil" })
	end,
}
