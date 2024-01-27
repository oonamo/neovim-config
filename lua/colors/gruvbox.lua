local M = {}

function M.setup()
	O.colorscheme = "gruvbox-material"
	vim.opt.background = "dark"
	vim.g.gruvbox_material_foreground = "material"
	vim.g.gruvbox_material_background = "hard"
	vim.g.grubox_material_dim_inactive_windows = 1
	vim.g.grubox_material_show_eob = 0
	vim.g.gruvbox_material_enable_bold = 1
	vim.g.gruvbox_material_enable_italic = 1
	vim.g.gruvbox_material_colors_override = {
		bg0 = { "#171717", "234" },
	}
	vim.cmd("colorscheme " .. O.colorscheme)
end

return M
