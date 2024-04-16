return {
	{
		"nvim-tree/nvim-tree.lua",
		opts = {
			filters = {
				dotfiles = false,
			},
			disable_netrw = true,
			hijack_netrw = true,
			hijack_cursor = true,
			hijack_unnamed_buffer_when_opening = false,
			sync_root_with_cwd = true,
			update_focused_file = {
				enable = true,
				update_root = true,
				ignore_list = { "fzf", "help", "git" },
			},
			view = {
				adaptive_size = false,
				side = "right",
				width = 20,
				preserve_window_proportions = true,
			},
			git = {
				enable = false,
				ignore = true,
			},
			filesystem_watchers = {
				enable = true,
			},
			actions = {
				open_file = {
					resize_window = true,
				},
			},
			renderer = {
				root_folder_label = false,
				highlight_git = false,
				highlight_opened_files = "none",
				indent_markers = {
					enable = false,
				},
				icons = {
					padding = " ",
					webdev_colors = true,
					git_placement = "after",
					show = {
						file = true,
						folder = true,
						folder_arrow = true,
						git = true,
					},
					glyphs = {
						default = "",
						symlink = " ➛  ",
						folder = {
							default = "",
							open = "",
							-- empty = "",
							-- empty_open = "",
							-- open = "",
							-- symlink = "",
							-- symlink_open = "",
							-- arrow_open = "",
							-- arrow_closed = "",
						},
						git = {
							unstaged = "✗",
							staged = "✓",
							unmerged = "",
							renamed = "➜",
							untracked = "★",
							-- deleted = "",
							-- ignored = "◌",
						},
					},
				},
			},
		},
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
