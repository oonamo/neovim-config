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
					name = "neorg",
					after = function()
						vim.schedule(function()
							vim.cmd("Neorg index")
							vim.cmd("ZenMode")
						end)
					end,
				},
				{
					"~/Desktop/DB/DB",
					name = "obsidian",
					after = function()
						vim.schedule(function()
							vim.cmd("e base.md")
						end)
					end,
				},
				{ "~/AppData/Local/nvim", name = "nvim config" },
				{ "~/projects/cs216", name = "cs216" },
				{ "~/.glaze-wm", name = "glaze-wm" },
				"~/projects",
				"~/.config",
			},
			term_cd = true,
		},
		keys = {
			{ "<leader>ms", "<cmd>ManageMySessions<cr>", desc = "[M]anage My [S]essions" },
			{
				"<leader>mf",
				function()
					require("manage_my_sessions.fzf.sessions"):run()
				end,
			},
		},
	},
}
