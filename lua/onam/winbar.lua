if vim.g.use_custom_winbar == false then
	return
end

local harponn = require("onam.harpoon_list_ext")

harponn.setup_tabline({
	-- separator = "  |  ",
	separator = "    ",
	num_separator = " ",
	show_active = false,
	max_full_length_items = 6,
	inactive_highlight = "ClapDisplay",
	numbered_highlights = {
		enabled = false,
		groups = {
			"lualine_a_insert",
			"ClapDisplay",
		},
	},
})

-- vim.api.nvim_create_autocmd({ "BufEnter", "VimEnter" }, {
-- 	pattern = "*",
-- 	callback = function()
-- 		vim.opt.winbar = harponn.harpoon_list_as_statusline({
-- 			separator = "  |  ",
-- 			num_separator = " ",
-- 			show_active = false,
-- 			max_full_length_items = 6,
-- 		})
-- 	end,
-- })

-- vim.api.nvim_create_autocmd("User", {
-- 	pattern = "HarpoonListChange",
-- 	group = "HarpoonStatus",
-- 	callback = function()
-- 		vim.opt.winbar = harponn.harpoon_list_as_statusline({
-- 			separator = "  |  ",
-- 			num_separator = " ",
-- 			show_active = false,
-- 			max_full_length_items = 6,
-- 		})
-- 	end,
-- })
