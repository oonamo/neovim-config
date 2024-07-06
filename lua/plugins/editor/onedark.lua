return {
	"navarasu/onedark.nvim",
	-- init = function()
	-- 	vim.o.background = "light"
	-- end,
	-- priority = 1000,
	-- lazy = false,
	opts = {
		toggle_style_key = "<leader>Lcf",
		ending_tildes = true,
		-- transparent = true,
		toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" }, -- List of styles to toggle between
	},
	config = function(_, opts)
		require("onedark").setup(opts)
		vim.cmd.colorscheme("onedark")
	end,
}
