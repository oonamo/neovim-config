-- Place for local plugins in devolopment
return {
	{
		"oonamo/manage_my_sessions",
		dependencies = { "nvim-lua/plenary.nvim", "ibhagwan/fzf-lua" },
		dev = true,
		dir = "~/projects/manage_my_sessions",
		opts = {
			sessions = {
				{
					"~/Documents/School/spring2024",
					after = function()
						vim.schedule(function()
							vim.cmd("Neorg index")
							vim.cmd("ZenMode")
						end)
					end,
				},
				"~/Desktop/DB",
				"~/AppData/Local/nvim",
				"~/projects",
				"~/.glaze-wm",
				"~/projects/cs216",
				"~/.config",
				"~/Arduino/projects",
				os.getenv("OBSIDIAN_VAULT") or "",
			},
			term_cd = true,
		},
		keys = {
			{ "<leader>ms", "<cmd>ManageMySessions<cr>", desc = "[M]anage My [S]essions" },
			-- {
			-- 	"<leader>mf",
			-- 	function()
			-- 		require("manage_my_sessions.fzf.sessions"):run()
			-- 	end,
			-- },
		},
	},
}
