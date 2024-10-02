return {
	{
		"echasnovski/mini.nvim",
		lazy = true,
	},
	{
		"mini.basic",
		dev = true,
		event = "VeryLazy",
		opts = {
			mappings = {
				windows = true,
			},
			silent = true,
		},
		config = function(_, opts)
			require("mini.basics").setup(opts)
		end,
	},
	{
		"mini.pick",
		dev = true,
		config = function()
			require("mini.pick").setup({
				source = {
					show = require("mini.pick").default_show,
				},
			})
		end,
		keys = {
			{
				"<C-p>",
				"<cmd>Pick files<cr>",
			},
			{
				"<leader>,",
				"<cmd>Pick buffers<cr>",
				desc = "Switch Buffer",
			},
			{
				"<C-P>",
				"<cmd>Pick files<cr>",
				desc = "find files",
			},
			{
				"<C-F>",
				"<cmd>Pick grep_live<cr>",
				desc = "grep live",
			},
			{
				"<leader>fh",
				"<cmd>Pick help<cr>",
				desc = "help tags",
			},
			{
				"<leader>gw",
				"<cmd>Pick grep<cr>",
				desc = "grep word",
			},
			{
				"<leader>\\",
				"<cmd>Pick buf_lines<cr>",
				desc = "find from current buffer",
			},
			{
				"<leader>fi",
				"<cmd>Pick hl_groups<cr>",
				desc = "highlights",
			},
			{
				"<leader>fm",
				"<cmd>Pick marks<cr>",
				desc = "marks",
			},
			{
				"<leader>of",
				"<cmd>Pick oldfiles<cr>",
				desc = "Old files (cwd)",
			},
		},
	},
	{
		"mini.splitjoin",
		dev = true,
		config = function()
			require("mini.splitjoin").setup()
		end,
		keys = {
			"gS",
		},
	},
	{
		"mini.ai",
		dev = true,
		event = { "BufWritePre", "BufReadPost", "BufNewFile" },
		config = function()
			require("mini.ai").setup({
				custom_textobjects = {
					B = require("mini.extra").gen_ai_spec.buffer(),
				},
			})
		end,
	},
	{
		"mini.diff",
		dev = true,
		event = { "BufWritePre", "BufReadPost", "BufNewFile" },
		opts = {
			view = {
				style = "sign",
				-- signs = { add = "┃", change = "┃", delete = "┃" },
				signs = { add = "▍ ", change = "▍ ", delete = " " },
			},
		},
		config = function(_, opts)
			require("mini.diff").setup(opts)
			vim.keymap.set("n", "<leader>gdo", MiniDiff.toggle_overlay, { desc = "MiniDiff toggle overlay" })
			vim.keymap.set("n", "<leader>gdf", MiniDiff.toggle_overlay, { desc = "MiniDiff show overlay" })
			vim.keymap.set("n", "<leader>gh", function()
				vim.fn.setqflist(MiniDiff.export("qf"))
			end, { desc = "Export Hunks to Quickfix" })
		end,
	},
	{
		"mini.jump",
		dev = true,
		config = function()
			require("mini.jump").setup()
		end,
		keys = {
			{ "F", desc = "Jump to previous occurrence" },
			{ "f", desc = "Jump to next occurrence" },
			{ "T", desc = "Jump till previous occurrence" },
			{ "t", desc = "Jump till next occurrence" },
		},
	},
	{
		"mini.hipatterns",
		dev = true,
		event = { "BufWritePre", "BufReadPost", "BufNewFile" },
		opts = {
			highlighters = {
				fixme = { pattern = "FIXME", group = "MiniHipatternsFixme" },
				hack = { pattern = "HACK", group = "MiniHipatternsHack" },
				todo = { pattern = "TODO", group = "MiniHipatternsTodo" },
				note = { pattern = "NOTE", group = "MiniHipatternsNote" },
			},
		},
		config = function(_, opts)
			require("mini.hipatterns").setup(opts)
		end,
	},
	{
		"mini.surround",
		dev = true,
		opts = {
			highlight_duration = 500,
			mappings = {
				add = "sa", -- Add surrounding in Normal and Visual modes
				delete = "sd", -- Delete surrounding
				find = "sf", -- Find surrounding (to the right)
				find_left = "sF", -- Find surrounding (to the left)
				highlight = "sh", -- Highlight surrounding
				replace = "sr", -- Replace surrounding
				update_n_lines = "sn", -- Update `n_lines`

				suffix_last = "l", -- Suffix to search with "prev" method
				suffix_next = "n", -- Suffix to search with "next" method
			},
			search_method = "cover_or_next",
		},
		config = function(_, opts)
			require("mini.surround").setup(opts)
		end,
		keys = {
			{ mode = "n", "sa", desc = "Add surrounding" }, -- Add surrounding in Normal and Visual modes
			{ mode = "n", "sd", desc = "Delete surrounding" }, -- Delete surrounding
			{ mode = "n", "sf", desc = "Find surrounding" }, -- Find surrounding (to the right)
			{ mode = "n", "sF", desc = "Find surrounding (left)" }, -- Find surrounding (to the left)
			{ mode = "n", "sh", desc = "Highlight surrounding" }, -- Highlight surrounding
			{ mode = "n", "sr", desc = "Replace surrounding" }, -- Replace surrounding
			{ mode = "n", "sn", desc = "Update search lines" }, -- Update `n_lines`
		},
	},
	{
		"mini.move",
		dev = true,
		opts = {
			mappings = {
				left = "H",
				right = "L",
				line_left = "H",
				down = "J",
				up = "K",
			},
		},
		config = function(_, opts)
			require("mini.move").setup(opts)
		end,
		keys = {
			{ mode = "v", "H" },
			{ mode = "v", "L" },
			{ mode = "v", "J" },
			{ mode = "v", "K" },
		},
	},
	{
		"mini.base16",
		dev = true,
		lazy = false,
		config = function()
			local ok, _ = pcall(require, "mini.base16")
			vim.cmd.hi("clear")
			local p = {
				base00 = "#181818",
				base01 = "#282828",
				base02 = "#383838",
				base03 = "#585858",
				base04 = "#b8b8b8",
				base05 = "#d8d8d8",
				base06 = "#e8e8e8",
				base07 = "#f8f8f8",
				base08 = "#ab4642",
				base09 = "#dc9656",
				base0A = "#f7ca88",
				base0B = "#a1b56c",
				base0C = "#86c1b9",
				base0D = "#7cafc2",
				base0E = "#ba8baf",
				base0F = "#a16946",
			}

			local function apply()
				vim.cmd.hi("clear")
				require("mini.base16").setup({ palette = p })
				local hls = {
					Delimiter = { fg = p.base05 },
					Special = { fg = p.base0A },
					Charcter = { fg = p.base09 },
					["@lsp.type.variable"] = { fg = p.base06 },
					Identifier = { fg = "#DE8452" },
					["@lsp.mod.global"] = { fg = p.base08 },
					StatusLine = { bg = p.base01, fg = p.base04 },
					CursorLineNr = { fg = p.base04, bold = true, bg = p.base01 },
					["@markup.heading.1.markdown"] = { fg = p.base08 },
					["@markup.heading.2.markdown"] = { fg = p.base09 },
					["@markup.heading.3.markdown"] = { fg = p.base0A },
					["@markup.heading.4.markdown"] = { fg = p.base0B },
					["@markup.heading.5.markdown"] = { fg = p.pase0B },
					["@markup.heading.6.markdown"] = { fg = p.base0C },
					RenderMarkdownH1 = { fg = p.base08 },
					RenderMarkdownH2 = { fg = p.base09 },
					RenderMarkdownH3 = { fg = p.base0A },
					RenderMarkdownH4 = { fg = p.base0B },
					RenderMarkdownH5 = { fg = p.pase0B },
					RenderMarkdownH6 = { fg = p.base0C },
					-- RenderMarkdownH1Bg = { fg = p.base08, bg = p.base01 },
					-- RenderMarkdownH2Bg = { fg = p.base09, bg = p.base01 },
					-- RenderMarkdownH3Bg = { fg = p.base0A, bg = p.base01 },
					-- RenderMarkdownH4Bg = { fg = p.base0B, bg = p.base01 },
					-- RenderMarkdownH5Bg = { fg = p.base0C, bg = p.base01 },
					-- RenderMarkdownH6Bg = { fg = p.baseOD, bg = p.base01 },
				}

				for k, v in pairs(hls) do
					vim.api.nvim_set_hl(0, k, v)
				end
				vim.api.nvim_exec_autocmds("Colorscheme", { modeline = false })
				vim.g.colors_name = "default_dark"
			end

			if not ok then
				vim.api.nvim_create_autocmd("User", {
					pattern = "VeryLazy",
					once = true,
					callback = function()
						apply()
						return true
					end,
				})
			else
				apply()
			end
		end,
	},
	{
		"mini.completion",
		dev = true,
		event = "InsertEnter",
		config = function()
			local imap_expr = function(lhs, rhs)
				vim.keymap.set("i", lhs, rhs, { expr = true })
			end
			imap_expr("<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]])
			imap_expr("<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]])

			require("mini.completion").setup({
				delay = { completion = 100, info = 100, signature = 50 },
			})
		end,
	},
}
