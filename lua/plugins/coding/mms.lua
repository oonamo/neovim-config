require("manage_my_sessions").setup({
	sessions = {
		{
			"~/Desktop/DB/DB",
			name = "obsidian",
			elect = function(path)
				vim.cmd("cd " .. path .. " | e base.md")
			end,
		},
		{ "~/AppData/Local/nvim", name = "nvim config" },
		{ "~/projects/cs216", name = "cs216" },
		{ "~/.glaze-wm", name = "glaze-wm" },
		"~/projects",
		"~/.config",
	},
	term_cd = true,
})

utils.norm_lazy_to_normal({ "<leader>ms", "<cmd>ManageMySessions<cr>", desc = "[M]anage My [S]essions" })
