local opts = {
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
}
require("conform").setup(opts)
vim.api.nvim_create_user_command("ToggleFormat", function()
	vim.g.disable_autoformat = not vim.g.disable_autoformat
	local state = vim.g.disable_autoformat and "disabled" or "enabled"
	vim.notify("Auto-save " .. state)
end, { desc = "Toggle Conform Format", bang = true })
