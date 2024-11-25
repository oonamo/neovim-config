local is_dark = vim.o.background == "dark"
local bg = is_dark and "#122722" or "#cfeae1"
local fg = is_dark and "#ced7d4" or "#29302e"

require("mini.hues").setup({
	background = bg,
	foreground = fg,
	saturation = is_dark and "medium" or "high",
	accent = "green",
})

vim.g.colors_name = "minispring"
