return {
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform will run multiple formatters sequentially
				python = { "isort", "black" },
				-- Use a sub-list to run only the first available formatter
				-- javascript = { "prettier" },
				-- html = { "prettier" },
				-- css = { "prettier" },
				-- json = { "prettier" },
				-- yaml = { "prettier" },
				-- markdown = { "prettier" },
				cpp = { "clang-format" },
			},
			timeout_ms = 500,

			format_on_save = function()
				if vim.g.disable_autoformat then
					return
				end
				return {
					-- These options will be passed to conform.format()
					timeout_ms = 500,
					lsp_fallback = true,
				}
			end,
		},
		config = function(_, opts)
			require("conform").setup(opts)
			vim.api.nvim_create_user_command("ToggleFormat", function(args)
				vim.g.disable_autoformat = not vim.g.disable_autoformat
				local state = vim.g.disable_autoformat and "disabled" or "enabled"
				vim.notify("Auto-save " .. state)
			end, { desc = "Toggle Conform Format", bang = true })
		end,
		-- keys = {
		-- 	{
		-- 		"<leader>lf",
		-- 		function()
		-- 			vim.notify("enabling format")
		-- 		end,
		-- 		desc = "format",
		-- 	},
		-- },
	},
}
