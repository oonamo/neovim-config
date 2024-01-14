local M = {}

function M.setup()
	O.colorscheme = "gruvbox-material"
	vim.opt.background = "dark"
	vim.g.gruvbox_material_foreground = "original"
	vim.g.gruvbox_material_background = "hard"
	vim.g.gruvbox_enable_bold = 1
	vim.g.gruvbox_enable_italic = 1
	vim.cmd("colorscheme " .. O.colorscheme)

	utils.hl = {
		opts = {
			{ "Normal", { fg = "#ebdbb2", bg = "#171717" } },
		},
	}
	utils:create_hl()
end

return M
