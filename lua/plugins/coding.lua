return {
	{
		"stevearc/conform.nvim",
		-- event = "BufWritePre",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "black" },
				cpp = { "clang-format" },
			},
			timeout_ms = 500,
		},
		keys = {
			{
				"<leader>ff",
				function()
					require("conform").format({
						timeout_ms = 500,
						lsp_fallback = true,
					})
				end,
			},
			{
				"gf",
				mode = "v",
				function()
					require("conform").format({
						timeout_ms = 500,
						lsp_fallback = true,
					})
				end,
			},
		},
	},
}
