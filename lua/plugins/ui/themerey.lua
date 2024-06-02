local rose_pine_moon_map = {
	-- ["#232136"] = "#272637",
	["#2a273f"] = nil,
	["#393552"] = nil,
	["#6e6a86"] = nil,
	["#908caa"] = nil,
	["#e0def4"] = nil,
	["#eb6f92"] = "#e69ec4",
	["#f6c177"] = "#f8c984",
	["#ea9a97"] = "#f3afab",
	["#3e8fb0"] = "#78b2cd",
	["#9ccfd8"] = "#aed6e1",
	["#c4a7e7"] = "#c2ade4",
	["#2a283e"] = nil,
	["#44415a"] = nil,
	["#56526e"] = nil,
	["#1f1d30"] = nil,
	["NONE"] = nil,
}

local has_found = false

return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		priority = 1000,
		lazy = true,
		opts = {
			highlight_groups = {
				-- String = { fg = "iris", italic = true },
				GrappleTitle = { bg = "muted", fg = "base" },
				GrappleBorder = { bg = "surface", fg = "surface" },
				GrappleFooter = { bg = "love", fg = "base" },
				-- Normal = { bg = "#272637", fg = "text" },
			},
			before_highlight = function(group, highlight, palette)
				-- if highlight.fg == palette.love then
				-- 	highlight.fg = "#f0a5cb"
				-- end
				-- if highlight.bg == palette.love then
				-- 	highlight.bg = "#f0a5cb"
				-- end
				-- if rose_pine_moon_map[highlight.fg] then
				-- 	if not has_found then
				-- 		vim.notify("found moon")
				-- 		has_found = true
				-- 	end
				-- 	highlight.fg = rose_pine_moon_map[highlight.fg]
				-- end
				-- if rose_pine_moon_map[highlight.bg] then
				-- 	if not has_found then
				-- 		vim.notify("found moon")
				-- 		has_found = true
				-- 	end
				-- 	highlight.bg = rose_pine_moon_map[highlight.bg]
				-- end
			end,
		},
	},
	{
		"folke/tokyonight.nvim",
		lazy = true,
		opts = {
			sidebars = {
				"qf",
				"vista_kind",
				-- "terminal",
				"spectre_panel",
				"startuptime",
				"Outline",
			},
			-- on_highlights = function(hl, c)
			-- 	-- hl.Normal = { fg = c.normal, bg = "#1c1c1c" }
			-- 	hl.Normal = { fg = c.normal, bg = "#000000" }
			-- 	hl.NormalNC = {}
			-- end,
		},
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = true,
		-- opts = {
		-- 	flavour = "macchiato", -- latte, frappe, macchiato, mocha
		-- 	background = {
		-- 		light = "latte",
		-- 		dark = "mocha",
		-- 	},
		-- 	term_colors = false,
		-- },
	},
	-- good light theme
	-- {
	-- 	"ronisbr/nano-theme.nvim",
	-- 	lazy = true,
	-- },
	{
		"Yazeed1s/oh-lucy.nvim",
		lazy = true,
	},
	-- nice dark theme
	{
		"wuelnerdotexe/vim-enfocado",
		lazy = true,
		init = function()
			vim.g.enfocado_plugins = {
				-- "animate",
				-- "bufferline",
				"cmp",
				"dap-ui",
				-- "edgy",
				-- "flash",
				-- "gitsigns",
				-- "highlight-undo",
				-- "illuminate",
				"indentscope",
				-- "indent-blankline",
				"lazy",
				"lspconfig",
				-- "lsp-lens",
				"mason",
				-- "navic",
				-- "neo-tree",
				-- "noice",
				-- "null-ls",
				-- "substitute",
				-- "surround",
				-- "rainbow-delimiters",
				-- "telescope",
				"treesitter",
				"treesitter-context",
				-- "ufo",
				-- "visual-multi",
				-- "yanky",
			}
		end,
	},
	-- nice look, and light theme
	{
		"polirritmico/monokai-nightasty.nvim",
		lazy = true,
	},
	-- best light theme
	-- good with mini.colors
	-- chan_add('saturation', 20,  { filter = 'fg' })
	-- chan_add('lightness', -100,  { filter = 'bg' })
	{
		"yorik1984/newpaper.nvim",
		lazy = true,
		config = true,
	},
}
