return {
	"rcarriga/nvim-notify",
	opts = {
		render = "wrapped-compact",
	},
	config = function(_, opts)
		local notify = require("notify")
		vim.notify = notify
		notify.setup(opts)
	end,
}
