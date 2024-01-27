return {
	"m4xshen/hardtime.nvim",
	dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
	config = true,
	opts = {
		disabled_filetypes = { "qf", "netrw", "NvimTree", "lazy", "mason", "oil", "harpoon", "text" },
		hints = {
			["Esc"] = {
				message = function()
					return "Use C-c instead of Esc"
				end,
			},
		},
	},
	event = { "BufReadPre", "BufNewFile" },
}
