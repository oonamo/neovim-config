return {
	{
		"nvim-tree/nvim-tree.lua",
		cond = O.ui.tree.nvimtree,
		opts = {
			auto_reload_on_write = false,
			disable_netrw = false,
			hijack_cursor = false,
			hijack_netrw = true,
			hijack_unnamed_buffer_when_opening = false,
			sort_by = "name",
			root_dirs = {},
			prefer_startup_root = false,
			sync_root_with_cwd = true,
			reload_on_bufenter = false,
			respect_buf_cwd = false,
			on_attach = "default",
			select_prompts = false,
			view = {
				adaptive_size = false,
				centralize_selection = true,
				width = 30,
				side = "left",
				preserve_window_proportions = false,
				number = false,
				relativenumber = false,
				signcolumn = "yes",
				float = {
					enable = false,
					quit_on_focus_loss = true,
					open_win_config = {
						relative = "editor",
						border = "rounded",
						width = 30,
						height = 30,
						row = 1,
						col = 1,
					},
				},
			},
			renderer = {
				add_trailing = false,
				group_empty = false,
				highlight_git = true,
				full_name = false,
				highlight_opened_files = "none",
				root_folder_label = ":t",
				indent_width = 2,
				indent_markers = {
					enable = false,
					inline_arrows = true,
					icons = {
						corner = "└",
						edge = "│",
						item = "│",
						none = " ",
					},
				},
				icons = {
					webdev_colors = true,
					git_placement = "before",
					padding = " ",
					symlink_arrow = " ➛ ",
					show = {
						file = true,
						folder = true,
						folder_arrow = true,
						git = false,
					},
					glyphs = {
						default = tools.ui.icons.Text,
						symlink = tools.ui.icons.FileSymlink,
						bookmark = tools.ui.icons.BookMark,
						folder = {
							arrow_closed = tools.ui.icons.TriangleShortArrowRight,
							arrow_open = tools.ui.icons.TriangleShortArrowDown,
							default = tools.ui.icons.Folder,
							open = tools.ui.icons.FolderOpen,
							empty = tools.ui.icons.EmptyFolder,
							empty_open = tools.ui.icons.EmptyFolderOpen,
							symlink = tools.ui.icons.FolderSymlink,
							symlink_open = tools.ui.icons.FolderOpen,
						},
						git = {
							unstaged = tools.ui.icons.FileUnstaged,
							staged = tools.ui.icons.FileStaged,
							unmerged = tools.ui.icons.FileUnmerged,
							renamed = tools.ui.icons.FileRenamed,
							untracked = tools.ui.icons.FileUntracked,
							deleted = tools.ui.icons.FileDeleted,
							ignored = tools.ui.icons.FileIgnored,
						},
					},
				},
				special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
				symlink_destination = true,
			},
			hijack_directories = {
				enable = false,
				auto_open = true,
			},
			update_focused_file = {
				enable = true,
				debounce_delay = 15,
				update_root = true,
				ignore_list = { "fzf", "help", "git" },
				-- ignore_list = {},
			},
			diagnostics = {
				enable = true,
				show_on_dirs = false,
				show_on_open_dirs = true,
				debounce_delay = 50,
				severity = {
					min = vim.diagnostic.severity.HINT,
					max = vim.diagnostic.severity.ERROR,
				},
				-- icons = {
				-- 	hint = tools.ui.lsp_signs[vim.diagnostic.severity.HINT],
				-- 	info = tools.ui.lsp_signs[vim.diagnostic.severity.INFO],
				-- 	warning = tools.ui.lsp_signs[vim.diagnostic.severity.WARN],
				-- 	error = tools.ui.lsp_signs[vim.diagnostic.severity.ERROR],
				-- },
			},
			filters = {
				dotfiles = false,
				git_clean = false,
				no_buffer = false,
				custom = { "node_modules", "\\.cache" },
				exclude = {},
			},
			filesystem_watchers = {
				enable = true,
				debounce_delay = 50,
				ignore_dirs = {},
			},
			git = {
				enable = true,
				ignore = false,
				show_on_dirs = true,
				show_on_open_dirs = true,
				timeout = 200,
			},
			actions = {
				use_system_clipboard = true,
				change_dir = {
					enable = true,
					global = false,
					restrict_above_cwd = false,
				},
				expand_all = {
					max_folder_discovery = 300,
					exclude = {},
				},
				file_popup = {
					open_win_config = {
						col = 1,
						row = 1,
						relative = "cursor",
						border = "shadow",
						style = "minimal",
					},
				},
				open_file = {
					quit_on_open = false,
					resize_window = false,
					window_picker = {
						enable = true,
						picker = "default",
						chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
						exclude = {
							filetype = { "notify", "lazy", "qf", "diff", "fugitive", "fugitiveblame" },
							buftype = { "nofile", "terminal", "help" },
						},
					},
				},
				remove_file = {
					close_window = true,
				},
			},
			trash = {
				cmd = "trash",
				require_confirm = true,
			},
			live_filter = {
				prefix = "[FILTER]: ",
				always_show_folders = true,
			},
			tab = {
				sync = {
					open = false,
					close = false,
					ignore = {},
				},
			},
			notify = {
				threshold = vim.log.levels.INFO,
			},
			log = {
				enable = false,
				truncate = false,
				types = {
					all = false,
					config = false,
					copy_paste = false,
					dev = false,
					diagnostics = false,
					git = false,
					profile = false,
					watcher = false,
				},
			},
			system_open = {
				cmd = nil,
				args = {},
			},
		},
		config = function(_, opts)
			local function on_attach(bufnr)
				local api = require("nvim-tree.api")

				local function desc(message)
					return {
						desc = "nvim-tree: " .. message,
						buffer = bufnr,
						noremap = true,
						silent = true,
						nowait = true,
					}
				end
				local function move_file_to()
					local node = api.tree.get_node_under_cursor()
					local file_src = node["absolute_path"]
					-- The args of input are {prompt}, {default}, {completion}
					-- Read in the new file path using the existing file's path as the baseline.
					local file_out = vim.ui.input("COPY TO: ", file_src, "file")
					-- vim.ui.select("Move to folder: "
					-- Create any parent dirs as required
					local dir = vim.fn.fnamemodify(file_out, ":h")
					vim.fn.system({ "mkdir", "-p", dir })
					-- Copy the file
					vim.fn.system({ "mv", file_src, file_out })
				end
				local function change_root_to_global_cwd()
					local global_cwd = vim.fn.getcwd(-1, -1)
					api.tree.change_root(global_cwd)
				end
				local selected_files = {}
				local function select_file_and_move()
					local node = api.tree.get_node_under_cursor()
					print(node.absolute_path)
					if node.type == "file" then
						table.insert(selected_files, node.absolute_path)
					elseif node.type == "directory" then
						local destination = node.absolute_path
						for _, v in ipairs(selected_files) do
							vim.fn.system({ "mv", v, destination })
						end
						selected_files = {}
					end
				end

				-- default mappings
				api.config.mappings.default_on_attach(bufnr)

				-- custom mappings
				vim.keymap.set("n", "X", move_file_to, desc("Move File To"))
				vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent, desc("Up"))
				vim.keymap.set("n", "?", api.tree.toggle_help, desc("Help"))
				vim.keymap.set("n", "<C-c>", change_root_to_global_cwd, desc("Change Root To Global CWD"))
				vim.keymap.set("n", "M", select_file_and_move, desc("Move file to folder"))
			end
			opts.on_attach = on_attach
			require("nvim-tree").setup(opts)
			-- 			local api = require("nvim-tree.api")
			-- 			local function change_root_to_global_cwd()
			-- 				local global_cwd = vim.fn.getcwd()
			-- 				-- local global_cwd = vim.fn.getcwd(-1, -1)
			-- 				api.tree.change_root(global_cwd)
			-- 			end
			--
			-- 			local hint = [[
			--  _w_: cd cwd   _c_: Path yank           _/_: Filter
			--  _y_: Copy     _x_: Cut                 _p_: Paste
			--  _r_: Rename   _d_: Remove              _n_: New
			--  _._: hidden   _?_: Help
			--  ^
			-- ]]
			-- 			-- ^ ^           _q_: exit
			--
			-- 			local nvim_tree_hydra = nil
			-- 			local nt_au_group = vim.api.nvim_create_augroup("NvimTreeHydraAu", { clear = true })
			--
			-- 			local Hydra = require("hydra")
			-- 			local function spawn_nvim_tree_hydra()
			-- 				nvim_tree_hydra = Hydra({
			-- 					name = "NvimTree",
			-- 					hint = hint,
			-- 					config = {
			-- 						color = "pink",
			-- 						invoke_on_body = true,
			-- 						buffer = 0, -- only for active buffer
			-- 						hint = {
			-- 							position = "bottom",
			-- 							border = "rounded",
			-- 						},
			-- 					},
			-- 					mode = "n",
			-- 					-- body = "H",
			-- 					heads = {
			-- 						{ "w", change_root_to_global_cwd, { silent = true } },
			-- 						{ "c", api.fs.copy.absolute_path, { silent = true } },
			-- 						{ "/", api.live_filter.start, { silent = true } },
			-- 						{ "y", api.fs.copy.node, { silent = true } },
			-- 						{ "x", api.fs.cut, { exit = true, silent = true } },
			-- 						{ "p", api.fs.paste, { exit = true, silent = true } },
			-- 						{ "r", api.fs.rename, { silent = true } },
			-- 						{ "d", api.fs.remove, { silent = true } },
			-- 						{ "n", api.fs.create, { silent = true } },
			-- 						-- { "H", api.tree.collapse_all, { silent = true } },
			-- 						{ ".", api.tree.toggle_hidden_filter, { silent = true } },
			-- 						{ "?", api.tree.toggle_help, { silent = true } },
			-- 						-- { "q", nil, { exit = true, nowait = true } },
			-- 					},
			-- 				})
			-- 				nvim_tree_hydra:activate()
			-- 			end
			--
			-- 			vim.api.nvim_create_autocmd({ "BufEnter" }, {
			-- 				pattern = "*",
			-- 				callback = function(options)
			-- 					-- print("leave: ft "..vim.bo[opts.buf].filetype)
			-- 					if vim.bo[options.buf].filetype == "NvimTree" then
			-- 						spawn_nvim_tree_hydra()
			-- 					else
			-- 						-- print("au close hydra")
			-- 						if nvim_tree_hydra then
			-- 							nvim_tree_hydra:exit()
			-- 						end
			-- 						-- return true -- removes autocmd
			-- 					end
			-- 				end,
			-- 				group = nt_au_group,
			-- 			})
		end,
		keys = {
			{ "<leader>fe", "<cmd>NvimTreeToggle<cr>", desc = "Toggle NvimTree" },
			{
				"<leader>fl",
				function()
					require("nvim-tree.api").tree.open({
						path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":h"),
						find_file = true,
					})
				end,
				desc = "Toggle NvimTree in local directory",
			},
		},
	},
}
