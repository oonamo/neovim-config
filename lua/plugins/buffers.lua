return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = {
			mode = "buffers",
			name_formatter = function(buf) end,
		},
	},
	enabled = false,
}
