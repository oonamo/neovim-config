return {
	{ "nvim-lua/plenary.nvim" },
	{
		"nvim-telescope/telescope.nvim",
		lazy = true,
		branch = "0.1.x",
		-- tag = "0.1.6",
		-- or                              , branch = '0.1.x',
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },
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
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
						-- the default case_mode is "smart_case"
					},
				},
			}
		end,
		config = function(_, opts)
			require("telescope").setup(opts)
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("ui-select")
		end,
		keys = function()
			return {
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
				-- {
				-- 	"z=",
				-- 	builtin.spell_suggest,
				-- 	desc = "find from current buffer",
				-- },
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
						name = "Toggle-Lightness",
						desc = "Toggle the background of neovim. Some plugins may not have an autocommand to detect this change",
						command = function()
							vim.o.bg = vim.o.bg == "light" and "dark" or "light"
						end,
					},
					{
						group = "Format",
						name = "Toggle-Auto-Format",
						desc = "Toggle formatting on save with conform. Useful for new repos without a formatting file",
						command = function()
							vim.g.disable_autoformat = not vim.g.disable_autoformat
						end,
					},
					{
						group = "Lua",
						name = "Set-Global",
						desc = "Quickly set a global in the nvim cmdline",
						command = utils.set_cmdline(":lua vim.g."),
					},
					{
						group = "Lua",
						name = "Set-Option",
						desc = "Quickly set an option in the nvim cmdline",
						command = utils.set_cmdline(":lua vim.opt."),
					},
					{
						group = "Lua",
						name = "Toggle-Ruler",
						desc = "Set Ruler into statusline",
						command = function()
							vim.g.enable_ruler = not vim.g.enable_ruler
						end,
					},
					{
						group = "Compile",
						name = "Compile file",
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
				"<C-x>",
				function()
					require("command_pal").open({})
				end,
			},
			{
				"<leader>fp",
				function()
					require("command_pal").open({
						filter_group = { "Vim", "Quickfix", "User" },
					})
				end,
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
			},
			{
				"<leader>pf",
				function()
					require("command_pal").open({
						picker = "fzf-lua",
					})
				end,
			},
		},
	},
	{
		"oonamo/everyones-jk.nvim",
		dir = "~/projects/everyone-is-jk",
		dev = true,
		keys = {
			{ "[" },
			{ "]" },
		},
		opts = {
			use_recommended = true,
			j = "J",
			k = "K",
			keys = {
				{
					"Markdown",
					j = {
						"]m",
						[[/^##\+\s.*$]],
					},
					k = {
						"[m",
						[[?^##\+\s.*$]],
					},
				},
				{
					"Resize Windows",
					j = {
						"]wh",
						"resize -1",
					},
					k = {
						"[wh",
						"resize +1",
					},
				},
				{
					"Resize Windows Vertical",
					j = {
						"]wv",
						"vertical resize -1",
					},
					k = {
						"[wv",
						"vertical resize +1",
					},
				},
			},
		},
	},
	{
		"stevearc/quicker.nvim",
		event = "FileType qf",
		opts = {},
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			defaults = {},
			{
				mode = { "n", "v" },
				{ "<leader>f", group = "+Find" },
				{ "<leader>c", group = "+Compile" },
				{ "<leader>g", group = "+Git" },
				{ "<leader>gd", group = "+Diff" },
				{ "<leader>ga", group = "+Add" },
				{ "<leader>v", group = "+Variables" },
				{ "<leader>l", group = "+Location" },
				{ "<leader>L", group = "+Lua" },
				{ "<leader>n", group = "+Namespaces" },
				{ "<leader>p", group = "+Perform" },
				{ "[", group = "prev" },
				{ "]", group = "next" },
				{ "g", group = "goto" },
				{ "s", group = "surround" },
				{ "z", group = "fold" },
				{ "gx", desc = "Open with system app" },
				{
					"<leader>b",
					group = "buffer",
					expand = function()
						return require("which-key.extras").expand.buf()
					end,
				},
				{
					"<leader>w",
					group = "windows",
					proxy = "<c-w>",
					expand = function()
						return require("which-key.extras").expand.win()
					end,
				},
			},
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
	{
		"rebelot/heirline.nvim",
		-- You can optionally lazy-load heirline on UiEnter
		-- to make sure all required plugins and colorschemes are loaded before setup
		-- event = "UiEnter",
		event = "VeryLazy",
		opts = function()
			return require("plugins.confs.heirline")
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
				"<leader>dd",
				function()
					require("notify").dismiss({ pending = true, silent = true })
				end,
				desc = "Dismiss notification",
			},
		},
	},
}
