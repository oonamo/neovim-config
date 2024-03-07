local M = {}
local utils = require("onam.utils")
local function hsl(h, s, l)
	-- return string.format("#%02x%02x%02x", utils.hsl_to_rgb(h, s, l))
	return utils.hsl_to_rgb(h, s, l)
	-- return "#%02x%02x%02x"
end
M.colors = {
	bg = "#262626",
	fg = "#C7C7C7",
	black = hsl(0, 0, 15),
	-- "maroon",
	-- "#b4637a",
	-- hsl(260, 45, 70),
	red = hsl(350, 67, 63),
	-- "green"
	-- "#56949f",
	-- hsl(260, 45, 70),
	green = hsl(197, 100, 38),
	-- "olive",
	-- "#bba19e",
	-- hsl(260, 45, 70),
	yellow = hsl(55, 89, 57),
	-- "navy",
	-- "#286983",
	blue = hsl(260, 45, 70),
	-- "purple"
	-- "#907aa9",
	purple = hsl(260, 45, 70),
	-- "teal",
	"#56949f",
	teal = hsl(260, 45, 70),
	-- "silver",
	-- "#b2afc4",
	silver = hsl(0, 0, 78),
}

function M.setup()
	O.colorscheme = "paramount-ng"
	O.fn = "paramount"
	utils.hl = {
		opts = {
			{ "markdownH1", { fg = M.colors.purple } },
			{ "markdownH2", { fg = M.colors.teal } },
			{ "markdownH3", { fg = M.colors.fg } },
			{ "markdownH4", { fg = M.colors.fg } },
			{ "markdownH5", { fg = M.colors.fg } },
			{ "markdownH6", { fg = M.colors.fg } },

			{ "@neorg.headings.1.title", { link = "markdownH1" } },
			{ "@neorg.headings.2.title", { link = "markdownH2" } },
			{ "@neorg.headings.3.title", { link = "markdownH3" } },
			{ "@neorg.headings.4.title", { link = "markdownH4" } },
			{ "@neorg.headings.5.title", { link = "markdownH5" } },
			{ "@neorg.headings.6.title", { link = "markdownH6" } },

			{ "FloatBorder", { blend = 15 } },
			{ "Visual", { bg = M.colors.purple } },
			{ "Normal", { fg = M.colors.fg } },
		},
	}
	utils:create_hl()
	vim.cmd("colorscheme " .. O.colorscheme)
end

return M
