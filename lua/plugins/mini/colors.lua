-- require("mini.colors").setup()
-- local colorscheme = require("mini.colors").get_colorscheme()

local function set_colors()
	local hi_list = {}
	local function hi(name, data)
		-- vim.api.nvim_set_hl(0, name, data)
		table.insert(hi_list, { name = name, data = data })
	end
	local colorscheme
	local list = {
		"ColorColumn",
		"CursorColumn",
		"CursorLine",
		"CursorLineFold",
		"CursorLineNr",
		"CursorLineSign",
		"FoldColumn",
		"LineNr",
		"LineNrAbove",
		"LineNrBelow",
		"SignColumn",
		"Error",
	}
	if O.ui.transparency then
		if vim.tbl_contains(O.ui.transparency.include_list, vim.g.colors_name, {}) then
			if vim.g.neovide == nil then
				colorscheme = require("mini.colors").get_colorscheme():add_transparency()
			end
			local fg, _ = utils.get_hl("LineNr")
			vim.iter(list):each(function(v)
				hi(v, { fg = fg, bg = "NONE" })
			end)
		end
		-- if O.ui.transparency.enable and vim.g.neovide == nil then
		-- 	if vim.tbl_contains(O.ui.transparency.include_list, vim.g.colors_name, {}) then
		-- 		colorscheme = require("mini.colors").get_colorscheme():add_transparency()
		-- 		local fg, _ = utils.get_hl("LineNr")
		-- 		vim.iter(list):each(function(v)
		-- 			hi(v, { fg = fg, bg = "NONE" })
		-- 		end)

		-- hi("LineNr", { link = "Normal" })
		-- hi("SignColumn", { link = "Normal" })
		-- hi("FoldColumn", { link = "Normal" })
		-- hi("CursorlineFold", { link = "Normal" })
		-- hi("CursorLineSign", { link = "Normal" })
		-- hi("ColorColumn", { link = "Normal" })
		-- hi("LineNr", { bg = "NONE" })
		-- hi("SignColumn", { bg = "NONE" })
		-- hi("FoldColumn", { bg = "NONE" })
		-- hi("CursorlineFold", { bg = "NONE" })
		-- hi("CursorLineSign", { bg = "NONE" })
		-- hi("ColorColumn", { bg = "NONE" })
		-- hi("Statusline", { bg = "NONE" })
		-- hi("Statusline", { bg = "NONE" })
		-- hi("Float", { bg = "NONE" })
	end

	if O.ui.saturate then
		if not colorscheme then
			colorscheme = require("mini.colors").get_colorscheme()
		end
		colorscheme:chan_set("saturation", { 10, 90 }, { filter = "fg" })
	end

	if colorscheme then
		colorscheme:apply()
		for _, v in ipairs(hi_list) do
			vim.api.nvim_set_hl(0, v.name, v.data)
		end
	end
end
-- end

set_colors()

vim.api.nvim_create_autocmd({ "ColorScheme" }, {
	callback = function()
		set_colors()
	end,
})
