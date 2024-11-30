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
        }
			})
		end,
	},
	{
		"saghen/blink.cmp",
		cond = false,
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
	{
		"stevearc/quicker.nvim",
    cond = false,
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
		"HiPhish/rainbow-delimiters.nvim",
		event = { "BufWritePre", "BufReadPost", "BufNewFile", "VeryLazy" },
		config = function(_, opts)
			require("rainbow-delimiters.setup").setup(opts)
		end,
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"<C-s>",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
	},
}
