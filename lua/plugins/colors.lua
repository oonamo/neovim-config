return {
	-- {
	-- 	"genchad",
	-- 	dir = "~/projects/nvim/chadschemes/",
	-- 	dev = true,
	-- 	lazy = false,
	-- 	opts = {
	-- 		themes = {
	-- 			flexoki = {
	-- 				new_name = "chad-flexoki",
	-- 			},
	-- 			gruvbox = {
	-- 				new_name = "chad-gruvbox",
	-- 			},
	-- 		},
	-- 		disabled_integrations = {
	-- 			"minipick",
	-- 		},
	-- 	},
	-- },
	"nuvic/flexoki-nvim",
	"maxmx03/solarized.nvim",
	"ellisonleao/gruvbox.nvim",
	{
		"craftzdog/solarized-osaka.nvim",
		-- lazy = false,
		-- priority = 1000,
		opts = {
      transparent = false,
    },
    config = function(_, opts)
      require("solarized-osaka").setup(opts)
      vim.cmd.colorscheme("solarized-osaka")
    end,
	},
}
