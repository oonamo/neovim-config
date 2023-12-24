return {
	{
		"folke/which-key.nvim",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 500
			require("which-key").setup({
				vim.api.nvim_set_hl(0, "WhichKeyFloat", { blend = 10 }),
				-- your configuration comes here
				-- or leave it empty to the default setting,
				-- refer to the configuration section below
				-- window = {
				-- 	winblend = 70,
				-- },
			})
		end,
		event = "VeryLazy",
	},
}
