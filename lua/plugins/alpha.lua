return {
	"goolord/alpha-nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		-- require("alpha").setup(require("alpha.themes.startify").config)
		local alpha = require("alpha")
		local startify = require("alpha.themes.startify")

		startify.section.top_buttons.val = {
			startify.button("e", "∩à¢  New file", ":ene <BAR> startinsert <CR>"),
			startify.button("o", "∩à¢  Obsidian", ":cd C:/Users/onam7/Desktop/o notes/ | e . <CR>"),
			startify.button("q", "≤░àÜ  Quit NVIM", ":qa<CR>"),
		}

		alpha.setup(startify.config)
	end,
}
