if vim.g.use_custom_winbar == false then
	return
end
local harponn = require("onam.harpoon_list_ext")

harponn.setup_tabline({
	separator = " | ",
	num_separator = ". ",
	enable_icons = true,
	show_active = true,
	max_full_length_items = 3,
	inactive_highlight = "BufferInactive",
	background_highlight = "BufferInactive",
	active_highlight = "BufferVisible",
	bold_active = true,
})
