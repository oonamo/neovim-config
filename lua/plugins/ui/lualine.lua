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
			vim.opt.showmode = false
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

			local spaces = function()
				return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
			end

			local theme = "auto"
			if vim.g.colors_name == "rose-pine" and vim.o.background == "dark" then
				vim.notify("lualine theme: rose-pine-alt")
				theme = "rose-pine-alt"
				-- local prime_pine = require("lualine.themes.rose-pine")
				-- M.pine_colors = {
				-- 	-- Special
				-- 	green = "#afd7d7",
				-- 	-- String
				-- 	yellow = "#d7af87",
				-- 	-- function
				-- 	red = "#ffafd7",
				-- 	-- Keyword
				-- 	dark_green = "#5f8787",
				-- 	-- Constant
				-- 	orange = "#ffaf87",
				-- 	-- Variable
				-- 	text = "#d7d7ff",
				-- 	-- Propertu
				-- 	light_green = "#bcbcbc",
				-- 	-- Keyword Operator
				-- 	gray = "#8787af",
				-- 	-- Conditional
				-- 	blue = "#5f87af",
				-- }
				--
				-- prime_pine.normal.a.bg = M.pine_colors.orange
				-- prime_pine.normal.b.fg = M.pine_colors.orange
				--
				-- prime_pine.insert.a.bg = M.pine_colors.green
				-- prime_pine.insert.b.fg = M.pine_colors.green
				--
				-- prime_pine.visual.a.bg = M.pine_colors.blue
				-- prime_pine.visual.b.fg = M.pine_colors.blue
				--
				-- prime_pine.replace.a.bg = M.pine_colors.gray
				-- prime_pine.replace.b.fg = M.pine_colors.gray
				--
				-- prime_pine.command.a.bg = M.pine_colors.red
				-- prime_pine.command.b.fg = M.pine_colors.red
				--
				-- prime_pine.inactive.a.bg = M.pine_colors.orange
				-- prime_pine.inactive.b.fg = M.pine_colors.orange
				--
				-- prime_pine.normal.c.bg = "#282c34"
				-- prime_pine.insert.c.bg = "#282c34"
				-- prime_pine.visual.c.bg = "#282c34"
				-- prime_pine.replace.c.bg = "#282c34"
				-- prime_pine.command.c.bg = "#282c34"
				-- prime_pine.inactive.c.bg = "#282c34"
				-- theme = prime_pine
			elseif vim.g.colors_name == "gruvbox" then
				local gruvbox = require("lualine.themes.gruvbox")
				M.gruvbox = {
					dark0_hard = "#1d2021",
					dark0 = "#282828",
					dark0_soft = "#32302f",
					dark1 = "#3c3836",
					dark2 = "#504945",
					dark3 = "#665c54",
					dark4 = "#7c6f64",
					light0_hard = "#f9f5d7",
					light0 = "#fbf1c7",
					light0_soft = "#f2e5bc",
					light1 = "#ebdbb2",
					light2 = "#d5c4a1",
					light3 = "#bdae93",
					light4 = "#a89984",
					bright_red = "#fb4934",
					bright_green = "#b8bb26",
					bright_yellow = "#fabd2f",
					bright_blue = "#83a598",
					bright_purple = "#d3869b",
					bright_aqua = "#8ec07c",
					bright_orange = "#fe8019",
					neutral_red = "#cc241d",
					neutral_green = "#98971a",
					neutral_yellow = "#d79921",
					neutral_blue = "#458588",
					neutral_purple = "#b16286",
					neutral_aqua = "#689d6a",
					neutral_orange = "#d65d0e",
					faded_red = "#9d0006",
					faded_green = "#79740e",
					faded_yellow = "#b57614",
					faded_blue = "#076678",
					faded_purple = "#8f3f71",
					faded_aqua = "#427b58",
					faded_orange = "#af3a03",
					dark_red_hard = "#792329",
					dark_red = "#722529",
					dark_red_soft = "#7b2c2f",
					light_red_hard = "#fc9690",
					light_red = "#fc9487",
					light_red_soft = "#f78b7f",
					dark_green_hard = "#5a633a",
					dark_green = "#62693e",
					dark_green_soft = "#686d43",
					light_green_hard = "#d3d6a5",
					light_green = "#d5d39b",
					light_green_soft = "#cecb94",
					dark_aqua_hard = "#3e4934",
					dark_aqua = "#49503b",
					dark_aqua_soft = "#525742",
					light_aqua_hard = "#e6e9c1",
					light_aqua = "#e8e5b5",
					light_aqua_soft = "#e1dbac",
					gray = "#928374",
				}
				gruvbox.normal.a = { bg = M.gruvbox.bright_purple }
				gruvbox.insert.a = { bg = M.gruvbox.bright_aqua }
				gruvbox.visual.a = { bg = M.gruvbox.bright_orange }

				gruvbox.normal.b = { fg = M.gruvbox.bright_purple, bg = gruvbox.normal.c.bg }
				gruvbox.insert.b = { fg = M.gruvbox.bright_aqua, bg = gruvbox.normal.c.bg }
				gruvbox.visual.b = { fg = M.gruvbox.bright_orange, bg = gruvbox.normal.c.bg }

				theme = gruvbox
			end

			return {
				options = {
					icons_enabled = true,
					theme = theme,
					globalstatus = true,
					-- component_separators = { left = "", right = "" },
					-- section_separators = { left = "", right = "" },
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					-- component_separators = { right = "", left = "" },
					-- section_separators = { right = "", left = "" },
					-- component_separators = { left = '', right = ''},
					-- section_separators = { left = '', right = ''},
					disabled_filetypes = {
						statusline = { "dashboard", "alpha" },
						winbar = { "dashboard", "alpha" },
						tabline = { "dashboard", "alpha" },
					},
				},
				sections = {
					lualine_a = { diagnostics },
					lualine_b = {
						mode,
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
						"filename",
						"grapple",
					},
					lualine_x = {
						{
							function()
								return spaces()
							end,
							cond = function()
								-- Only on md, norg, tex files
								return vim.bo.filetype == "norg"
									or vim.bo.filetype == "markdown"
									or vim.bo.filetype == "rmd"
							end,
						},
						"encoding",
						"filetype",
					},
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
		-- cond = O.ui.statusline.lualine,
		cond = false,
	},
}
