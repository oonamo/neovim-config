return {
	"scottmckendry/cyberdream.nvim",
	-- init = function()
	-- 	vim.o.background = "light"
	-- end,
	-- lazy = false,
	-- priority = 1000,
	opts = {
		terminal_colors = false,
		borderless_telescope = false,
		theme = {
			variant = "auto",
			-- Only for light
			colors = {
				bg = "#eff1f5",
				bgAlt = "#dce0e8",
			},
		},
	},
	config = function(_, opts)
		require("cyberdream").setup(opts)
		vim.cmd.colorscheme("cyberdream")
	end,
}
