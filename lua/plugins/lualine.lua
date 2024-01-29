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

return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local prime_pine = require("lualine.themes.rose-pine")
			local autocmds = require("onam.autocmds")

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

			autocmds.setup_status_cmds()
			-- harpoon_list_ext.setup_autocmds()

			local function macro()
				if vim.fn.reg_recording() ~= "" then
					return "%#Macro#@recording " .. vim.fn.reg_recording() .. " "
				end
				return ""
			end
			require("lualine").setup({
				options = {
					theme = prime_pine,
					globalstatus = true,
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "filename", macro },
					lualine_c = { "diagnostics" },
					-- lualine_x = { harpoon_list_ext.harpoon_list_as_statusline },
					lualine_y = { "encoding" },
				},
			})
		end,
		enabled = not vim.g.use_custom_statusline,
		cond = vim.g.use_lualine,
	},
}
