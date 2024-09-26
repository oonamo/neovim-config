---@return Highlight
---
local function get_hl(name)
	return vim.api.nvim_get_hl(0, {
		name = name,
	})
end

Colors.register("tokyonight", nil, "folke/tokyonight.nvim")
	:add_flavours({
		"night",
		"moon",
	})
	:set_spec({
		opts = {
			styles = {
				keywords = { italic = false },
			},
			on_highlights = function(hl, c)
				hl["@keyword.directive.define"] = { fg = hl.PreProc.fg, bold = true }
				hl["@lsp.type.macro"] = { fg = hl.Normal.fg }
				hl.PreProc.bold = true
				hl.StatusLine.bg = "#161620"
				hl.TelescopeMatching = { fg = "#ff9e64", bg = "#0a0c17" }
				hl.TelescopePromptNormal = { fg = "#c0caf5", bg = "#161620" }
				hl.TelescopeNormal = { link = "Normal" }
				hl.CursorLineNr.fg = hl.Normal.fg
				hl.MatchParen = {
					fg = c.red,
					bg = c.terminal_black,
					bold = true,
				}
				hl.WinBar = { link = "Normal" }
			end,
		},
	})

Colors.register("everforest", nil, "sainnhe/everforest")
	:add_flavours({
		"dark",
		"light",
	}, function(_, flavour)
		vim.o.bg = flavour or "dark"
		vim.cmd.colorscheme("everforest")
	end)
	:before(function()
		vim.g.everforest_better_performance = 1
		vim.g.everforest_background = "hard"
	end)

Colors.register("gruvbox-material", nil, "sainnhe/gruvbox-material"):before(function()
	vim.g.gruvbox_material_enable_bold = 1
	vim.g.gruvbox_material_background = "hard"
	vim.g.gruvbox_material_better_performance = 1
end)

Colors.register("rose-pine", nil, "rose-pine/neovim")
	:add_flavours({
		"main",
		"moon",
		"dawn",
	})
	:set_variant_name("variant")
	:set_spec({
		opts = {
			styles = {
				italic = false,
			},
		},
	})

Colors.register("oh-lucy", nil, "Yazeed1s/oh-lucy.nvim")
	:before(function()
		-- oh-lucy
		vim.g.oh_lucy_italic_functions = false
		vim.g.oh_lucy_italic_comments = false
		-- The key is 'oh_lucy_'

		-- oh-lucy-evening
		vim.g.oh_lucy_evening_italic_functions = false
		vim.g.oh_lucy_evening_italic_comments = false
	end)
	:set_spec({
		dir = "~/projects/nvim/oh-lucy.nvim",
		dev = true,
	})
	:add_flavours({ "oh-lucy", "evening", "light", "evening-light" }, function(_, flavour)
		if flavour == "oh-lucy" then
			vim.cmd.colorscheme("oh-lucy")
		else
			vim.cmd.colorscheme("oh-lucy-" .. flavour)
		end
	end)
	:override({
		StatusLine = { link = "Normal" },
	})
--  black = "#000000",
--  blue = "#7788AA",
--  gray1 = "#080808",
--  gray2 = "#191919",
--  gray3 = "#2a2a2a",
--  gray4 = "#444444",
--  gray5 = "#555555",
--  gray6 = "#7a7a7a",
--  gray7 = "#aaaaaa",
--  gray8 = "#cccccc",
--  gray9 = "#DDDDDD",
--  green = "#789978",
--  lack = "#aaaa77",
--  luster = "#deeeed",
--  none = "none",
--  orange = "#ffaa88",
--  red = "#D70000",
--  yellow = "#abab77"
Colors.register("lackluster", function()
	vim.cmd("hi clear")
	vim.cmd.colorscheme("lackluster")
end, "slugbyte/lackluster.nvim"):set_spec({
	opts = function()
		local lackluster = require("lackluster")
		return {
			tweak_color = {
				-- lack = "#aaaa77",
				lack = "default",
				luster = "default",
				orange = "default",
				yellow = "default",
				green = "default",
				blue = "default",
				-- red = "default",
				-- red = "#a84342",
				red = "#c9264a",
			},
			tweak_syntax = {
				-- comment = lackluster.color.gray7,
				-- type = lackluster.color.orange,
				-- keyword = lackluster.color.orange,
				keyword = "#876883",
				-- keyword = "#95568b",
				-- keyword = "#c365b5",
				keyword_return = lackluster.color.green,
				-- keyword_return = lackluster.color.red,
				keyword_exception = "default",
				-- string = lackluster.color.yellow,
			},
			tweak_highlight = {
				CursorLine = { bg = "NONE" },
				StatusLine = { bg = "NONE" },
				MiniDiffSignAdd = { fg = lackluster.color.green },
				MiniDiffSignChange = { fg = lackluster.color.orange },
				MiniDiffSignDelete = { fg = lackluster.color.red },
			},
			tweak_background = {
				-- normal = "none",
				-- telescope = "none",
				-- menu = "none",
			},
		}
	end,
})

Colors.register("melange", nil, "savq/melange-nvim"):override({
	MiniDiffSignChange = { link = "GitSignsChange" },
	MiniDiffSignAdd = { link = "GitSignsAdd" },
	MiniDiffSignDelete = { link = "GitSignsDelete" },
	MiniIconsRed = { link = "DiagnosticError" },
	MiniIconsBlue = { link = "DiagnosticInfo" },
	MiniIconsCyan = { link = "DiagnosticHint" },
	MiniIconsAzure = { link = "String" },
	MiniIconsGreen = { link = "DiagnosticOk" },
	MiniIconsOrange = { link = "DiagnosticWarn" },
	MiniIconsPurple = { link = "Constant" },
	MiniIconsYellow = { link = "Function" },
	MiniPickMatchCurrent = { link = "IncSearch" },
})

Colors.register("astrotheme", nil, "AstroNvim/astrotheme")
Colors.register("kanagawa", nil, "rebelot/kanagawa.nvim")
	:add_flavours({
		"wave",
		"dragon",
		"lotus",
	})
	:set_spec({
		opts = {
			keywordStyle = { italic = false, bold = true },
			overrides = function(colors)
				local theme = colors.theme
				return {
					PreProc = { fg = theme.dragonRed, bold = true },
					["@keyword.directive.define"] = { fg = theme.dragonRed, bold = true },
					Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
					PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
					PmenuSbar = { bg = theme.ui.bg_m1 },
					PmenuThumb = { bg = theme.ui.bg_p2 },
				}
			end,
			colors = {
				theme = {
					all = {
						ui = {
							bg_gutter = "none",
						},
					},
				},
			},
		},
	})
Colors.register("vague", nil, "vague2k/vague.nvim"):set_spec({
	opts = {
		colors = {
			func = "#bc96b0",
			keyword = "#787bab",
			-- string = "#d4bd98",
			string = "#8a739a",
			-- string = "#f2e6ff",
			-- number = "#f2e6ff",
			-- string = "#d8d5b1",
			number = "#8f729e",
			-- type = "#dcaed7",
		},
	},
})
Colors.register("papercolor", nil, "NLKNguyen/papercolor-theme")
Colors.register("monokai-pro", nil, "loctvl842/monokai-pro.nvim")
Colors.register("modus", nil, "miikanissi/modus-themes.nvim")
	:auto_set_variant(false)
	:add_flavours({
		"dark",
		"light",
		"tinted-dark",
		"tinted-light",
	}, function(_, flavour)
		if not flavour then
			return
		end
		local variant, background = flavour:match("(.*)-(.*)")
		if not variant or not background then
			background = flavour
		end
		vim.o.background = background
		-- require("modus-themes.config").options.variant = variant or "default"
		require("modus-themes").load({
			variant = variant or "default",
			styles = {
				keywords = { italic = false },
				functions = { bold = true },
			},
			on_highlights = function(highlights, colors)
				print("on_highlights")
				highlights.EndOfBuffer = { fg = highlights.Normal.fg }
				highlights.MiniCursorWord = { fg = colors.yellow, undercurl = true, sp = colors.yellow }
				highlights.MiniCursorWordCurrent = { reverse = true }
			end,
		})
	end)
	:set_spec({
		opts = {
			-- variant = "tinted",
			styles = {
				keywords = { italic = false },
				functions = { bold = true },
			},
			on_highlights = function(highlights, colors)
				highlights.EndOfBuffer = { fg = highlights.Normal.fg }
				highlights.MiniCursorWord = { fg = colors.yellow, undercurl = true, sp = colors.yellow }
			end,
		},
	})
Colors.register("aurora", nil, "ray-x/aurora"):override({
	NormalNC = { link = "Normal" },
	-- Normal = { fg = get_hl("Normal").fg, bg = "NONE" },
	["@punctuation.delimiter"] = { fg = get_hl("Normal").fg },
})

Colors.register("catppuccin", nil, "catppuccin/nvim"):set_spec({
	build = function()
		require("local.colors.cat_colors").build_all_colors()
	end,
	name = "catppuccin",
})

Colors.register("moonfly", nil, "bluz71/vim-moonfly-colors"):override({
	-- "#323437",
	-- "#ff5454",
	-- "#8cc85f",
	-- "#e3c78a",
	-- "#80a0ff",
	-- "#cf87e8",
	-- "#79dac8",
	-- "#c6c6c6",
	CursorLine = { sp = "#c6c6c6", underline = true },
	-- TelescopeMatching = { fg = require("moonfly").orange, bg = require("moonfly").purple },
	-- TelescopePromptNormal = { fg = "#c0caf5", bg = "#161620" },
	-- TelescopeVisualMatch = { bg = require("moonfly").blue },
}, function()
	vim.api.nvim_set_hl(
		0,
		"TelescopeMatching",
		{ fg = require("moonfly").palette.orange, bg = require("moonfly").palette.grey7 }
	)
end)

Colors.register("onedark", nil, "navarasu/onedark.nvim"):set_spec({
	style = "darker",
})

Colors.register("gruber-darker", nil, "blazkowolf/gruber-darker.nvim"):override({
	MiniDiffSignAdd = { fg = "#73d936" },
	MiniDiffSignChange = { fg = "#ffdd33" },
	MiniDiffSignDelete = { fg = "#f43841" },
})

require("local.colors.cat_colors").register()
