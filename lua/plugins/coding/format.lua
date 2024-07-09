return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "isort", "black" },
			cpp = { "clang-format" },
		},
		timeout_ms = 500,

		format_on_save = function()
			if vim.g.disable_autoformat then
				return
			end
			return {
				timeout_ms = 500,
				lsp_fallback = true,
			}
		end,
	},
}
