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
					F = require("mini.ai").gen_spec.argument({ brackets = { "%b()" } }),
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
	{
		"mini.statusline",
		dev = true,
		event = { "BufWritePre", "BufReadPost", "BufNewFile" },
		config = function()
			require("mini.statusline").setup({
				use_icons = true,
			})
		end,
	},
	{
		"mini.files",
		dev = true,
		opts = {
			mappings = {
				go_in_plus = "<cr>",
				go_out_plus = "<tab>",
				close = "q",
				go_in = "L",
				go_out = "H",
				reset = "<BS>",
				reveal_cwd = "@",
				show_help = "g?",
				synchronize = "=",
				trim_left = "<",
				trim_right = ">",
			},
			content = {
				prevfix = function() end,
				filter = function(entry)
					return entry.fs_type ~= "file" or entry.name ~= ".DS_Store"
				end,
				sort = function(entries)
					local function compare_alphanumerically(e1, e2)
						-- Put directories first.
						if e1.is_dir and not e2.is_dir then
							return true
						end
						if not e1.is_dir and e2.is_dir then
							return false
						end
						-- Order numerically based on digits if the text before them is equal.
						if e1.pre_digits == e2.pre_digits and e1.digits ~= nil and e2.digits ~= nil then
							return e1.digits < e2.digits
						end
						-- Otherwise order alphabetically ignoring case.
						return e1.lower_name < e2.lower_name
					end

					local sorted = vim.tbl_map(function(entry)
						local pre_digits, digits = entry.name:match("^(%D*)(%d+)")
						if digits ~= nil then
							digits = tonumber(digits)
						end

						return {
							fs_type = entry.fs_type,
							name = entry.name,
							path = entry.path,
							lower_name = entry.name:lower(),
							is_dir = entry.fs_type == "directory",
							pre_digits = pre_digits,
							digits = digits,
						}
					end, entries)
					table.sort(sorted, compare_alphanumerically)
					-- Keep only the necessary fields.
					return vim.tbl_map(function(x)
						return { name = x.name, fs_type = x.fs_type, path = x.path }
					end, sorted)
				end,
			},
			windows = { width_nofocus = 25 },
			-- Move stuff to the minifiles trash instead of it being gone forever.
			options = {
				permanent_delete = false,
				use_as_default_explorer = true,
			},
		},
		config = function(_, opts)
			local function map_split(buf_id, lhs, direction)
				local minifiles = require("mini.files")
				local function rhs()
					local window = minifiles.get_target_window()

					-- Noop if the explorer isn't open or the cursor is on a directory.
					if window == nil or minifiles.get_fs_entry().fs_type == "directory" then
						return
					end

					local new_target_window
					vim.api.nvim_win_call(window, function()
						vim.cmd(direction .. " split")
						new_target_window = vim.api.nvim_get_current_win()
					end)

					minifiles.set_target_window(new_target_window)

					-- Go in and close the explorer.
					minifiles.go_in({ close_on_file = true })
				end

				vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = "Split " .. string.sub(direction, 12) })
			end

			require("mini.files").setup(opts)

			vim.api.nvim_create_autocmd("User", {
				desc = "Add minifiles split keymaps and options",
				pattern = "MiniFilesBufferCreate",
				callback = function(args)
					local buf_id = args.data.buf_id
					map_split(buf_id, "<C-s>", "belowright horizontal")
					map_split(buf_id, "<C-v>", "belowright vertical")
				end,
			})

			vim.api.nvim_create_autocmd("User", {
				desc = "Add minifiles split keymaps and options",
				pattern = "MiniFilesWindowOpen",
				callback = function(args)
					local win_id = args.data.win_id
					vim.wo[win_id].winbar = ""
				end,
			})
		end,
		keys = {
			{
				"<leader>e",
				function()
					require("mini.files").open()
				end,
				desc = "MiniFiles (CWD)",
			},
			{
				"-",
				function()
					local bufname = vim.api.nvim_buf_get_name(0)
					local path = vim.fn.fnamemodify(bufname, ":p")

					-- Noop if the buffer isn't valid.
					if path and vim.uv.fs_stat(path) then
						require("mini.files").open(bufname, false)
					end
				end,
				desc = "MiniFiles (BufDir)",
			},
		},
	},
	{
		"mini.pairs",
		event = "InsertEnter",
		dev = true,
		opts = {
			modes = { insert = true, command = false, terminal = false },
			-- skip autopair when next character is one of these
			skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
			-- skip autopair when the cursor is inside these treesitter nodes
			skip_ts = { "string" },
			-- skip autopair when next character is closing pair
			-- and there are more closing pairs than opening pairs
			skip_unbalanced = true,
			-- better deal with markdown code blocks
			markdown = true,
		},
		config = function(_, opts)
			require("mini.pairs").setup(opts)
		end,
	},
}
