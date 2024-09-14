local buf_list = {}

require("mini.tabline").setup({
	show_icons = false,
	tabpage_section = "right",
	-- format = function(buf_id, label)
	-- 	return "|  " .. MiniTabline.default_format(buf_id, label) .. "   "
	-- end,
})

-- vim.api.nvim_create_autocmd("Colorscheme", {
-- 	callback = function()
-- 		vim.api.nvim_set_hl(0, "MiniTablineFill", { link = "StatusLine" })
-- 	end,
-- })
