return {
	{
		"AstroNvim/astrotheme",
		lazy = true,
		opts = {
			background = { -- :h background, palettes to use when using the core vim background colors
				light = "astrolight",
				dark = "astrodark",
			},
			palettes = {
				astrolight = {
					ui = {
						base = "#feeeee",
					},
				},
			},
			highlights = {
				astrolight = {
					CursorLineNr = { fg = "#ead0dd" },
					CursorLine = { bg = "#E8E9EA" },
				},
			},
			style = {
				transparent = false, -- Bool value, toggles transparency.
				inactive = false, -- Bool value, toggles inactive window color.
				float = true, -- Bool value, toggles floating windows background colors.
				neotree = false, -- Bool value, toggles neo-trees background color.
				border = true, -- Bool value, toggles borders.
				title_invert = true, -- Bool value, swaps text and background colors.
				italic_comments = true, -- Bool value, toggles italic comments.
				simple_syntax_colors = true, -- Bool value, simplifies the amounts of colors used for syntax highlighting.
			},
		},
	},
	{
		"sainttttt/flesh-and-blood",
		lazy = true,
	},
	{
		"oonamo/neovim",
		name = "rose-pine",
		lazy = true,
		config = function()
			require("rose-pine").setup({
				-- variant = "",
				styles = {
					bold = true,
					italic = true,
					transparency = false,
				},
				highlight_groups = {
					-- _nc = "#16141f",
					-- base = "#191724",
					-- surface = "#1f1d2e",
					-- overlay = "#26233a",
					-- muted = "#6e6a86",
					-- subtle = "#908caa",
					-- text = "#e0def4",
					-- love = "#eb6f92",
					-- gold = "#f9bd98",
					-- rose = "#ebbcba",
					-- pine = "#7f9f9f",
					-- foam = "#bedfe0",
					-- iris = "#debee2",
					-- highlight_low = "#21202e",
					-- highlight_med = "#403d52",
					-- highlight_high = "#524f67",
					-- none = "NONE",
					TreesitterContext = { bg = "highlight_low" },
					TreesitterContextBottom = { sp = "rose", underline = true },
					TreesitterContextNumberBottom = { sp = "rose", underline = true },
					TelescopeTitle = { fg = "base", bg = "love" },
					TelescopePromptTitle = { fg = "base", bg = "pine" },
					TelescopePreviewTitle = { fg = "base", bg = "iris" },
					BufferVisible = { bg = "none", fg = "text", bold = true, italic = true },
					NoiceCmdlinePopupBorder = { fg = "subtle", bg = "subtle" },
				},
			})
		end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		lazy = true,
	},
	{
		"rebelot/kanagawa.nvim",
		lazy = true,
	},
	{
		"neanias/everforest-nvim",
		lazy = true,
	},
	{
		"EdenEast/nightfox.nvim",
		lazy = true,
	},
	{
		"Tsuzat/NeoSolarized.nvim",
		lazy = true,
		opts = {
			transparent = false,
		},
	},
	{
		"RRethy/base16-nvim",
		lazy = true,
	},
	{
		"NLKNguyen/papercolor-theme",
		lazy = true,
	},
	{
		"folke/tokyonight.nvim",
		lazy = true,
		config = function()
			local bg = "#011628"
			local bg_dark = "#011423"
			local bg_highlight = "#143652"
			local bg_search = "#0A64AC"
			local bg_visual = "#275378"
			local fg = "#CBE0F0"
			local fg_dark = "#B4D0E9"
			local fg_gutter = "#627E97"
			local border = "#547998"
			require("tokyonight").setup({
				on_colors = function(colors)
					-- if vim.o.background == "light" then
					-- 	return
					-- end
					-- colors.bg = bg
					-- colors.bg_dark = bg_dark
					-- colors.bg_float = bg_dark
					-- colors.bg_highlight = bg_highlight
					-- colors.bg_popup = bg_dark
					-- colors.bg_search = bg_search
					-- colors.bg_sidebar = bg_dark
					-- colors.bg_statusline = bg_dark
					-- colors.bg_visual = bg_visual
					-- colors.border = border
					-- colors.fg = fg
					-- colors.fg_dark = fg_dark
					-- colors.fg_float = fg
					-- colors.fg_gutter = fg_gutter
					-- colors.fg_sidebar = fg_dark
				end,
			})
		end,
	},
	{
		"mountain-theme/vim",
		name = "mountain",
		branch = "master",
		lazy = true,
	},
	{
		"mcauley-penney/ice-cave.nvim",
		lazy = true,
	},
	{
		dir = "~/projects/base46.nvim",
		dev = true,
		-- "jayden-chan/base46.nvim",
		lazy = true,
	},
}
