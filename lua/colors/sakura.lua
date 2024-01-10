local M = {}

function M.setup()
	O.colorscheme = "sakura"
	O.type = "base16"
	vim.opt.background = "dark"
	require("mini.base16").setup({
		palette = {
			base00 = "#0f0f0f",
			base01 = "#191919",
			base02 = "#262626",
			base03 = "#4c4c4c",
			base04 = "#ac8a8c",
			base05 = "#f0f0f0",
			base06 = "#e7e7e7",
			base07 = "#f0f0f0",
			base08 = "#ac8a8c",
			base09 = "#ceb188",
			base0A = "#aca98a",
			base0B = "#8aac8b",
			base0C = "#8aabac",
			base0D = "#8f8aac",
			base0E = "#ac8aac",
			base0F = "#ac8a8c",
		},
	})

	vim.g.colors_name = "sakura"
end

M.colors = {
	base00 = "0f0f0f",
	base01 = "191919",
	base02 = "262626",
	base03 = "4c4c4c",
	base04 = "ac8a8c",
	base05 = "f0f0f0",
	base06 = "e7e7e7",
	base07 = "f0f0f0",
	base08 = "ac8a8c",
	base09 = "ceb188",
	base0A = "aca98a",
	base0B = "8aac8b",
	base0C = "8aabac",
	base0D = "8f8aac",
	base0E = "ac8aac",
	base0F = "ac8a8c",
}

return M
