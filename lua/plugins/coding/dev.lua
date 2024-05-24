-- Place for local plugins in devolopment
return {
	{
		"oonamo/manage_my_sessions",
		dependencies = { "nvim-lua/plenary.nvim", "ibhagwan/fzf-lua" },
		dev = true,
		dir = "~/projects/manage_my_sessions",
		opts = {
			sessions = {
				-- {
				-- 	"~/Documents/School/spring2024",
				-- 	name = "neorg",
				-- 	after = function()
				-- 		vim.schedule(function()
				-- 			vim.cmd("Neorg index")
				-- 			vim.cmd("ZenMode")
				-- 		end)
				-- 	end,
				-- },
				{
					"~/Desktop/DB/DB",
					name = "obsidian",
					after = function()
						vim.schedule(function()
							vim.cmd("e base.md")
						end)
					end,
				},
				{ "~/AppData/Local/nvim", name = "nvim config" },
				{ "~/projects/cs216", name = "cs216" },
				{ "~/.glaze-wm", name = "glaze-wm" },
				"~/projects",
				"~/.config",
			},
			term_cd = true,
		},
		keys = {
			{ "<leader>ms", "<cmd>ManageMySessions<cr>", desc = "[M]anage My [S]essions" },
		},
	},
	{
		dir = "~/projects/manage_my_colors",
		dev = true,
		lazy = false,
		priority = 1000,
		opts = function()
			local c_tils = require("manage_my_colors.utils")
			return {
				before_all = function(theme, flavour)
					vim.notify("changing to " .. theme.name)
					vim.cmd.hi("clear")
				end,
				default_theme = {
					name = "rose-pine",
					flavours = { "main", "prime", "dawn" },
					action = c_tils.match_flavour({
						["prime"] = function(_, flavour)
							vim.notify("prime-pine")
							require("colors.prime-pine").setup(flavour)
						end,
					}, function(_, flavour)
						vim.notify("called default")
						vim.cmd.colorscheme("rose-pine-" .. flavour)
					end),
				},
				colorschemes = {
					{
						name = "gruvbox-material",
						flavours = {
							{ "dark", "soft" },
							{ "dark", "medium" },
							{ "dark", "hard" },
							{ "light", "soft" },
							{ "light", "medium" },
							{ "light", "hard" },
						},
						action = c_tils.match_table(function(_, flavour)
							vim.o.background = flavour[1]
							vim.g.gruvbox_material_background = flavour[2]
							vim.cmd.colorscheme("gruvbox-material")
						end),
					},
					{
						name = "rose-pine",
						flavours = { "main", "prime", "moon", "dawn" },
						action = c_tils.match_flavour({
							["prime"] = function(_, flavour)
								vim.notify("prime-pine")
								require("colors.prime-pine").setup(flavour)
							end,
						}, function(_, flavour)
							vim.cmd.colorscheme("rose-pine-" .. flavour)
						end),
					},
					{
						name = "kanagawa",
						flavours = { "wave", "dragon", "lotus" },
						action = c_tils.append_flavour_to_name("-"),
					},
					{
						name = "modus",
						flavours = { "vivendi", "operandi" },
						action = c_tils.append_flavour_to_name("_"),
					},
					{ name = "catppuccin" },
					{
						name = "base16",
						flavours = { "green", "box" },
						action = c_tils.match_flavour({
							["green"] = function()
								require("mini.base16").setup({
									palette = {
										base00 = "#1A1B26",
										base01 = "#16161E",
										base02 = "#2F3549",
										base03 = "#444B6A",
										base04 = "#787C99",
										base05 = "#A9B1D6",
										base06 = "#CBCCD1",
										base07 = "#D5D6DB",
										base08 = "#C0CAF5",
										base09 = "#A9B1D6",
										base0A = "#0DB9D7",
										base0B = "#9ECE6A",
										base0C = "#B4F9F8",
										base0D = "#2AC3DE",
										base0E = "#BB9AF7",
										base0F = "#F7768E",
									},
								})
							end,
							["box"] = function()
								require("mini.base16").setup({
									palette = {
										base00 = "#1d2021",
										base01 = "#3c3836",
										base02 = "#504945",
										base03 = "#665c54",
										base04 = "#bdae93",
										base05 = "#d5c4a1",
										base06 = "#ebdbb2",
										base07 = "#fbf1c7",
										base08 = "#fb4934",
										base09 = "#fe8019",
										base0A = "#fabd2f",
										base0B = "#b8bb26",
										base0C = "#8ec07c",
										base0D = "#83a598",
										base0E = "#d3869b",
										base0F = "#d65d0e",
									},
								})
							end,
						}),
					},
				},
				persistance = true,
			}
		end,
		keys = {
			{ "<leader>Lcp", "<cmd>ManageMyColors<cr>", desc = "Manage my themes" },
			{ "<leader>Lcf", "<cmd>ManageMyFlavour<cr>", desc = "move to next flavour" },
		},
	},
}
