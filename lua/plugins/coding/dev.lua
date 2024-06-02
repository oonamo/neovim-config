-- Place for local plugins in devolopment
return {
	{
		"oonamo/manage_my_sessions",
		ependencies = { "nvim-lua/plenary.nvim", "ibhagwan/fzf-lua" },
		dev = true,
		dir = "~/projects/manage_my_sessions",
		opts = {
			sessions = {
				{
					"~/Desktop/DB/DB",
					name = "obsidian",
					select = function(path)
						vim.cmd("cd " .. path .. " | e base.md")
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
				before_all = function(_, _)
					vim.cmd.hi("clear")
				end,
				after_all = function(_)
					local diag_fg, diag_bg, _ = utils.get_hl("DiagnosticVirtualTextError")
					if not diag_bg and diag_fg then
						vim.api.nvim_set_hl(
							0,
							"DiagnosticVirtualTextError",
							{ fg = diag_fg, bg = utils.brighten_hex(diag_fg, -70) }
						)
					end
					-- vim.api.nvim_set_hl(0, "ErrorMsg", { link = "DiagnosticVirtualTextError" })
				end,
				persistance = true,
				default_theme = {
					name = "rose-pine",
					flavours = { "main", "moon", "dawn" },
					action = c_tils.append_flavour_to_name("-"),
				},
				colorschemes = {
					{
						name = "rose-pine",
						flavours = { "main", "moon", "dawn" },
						action = c_tils.append_flavour_to_name("-"),
					},
					{
						name = "tokyonight",
						flavours = { "moon", "night", "storm", "day" },
						action = c_tils.append_flavour_to_name("-"),
					},
					{
						name = "minihues",
						flavours = {
							-- "default_dark",
							"blue",
							"slate",
							"purple",
							"maroon",
							"charcoal",
							"lavendar",
							"nightowl",
							"neutral",
						},
						action = c_tils.append_flavour_to_name("-"),
					},
					{
						name = "base16",
						flavours = {
							"default_dark",
							"oxocarbon",
							"kanagawa",
							"moon",
						},
						action = c_tils.append_flavour_to_name("-"),
					},
					{
						name = "oh-lucy",
						flavours = { "oh-lucy", "oh-lucy-evening" },
						action = c_tils.default(),
					},
					{
						name = "catppuccin",
						flavours = { "mocha", "macchiato", "frappe", "latte" },
						action = c_tils.append_flavour_to_name("-"),
					},
					{
						name = "enfocado",
						flavours = { "dark", "light" },
						action = c_tils.toggle_dark_light(function(name, flavour)
							vim.g.enfocado_style = flavour
							vim.cmd.colorscheme(name)
						end),
					},
					{
						name = "monokai-nightasty",
						flavours = { "dark", "light" },
						action = c_tils.toggle_dark_light(),
					},
					{
						name = "newpaper",
						flavours = { "dark", "light" },
						action = c_tils.toggle_dark_light(function(name, flavour)
							-- print(flavour)
							-- vim.g.newpaper_style = flavour

							print(flavour)

							-- vim.cmd.colorscheme(name)
							require("newpaper").setup({
								style = flavour,
								-- lightness = 0.2,
								-- saturation = 20,
							})
							if flavour == "dark" then
								require("mini.colors").setup()
								MiniColors.get_colorscheme()
									:chan_add("saturation", 20, { filter = "fg" })
									:chan_add("lightness", -20, { filter = "bg" })
									:apply()
							end
						end),
					},
				},
			}
		end,
		keys = {
			{ "<leader>Lcp", "<cmd>ManageMyColors<cr>", desc = "Manage my themes" },
			{ "<leader>Lcf", "<cmd>ManageMyFlavour<cr>", desc = "move to next flavour" },
		},
	},
}
