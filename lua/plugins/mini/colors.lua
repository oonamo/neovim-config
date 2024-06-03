-- require("mini.colors").setup()
-- local colorscheme = require("mini.colors").get_colorscheme()
local function set_colors()
	local colorscheme
	if O.ui.transparency.enable then
		if vim.tbl_contains(O.ui.transparency.include_list, vim.g.colors_name, {}) then
			colorscheme = require("mini.colors").get_colorscheme():add_transparency()
		end
	end

	if O.ui.saturate then
		if not colorscheme then
			colorscheme = require("mini.colors").get_colorscheme()
		end
		colorscheme:chan_set("saturation", { 10, 90 }, { filter = "fg" })
	end

	if colorscheme then
		colorscheme:apply()
	end
end

set_colors()

vim.api.nvim_create_autocmd({ "ColorScheme" }, {
	callback = function()
		set_colors()
	end,
})
