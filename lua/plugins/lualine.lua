return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local prime_pine = require("lualine.themes.rose-pine")
			-- local harpoon_list_ext = require("onam.harpoon_list_ext")
			local autocmds = require("onam.autocmds")

			autocmds.setup_status_cmds()
			-- harpoon_list_ext.setup_autocmds()
			prime_pine.normal.c.bg = "#d4a38d"

			local function macro()
				if vim.fn.reg_recording() ~= "" then
					return "%#Macro#@recording " .. vim.fn.reg_recording() .. " "
				end
				return ""
			end
			require("lualine").setup({
				options = {
					theme = "auto",
					globalstatus = true,
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "filename", macro },
					lualine_c = { "diagnostics" },
					-- lualine_x = { harpoon_list_ext.harpoon_list_as_statusline },
					lualine_y = { "encoding" },
				},
				-- tabline = {
				-- 	lualine_a = {},
				-- 	lualine_b = {},
				-- 	lualine_c = { "buffers" },
				-- 	lualine_x = {},
				-- 	lualine_y = {},
				-- 	lualine_z = {},
				-- },
			})
		end,
		enabled = not vim.g.use_custom_statusline,
	},
}
