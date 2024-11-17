return {
	{
		"echasnovski/mini.nvim",
		lazy = true,
	},
	{
		"mini.misc",
		dev = true,
		event = "VeryLazy",
		config = function()
			require("mini.misc").setup()
			MiniMisc.setup_auto_root({
				".git",
				"Makefile",
				"justfile",
			})
		end,
	},
	{
		"mini.pick",
		dev = true,
		init = function()
			vim.ui.select = require("mini.pick").ui_select
		end,
		opts = {
			mappings = {
				paste = "<C-y>",
				refine = "<C-Space>",
				refine_marked = "<C-r>",
				choose_marked = "<C-q>",
			},
			window = {
				-- prompt_cursor = "█",
				config = function()
					--- Center Float
					-- local height = math.floor(0.618 * vim.o.lines)
					-- local width = math.floor(0.618 * vim.o.columns)
					-- return {
					-- 	anchor = "NW",
					-- 	height = height,
					-- 	width = width,
					-- 	row = math.floor(0.5 * (vim.o.lines - height)),
					-- 	col = math.floor(0.5 * (vim.o.columns - width)),
					-- }

					--- Ivy Style
					local height = math.floor(0.5 * vim.o.lines)
					local width = math.floor(vim.o.columns)
					return {
						anchor = "NW",
						height = height,
						width = width,
						row = vim.o.lines,
					}
				end,
			},
		},
		config = function(_, opts)
			require("mini.pick").setup(opts)
		end,
		keys = {
			{
				"<C-p>",
				"<cmd>Pick files<cr>",
        desc = "Find files",
			},
			{
				"<leader>f",
				"<cmd>Pick files<cr>",
        desc = "Find files",
			},
			{
				"<leader>,",
				"<cmd>Pick buffers<cr>",
				desc = "Find Buffer",
			},
			{
				"<C-F>",
				"<cmd>Pick grep_live<cr>",
				desc = "Grep live",
			},
			{
				"<C-x>h",
				"<cmd>Pick help<cr>",
				desc = "Help tags",
			},
			{
				"<leader>gw",
				"<cmd>Pick grep<cr>",
				desc = "Grep word",
			},
			{
				"<leader>\\",
				"<cmd>Pick buf_lines<cr>",
				desc = "Find line",
			},
			{
				"<C-x>i",
				function()
					require("mini.extra").pickers.hl_groups()
				end,
				desc = "Find highlights",
			},
			{
				"<C-x>m",
				function()
					require("mini.extra").pickers.marks()
				end,
				desc = "Find marks",
			},
			{
				"<leader>of",
				"<cmd>Pick oldfiles<cr>",
				desc = "Old files (cwd)",
			},
			{
				"<C-x><C-f>",
				function()
					require("mini.extra").pickers.explorer()
				end,
				desc = "File explorer",
			},
			{
				"<leader>pn",
				function()
					require("mini.extra").pickers.hipatterns({
						highlighters = { "note", "fixme", "hack", "todo" },
					})
				end,
				desc = "Find notes",
			},
			{
				"z=",
				function()
					require("mini.extra").pickers.spellsuggest()
				end,
				desc = "Spell Suggest",
			},
		},
	},
	{
		"mini.splitjoin",
		dev = true,
		config = true,
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
					i = require("mini.extra").gen_ai_spec.indent(),
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
		keys = {
			{
				"<leader>gdo",
				function()
					MiniDiff.toggle_overlay()
				end,
				desc = "MiniDiff toggle overlay",
			},
			{
				"<leader>gdf",
				function()
					MiniDiff.toggle_overlay()
				end,
				desc = "MiniDiff show overlay",
			},
			{
				"<leader>ghq",
				function()
					vim.fn.setqflist(MiniDiff.export("qf"))
				end,
				desc = "Export Hunks to Quickfix",
			},
		},
	},
	{
		"mini.jump",
		dev = true,
		config = true,
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
		config = function()
			require("mini.hipatterns").setup({
				highlighters = {
					-- fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme"},
					-- hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack"},
					-- todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo"},
					-- note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote"},
					fixme = { pattern = "() FIXME():", group = "MiniHipatternsFixme" },
					hack = { pattern = "() HACK():", group = "MiniHipatternsHack" },
					todo = { pattern = "() TODO():", group = "MiniHipatternsTodo" },
					note = { pattern = "() NOTE():", group = "MiniHipatternsNote" },
					fixme_colon = { pattern = " FIXME():()", group = "MiniHipatternsFixmeColon" },
					hack_colon = { pattern = " HACK():()", group = "MiniHipatternsHackColon" },
					todo_colon = { pattern = " TODO():()", group = "MiniHipatternsTodoColon" },
					note_colon = { pattern = " NOTE():()", group = "MiniHipatternsNoteColon" },
					fixme_body = { pattern = " FIXME:().*()", group = "MiniHipatternsFixmeBody" },
					hack_body = { pattern = " HACK:().*()", group = "MiniHipatternsHackBody" },
					todo_body = { pattern = " TODO:().*()", group = "MiniHipatternsTodoBody" },
					note_body = { pattern = " NOTE:().*()", group = "MiniHipatternsNoteBody" },
					-- fixme = { pattern = "FIXME", group = "MiniHipatternsFixme" },
					-- hack = { pattern = "HACK", group = "MiniHipatternsHack" },
					-- todo = { pattern = "TODO", group = "MiniHipatternsTodo" },
					-- note = { pattern = "NOTE", group = "MiniHipatternsNote" },
					hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
				},
			})
			local function gen_colors()
				for _, v in ipairs({ "Fixme", "Hack", "Todo", "Note" }) do
					local basename = "MiniHipatterns" .. v
					local hl = vim.api.nvim_get_hl(0, { name = basename })
					if not hl.bg then
						vim.api.nvim_set_hl(0, basename .. "Body", { link = basename })
						vim.api.nvim_set_hl(0, basename .. "Colon", { link = basename })
					else
						vim.api.nvim_set_hl(0, basename .. "Colon", { fg = hl.bg, bg = hl.bg })
						vim.api.nvim_set_hl(0, basename .. "Body", { fg = hl.bg })
					end
				end
			end
			gen_colors()

			vim.api.nvim_create_autocmd("Colorscheme", {
				callback = gen_colors,
			})
		end,
	},
	{
		"mini.surround",
		dev = true,
		opts = {
			highlight_duration = 500,
			mappings = {
				add = "gsa", -- Add surrounding in Normal and Visual modes
				delete = "gsd", -- Delete surrounding
				find = "gsf", -- Find surrounding (to the right)
				find_left = "gsF", -- Find surrounding (to the left)
				highlight = "gsh", -- Highlight surrounding
				replace = "gsr", -- Replace surrounding
				update_n_lines = "gsn", -- Update `n_lines`

				suffix_last = "", -- Suffix to search with "prev" method
				suffix_next = "", -- Suffix to search with "next" method
			},
			search_method = "cover_or_next",
		},
		keys = {
			{ mode = "n", "gsa", desc = "Add surrounding" }, -- Add surrounding in Normal and Visual modes
			{ mode = "n", "gsd", desc = "Delete surrounding" }, -- Delete surrounding
			{ mode = "n", "gsf", desc = "Find surrounding" }, -- Find surrounding (to the right)
			{ mode = "n", "gsF", desc = "Find surrounding (left)" }, -- Find surrounding (to the left)
			{ mode = "n", "gsh", desc = "Highlight surrounding" }, -- Highlight surrounding
			{ mode = "n", "gsr", desc = "Replace surrounding" }, -- Replace surrounding
			{ mode = "n", "gsn", desc = "Update search lines" }, -- Update `n_lines`
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
		cond = false,
		-- lazy = false,
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
		cond = false,
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
		"mini.files",
		lazy = not (vim.fn.argc() == 1 and vim.fn.argv()[1] == "."),
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
			windows = {
				-- width_focuse = 15,
				-- width_nofocus = 25,
			},
			-- Move stuff to the minifiles trash instead of it being gone forever.
			options = {
				permanent_delete = false,
				use_as_default_explorer = true,
			},
		},
		config = function(_, opts)
			local map_split = function(buf_id, lhs, direction)
				local rhs = function()
					-- Make new window and set it as target
					local cur_target = MiniFiles.get_explorer_state().target_window
					local new_target = vim.api.nvim_win_call(cur_target, function()
						vim.cmd(direction .. " split")
						return vim.api.nvim_get_current_win()
					end)

					vim.schedule(function()
						MiniFiles.set_target_window(new_target)
					end)
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
					vim.wo[win_id].relativenumber = false
					-- vim.api.nvim_win_set_config(args.data.win_id, {
					-- 	border = { " " },
					-- })
				end,
			})

			vim.api.nvim_create_autocmd("User", {
				pattern = "MiniFilesActionRename",
				callback = function(event)
					Snacks.rename.on_rename_file(event.data.from, event.data.to)
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
		"mini.jump2d",
		dev = true,
		opts = {
			-- spotter = nil,
			view = {
				dim = true,
				n_steps_ahead = 100,
			},
			mappings = {
				start_jumping = "<C-s>",
			},
		},
		config = function(_, opts)
			opts = opts or {}

			local function make_ignore_case(word)
				local parts = {}
				for i = 1, word:len() do
					local char = word:sub(i, i)
					if char:find("^%a$") then
						char = "[" .. char:lower() .. char:upper() .. "]"
					else
						char = vim.pesc(char)
					end

					table.insert(parts, char)
				end
				return table.concat(parts)
			end

			-- Produce `opts` which modifies spotter based on user input
			local function user_input_opts(input_fun)
				local res = {
					spotter = function()
						return {}
					end,
					allowed_lines = { blank = false, fold = false },
				}

				res.hooks = {
					before_start = function()
						local input = input_fun()
						if input == nil then
							res.spotter = function()
								return {}
							end
						else
              local pattern = make_ignore_case(input)
							res.spotter = MiniJump2d.gen_pattern_spotter(pattern)
						end
					end,
				}

				return res
			end

			local function n_characters(n)
				return user_input_opts(function()
					local chars = ""
					for i = 1, n do
						chars = chars .. require("utils").getcharstr(i .. " charcter for search")
					end
					return chars
				end)
			end

			-- match beginning of words, punctuation, _, uppercase letters
			opts.spotter = require("mini.jump2d").gen_pattern_spotter("[^%s%p%u]+")
			require("mini.jump2d").setup(opts)

			local leap = n_characters(2)
			vim.keymap.set("n", "s", function()
				MiniJump2d.start(leap)
			end)
		end,
		keys = {
			"<C-s>",
			"s",
		},
	},
	{
		"mini.icons",
		dev = true,
		lazy = true,
		init = function()
			package.preload["nvim-web-devicons"] = function()
				require("mini.icons").mock_nvim_web_devicons()
				return package.loaded["nvim-web-devicons"]
			end
		end,
		-- config = function()
		-- 	require("mini.icons").setup()
		-- 	require("mini.icons").mock_nvim_web_devicons()
		--     require("mini.icons").tweak_lsp_kind()
		-- end,
	},
	{
		"mini.align",
		dev = true,
		config = function()
			require("mini.align").setup()
		end,
		keys = {
			{ mode = { "x", "v" }, "ga" },
		},
	},
	-- {
	-- 	"mini.statusline",
	-- 	dev = true,
	-- 	event = { "BufWritePre", "BufReadPost", "BufNewFile" },
	-- 	opts = {
	-- 		content = {
	-- 			active = function()
	-- 				local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 70 })
	-- 				local git = MiniStatusline.section_git({ trunc_width = 40 })
	-- 				local diff = MiniStatusline.section_diff({ trunc_width = 75 })
	-- 				local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
	-- 				local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
	-- 				local filename = MiniStatusline.section_filename({ trunc_width = 140 })
	-- 				local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
	-- 				local location = MiniStatusline.section_location({ trunc_width = 75 })
	-- 				local search = MiniStatusline.section_searchcount({ trunc_width = 75 })
	--
	-- 				return MiniStatusline.combine_groups({
	-- 					{ hl = mode_hl, strings = { mode } },
	-- 					{ hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics, lsp } },
	-- 					"%<", -- Mark general truncate point
	-- 					{ hl = "MiniStatuslineFilename", strings = { filename } },
	-- 					"%=", -- End left alignment
	-- 					{ hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
	-- 					{ hl = mode_hl, strings = { search, location } },
	-- 				})
	-- 			end,
	-- 		},
	-- 	},
	-- },
	{
		"mini.indentscope",
		dev = true,
		event = { "BufWritePre", "BufReadPost", "BufNewFile" },
		opts = {
			options = {
				try_as_border = true,
			},
		},
	},
	{
		"mini.pairs",
		dev = true,
		event = "InsertEnter",
		opts = {
			modes = { insert = true, command = true, terminal = false },
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
			-- FROM: https://github.com/LazyVim/LazyVim/blob/f11890bf99477898f9c003502397786026ba4287/lua/lazyvim/util/mini.lua#L123-L168
			local pairs = require("mini.pairs")
			pairs.setup(opts)
			local open = pairs.open
			pairs.open = function(pair, neigh_pattern)
				if vim.fn.getcmdline() ~= "" then
					return open(pair, neigh_pattern)
				end
				local o, c = pair:sub(1, 1), pair:sub(2, 2)
				local line = vim.api.nvim_get_current_line()
				local cursor = vim.api.nvim_win_get_cursor(0)
				local next = line:sub(cursor[2] + 1, cursor[2] + 1)
				local before = line:sub(1, cursor[2])
				if opts.markdown and o == "`" and vim.bo.filetype == "markdown" and before:match("^%s*``") then
					return "`\n```" .. vim.api.nvim_replace_termcodes("<up>", true, true, true)
				end
				if opts.skip_next and next ~= "" and next:match(opts.skip_next) then
					return o
				end
				if opts.skip_ts and #opts.skip_ts > 0 then
					local ok, captures =
						pcall(vim.treesitter.get_captures_at_pos, 0, cursor[1] - 1, math.max(cursor[2] - 1, 0))
					for _, capture in ipairs(ok and captures or {}) do
						if vim.tbl_contains(opts.skip_ts, capture.capture) then
							return o
						end
					end
				end
				if opts.skip_unbalanced and next == c and c ~= o then
					local _, count_open = line:gsub(vim.pesc(pair:sub(1, 1)), "")
					local _, count_close = line:gsub(vim.pesc(pair:sub(2, 2)), "")
					if count_close > count_open then
						return o
					end
				end
				return open(pair, neigh_pattern)
			end
		end,
	},
	{
		"mini.bracketed",
		dev = true,
		opts = {
			indent = { suffix = "" },
		},
		keys = {
			"[",
			"]",
		},
	},
}
