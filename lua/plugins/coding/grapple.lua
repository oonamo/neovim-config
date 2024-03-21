return {
	"cbochs/grapple.nvim",
	dependencies = {
		{ "nvim-tree/nvim-web-devicons", lazy = true },
	},
	opts = {
		scope = "cwd",
	},
	event = { "BufReadPost", "BufNewFile" },
	cmd = "Grapple",
	keys = {
		{ "<leader>a", "<cmd>Grapple toggle<cr>", desc = "Tag a file" },
		{ "<c-e>", "<cmd>Grapple toggle_tags<cr>", desc = "Toggle tags menu" },

		{ "<c-h>", "<cmd>Grapple select index=1<cr>", desc = "Select first tag" },
		{ "<c-j>", "<cmd>Grapple select index=2<cr>", desc = "Select second tag" },
		{ "<c-k>", "<cmd>Grapple select index=3<cr>", desc = "Select third tag" },
		{ "<c-l>", "<cmd>Grapple select index=4<cr>", desc = "Select fourth tag" },

		{ "<c-s-p>", "<cmd>Grapple cycle backward<cr>", desc = "Go to previous tag" },
		{ "<c-s-n>", "<cmd>Grapple cycle forward<cr>", desc = "Go to next tag" },
	},
}
