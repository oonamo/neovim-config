return {
	{ "nvim-lua/plenary.nvim" },
	{
		"nvim-telescope/telescope.nvim",
		lazy = true,
		branch = "0.1.x",
		cmd = "Telescope",
		-- tag = "0.1.6",
		-- or                              , branch = '0.1.x',
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
			},
			"nvim-telescope/telescope-ui-select.nvim",
			{
				"nvim-telescope/telescope-file-browser.nvim",
				dir = "~/projects/nvim/telescope-file-browser.nvim",
				dev = true,
			},
			"nvim-telescope/telescope-frecency.nvim",
		},
		opts = function()
			local actions = require("telescope.actions")
			local layout = require("telescope.actions.layout")
			local defaults = require("telescope.themes").get_ivy({
				layout_config = { height = 0.30 },
				prompt_prefix = "  ", -- ❯  
				pickers = {
					lsp_references = {
						show_line = false,
					},
				},
				selection_caret = "▍ ",
				multi_icon = " ",
				disable_devicons = true,
				border = false,

				-- color_devicons = false,
				vimgrep_arguments = {
					"rg",
					"-L",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
				},

				preview = {
					hide_on_startup = true,
				},

				mappings = {
					n = {
						["<ESC>"] = actions.close,
						["<C-c>"] = actions.close,
						["<C-y>"] = layout.toggle_preview,
					},
					i = {
						["<C-y>"] = layout.toggle_preview,
					},
				},
			})
			return {
				defaults = defaults,
				extensions = {
					fzf = {
						fuzzy = false, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
						-- the default case_mode is "smart_case"
						hidden = true,
					},
					file_browser = {
						quiet = true,
						hidden = {
							file_browser = true,
							folder_browse = true,
						},
					},
				},
			}
		end,
		config = function(_, opts)
			require("telescope").setup(opts)
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("frecency")
			require("telescope").load_extension("ui-select")
			require("telescope").load_extension("file_browser")
		end,
		keys = function()
			return {
				{
					"<leader>,",
					"<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
					desc = "Switch Buffer",
				},
				{
					"<C-P>",
					function()
						require("telescope.builtin").find_files()
					end,
					desc = "find files",
				},
				{
					"<C-F>",
					function()
						require("telescope.builtin").live_grep()
					end,
					desc = "grep live",
				},
				{
					"<leader>fh",
					function()
						require("telescope.builtin").help_tags()
					end,
					desc = "help tags",
				},
				{
					"<leader>gw",
					function()
						require("telescope.builtin").grep_string()
					end,
					desc = "grep word",
				},
				{
					"<leader>gw",
					function()
						require("telescope.builtin").grep_string()
					end,
					desc = "grep word",
				},
				{
					"<leader>\\",
					function()
						require("telescope.builtin").current_buffer_fuzzy_find()
					end,
					desc = "find from current buffer",
				},
				{
					"z=",
					function()
						require("telescope.builtin").spell_suggest()
					end,
					desc = "Suggest spelling",
				},
				{
					"<leader>fe",
					function()
						require("telescope.builtin").find_files({
							prompt_title = "Open in Mini.Files",
							find_command = {
								"fd",
								"--type",
								"d",
								".",
								vim.uv.cwd(),
							},
							attach_mappings = function(_, map)
								local state = require("telescope.actions.state")
								local actions = require("telescope.actions")
								map("i", "<CR>", function(prompt_buffer)
									local content = state.get_selected_entry()
									actions.close(prompt_buffer)
									local dir = content.value
									require("mini.files").open(dir, false)
								end)
								return true
							end,
						})
					end,
					desc = "Open dir in mini files",
				},
				{
					"<leader>fi",
					function()
						require("telescope.builtin").highlights()
					end,
					desc = "highlights",
				},
				{
					"<leader>fm",
					function()
						require("telescope.builtin").marks()
					end,
					desc = "marks",
				},
				{
					"<leader>ss",
					"<cmd>Telescope aerial<cr>",
					desc = "Goto Symbol (aerial)",
				},
				{
					"<leader>gb",
					"<cmd>Telescope buffers<cr>",
					desc = "Find Buffers",
				},
				{
					"<C-x><C-f>",
					function()
						require("telescope").extensions.file_browser.file_browser()
					end,
					desc = "Open File Browser",
				},
				{
					"<leader>of",
					"<cmd>Telescope frecency workspace=CWD<cr>",
					desc = "Old files (cwd)",
				},
				{
					"<leader>oF",
					"<cmd>Telescope frecency<cr>",
					desc = "Old files",
				},
			}
		end,
	},
	{
		"MagicDuck/grug-far.nvim",
		config = true,
		keys = {
			{
				"<leader>S",
				function()
					require("grug-far").grug_far({})
				end,
				desc = "Search whole project",
			},
			{
				"<leader>sw",
				function()
					require("grug-far").grug_far({
						prefills = { search = vim.fn.expand("<cword>") },
					})
				end,
				desc = "Search whole project using <cword>",
			},
			{
				"<leader>sf",
				function()
					require("grug-far").grug_far({ prefills = { flags = vim.fn.expand("%") } })
				end,
				desc = "Search current file",
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			event = "VeryLazy",
		},
		lazy = vim.fn.argc(-1) == 0,
		build = function()
			vim.cmd("TSUpdate")
		end,
		init = function(plugin)
			require("lazy.core.loader").add_to_rtp(plugin)
			require("nvim-treesitter.query_predicates")
		end,
		event = { "LazyFile", "VeryLazy" },
		config = function()
			require("nvim-treesitter.query_predicates")
			local config = require("nvim-treesitter.configs")
			config.setup({
				ensure_installed = {
					"lua",
					"javascript",
					"c",
					"norg",
					"rust",
					"vim",
					"vimdoc",
					"markdown",
					"markdown_inline",
					"latex",
					"org",
				},
				auto_install = true,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				indent = {
					enable = true,
					disable = function(_, buf)
						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							return true
						end
					end,
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-i>",
						node_incremental = "<CR>",
						scope_incremental = false,
						node_decremental = "<BS>",
					},
				},
				textobjects = {
					move = {
						enable = true,
						goto_next_start = {
							["]f"] = "@function.outer",
							["]c"] = "@class.outer",
							["]a"] = "@parameter.inner",
						},
						goto_next_end = {
							["]F"] = "@function.outer",
							["]C"] = "@class.outer",
							["]A"] = "@parameter.inner",
						},
						goto_previous_start = {
							["[f"] = "@function.outer",
							["[c"] = "@class.outer",
							["[a"] = "@parameter.inner",
						},
						goto_previous_end = {
							["[F"] = "@function.outer",
							["[C"] = "@class.outer",
							["[A"] = "@parameter.inner",
						},
					},
				},
			})
		end,
	},
	{
		dir = "~/projects/command_pal",
		dev = true,
		opts = function()
			local utils = require("command_pal.utils")
			return {
				actions = {
					{
						group = "Colorscheme",
						name = "toggle-lightness",
						desc = "Toggle the background of neovim. Some plugins may not have an autocommand to detect this change",
						command = function()
							vim.o.bg = vim.o.bg == "light" and "dark" or "light"
						end,
					},
					{
						group = "Format",
						name = "toggle-auto-format",
						desc = "Toggle formatting on save with conform. Useful for new repos without a formatting file",
						command = function()
							vim.g.disable_autoformat = not vim.g.disable_autoformat
						end,
					},
					{
						group = "Lua",
						name = "lua-set-global",
						desc = "Quickly set a global in the nvim cmdline",
						command = utils.set_cmdline(":lua vim.g."),
					},
					{
						group = "Lua",
						name = "lua-set-option",
						desc = "Quickly set an option in the nvim cmdline",
						command = utils.set_cmdline(":lua vim.opt."),
					},
					{
						group = "Statusline",
						name = "statusline-toggle-ruler",
						desc = "Set Ruler into statusline",
						command = function()
							vim.g.enable_ruler = not vim.g.enable_ruler
						end,
					},
					{
						group = "Overseer",
						name = "overseer-compile-file",
						desc = "Use Overseer to compile",
						command = function()
							local compilers = {
								["c"] = "gcc -Wall -pedantic %f.c -o tmp -std=c99 && ./tmp",
								["cpp"] = "g++ -Wall -pedantic %f.cpp -o tmp && ./tmp",
								["lua"] = function(file)
									if file then
										vim.notify("sourcing file " .. file .. "...")
										vim.cmd("so " .. file)
									end
								end,
							}
							require("overseer").new_task({
								cmd = compilers[vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":e")],
							})
						end,
					},
				},
				builtin = {},
				telescope = {
					opts = {},
				},
			}
		end,
		keys = {
			{
				"<A-x>",
				function()
					require("command_pal").open({})
				end,
				desc = "Command Pal",
			},
			{
				"<leader>fp",
				function()
					require("command_pal").open({
						filter_group = { "Vim", "Quickfix", "User" },
					})
				end,
				desc = "Find Vim, QF, User commands",
			},
			{
				"<leader>pp",
				function()
					require("command_pal").open({
						picker = "mini_pick",
						mini_pick = {
							ivy_style = true,
						},
					})
				end,
				desc = "MiniPick command pal",
			},
			{
				"<leader>pi",
				function()
					require("command_pal").open({
						picker = "mini_pick",
						mini_pick = {
							ivy_style = true,
						},
					})
				end,
				desc = "Ivy Style command_pal",
			},
			{
				"<leader>pf",
				function()
					require("command_pal").open({
						picker = "fzf-lua",
					})
				end,
				desc = "Fzf-lua file",
			},
		},
	},
	-- {
	-- 	"oonamo/everyones-jk.nvim",
	-- 	dir = "~/projects/everyone-is-jk",
	-- 	dev = true,
	-- 	keys = {
	-- 		{ "[" },
	-- 		{ "]" },
	-- 	},
	-- 	opts = {
	-- 		use_recommended = true,
	-- 		j = "J",
	-- 		k = "K",
	-- 		keys = {
	-- 			{
	-- 				"Markdown",
	-- 				j = {
	-- 					"]m",
	-- 					[[/^##\+\s.*$]],
	-- 				},
	-- 				k = {
	-- 					"[m",
	-- 					[[?^##\+\s.*$]],
	-- 				},
	-- 			},
	-- 			{
	-- 				"Resize Windows",
	-- 				j = {
	-- 					"]wh",
	-- 					"resize -1",
	-- 				},
	-- 				k = {
	-- 					"[wh",
	-- 					"resize +1",
	-- 				},
	-- 			},
	-- 			{
	-- 				"Resize Windows Vertical",
	-- 				j = {
	-- 					"]wv",
	-- 					"vertical resize -1",
	-- 				},
	-- 				k = {
	-- 					"[wv",
	-- 					"vertical resize +1",
	-- 				},
	-- 			},
	-- 		},
	-- 	},
	-- },
	{
		"rebelot/heirline.nvim",
		-- You can optionally lazy-load heirline on UiEnter
		-- to make sure all required plugins and colorschemes are loaded before setup
		-- event = "UiEnter",
		event = "VeryLazy",
		opts = function()
			return {
				statuscolumn = require("plugins.confs.heirline.statuscolumn"),
				statusline = require("plugins.confs.heirline.statusline"),
			}
		end,
		config = function(_, opts)
			local stl_get_hl = utils.safe_get_hl("StatusLine")
			local stl_get_lualine_hl = utils.gen_safe_lualine_getter("StatusLine")
			local heirline = require("heirline")
			local function get_colors()
				local colors = {
					fg = stl_get_hl("StatusLine", "fg"),
					bg = stl_get_hl("StatusLine", "bg"),
					bright_bg = stl_get_hl("Folded", "bg"),
					bright_fg = stl_get_hl("Folded", "fg"),
					red = stl_get_hl("DiagnosticError", "fg"),
					dark_red = stl_get_hl("DiffDelete", "bg"),
					green = stl_get_hl("String", "fg"),
					blue = stl_get_hl("Function", "fg"),
					gray = stl_get_hl("NonText", "fg"),
					orange = stl_get_hl("Constant", "fg"),
					purple = stl_get_hl("Statement", "fg"),
					cyan = stl_get_hl("Special", "fg"),
					warn = stl_get_hl("DiagnosticWarn", "fg"),
					error = stl_get_hl("DiagnosticError", "fg"),
					hint = stl_get_hl("DiagnosticHint", "fg"),
					info = stl_get_hl("DiagnosticInfo", "fg"),
					del = stl_get_hl("MiniDiffSignDelete", "fg"),
					add = stl_get_hl("MiniDiffSignAdd", "fg"),
					change = stl_get_hl("MiniDiffSignChange", "fg"),
					tabline_bg = stl_get_hl("TabLine", "bg"),
					close_fg = stl_get_hl("Error", "fg"),
					-- fg = get_hl("StatusLine", "fg"),
					-- bg = get_hl("StatusLine", "bg"),
					section_fg = stl_get_hl("StatusLine", "fg"),
					section_bg = stl_get_hl("StatusLine", "bg"),
					git_branch_fg = stl_get_hl("Conditional", "fg"),
					mode_fg = stl_get_hl("StatusLine", "bg"),
					treesitter_fg = stl_get_hl("String", "fg"),
					virtual_env_fg = stl_get_hl("NvimEnvironmentName", "fg"),
					scrollbar = stl_get_hl("TypeDef", "fg"),
					git_added = stl_get_hl("GitSignsAdd", "fg"),
					git_changed = stl_get_hl("GitSignsChange", "fg"),
					git_removed = stl_get_hl("GitSignsDelete", "fg"),
					diag_ERROR = stl_get_hl("DiagnosticError", "fg"),
					diag_WARN = stl_get_hl("DiagnosticWarn", "fg"),
					diag_INFO = stl_get_hl("DiagnosticInfo", "fg"),
					diag_HINT = stl_get_hl("DiagnosticHint", "fg"),
					winbar_fg = stl_get_hl("WinBar", "fg"),
					winbar_bg = stl_get_hl("WinBar", "bg"),
					winbarnc_fg = stl_get_hl("WinBarNC", "fg"),
					winbarnc_bg = stl_get_hl("WinBarNC", "bg"),
					-- tabline_bg = get_hl("TabLineFill", "bg"),
					tabline_fg = stl_get_hl("TabLineFill", "bg"),
					buffer_fg = stl_get_hl("Comment", "fg"),
					buffer_path_fg = stl_get_hl("WinBarNC", "fg"),
					buffer_close_fg = stl_get_hl("Comment", "fg"),
					buffer_bg = stl_get_hl("TabLineFill", "bg"),
					buffer_active_fg = stl_get_hl("Normal", "fg"),
					buffer_active_path_fg = stl_get_hl("WinBarNC", "fg"),
					buffer_active_close_fg = stl_get_hl("Error", "fg"),
					buffer_active_bg = stl_get_hl("Normal", "bg"),
					buffer_visible_fg = stl_get_hl("Normal", "fg"),
					buffer_visible_path_fg = stl_get_hl("WinBarNC", "fg"),
					buffer_visible_close_fg = stl_get_hl("Error", "fg"),
					buffer_visible_bg = stl_get_hl("Normal", "bg"),
					buffer_overflow_fg = stl_get_hl("Comment", "fg"),
					buffer_overflow_bg = stl_get_hl("TabLineFill", "bg"),
					buffer_picker_fg = stl_get_hl("Error", "fg"),
					tab_close_fg = stl_get_hl("Error", "fg"),
					tab_close_bg = stl_get_hl("TabLineFill", "bg"),
					tab_fg = stl_get_hl("TabLine", "fg"),
					tab_bg = stl_get_hl("TabLine", "bg"),
					tab_active_fg = stl_get_hl("TabLineSel", "fg"),
					tab_active_bg = stl_get_hl("TabLineSel", "bg"),
					inactive = stl_get_lualine_hl("inactive"),
					normal = stl_get_lualine_hl("normal"),
					insert = stl_get_lualine_hl("insert"),
					visual = stl_get_lualine_hl("visual"),
					replace = stl_get_lualine_hl("replace"),
					command = stl_get_lualine_hl("command"),
					terminal = stl_get_lualine_hl("terminal"),
				}
				-- Checkings
				for _, section in ipairs({
					"git_branch",
					"file_info",
					"git_diff",
					"diagnostics",
					"lsp",
					"macro_recording",
					"mode",
					"cmd_info",
					"treesitter",
					"nav",
					"virtual_env",
				}) do
					if not colors[section .. "_bg"] then
						colors[section .. "_bg"] = colors["section_bg"]
					end
					if not colors[section .. "_fg"] then
						colors[section .. "_fg"] = colors["section_fg"]
					end
				end
				return colors
			end
			vim.api.nvim_create_augroup("Heirline", { clear = true })
			vim.api.nvim_create_autocmd("ColorScheme", {
				callback = vim.schedule_wrap(function()
					require("heirline.utils").on_colorscheme(get_colors)
				end),
				group = "Heirline",
			})
			local colors = get_colors()
			opts.colors = colors

			heirline.load_colors(colors)
			heirline.setup(opts)
		end,
	},
	{
		"rcarriga/nvim-notify",
		event = "VeryLazy",
		init = function()
			vim.notify = require("notify")
		end,
		opts = {
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
			on_open = function(win)
				vim.api.nvim_win_set_config(win, { zindex = 125 })
				vim.wo[win].conceallevel = 3
				local buf = vim.api.nvim_win_get_buf(win)
				if not pcall(vim.treesitter.start, buf, "markdown") then
					vim.bo[buf].syntax = "markdown"
				end
				vim.wo[win].spell = false
			end,
		},
		keys = {
			{
				"<leader>nd",
				function()
					require("notify").dismiss({ pending = true, silent = true })
				end,
				desc = "Dismiss notification",
			},
		},
	},
	{
		"monkoose/matchparen.nvim",
		event = "LazyFile",
		cmd = {
			"MatchParenDisable",
			"MatchParenEnable",
		},
		opts = {
			on_startup = true, -- Should it be enabled by default
			hl_group = "MatchParen", -- highlight group of the matched brackets
			augroup_name = "matchparen", -- almost no reason to touch this unless there is already augroup with such name
			debounce_time = 150, -- debounce time in milliseconds for rehighlighting of brackets.
		},
	},
	{
		"brenton-leighton/multiple-cursors.nvim",
		version = "*", -- Use the latest tagged version
		opts = {}, -- This causes the plugin setup function to be called
		keys = {
			{ "<leader>j", "<Cmd>MultipleCursorsAddDown<CR>", mode = { "n", "x" }, desc = "Add cursor and move down" },
			{ "<leader>k", "<Cmd>MultipleCursorsAddUp<CR>", mode = { "n", "x" }, desc = "Add cursor and move up" },

			{ "<C-Up>", "<Cmd>MultipleCursorsAddUp<CR>", mode = { "n", "i", "x" }, desc = "Add cursor and move up" },
			{
				"<C-Down>",
				"<Cmd>MultipleCursorsAddDown<CR>",
				mode = { "n", "i", "x" },
				desc = "Add cursor and move down",
			},

			{
				"<C-LeftMouse>",
				"<Cmd>MultipleCursorsMouseAddDelete<CR>",
				mode = { "n", "i" },
				desc = "Add or remove cursor",
			},

			{ "<Leader>m", "<Cmd>MultipleCursorsAddMatches<CR>", mode = { "n", "x" }, desc = "Add cursors to cword" },
			{
				"<Leader>A",
				"<Cmd>MultipleCursorsAddMatchesV<CR>",
				mode = { "n", "x" },
				desc = "Add cursors to cword in previous area",
			},

			{
				"<Leader>d",
				"<Cmd>MultipleCursorsAddJumpNextMatch<CR>",
				mode = { "n", "x" },
				desc = "Add cursor and jump to next cword",
			},
			{ "<Leader>D", "<Cmd>MultipleCursorsJumpNextMatch<CR>", mode = { "n", "x" }, desc = "Jump to next cword" },

			{ "<Leader>lo", "<Cmd>MultipleCursorsLock<CR>", mode = { "n", "x" }, desc = "Lock virtual cursors" },
		},
	},
}
