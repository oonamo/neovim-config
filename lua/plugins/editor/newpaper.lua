return {
	"yorik1984/newpaper.nvim",
	-- lazy = false,
	-- priority = 1000,
	config = function()
		local colors = {
			black = "#2B2B2B", -- color00
			maroon = "#AF0000", -- color01
			darkgreen = "#008700", -- color02
			darkorange = "#AF5F00", -- color03
			navy = "#27408B", -- color04
			purple = "#8700AF", -- color05
			teal = "#005F87", -- color06
			darkgrey = "#444444", -- color08
			red = "#E14133", -- color09
			green = "#50A14F", -- color10
			orange = "#D75F00", -- color11
			lightblue = "#0072C1", -- color12
			lightmagenta = "#E563BA", -- color13
			blue = "#0087AF", -- color14
			white = "#F1F3F2",

			-- Default fg and bg
			fg = "#2B2B2B", -- color15
			bg = "#F1F3F2", -- color07

			-- Other colors
			dark_maroon = "#8C1919",
			redorange = "#E12D23",
			pink = "#FFEEFF",
			lightorange = "#E4C07A",
			persimona = "#EF7932",
			yellow = "#FFFF00",
			darkyellow = "#C18301",
			olive = "#5F8700",
			darkengreen = "#007200",
			ocean = "#2E8B57",
			nephritis = "#00AB66",
			bluegreen = "#1B7F82",
			aqua = "#BFD5EC",
			aquadark = "#AFD7FF",
			aqualight = "#DFE4EB",
			lightviolet = "#E5D9F2",
			blueviolet = "#AF87D7",
			violet = "#957CC6",
			darkpurple = "#5823C7",
			magenta = "#D7005F",
			magenta_bg = "#FFBBFF",
			grey = "#585858",
			lightgrey = "#878787",
			lightlightgrey = "#D4D4D4",
			silver = "#E4E4E4",
			lightsilver = "#EEEEEE",

			codeblock = "#DEDEDE",
			disabled = "#C3C3C3",

			regexp_blue = "#5588FF",
			regexp_brown = "#884400",
			regexp_green = "#00AA00",
			regexp_magenta = "#CC00CC",
			regexp_orange = "#DD7700",
			regexp_green_bg = "#E1F0E1",
			regexp_orange_bg = "#F0F0C8",

			-- Git and diff
			git_fg = "#413932",
			git_bg = "#EBEAE2",
			git_added = "#28A745",
			git_modified = "#DBAB09",
			git_removed = "#D73A49",
			diffadd_bg = "#AFFFAF",
			diffdelete_bg = "#FFD7FF",
			difftext_bg = "#FFFFD7",
			diffchange_bg = "#FFD787",

			-- Spell
			spellbad = "#FFF4FF",
			spellcap = "#E7E7FF",
			spellrare = "#FFFFDF",
			spelllocal = "#E3FFD5",

			-- LSP message
			error_fg = "#D75F66",
			warn_fg = "#D37300",
			info_fg = "#005FAF",
			hint_fg = "#0EA674",
			ok_fg = "#0EA628",
			lsp_error_bg = "#FDF0F0",
			warn_bg = "#FDF5EC",
			info_bg = "#EBF0FD",
			hint_bg = "#E7F8F2",
			ok_bg = "#E6F6E9",

			-- Todo
			todo_error = "#DF0000",
			todo_warn = "#D75F00",
			todo_info = "#3A72ED",
			todo_hint = "#199319",
			todo_default = "#894DEE",
			todo_test = "#B748B7",

			-- TeX
			tex_maroon = "#A2251A",
			tex_olive = "#89802B",
			tex_navy = "#1E40C2",
			tex_red = "#D84342",
			tex_blue = "#0089B3",
			tex_teal = "#005579",
			tex_magenta = "#E00050",
			tex_aqua = "#14B9C4",
			tex_orange = "#D37300",
			tex_redorange = "#F3752D",
			tex_darkorange = "#BA6400",

			tex_lightpurple = "#684D99",
			tex_lightviolet = "#B777B7",
			tex_pink = "#D75F66",
			tex_lightgreen = "#20A93E",

			tex_math = "#008000",
			tex_math_cmd = "#636D1D",
			tex_math_delim = "#349279",
			tex_operator = "#09529B",
			tex_part_title = "#5F8A00",
			tex_ch_brown = "#8C1919",
			tex_ch_orange = "#E5740B",
			tex_ch_green = "#19A665",
			tex_ch_red = "#E04A4A",
			tex_ch_blue = "#394892",
			tex_keyword = "#7F2DC2",
			tex_verb = "#4E5B5F",
			tex_string = "#007FD7",
			tex_tikz_purple = "#635F8C",
			tex_tikz_green = "#568355",
			tex_tikz_orange = "#AB915E",
			tex_tikz_navy = "#4654C0",
			tex_tikz_verb = "#535362",
			tex_quotes = "#003399",
			tex_SI_purple = "#523891",
			tex_SI_orange = "#D55C1F",
			tex_SI_red = "#D83851",
			tex_SI_navy = "#0B5394",
			tex_SI_green = "#589927",
			tex_SI_magenta = "#BC5AA2",
			tex_SI_yellow = "#C88900",

			tex_group_error = "#EBF2FF",
			tex_math_error = "#CCE5CC",
			tex_math_delim_error = "#FBE5CC",
			tex_parbox_opt_error = "#F0D4D1",
			tex_only_math_error = "#EAE8D5",

			-- Ruby
			ruby_maroon = "#880000",
			ruby_navy = "#09529B",
			ruby_purple = "#6838CC",
			ruby_magenta = "#A626A4",
			ruby_orange = "#BF5019",

			-- Lua
			lua_navy = "#030380",
			lua_blue = "#128897",

			-- Jinja
			jinja_red = "#B80000",

			-- Python
			python_blue = "#336D9E",

			--Rust
			rust_green = "#0B7261",

			-- HTML
			tag_navy = "#0044AA",

			rainbowred = "#FF0000",
			rainbowyellow = "#FDA135",
			rainbowblue = "#0041FF",
			rainboworange = "#FF6A00",
			rainbowgreen = "#28CE00",
			rainbowviolet = "#7D00E5",
			rainbowcyan = "#E500E5",

			-- Neovim
			neovim_green = "#54A23D",
		}
		require("newpaper").setup({
			style = "light",
			custom_highlights = {
				TelescopePreviewBorder = { bg = colors.pink, fg = colors.pink },
				TelescopePreviewNormal = { bg = colors.pink },
				TelescopePreviewTitle = { fg = colors.pink, bg = colors.pink },
				TelescopePromptBorder = { bg = colors.silver, fg = colors.silver },
				TelescopePromptCounter = { fg = colors.darkpurple, bold = true },
				TelescopePromptNormal = { bg = colors.silver },
				TelescopePromptPrefix = { bg = colors.silver },
				TelescopePromptTitle = { fg = colors.silver, bg = colors.silver },
				TelescopeResultsBorder = { bg = colors.lightlightgrey, fg = colors.lightlightgrey },
				TelescopeResultsNormal = { bg = colors.lightlightgrey },
				TelescopeResultsTitle = { fg = colors.lightlightgrey, bg = colors.lightlightgrey },
				TelescopeSelection = { bg = colors.silver },
			},
		})
	end,
}
