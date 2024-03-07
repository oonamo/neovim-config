return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 400
	end,
	config = function()
		require("which-key").setup()
		require("which-key").register({
			["<leader>f"] = { name = "[F]ind", _ = "which_key_ignore" },
			["<leader>n"] = { name = "[N]org", _ = "which_key_ignore" },
			["<leader>o"] = { name = "[O]bsidian", _ = "which_key_ignore" },
			["<leader>g"] = { name = "[G]it", _ = "which_key_ignore" },
		})
	end,
}
