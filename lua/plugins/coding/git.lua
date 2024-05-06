return {
	-- {
	-- 	"tpope/vim-fugitive",
	-- 	keys = {
	-- 		{ "<leader>gs", vim.cmd.Git, desc = "[g]it [s]tatus" },
	-- 		{ "<leader>ga", "<cmd>Git add %<cr>", desc = "[g]it [a]dd current file" },
	-- 		{ "<leader>gc", "<cmd>Git commit<cr>", desc = "[g]it [c]ommit" },
	-- 		{ "<leader>gp", "<cmd>Git push<cr>", desc = "[g]it [p]ush" },
	-- 		{ "<leader>gd", "<cmd>Gdiffsplit<cr>", desc = "[g]it [d]iff split" },
	-- 	},
	-- 	lazy = true,
	-- },
	{

		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration
			-- Only one of these is needed, not both.
			"ibhagwan/fzf-lua", -- optional
		},
		cmd = "Neogit",
		config = true,
		keys = {
			{
				"<leader>gs",
				function()
					require("neogit").open()
				end,
				desc = "open status buffer",
			},
			{
				"<leader>gc",
				function()
					require("neogit").open({ "commit" })
				end,
				desc = "open commit buffer",
			},
			{
				"<leader>gl",
				function()
					require("neogit").popups.pull.create()
				end,
				desc = "open pull popup",
			},
			{
				"<leader>gp",
				function()
					require("neogit").popups.push.create()
				end,
				desc = "open push popup",
			},
		},
	},
}
