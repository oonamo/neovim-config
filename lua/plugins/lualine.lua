return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "VeryLazy",
		init = function()
			vim.g.lualine_laststatus = vim.o.laststatus
			if vim.fn.argc(-1) > 0 then
				-- set an empty statusline till lualine loads
				vim.o.statusline = " "
			else
				-- hide the statusline on the starter page
				vim.o.laststatus = 0
			end
		end,
		opts = function()
			-- From LazyVim
			local lualine_require = require("lualine_require")
			lualine_require = require

			vim.o.laststatus = vim.g.lualine_laststatus

			local M = {}
			M.colors = {
				-- Special
				green = "#afd7d7",
				-- String
				yellow = "#d7af87",
				-- function
				red = "#ffafd7",
				-- Keyword
				dark_green = "#5f8787",
				-- Constant
				orange = "#ffaf87",
				-- Variable
				text = "#d7d7ff",
				-- Propertu
				light_green = "#bcbcbc",
				-- Keyword Operator
				gray = "#8787af",
				-- Conditional
				blue = "#5f87af",
			}
			local prime_pine = require("lualine.themes.rose-pine")
			vim.opt.showmode = false

			prime_pine.normal.a.bg = M.colors.orange
			prime_pine.normal.b.fg = M.colors.orange

			prime_pine.insert.a.bg = M.colors.green
			prime_pine.insert.b.fg = M.colors.green

			prime_pine.visual.a.bg = M.colors.blue
			prime_pine.visual.b.fg = M.colors.blue

			prime_pine.replace.a.bg = M.colors.gray
			prime_pine.replace.b.fg = M.colors.gray

			prime_pine.command.a.bg = M.colors.red
			prime_pine.command.b.fg = M.colors.red

			prime_pine.inactive.a.bg = M.colors.orange
			prime_pine.inactive.b.fg = M.colors.orange

			prime_pine.normal.c.bg = "#282c34"
			prime_pine.insert.c.bg = "#282c34"
			prime_pine.visual.c.bg = "#282c34"
			prime_pine.replace.c.bg = "#282c34"
			prime_pine.command.c.bg = "#282c34"
			prime_pine.inactive.c.bg = "#282c34"

			local mode = {
				"mode",
				fmt = function(str)
					return "-- " .. str .. " --"
				end,
			}

			local diagnostics = {
				"diagnostics",
				sources = { "nvim_diagnostic" },
				sections = { "error", "warn" },
				symbols = { error = " ", warn = " " },
				colored = false,
				update_in_insert = false,
				always_visible = true,
			}

			return {
				options = {
					theme = "auto",
					globalstatus = true,
					-- component_separators = { left = "", right = "" },
					component_separators = { left = "", right = "" },
					-- component_separators = { left = "◣", right = "◢" },
					-- section_separators = { left = "◣", right = "◢" },
					section_separators = { left = "", right = "" },
					-- component_separators = { left = "", right = "" },
					-- section_separators = { left = "", right = "" },
				},
				sections = {
					lualine_a = { diagnostics },
					lualine_b = {
						mode,
						{
							function()
								return require("arrow.statusline").text_for_statusline_with_icons()
							end,
							cond = function()
								return package.loaded["arrow"]
									and require("arrow.statusline").text_for_statusline_with_icons() ~= nil
							end,
						},
					},
					lualine_c = {
						{
							function()
								return require("pomo").get_first_to_finish()
							end,
							cond = function()
								return package.loaded["pomo"] and require("pomo").get_first_to_finish() ~= nil
							end,
							icon = "",
						},
					},
					lualine_x = { "diff", "encoding", "filetype" },
					lualine_y = { "location" },
					lualine_z = { "progress" },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},
			}
		end,
		enabled = not vim.g.use_custom_statusline,
		cond = vim.g.use_lualine,
	},
}
