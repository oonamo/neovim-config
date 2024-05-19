return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		priority = 1000,
		lazy = true,
	},
	{
		"EdenEast/nightfox.nvim",
		lazy = true,
		priority = 1000,
		opts = function()
			local S = require("nightfox.lib.shade")
			return {
				options = {
					transparent = false,
					-- dim_inactive = true,
					styles = { -- Style to be applied to different syntax groups
						functions = "bold,italic",
						keywords = "bold",
						conditional = "italic",
					},
					inverse = { -- Inverse highlight for different types
						match_paren = false,
						visual = false,
						search = true,
					},
				},
				palettes = {
					dayfox = {
						-- commit = "c88664b18e593319aea1ded731dd252d4f9e0f9a", -- before day-fox refactor, not looking goodd
						black = S.new("#1d344f", "#24476f", "#1c2f44", true),
						red = S.new("#b95d76", "#c76882", "#ac5169", true),
						green = S.new("#618774", "#629f81", "#597668", true),
						yellow = S.new("#ba793e", "#ca884a", "#a36f3e", true),
						blue = S.new("#4d688e", "#4e75aa", "#485e7d", true),
						magenta = S.new("#8e6f98", "#9f75ac", "#806589", true),
						-- cyan    = S.new("#6ca7bd", "#74b2c9", "#5a99b0", true),
						cyan = { base = "#208990", bright = "#259495", dim = "#107980" }, -- darken
						-- white   = S.new("#cdd1d5", "#cfd6dd", "#b6bcc2", true),
						white = { base = "#ee9310", bright = "#f19615", dim = "#d38305" },
						orange = S.new("#e3786c", "#e8857a", "#d76558", true),
						pink = S.new("#d685af", "#de8db7", "#c9709e", true),

						comment = "#7f848e",

						bg0 = "#dfdfdf", -- Dark bg (status line and float)
						bg1 = "#F7F7FA", -- Default bg
						bg2 = "#E8E8EC", -- Lighter bg (colorcolm folds)
						bg3 = "#DbEAfB", -- Lighter bg (cursor line)
						bg4 = "#dcdcdc", -- Conceal, border fg

						fg0 = "#182a40", -- Lighter fg
						fg1 = "#1d344f", -- Default fg
						fg2 = "#233f5e", -- Darker fg (status line)
						fg3 = "#2e537d", -- Darker fg (line numbers, fold colums)

						sel0 = "#D8E7fB", -- Popup bg, visual selection bg
						sel1 = "#dcdcdc", -- Popup sel bg, search bg
					},
					-- dawnfox = {
					-- 	bg1 = "#FFFAF3", -- brighter
					-- 	bg2 = "#eae1e3", -- brighter
					-- 	yellow = { base = "#ee9310", bright = "#f19615", dim = "#d38305" },
					-- },
				},
				all = {
					git = {
						added = "#a4cf69",
						changed = "#63c1e6",
						removed = "#d74f56",
					},
				},
				dayfox = {
					syntax = {
						func = "blue.bright", -- was blue.dim
						ident = "magenta", -- cyan by default
					},
				},
				-- 	dawnfox = {
				-- 		syntax = {
				-- 			func = "blue.bright", -- was blue.dim
				-- 		},
				-- 	},
				-- 	nightfox = {
				-- 		git = {
				-- 			added = "#a4cf69",
				-- 			changed = "#63c1e6",
				-- 			removed = "#d74f56",
				-- 		},
				-- 		syntax = {
				-- 			func = "blue.bright", -- was blue.dim
				-- 		},
				-- 	},
				-- },
				groups = {
					all = {
						-- 	["@keyword.function"] = { link = "@keyword.return" }, -- make them reddish
						-- 	["@keyword.repeat"] = { link = "@keyword.return" }, -- make them reddish
						-- 	["@keyword.conditional"] = { link = "@keyword.return" }, -- make them reddish
						-- 	["@keyword.exception"] = { link = "@keyword.return" }, -- make them reddish
						-- 	-- ["@conditional"] = { link = "@keyword.return" },
						-- 	["@repeat"] = { link = "@keyword.return" },
						-- 	["@keyword.operator"] = { link = "@keyword.return" },
						-- 	["@keyword"] = { link = "@keyword.return" }, -- from blueish, to red
						-- 	["@function.builtin"] = { link = "@keyword" }, -- blueish - list, enumerate, range...
						["MatchParen"] = { fg = "palette.red" }, -- blueish - list, enumerate, range...
						-- 	-- DiffAdd = {bg = "#a4cf69" }, -- does not seem to work...
						-- 	-- DiffChange = {bg = "#63c1e6" },
						-- 	-- DiffDelete = {bg = "#d74f56" },
						["StatusLineNC"] = { bg = "palette.cyan", fg = "palette.fg0" },
					},
					terafox = {
						StatusLineNC = { bg = "#74b2c9", fg = "#000000" },
					},
				},
			}
		end,
	},
	{
		"sainnhe/gruvbox-material",
		lazy = true,
	},
	{
		"rebelot/kanagawa.nvim",
		lazy = true,
	},
	{ "catppuccin/nvim", lazy = true, name = "catppuccin" },
}
