return {
	"RaafatTurki/corn.nvim",
	config = function()
		vim.diagnostic.config({
			virtual_text = false,
		})
		require("corn").setup({
			on_toggle = function()
				vim.diagnostic.config({
					virtual_text = not vim.diagnostic.config().virtual_text,
				})
			end,
		})
	end,
	event = { "BufReadPost", "BufNewFile", "BufWritePre" },
}
