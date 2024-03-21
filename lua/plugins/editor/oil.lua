return {
	"stevearc/oil.nvim",
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
	opts = {
		keymaps = {
			["<C-h>"] = false,
		},
	},
	config = function(_, opts)
		require("oil").setup(opts)
		vim.keymap.set("n", "<leader>e", "<cmd>Oil<cr>", { desc = "Open oil" })
	end,
}
