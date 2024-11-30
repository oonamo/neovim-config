local is_dark = vim.o.background == "dark"
-- local bg = is_dark and "#122722" or "#cfeae1"
-- local fg = is_dark and "#ced7d4" or "#29302e"

local bg = is_dark and '#1c2617' or '#dde6d9'
local fg = is_dark and '#c8d9d4' or '#23322e'

require("mini.hues").setup({
	background = bg,
	foreground = fg,
	saturation = is_dark and "medium" or "high",
	accent = "green",
})

vim.g.colors_name = "minispring"
