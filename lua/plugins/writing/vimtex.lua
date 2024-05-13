return {
	"lervag/vimtex",
	dependencies = {
		"evesdropper/luasnip-latex-snippets.nvim",
	},
	ft = { "tex", "plaintex", "latex" },
	config = function()
		vim.g.vimtex_view_general_viewer = "SumatraPDF"
		vim.g.vimtex_view_general_options = "-reuse-instance -forward-search @tex @line @pdf"
		vim.keymap.set("n", "<leader>vt", function()
			require("onam.helpers.vimtex_helper").open()
		end)
	end,
}
