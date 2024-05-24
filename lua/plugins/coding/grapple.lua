return {
	"cbochs/grapple.nvim",
	opts = {
		scope = "cwd",
		icons = false,
		scopes = {
			{
				name = "obsidian",
				desc = "obsidian files",
				cache = {
					event = { "BufEnter", "FocusGained" },
				},
				resolver = function()
					local file = vim.loop.cwd()
					local id = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t:r")
					return id, file, nil
				end,
			},
		},
	},
	event = { "BufReadPost", "BufNewFile" },
	cmd = "Grapple",
	keys = {
		{ "<leader>a", "<cmd>Grapple toggle<cr>", desc = "Tag a file" },
		{ "<c-e>", "<cmd>Grapple toggle_tags<cr>", desc = "Toggle tags menu" },

		{ "<C-h>", "<cmd>Grapple select index=1<cr>", desc = "Select first tag" },
		{ "<C-j>", "<cmd>Grapple select index=2<cr>", desc = "Select second tag" },
		{ "<C-k>", "<cmd>Grapple select index=3<cr>", desc = "Select third tag" },
		{ "<C-l>", "<cmd>Grapple select index=4<cr>", desc = "Select fourth tag" },

		{ "<c-s-p>", "<cmd>Grapple cycle backward<cr>", desc = "Go to previous tag" },
		{ "<c-s-n>", "<cmd>Grapple cycle forward<cr>", desc = "Go to next tag" },
	},
}
