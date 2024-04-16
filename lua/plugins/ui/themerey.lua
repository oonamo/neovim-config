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
				-- astrolight = {
				-- 	ui = {
				-- 		base = "#feeeee",
				-- 	},
				-- },
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
		-- "oonamo/neovim",
		"rose-pine/neovim",
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
				enable = {
					terminal = true,
					legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
					migrations = true, -- Handle deprecated options automatically
				},
				groups = {
					border = "muted",
					link = "iris",
					panel = "surface",

					error = "love",
					hint = "iris",
					info = "foam",
					note = "pine",
					todo = "rose",
					warn = "gold",

					git_add = "foam",
					git_change = "rose",
					git_delete = "love",
					git_dirty = "rose",
					git_ignore = "muted",
					git_merge = "iris",
					git_rename = "pine",
					git_stage = "iris",
					git_text = "rose",
					git_untracked = "subtle",

					h1 = "iris",
					h2 = "foam",
					h3 = "rose",
					h4 = "gold",
					h5 = "pine",
					h6 = "foam",
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
		"NLKNguyen/papercolor-theme",
		lazy = true,
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
	{
		"Verf/deepwhite.nvim",
		lazy = true,
	},
	{
		"akinsho/horizon.nvim",
		opts = {
			plugins = {
				cmp = true,
				telescope = true,
				gitsigns = true,
			},
		},
		lazy = true,
	},
	{
		"water-sucks/darkrose.nvim",
		opts = {
			styles = {
				bold = true,
				italic = true,
				underline = true,
			},
		},
		lazy = true,
	},
	{
		"LunarVim/darkplus.nvim",
		lazy = true,
	},
	{
		"kyazdani42/blue-moon",
		lazy = true,
	},
}
