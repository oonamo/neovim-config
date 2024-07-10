return {
	{
		"nvim-telescope/telescope.nvim",
		lazy = true,
		branch = "0.1.x",
		-- tag = "0.1.6",
		-- or                              , branch = '0.1.x',
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
			},
		},
		opts = function()
			local actions = require("telescope.actions")
			local layout = require("telescope.actions.layout")
			local defaults = require("telescope.themes").get_ivy({
				layout_config = { height = 0.30 },
				prompt_prefix = "  ", -- ❯  
				selection_caret = "▍ ",
				multi_icon = " ",
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
				{
					"z=",
					builtin.spell_suggest,
					desc = "find from current buffer",
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
		"nvim-pack/nvim-spectre",
		config = true,
		keys = function()
			local spectre = require("spectre")
			return {
				{
					"<leader>S",
					spectre.toggle,
					desc = "Toggle Spectre",
				},
				{
					"<leader>sw",
					function()
						spectre.open_visual({ select_word = true })
					end,
					desc = "Search current word",
				},
				{
					mode = "v",
					"<leader>sw",
					spectre.open_visual,
					desc = "Search current word",
				},
				{
					"<leader>sp",
					function()
						spectre.open_file_search({ select_word = true })
					end,
					desc = "Search current word",
				},
			}
		end,
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
						init_selection = "<CR>",
						node_incremental = "<CR>",
						scope_incremental = false,
						node_decremental = "<BS>",
					},
				},
			})
		end,
	},
	{
		dir = "~/projects/command_pal",
		dev = true,
		opts = {
			actions = {
				{
					group = "Writing",
					name = "Go To My Notes",
					command = "GoToNotes",
					desc = "Open my notes using mini.sessions",
				},
				{
					group = "Harpoon",
					name = "Add File to Harpoon",
					command = function()
						require("harpoon"):list():add()
					end,
					desc = "append file to harpoon",
				},
			},
			builtin = {},
			telescope = {
				opts = {},
			},
		},
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
						filter_group = { "Vim", "Quickfix" },
					})
				end,
			},
			{
				"<leader>pp",
				function()
					require("command_pal").open({
						picker = "mini_pick",
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
}
