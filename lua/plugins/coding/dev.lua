-- Place for local plugins in devolopment
return {
	{
		"oonamo/manage_my_sessions",
		dependencies = { "nvim-lua/plenary.nvim", "ibhagwan/fzf-lua" },
		dev = true,
		dir = "~/projects/manage_my_sessions",
		opts = {
			sessions = {
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
				before_all = function(_, _)
					vim.cmd.hi("clear")
				end,
				after_all = function(theme, _)
					-- modus theme already sets this
					if theme == "modus" then
						return
					end
					local diag_fg, diag_bg, _ = utils.get_hl("DiagnosticVirtualTextError")
					if not diag_bg and diag_fg then
						vim.api.nvim_set_hl(
							0,
							"DiagnosticVirtualTextError",
							{ fg = diag_fg, bg = utils.brighten_hex(diag_fg, -70) }
						)
					end
					vim.api.nvim_set_hl(0, "ErrorMsg", { link = "DiagnosticVirtualTextError" })
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
						name = "modus",
						flavours = { "vivendi", "operandi" },
						action = c_tils.append_flavour_to_name("_"),
					},
					{
						name = "melange",
						flavours = { "melange" },
						action = c_tils.default(),
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
