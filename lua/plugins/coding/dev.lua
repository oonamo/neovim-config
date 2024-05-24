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
						flavours = { "main", "prime", "dawn" },
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
					{ name = "missdracula" },
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
