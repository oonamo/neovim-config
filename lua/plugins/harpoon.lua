return {
	{
		"ThePrimeagen/harpoon",
		config = function()
			local mark = require("harpoon.mark")
			local ui = require("harpoon.ui")
			vim.keymap.set("n", "<leader>a", mark.add_file, {
				desc = "Mark file",
			})
			vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, {
				desc = "Toggle Harppon UI",
			})

			vim.keymap.set("n", "<leader>b1", function()
				ui.nav_file(1)
			end, {
				desc = "Switch to harp file 1",
			})
			vim.keymap.set("n", "<leader>b2", function()
				ui.nav_file(2)
			end, {
				desc = "Switch to harp file 2",
			})
			vim.keymap.set("n", "<leader>b3", function()
				ui.nav_file(3)
			end, {
				desc = "Switch to harp filr 3",
			})
			vim.keymap.set("n", "<leader>b4", function()
				ui.nav_file(4)
			end, {
				desc = "Switch to harp file 4",
			})
		end,
	},
}
