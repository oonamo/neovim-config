-- Purple
-- require("mini.hues").setup({
--   background = "#29193d",
--   foreground = "#ba85fa",
--   accent = "purple",
-- })
--
local purple = function()
	require("mini.hues").setup({
		background = "#29193d",
		foreground = "#ba85fa",
		accent = "purple",
	})
end

local autummn = function()
	local is_dark = vim.o.background == "dark"
	local bg = is_dark and "#211017" or "#f4dbe4"
	local fg = is_dark and "#ccc4c7" or "#332c2e"

	require("mini.hues").setup({
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

	require("mini.hues").setup({
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

	require("mini.hues").setup({
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

	require("mini.hues").setup({
		background = bg,
		foreground = fg,
		-- Make it "gloomy"
		saturation = is_dark and "lowmedium" or "mediumhigh",
		accent = "azure",
	})

	vim.g.colors_name = "miniwinter"
end
-- require("mini.hues").setup({
--   background = "#616161",
--   foreground = "#d9d9d9",
--   saturation = "medium",
--   n_hues = 8,
-- })
--
local function ef_reverie()
	local is_dark = vim.o.background == "dark"
	local bg = is_dark and "#232025" or "#f3eddf"
	local fg = is_dark and "#efd5c5" or "#4f204f"
  require("mini.hues").setup({
    background = bg,
    foreground = fg,
		saturation = is_dark and "lowmedium" or "mediumhigh",
		accent = "azure",
  })
end

-- purple()
-- ef_reverie()
-- autummn()
-- grey()
spring()
-- summer()
-- winter()
vim.cmd("doautocmd ColorScheme")
