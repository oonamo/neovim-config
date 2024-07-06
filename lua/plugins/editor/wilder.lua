return {
	-- emacs style cmdline
	"gelguy/wilder.nvim",
	build = ":UpdateRemotePlugins",
	event = "CmdlineEnter",
	config = function()
		local wilder = require("wilder")
		wilder.setup({
			modes = { ":", "/", "?" },
			next_key = "<Tab>",
			previous_key = "<S-Tab>",
			accept_key = "<C-y>",
			reject_key = "<C-e>",
		})
	end,
}
