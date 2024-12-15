return {
	{
		"echasnovski/mini.nvim",
		event = "VeryLazy",
		config = function()
			require("plugins.mini.keymaps")
			package.preload["nvim-web-devicons"] = function()
				require("mini.icons").mock_nvim_web_devicons()
				return package.loaded["nvim-web-devicons"]
			end
			vim.ui.select = require("mini.pick").ui_select
			require("mini.pick").setup({
				mappings = {
					paste = "<C-y>",
					refine = "<C-g>",
					refine_marked = "<C-r>",
					choose_marked = "<C-q>",
				},
				window = {
					-- prompt_prefix = "| ",
					config = function()
						return {
							width = vim.o.columns,
							height = math.floor(vim.o.lines * 0.3),
							border = "none",
						}
					end,
				},
			})
			require("mini.move").setup({
				mappings = {
					left = "H",
					right = "L",
					line_left = "H",
					down = "J",
					up = "K",
				},
			})
			require("mini.operators").setup()
			require("mini.splitjoin").setup()
			require("mini.bracketed").setup()
			require("mini.align").setup()
			-- require("mini.files").setup({
			-- 	go_in_plus = "<cr>",
			-- 	go_out_plus = "<tab>",
			-- 	close = "q",
			-- 	go_in = "L",
			-- 	go_out = "H",
			-- 	reset = "<BS>",
			-- 	reveal_cwd = "@",
			-- 	show_help = "g?",
			-- 	synchronize = "=",
			-- 	trim_left = "<",
			-- 	trim_right = ">",
			-- })
			require("mini.surround").setup({
				highlight_duration = 500,
				mappings = {
					add = "gsa", -- Add surrounding in Normal and Visual modes
					delete = "gsd", -- Delete surrounding
					find = "gsn", -- Find surrounding (to the right)
					find_left = "gsN", -- Find surrounding (to the left)
					highlight = "gsh", -- Highlight surrounding
					replace = "gsr", -- Replace surrounding
					update_n_lines = "", -- Update `n_lines`

					suffix_last = "l", -- Suffix to search with "prev" method
					suffix_next = "n", -- Suffix to search with "next" method
				},
				search_method = "cover_or_next",
			})

			require("mini.hipatterns").setup({
				highlighters = {
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

			require("mini.align").setup()
			require("mini.jump").setup()
			require("mini.diff").setup({
				view = {
					style = "sign",
					signs = { add = "┃", change = "┃", delete = "┃" },
					-- signs = { add = "▍ ", change = "▍ ", delete = " " },
				},
			})
			local ai = require("mini.ai")
			require("mini.ai").setup({
				custom_textobjects = {
					B = require("mini.extra").gen_ai_spec.buffer(),
					i = require("mini.extra").gen_ai_spec.indent(),
					F = ai.gen_spec.argument({ brackets = { "%b()" } }),
					t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
					d = { "%f[%d]%d+" }, -- digits
					e = { -- Word with case
						{
							"%u[%l%d]+%f[^%l%d]",
							"%f[%S][%l%d]+%f[^%l%d]",
							"%f[%P][%l%d]+%f[^%l%d]",
							"^[%l%d]+%f[^%l%d]",
						},
						"^().*()$",
					},
					u = ai.gen_spec.function_call(), -- u for Usage
					U = ai.gen_spec.function_call({ name_pattern = "[%w_" }), -- without dot
				},
			})

			local pairs = require("mini.pairs")
			pairs.setup()
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
				if vim.bo.filetype == "markdown" and before:match("^%s*``") then
					return "`\n```" .. vim.api.nvim_replace_termcodes("<up>", true, true, true)
				end
				if next ~= "" and next:match([=[[%w%%%'%[%"%.%`%$]]=]) then
					return o
				end
				local ok, captures =
					pcall(vim.treesitter.get_captures_at_pos, 0, cursor[1] - 1, math.max(cursor[2] - 1, 0))
				for _, capture in ipairs(ok and captures or {}) do
					if vim.tbl_contains({ "string " }, capture.capture) then
						return o
					end
				end
				if next == c and c ~= o then
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
}
