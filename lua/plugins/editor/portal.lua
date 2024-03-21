return {
	"cbochs/portal.nvim",
	-- Optional dependencies
	dependencies = {
		"cbochs/grapple.nvim",
		"ThePrimeagen/harpoon",
	},
	keys = {
		{ "<leader>jb", "<cmd>Portal jumplist backward<cr>", desc = "jumplist backward" },
		{ "<leader>jf", "<cmd>Portal jumplist forward<cr>", desc = "jumplist forward" },
	},
}
