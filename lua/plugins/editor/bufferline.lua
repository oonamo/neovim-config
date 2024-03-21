return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	enabled = false,
	config = function()
		require("bufferline").setup({
			options = {
				mode = "buffers",
				separator_style = "thin",
				-- numbers = "ordinal",
				--numbers = "buffer_id",
				numbers = "none",
			},
		})
	end,
}
