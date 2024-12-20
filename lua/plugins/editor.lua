local function term_nav(dir)
	return function(self)
		return self:is_floating() and "<C-" .. dir or vim.schedule(function()
			vim.cmd.wincmd(dir)
		end)
	end
end

return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = vim.fn.argc(-1) == 0,
		event = { "BufWritePre", "BufReadPost", "BufNewFile", "VeryLazy" },
		cmd = "TSUpdate",
		build = function()
			vim.cmd("TSUpdate")
		end,
		init = function(plugin)
			vim.cmd("syntax off")
			require("lazy.core.loader").add_to_rtp(plugin)
			require("nvim-treesitter.query_predicates")
		end,
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
					disable = function(_, buf)
						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							return true
						end
					end,
				},
				indent = {
					enable = false,
					disable = function(_, buf)
						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							return true
						end
					end,
				},
				incremental_selection = {
					enable = false,
					disable = function(_, buf)
						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							return true
						end
					end,
					keymaps = {
						init_selection = "<C-i>",
						node_incremental = "<CR>",
						scope_incremental = false,
						node_decremental = "<BS>",
					},
				},
				textobjects = {
					enabled = false,
				},
			})
		end,
	},
	{
		"folke/snacks.nvim",
		priority = 1000,
    cond = false,
		lazy = false,
		opts = {
			input = {},
			dim = {},
			zen = {
				win = {
					style = {
						-- blend = 100,
						backdrop = {
							transparent = false,
							blend = 100,
						},
					},
				},
			},
			dashboard = {
				sections = {
					{ section = "header" },
					{
						pane = 2,
						icon = " ",
						title = "Recent Files",
						section = "recent_files",
						indent = 2,
						padding = 1,
					},
					{
						pane = 2,
						icon = " ",
						title = "Git Status",
						section = "terminal",
						enabled = function()
							return Snacks.git.get_root() ~= nil
						end,
						cmd = "git status --short --branch --renames",
						height = 5,
						padding = 1,
						ttl = 5 * 60,
						indent = 3,
					},
					{ section = "startup" },
				},
			},
			bigfile = {
				enabled = true,
				setup = function(ctx)
					vim.b.minianimate_disable = true
					vim.b.minicursorword_disable = true
					vim.b.miniindentscope_disable = true
					local ok, rainbow = pcall(require, "rainbow-delimiters")
					if ok then
						rainbow.disable()
					end
					vim.schedule(function()
						vim.w.statusline = nil
						vim.w.statuscolumn = nil
						vim.bo[ctx.buf].syntax = ctx.ft
					end)
				end,
			},
			notifier = {
				enabled = true,
				timeout = 3000,
				-- style = "minimal",
				-- top_down = false,
				-- margin = { top = 0, right = 1, bottom = 1 },
				history = {
					wo = {
						wrap = true,
					},
				},
			},
			terminal = {
				win = {
					keys = {
						nav_h = { "<C-h>", term_nav("h"), desc = "Go to left window", expr = true, mode = "t" },
						nav_j = { "<C-j>", term_nav("j"), desc = "Go to bottom window", expr = true, mode = "t" },
						nav_k = { "<C-k>", term_nav("k"), desc = "Go to top window", expr = true, mode = "t" },
						nav_l = { "<C-l>", term_nav("l"), desc = "Go to right window", expr = true, mode = "t" },
					},
				},
			},
			quickfile = { enabled = true },
			-- statuscolumn = {
			-- 	enabled = true,
			-- 	git = {
			-- 		-- patterns to match Git signs
			-- 		patterns = { "MiniDiffSign" },
			-- 	},
			-- },
			styles = {
				notification = {
					wo = { wrap = true }, -- Wrap notifications
				},
			},
		},
		keys = {
			{
				"<leader>uz",
				function()
					Snacks.zen()
				end,
			},
			{
				"<C-x>1",
				function()
					Snacks.zen.zoom()
				end,
			},
			{
				"<leader>uh",
				function()
					Snacks.notifier.show_history()
				end,
				desc = "Show notification history",
			},
			{
				"<leader>un",
				function()
					Snacks.notifier.hide()
				end,
				desc = "Dismiss All Notifications",
			},
			{
				"<leader>ud",
				function()
					if Snacks.dim.enabled then
						Snacks.dim.disable()
					else
						Snacks.dim.enable()
					end
				end,
			},
			{
				"<leader>bd",
				function()
					Snacks.bufdelete()
				end,
				desc = "Delete Buffer",
			},
			{
				"<leader>gg",
				function()
					Snacks.lazygit()
				end,
				desc = "Lazygit",
			},
			{
				"<leader>gb",
				function()
					Snacks.git.blame_line()
				end,
				desc = "Git Blame Line",
			},
			{
				"<leader>gB",
				function()
					Snacks.gitbrowse()
				end,
				desc = "Git Browse",
			},
			{
				"<leader>gf",
				function()
					Snacks.lazygit.log_file()
				end,
				desc = "Lazygit Current File History",
			},
			{
				"<leader>gl",
				function()
					Snacks.lazygit.log()
				end,
				desc = "Lazygit Log (cwd)",
			},
			{
				vim.env.TERM_PROGRAM ~= "WezTerm" and "<c-\\>" or "F9",
				mode = { "n", "t" },
				function()
					Snacks.terminal(nil, {
						bo = {
							minianimate_disable = true,
							minicursorword_disable = true,
							miniindentscope_disable = true,
						},
					})
				end,
				desc = "Toggle Terminal",
			},
		},
		init = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "VeryLazy",
				callback = function()
					-- Setup some globals for debugging (lazy-loaded)
					_G.P = function(...)
						Snacks.debug.inspect(...)
					end
					_G.bt = function()
						Snacks.debug.backtrace()
					end
					-- vim.print = _G.dd -- Override print to use snacks for `:=` command
				end,
			})
		end,
	},
	{
		"stevearc/quicker.nvim",
		event = "FileType qf",
		opts = {
			keys = {
				{
					">",
					function()
						require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
					end,
					desc = "Expand quickfix context",
				},
				{
					"<",
					function()
						require("quicker").collapse()
					end,
					desc = "Collapse quickfix context",
				},
			},
			highlight = {
				-- Use treesitter highlighting
				treesitter = true,
				-- Use LSP semantic token highlighting
				lsp = false,
				-- Load the referenced buffers to apply more accurate highlights (may be slow)
				load_buffers = true,
			},
		},
		keys = {
			{
				"<leader>qq",
				function()
					require("quicker").toggle()
				end,
				desc = "Toggle Quickfix",
			},
			{
				"<leader>ql",
				function()
					require("quicker").toggle({ loclist = true })
				end,
				desc = "Toggle Location list",
			},
		},
	},
	-- {
	-- 	"mikavilpas/yazi.nvim",
	-- 	keys = {
	-- 		{
	-- 			"-",
	-- 			"<cmd>Yazi<cr>",
	-- 			desc = "Open yazi at the current file",
	-- 		},
	-- 		{
	-- 			"<leader>e",
	-- 			"<cmd>Yazi cwd<cr>",
	-- 			desc = "Open the file manager in nvim's working directory",
	-- 		},
	-- 	},
	-- 	opts = {
	-- 		integrations = {
	-- 			--- What should be done when the user wants to grep in a directory
	-- 			grep_in_directory = function(directory)
	-- 				require("mini.pick").registry.grep_live({
	-- 					globs = { directory },
	-- 				})
	-- 				-- require("mini.pick").registry.grep_live(nil, {
	-- 				-- 	source = {
	-- 				-- 		cwd = directory,
	-- 				-- 	},
	-- 				-- })
	-- 				-- the default implementation uses telescope if available, otherwise nothing
	-- 			end,
	-- 			grep_in_selected_files = function(selected_files)
	-- 				-- similar to grep_in_directory, but for selected files
	-- 			end,
	-- 			-- --- Similarly, search and replace in the files in the directory
	-- 			-- replace_in_directory = function(directory)
	-- 			-- 	-- default: grug-far.nvim
	-- 			-- end,
	-- 			-- replace_in_selected_files = function(selected_files)
	-- 			-- 	-- default: grug-far.nvim
	-- 			-- end,
	-- 		},
	-- 	},
	-- },
	{
		"MagicDuck/grug-far.nvim",
		opts = {},
		keys = {
			{
				"<leader>rw",
				function()
					require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
				end,
				desc = "Replace <cword>",
			},
			{
				"<leader>rf",
				function()
					require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } })
				end,
				desc = "Replace current file",
			},
		},
	},
	{
		"ibhagwan/fzf-lua",
		opts = {
			files = {
				git_icons = false,
				no_header = true,
				cwd_header = false,
				cwd_prompt = false,
				file_icons = false,
			},
			lsp = { code_actions = { previewer = "codeaction_native" } },
			tags = { previewer = "bat" },
			btags = { previewer = "bat" },
			-- winopts = {
			-- 	border = "none",
			-- 	split = "botright new",
			-- 	preview = {
			-- 		default = "bat",
			-- 	},
			-- },
			keymap = {
				fzf = {
					["ctrl-q"] = "select-all+accept",
				},
			},
		},
		cmd = "FzfLua",
		keys = { { "<leader>pl", "<cmd>FzfLua files<cr>" } },
	},
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		opts = function(opts)
			local defaults = require("telescope.themes").get_ivy({
				path_display = { "filename_first" },
				layout_config = { height = 0.5 },
				border = true,
			})
			opts.defaults = defaults
			return opts
		end,
		keys = {
			{ "<leader>pf", "<cmd>Telescope find_files<cr>" },
		},
	},
}
