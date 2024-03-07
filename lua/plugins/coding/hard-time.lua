return {
	"m4xshen/hardtime.nvim",
	dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
	enabled = false,
	config = true,
	opts = {
		disabled_filetypes = {
			"qf",
			"netrw",
			"NvimTree",
			"lazy",
			"mason",
			"oil",
			"harpoon",
			"text",
			"norg",
			"latex",
			"tex",
		},
	},
	event = { "BufReadPost", "BufNewFile", "BufWritePre" },
}
