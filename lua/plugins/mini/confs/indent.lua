local disable_list = {
	"aerial",
	"dashboard",
	"help",
	"lazy",
	"leetcode.nvim",
	"mason",
	"neo-tree",
	"NvimTree",
	"neogitstatus",
	"notify",
	"startify",
	"toggleterm",
	"Trouble",
	"calltree",
	"coverage",
}

require("mini.indentscope").setup({
	symbol = "│",
	options = {
		try_as_border = true,
		border = "both",
		indent_at_cursor = true,
	},
	draw = {
		animation = require("mini.indentscope").gen_animation.linear({
			easing = "in",
			duration = 40,
			unit = "step",
		}),
	},
})
if utils.get_hl("NonText") then
	vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { link = "NonText" })
else
	local fg, _, _ = utils.get_hl("Normal")
	if fg == nil then
		fg = "#ffffff"
	end
	vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = fg })
end
vim.api.nvim_create_autocmd({ "FileType" }, {
	callback = function()
		if vim.tbl_contains(disable_list, vim.bo.filetype) then
			vim.b.miniindentscope_disable = true
		end
	end,
})
