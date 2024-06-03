-- return {
	-- "cbochs/grapple.nvim",
local opts = {
    scope = "cwd",
    icons = false,
    win_opts = {
        -- border = "none",
        title = "Grapple",
    },
}

require("grapple").setup(opts)

local set = vim.keymap.set

		set("n", "<leader>a", "<cmd>Grapple toggle<cr>", { desc = "Tag a file" })
		set("n", "<c-e>", "<cmd>Grapple toggle_tags<cr>", {desc = "Toggle tags menu" })

		set("n", "<C-h>", "<cmd>Grapple select index=1<cr>", {desc = "Select first tag" })
		set("n", "<C-j>", "<cmd>Grapple select index=2<cr>", {desc = "Select second tag" })
		set("n", "<C-k>", "<cmd>Grapple select index=3<cr>", {desc = "Select third tag" })
		set("n", "<C-l>", "<cmd>Grapple select index=4<cr>", {desc = "Select fourth tag" })

		set("n", "<c-s-p>", "<cmd>Grapple cycle backward<cr>", {desc = "Go to previous tag" })
		set("n", "<c-s-n>", "<cmd>Grapple cycle forward<cr>", {desc = "Go to next tag" })

	-- event = { "BufReadPost", "BufNewFile" },
	-- lazy = false,
	-- priority = 1001,
	-- cmd = "Grapple",
	-- keys = {
	-- 	{ "<leader>a", "<cmd>Grapple toggle<cr>", desc = "Tag a file" },
	-- 	{ "<c-e>", "<cmd>Grapple toggle_tags<cr>", desc = "Toggle tags menu" },
	--
	-- 	{ "<C-h>", "<cmd>Grapple select index=1<cr>", desc = "Select first tag" },
	-- 	{ "<C-j>", "<cmd>Grapple select index=2<cr>", desc = "Select second tag" },
	-- 	{ "<C-k>", "<cmd>Grapple select index=3<cr>", desc = "Select third tag" },
	-- 	{ "<C-l>", "<cmd>Grapple select index=4<cr>", desc = "Select fourth tag" },
	--
	-- 	{ "<c-s-p>", "<cmd>Grapple cycle backward<cr>", desc = "Go to previous tag" },
	-- 	{ "<c-s-n>", "<cmd>Grapple cycle forward<cr>", desc = "Go to next tag" },
	-- },
-- }
