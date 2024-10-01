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

Colors.register("catppuccin", nil, "catppuccin/nvim"):set_spec({
	build = function()
		require("local.colors.cat_colors").build_all_colors()
	end,
	name = "catppuccin",
})

Colors.register("default_dark", nil, nil)

require("local.colors.cat_colors").register()
