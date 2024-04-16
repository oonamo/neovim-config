return {
	-- {
	-- 	"oonamo/manage_my_sessions",
	-- 	dependencies = { "nvim-lua/plenary.nvim", "ibhagwan/fzf-lua" },
	-- 	dev = true,
	-- 	dir = "~/projects/manage_my_sessions",
	-- 	opts = {
	-- 		finder = "telescope",
	-- 		sessions = {
	-- 			{
	-- 				"~/Documents/School/spring2024",
	-- 				after = function()
	-- 					vim.schedule(function()
	-- 						vim.cmd("Neorg index")
	-- 						vim.cmd("ZenMode")
	-- 					end)
	-- 				end,
	-- 			},
	-- 			"~/AppData/Local/nvim",
	-- 			"~/projects",
	-- 			"~/.glaze-wm",
	-- 			"~/projects/cs216",
	-- 		},
	-- 		term_cd = true,
	-- 	},
	-- 	keys = {
	-- 		{ "<leader>ms", "<cmd>ManageMySessions<cr>", desc = "Manage My Sessions" },
	-- 		{
	-- 			"<leader>mf",
	-- 			function()
	-- 				require("manage_my_sessions.fzf.sessions"):run()
	-- 			end,
	-- 		},
	-- 	},
	-- },
	{
		"oonamo/arrow.nvim",
		opts = {
			show_icons = true,
			leader_key = ";", -- Recommended to be a single keys
		},
	},
}
