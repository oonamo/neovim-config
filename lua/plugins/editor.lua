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
			local builtin = require("telescope.builtin")
			return {
				{
					"<C-P>",
					builtin.find_files,
					desc = "find files",
				},
				{
					"<C-F>",
					builtin.live_grep,
					desc = "grep live",
				},
				{
					"<leader>fh",
					builtin.help_tags,
					desc = "help tags",
				},
				{
					"<leader>gw",
					builtin.grep_string,
					desc = "grep word",
				},
				{
					"<leader>gw",
					builtin.grep_string,
					desc = "grep word",
				},
				{
					"<leader>\\",
					builtin.current_buffer_fuzzy_find,
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
					builtin.highlights,
					desc = "highlights",
				},
				{
					"<leader>fm",
					builtin.marks,
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
			},
			{
				"<leader>sw",
				function()
					require("grug-far").grug_far({
						prefills = { search = vim.fn.expand("<cword>") },
					})
				end,
			},
			{
				"<leader>sf",
				function()
					require("grug-far").grug_far({ prefills = { flags = vim.fn.expand("%") } })
				end,
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
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
			})
		end,
	},
	{
		"stevearc/oil.nvim",
		opts = function()
			local type_hlgroups = setmetatable({
				["-"] = "OilTypeFile",
				["dir"] = "OilTypeDir",
				["p"] = "OilTypeFifo",
				["l"] = "OilTypeLink",
				["s"] = "OilTypeSocket",
			}, {
				__index = function()
					return "OilTypeFile"
				end,
			})
			local function oil_sethl()
				local sethl = utils.set_hl_from
				sethl(0, "OilDir", { fg = "Directory" })
				sethl(0, "OilDirIcon", { fg = "Directory" })
				sethl(0, "OilLink", { fg = "Constant" })
				sethl(0, "OilLinkTarget", { fg = "Comment" })
				sethl(0, "OilCopy", { fg = "DiagnosticSignHint", bold = true })
				sethl(0, "OilMove", { fg = "DiagnosticSignWarn", bold = true })
				sethl(0, "OilChange", { fg = "DiagnosticSignWarn", bold = true })
				sethl(0, "OilCreate", { fg = "DiagnosticSignInfo", bold = true })
				sethl(0, "OilDelete", { fg = "DiagnosticSignError", bold = true })
				sethl(0, "OilPermissionNone", { fg = "NonText" })
				sethl(0, "OilPermissionRead", { fg = "DiagnosticSignWarn" })
				sethl(0, "OilPermissionWrite", { fg = "DiagnosticSignError" })
				sethl(0, "OilPermissionExecute", { fg = "DiagnosticSignOk" })
				sethl(0, "OilTypeDir", { fg = "Directory" })
				sethl(0, "OilTypeFifo", { fg = "Special" })
				sethl(0, "OilTypeFile", { fg = "NonText" })
				sethl(0, "OilTypeLink", { fg = "Constant" })
				sethl(0, "OilTypeSocket", { fg = "OilSocket" })
			end
			oil_sethl()

			vim.api.nvim_create_autocmd("ColorScheme", {
				desc = "Set some default hlgroups for oil.",
				group = vim.api.nvim_create_augroup("OilSetDefaultHlgroups", {}),
				callback = oil_sethl,
			})
			return {
				default_file_explorer = true,
				columns = {
					{
						"type",
						highlight = function(type_str)
							return type_hlgroups[type_str]
						end,
					},
					{ "size", highlight = "Special" },
					{ "mtime", highlight = "Number" },
				},
				skip_confirm_for_simple_edits = true,
				keymaps = {
					["<C-p>"] = false,
					["-"] = "actions.parent",
					["H"] = "actions.parent",
					["="] = "actions.select",
					["+"] = "actions.select",
					["<CR>"] = "actions.select",
					["L"] = "actions.select",
					["<C-h>"] = "actions.toggle_hidden",
					["gh"] = "actions.toggle_hidden",
					["gs"] = "actions.change_sort",
					["gx"] = "actions.open_external",
					["gY"] = "actions.copy_entry_filename",
					["<C-c>"] = "actions.close",
					q = "actions.close",
				},
			}
		end,
		keys = {
			{ "<leader>e", "<CMD>Oil<CR>" },
			{ "-", "<CMD>Oil --float<CR>" },
		},
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
										vim.cmd("so " .. file)
									end
								end,
							}
							-- require("overseer").new_task({
							-- 	cmd = compilers[vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":e")],
							-- })
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
							ivy_style = false,
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
			},
		},
	},
	{
		"stevearc/aerial.nvim",
		cmd = "AerialToggle",
		opts = {
			on_attach = function(bufnr)
				vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
				vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
			end,
		},
	},
	{
		"stevearc/quicker.nvim",
		event = "FileType qf",
		opts = {},
	},
	{
		"nacro90/numb.nvim",
		event = "CmdlineEnter",
		opts = {
			show_numbers = true, -- Enable 'number' for the window while peeking
			show_cursorline = true, -- Enable 'cursorline' for the window while peeking
			hide_relativenumbers = true, -- Enable turning off 'relativenumber' for the window while peeking
			number_only = false, -- Peek only when the command is only a number instead of when it starts with a number
			centered_peeking = true, -- Peeked line will be centered relative to window
		},
		-- lazy = false,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
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
	{ "shortcuts/no-neck-pain.nvim", opts = {} },
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
}
