return {
	"folke/noice.nvim",
	dependencies = { "MunifTanjim/nui.nvim" },
	cond = vim.g.use_noice,
	event = "VeryLazy",
	opts = {
		routes = {
			{
				filter = {
					event = "msg_show",
					kind = "",
					find = "written",
				},
				opts = { skip = true },
			},
		},
		lsp = {
			-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
		},
		messages = { enabled = true },
		notify = { enabled = false },
		popupmenu = { enabled = true },
		cmdline = { enabled = true },
		smart_move = {
			excluded_filetypes = {},
		},
		-- you can enable a preset for easier configuration
		presets = {
			bottom_search = true, -- use a classic bottom cmdline for search
			command_palette = true, -- position the cmdline and popupmenu together
			-- long_message_to_split = true, -- long messages will be sent to a split
			-- inc_rename = false, -- enables an input dialog for inc-rename.nvim
			lsp_doc_border = false, -- add a border to hover docs and signature help
		},
		views = {
			cmdline_popup = {
				border = {
					style = "none",
					padding = { 1, 3 },
				},
				position = {
					row = "40%",
					col = "50%",
				},
				filter_options = {},
				win_options = {
					winhighlight = {
						Normal = "Pmenu",
						FloatBorder = "TelescopeBorder",
					},
				},
			},
		},
	},
}