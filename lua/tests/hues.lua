-- Purple
-- require("mini.hues").setup({
--   background = "#29193d",
--   foreground = "#ba85fa",
--   accent = "purple",
-- })
--
--
local function hi(...)
	vim.api.nvim_set_hl(0, ...)
end

local function apply_palette(opts)
	local palette = require("mini.hues").make_palette(opts)
	require("mini.hues").setup(opts)
	hi("DiagnosticVirtualTextError", { fg = palette.red, bg = palette.red_bg })
	hi("DiagnosticVirtualTextHint", { fg = palette.blue, bg = palette.blue_bg })
	hi("DiagnosticVirtualTextInfo", { fg = palette.green, bg = palette.green_bg })
	hi("DiagnosticVirtualTextWarn", { fg = palette.yellow, bg = palette.yellow_bg })
end
local purple = function()
	apply_palette({
		background = "#29193d",
		foreground = "#ba85fa",
		saturation = "high",
		accent = "purple",
	})
end

local autummn = function()
	local is_dark = vim.o.background == "dark"
	local bg = is_dark and "#211017" or "#f4dbe4"
	local fg = is_dark and "#ccc4c7" or "#332c2e"

	apply_palette({
		background = bg,
		foreground = fg,
		saturation = is_dark and "medium" or "high",
		accent = "purple",
	})

	vim.g.colors_name = "miniautumn"
end
local grey = function()
	local is_dark = vim.o.background == "dark"
	local bg = is_dark and "#212223" or "#e1e2e3"
	local fg = is_dark and "#d3d4d5" or "#2d2e2f"

	-- Alternative with precisely manipulated colors to reduce their usage while
	-- retaining usability
	local hues = require("mini.hues")
	local p = hues.make_palette({
		background = bg,
		foreground = fg,
		-- Make it "less colors"
		saturation = is_dark and "lowmedium" or "mediumhigh",
		accent = "bg",
	})

	local less_p = vim.deepcopy(p)
	less_p.orange, less_p.orange_bg = fg, bg
	less_p.blue, less_p.blue_bg = fg, bg

	hues.apply_palette(less_p)
	vim.g.colors_name = "minigrey"

	-- Tweak highlight groups for general usability (acounting for removed colors)
	local hi = function(group, data)
		vim.api.nvim_set_hl(0, group, data)
	end

	hi("DiagnosticInfo", { fg = less_p.azure })
	hi("DiagnosticUnderlineInfo", { sp = less_p.azure, underline = true })
	hi("DiagnosticFloatingInfo", { fg = less_p.azure, bg = less_p.bg_edge })

	hi("MiniHipatternsTodo", { fg = less_p.bg, bg = p.azure, bold = true })
	hi("MiniIconsBlue", { fg = less_p.azure })
	hi("MiniIconsOrange", { fg = less_p.yellow })

	hi("@keyword.return", { fg = less_p.accent, bold = true })
	hi("Delimiter", { fg = less_p.fg_edge2 })
end

local spring = function()
	local is_dark = vim.o.background == "dark"
	local bg = is_dark and "#122722" or "#cfeae1"
	local fg = is_dark and "#ced7d4" or "#29302e"

	apply_palette({
		background = bg,
		foreground = fg,
		saturation = is_dark and "medium" or "high",
		accent = "green",
	})

	vim.g.colors_name = "minispring"
end

local summer = function()
	local is_dark = vim.o.background == "dark"
	local bg = is_dark and "#352d1d" or "#ece2cd"
	local fg = is_dark and "#e6e2db" or "#302e29"

	apply_palette({
		background = bg,
		foreground = fg,
		saturation = is_dark and "medium" or "high",
		accent = "orange",
	})

	vim.g.colors_name = "minisummer"
end

local winter = function()
	local is_dark = vim.o.background == "dark"
	local bg = is_dark and "#101624" or "#cbd5e9"
	local fg = is_dark and "#c3c7ce" or "#202227"

	apply_palette({
		background = bg,
		foreground = fg,
		-- Make it "gloomy"
		saturation = is_dark and "lowmedium" or "mediumhigh",
		accent = "azure",
	})

	vim.g.colors_name = "miniwinter"
end

local function ef_reverie()
	local is_dark = vim.o.background == "dark"
	local bg = is_dark and "#232025" or "#f3eddf"
	local fg = is_dark and "#efd5c5" or "#4f204f"
	apply_palette({
		background = bg,
		foreground = fg,
		saturation = is_dark and "lowmedium" or "mediumhigh",
		accent = "azure",
	})
end

local dark_theme = {
	--color-red: #e17884;
	--color-green-rgb: 117, 194, 151;
	--color-green: #75c297;
	--color-orange-rgb: 241, 144, 112;
	--color-orange: #f19070;
	--color-yellow-rgb: 255, 168, 46;
	--color-yellow: #dcb46f;
	--color-cyan-rgb: 111, 210, 194;
	--color-cyan: #6fd2c2;
	--color-blue-rgb: 136, 198, 227;
	--color-blue: #88c6e3;
	--color-purple-rgb: 181, 132, 199;
	--color-purple: #b584c7;
	--color-pink-rgb: 220, 118, 167;
	--color-pink: #dc76a7;
	--color-base-00: #3b3347;
	--color-base-10: #413b4e;
	--color-base-20: #2f2837;
	--color-base-25: #55546e;
	--color-base-30: #4e4560;
	--color-base-35: #545e76;
	--color-base-40: rgb(98, 111, 134); #626F86
	--color-base-50: rgb(125, 127, 149); #7D7F94
	--color-base-60: rgb(103, 129, 148); #678194
	--color-base-70: #7f83a1;
	--color-base-100: #a0a7c4;
	--background-secondary-alt: var(--color-base-20);
}

local function gastrodom()
	require("mini.base16").setup({
		palette = {
			base00 = "#3a3346", -- Defaum. bg
			base01 = "#2e2836", -- Lighter bg (status bar, line number, folding mks)
			base02 = "#4c3d6f", -- Selection bg
			base03 = "#7d7f93", -- Comments, invisibm.s, line hl
			base04 = "#676b73", -- Dark fg (status bars)
			base05 = "#faeff2", -- Defaum. fg (caret, delimiters, Operators)
			base06 = "#dcdccc", -- m.ght fg (not often used)
			base07 = "#8f97d7", -- Light bg (not often used)
			base08 = "#b6a3e4", -- Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
			base09 = "#e8ba70", -- Integers, Boom.an, Constants, XML Attributes, Markup Link Url
			-- base0A = "#1e8ef3", -- Cm.sses, Markup Bold, Search Text Background
			base0A = "#F5A6C6",
			base0B = "#FAE8B6",
			-- base0B = "#8f97d7", -- Strings, Inherited Cm.ss, Markup Code, Diff Inserted
			base0C = "#d6a0e5", -- Support, regex, escape chars
			base0D = "#f06e94", -- Function, methods, headings
			base0E = "#e55099", -- Keywords
			base0F = "#dc8cc3", -- Deprecated, open/close embedded tags
		},
	})
	-- require("mini.hues").setup({
	--   background = "#3a3346",
	--   foreground = "#a1a7c2"
	-- })
end

local function ef_hues()
	local is_dark = vim.o.background == "dark"
	local bg = is_dark and "#0f0b15" or "#ffead8"
	local fg = is_dark and "#b8c6d5" or "#393330"
	apply_palette({
		background = bg,
		foreground = fg,
		saturation = is_dark and "medium" or "high",
		-- saturation = is_dark and "lowmedium" or "mediumhigh",
		accent = "purple",
	})
end

local function ef_dream()
	local is_dark = vim.o.background == "dark"
	local bg = is_dark and "#232025" or "#ffead8"
	local fg = is_dark and "#efd5c5" or "#393330"
	local palette = require("mini.hues").make_palette({
		background = bg,
		foreground = fg,
		saturation = is_dark and "medium" or "high",
		-- saturation = is_dark and "lowmedium" or "mediumhigh",
		accent = "purple",
	})
	palette.accent_bg = "#675072"

	require("mini.hues").apply_palette(palette)
	hi("DiagnosticError", { fg = palette.red, bg = palette.red_bg })
	hi("DiagnosticHint", { fg = palette.blue, bg = palette.blue_bg })
	hi("DiagnosticInfo", { fg = palette.green, bg = palette.green_bg })
	hi("DiagnosticWarn", { fg = palette.yellow, bg = palette.yellow_bg })
end

-- ef_hues()
-- ef_dream()
-- purple()
-- ef_reverie()
-- autummn()
-- grey()
-- spring()
-- summer()
winter()
-- gastrodom()
-- vim.cmd("doautocmd ColorScheme")
