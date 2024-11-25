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
			})
		end,
	},
	{
		"saghen/blink.cmp",
		cond = true,
		event = "InsertEnter",
		-- lazy = false, -- lazy loading handled internally
		-- optional: provides snippets for the snippet source
		dependencies = "rafamadriz/friendly-snippets",

		-- use a release tag to download pre-built binaries
		version = "v0.*",
		-- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		-- build = 'cargo build --release',
		-- If you use nix, you can build from source using latest nightly rust with:
		-- build = 'nix run .#build-plugin',

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			-- 'default' for mappings similar to built-in completion
			-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
			-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
			-- see the "default configuration" section below for full documentation on how to define
			-- your own keymap.
			keymap = {
				-- preset = "default",
				-- "default" keymap
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				-- ['<C-e>'] = { 'hide' },
				["<C-y>"] = { "select_and_accept" },

				["<C-p>"] = { "select_prev", "fallback" },
				["<C-n>"] = { "select_next", "fallback" },

				["<C-b>"] = { "scroll_documentation_up", "fallback" },
				["<C-f>"] = { "scroll_documentation_down", "fallback" },

				["<Tab>"] = { "snippet_forward", "fallback" },
				["<S-Tab>"] = { "snippet_backward", "fallback" },
			},

			highlight = {
				-- sets the fallback highlight groups to nvim-cmp's highlight groups
				-- useful for when your theme doesn't support blink.cmp
				-- will be removed in a future release, assuming themes add support
				use_nvim_cmp_as_default = false,
			},
			-- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- adjusts spacing to ensure icons are aligned
			nerd_font_variant = "mono",

			-- experimental auto-brackets support
			-- accept = { auto_brackets = { enabled = true } }

			-- experimental signature help support
			trigger = { signature_help = { enabled = true } },

			windows = {
				autocomplete = {
					-- winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None,FloatBorder:CmpBorder",
					-- border = "single",
					-- draw = "reversed",
				},
			},
		},
	},
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
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
				style = "minimal",
				top_down = false,
				margin = { top = 0, right = 1, bottom = 1 },
			},
			quickfile = { enabled = true },
			statuscolumn = {
				enabled = true,
				git = {
					-- patterns to match Git signs
					patterns = { "MiniDiffSign" },
				},
			},
			styles = {
				notification = {
					wo = { wrap = true }, -- Wrap notifications
				},
			},
		},
		keys = {
			{
				"<leader>un",
				function()
					Snacks.notifier.hide()
				end,
				desc = "Dismiss All Notifications",
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
				"<leader>cR",
				function()
					Snacks.rename()
				end,
				desc = "Rename File",
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
	-- Generate NVChad colorschemes
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
	{
		"folke/which-key.nvim",
		opts = {
			spec = {
				{
					mode = { "n", "v" },
					{ "<leader><tab>", group = "tabs" },
					{ "<leader>g", group = "git" },
					{ "<leader>gh", group = "hunks" },
					{ "<leader>gd", group = "diff" },
					{ "<leader>l", group = "location list" },
					{ "<leader>b", group = "buffer" },
					{ "<leader>ba", group = "buffer all" },
					{ "<leader>m", group = "make" },
					{ "<leader>n", group = "nabla" },
					{ "<leader>o", group = "old" },
					{ "<leader>p", group = "find+" },
					{ "<leader>q", group = "quickfix" },
					{ "<leader>s", group = "signature" },
					{ "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
					{ "<leader>v", group = "split" },
					{ "<leader>x", group = "zen" },
					{ "<leader>c", group = "compile" },
					{ "<leader>i", group = "inlay" },
					-- { "<leader>s", group = "search" },
					-- { "<leader>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
					{ "[", group = "prev" },
					{ "]", group = "next" },
					{ "g", group = "goto" },
					{ "gs", group = "surround" },
					{ "z", group = "fold" },
					{ "<localleader>t", group = "terminal" },
				},
			},
		},
		keys = {
			"<leader>",
			"g",
			"m",
			"<localleader>",
		},
	},
	{
		"HiPhish/rainbow-delimiters.nvim",
		event = { "BufWritePre", "BufReadPost", "BufNewFile", "VeryLazy" },
		config = function(_, opts)
			require("rainbow-delimiters.setup").setup(opts)
		end,
	},
	{
		"cbochs/grapple.nvim",
		opts = {},
		keys = {
			{ "<leader>a", "<cmd>Grapple toggle<cr>", desc = "Grapple toggle tag" },
			{ "<leader>1", "<cmd>Grapple select index=1<cr>", desc = "Grapple select tag 1" },
			{ "<leader>2", "<cmd>Grapple select index=2<cr>", desc = "Grapple select tag 2" },
			{ "<leader>3", "<cmd>Grapple select index=3<cr>", desc = "Grapple select tag 3" },
			{ "<leader>4", "<cmd>Grapple select index=4<cr>", desc = "Grapple select tag 4" },
			{ "<leader>5", "<cmd>Grapple select index=5<cr>", desc = "Grapple select tag 5" },
			{ "<leader>6", "<cmd>Grapple select index=6<cr>", desc = "Grapple select tag 6" },
			{ "<leader>7", "<cmd>Grapple select index=7<cr>", desc = "Grapple select tag 7" },
			{ "<leader>8", "<cmd>Grapple select index=8<cr>", desc = "Grapple select tag 8" },
			{ "<leader>9", "<cmd>Grapple select index=9<cr>", desc = "Grapple select tag 9" },
			{ "<C-e>", "<cmd>Grapple toggle_tags<cr>", desc = "Toggle tag menu" },
		},
	},
	{
		"jake-stewart/multicursor.nvim",
		opts = {},
		keys = {
			{
				"<leader>mcn",
				function()
					require("multicursor-nvim").matchAddCursor(1)
				end,
				desc = "Add cursor to next match",
			},
			{
				"<leader>mcN",
				function()
					require("multicursor-nvim").matchAddCursor(-1)
				end,
				desc = "Add cursor to previous match",
			},
			{
				"<leader>mck",
				function()
					require("multicursor-nvim").lineAddCursor(-1)
				end,
				desc = "Add cursor to previous line",
			},
			{
				"<leader>mcj",
				function()
					require("multicursor-nvim").lineAddCursor(1)
				end,
				desc = "Add cursor below",
			},
			{
				"<leader>mcsk",
				function()
					require("multicursor-nvim").LineSkipCursor(-1)
				end,
				desc = "Add cursor to next line",
			},
			{
				"<leader>mcsj",
				function()
					require("multicursor-nvim").LineSkipCursor(1)
				end,
				desc = "Add cursor below, skipping the first line",
			},
			{
				"<leader>mca",
				function()
					require("multicursor-nvim").matchAddAllCursors()
				end,
				desc = "Match all and add cursor",
			},
			{
				"<leader>mcJ",
				function()
					require("multicursor-nvim").nextCursor()
				end,
				desc = "Change main cursor the next",
			},
			{
				"<leader>mcK",
				function()
					require("multicursor-nvim").prevCursor()
				end,
				desc = "Change main cursor to previous",
			},
			{
				"<leader>mcx",
				function()
					require("multicursor-nvim").deleteCursor()
				end,
				desc = "Delete current cursor",
			},
			{
				"<leader>mcc",
				function()
					local mc = require("multicursor-nvim")
					if not mc.cursorsEnabled() then
						mc.enableCursors()
					else
						mc.clearCursors()
					end
				end,
				desc = "Clear cursors",
			},
			{
				"<leader>mcr",
				function()
					require("mutlicursor-nvim").restoreCursors()
				end,
				desc = "Restore cursors",
			},
      {
        "<c-q>",
        function()
          require("multicursor-nvim").toggleCursor()
        end,
        desc = "Toggle current cursor",
      },
      {
        "<leader>mc=",
        function()
          require("multicursor-nvim").alignCursors()
        end,
        desc = "Align cursors",
      },
      {
        "<leader>mcs",
        function()
          require("multicursor-nvim").splitCursors()
        end,
        desc = "Split cursor by pattern",
      }
		},
	},
}
