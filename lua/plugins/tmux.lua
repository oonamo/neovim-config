return {
	-- {
	-- 	"christoomey/vim-tmux-navigator",
	-- 	keys = {
	-- 		{ "<C-h>", "<cmd> TmuxNavigateLeft<CR>", desc = "window left" },
	-- 		{ "<C-j>", "<cmd> TmuxNavigateDown<CR>", desc = "window down" },
	-- 		{ "<C-k>", "<cmd> TmuxNavigateUp<CR>", desc = "window up" },
	-- 		{ "<C-l>", "<cmd> TmuxNavigateRight<CR>", desc = "window right" },
	-- 	},
	-- },
	-- "mrjones2014/smart-splits.nvim",
	-- config = true,
	-- keys = {
	-- 	{ "<A-h>", require("smart-splits").resize_left },
	-- 	{ "<A-j>", require("smart-splits").resize_down },
	-- 	{ "<A-k>", require("smart-splits").resize_up },
	-- 	{ "<A-l>", require("smart-splits").resize_right },
	-- 	-- moving between splits
	-- 	{ "<C-h>", require("smart-splits").move_cursor_left },
	-- 	{ "<C-j>", require("smart-splits").move_cursor_down },
	-- 	{ "<C-k>", require("smart-splits").move_cursor_up },
	-- 	{ "<C-l>", require("smart-splits").move_cursor_right },
	-- 	-- swapping buffers between windows
	-- 	{ "<leader><leader>h", require("smart-splits").swap_buf_left },
	-- 	{ "<leader><leader>j", require("smart-splits").swap_buf_down },
	-- 	{ "<leader><leader>k", require("smart-splits").swap_buf_up },
	-- 	{ "<leader><leader>l", require("smart-splits").swap_buf_right },
	-- },
	"numToStr/Navigator.nvim",
	-- lazy = false,
	config = function()
		local Navigator = require("Navigator")
		Navigator.setup({
			-- Save modified buffer(s) when moving to mux
			-- nil - Don't save (default)
			-- 'current' - Only save the current modified buffer
			-- 'all' - Save all the buffers
			auto_save = nil,

			-- Disable navigation when the current mux pane is zoomed in
			disable_on_zoom = false,

			-- Multiplexer to use
			-- 'auto' - Chooses mux based on priority (default)
			-- table - Custom mux to use
			mux = "auto",
		})
		-- vim.keymap.set({ "n", "t" }, "<C-h>", require("Navigator").left)
		-- vim.keymap.set({ "n", "t" }, "<C-l>", require("Navigator").right)
		-- vim.keymap.set({ "n", "t" }, "<C-k>", require("Navigator").up)
		-- vim.keymap.set({ "n", "t" }, "<C-j>", require("Navigator").down)
		-- vim.keymap.set("", "<C-p>", require("Navigator").previous)
	end,
	-- keys = {
	-- 	-- { "<C-h>" },
	-- 	-- { "<C-l>" },
	-- 	-- { "<C-k>" },
	-- 	-- { "<C-j>" },
	-- 	-- { "<C-p>" },
	-- },
}
