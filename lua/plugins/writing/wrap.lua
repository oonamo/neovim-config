return {
	{
		"andrewferrier/wrapping.nvim",
		config = function()
			require("wrapping").setup()
			local utils = require("onam.utils")
		end,
		lazy = true,
		cmd = { "SoftWrapMode", "HardWrapMode" },
		keys = { "[ow", "]ow" },
	},
}
