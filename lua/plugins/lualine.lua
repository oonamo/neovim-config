return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local prime_pine = require("lualine.themes.rose-pine")
			local autocmds = require("onam.autocmds")

			autocmds.setup_status_cmds()
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
					section_separators = "",
					component_separators = "",
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "filename", macro },
					lualine_c = { "diagnostics" },
					lualine_y = { "encoding" },
				},
			})
		end,
		enabled = not vim.g.use_custom_statusline,
	},
}
