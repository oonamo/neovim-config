return {
	"nvim-pack/nvim-spectre",
	config = function() end,
	keys = function()
		local spectre = require("spectre")
		return {
			{
				"<leader>S",
				spectre.toggle,
				desc = "Toggle Spectre",
			},
			{
				"<leader>sw",
				function()
					spectre.open_visual({ select_word = true })
				end,
				desc = "Search current word",
			},
			{
				mode = "v",
				"<leader>sw",
				spectre.open_visual,
				desc = "Search current word",
			},
			{
				"<leader>sp",
				function()
					spectre.open_file_search({ select_word = true })
				end,
				desc = "Search current word",
			},
		}
	end,
}
