return {
	{
		"andrewferrier/wrapping.nvim",
		opts = {
			notify_on_switch = false,
		},
		lazy = true,
		cmd = { "SoftWrapMode", "HardWrapMode" },
		keys = { "[ow", "]ow" },
	},
}
