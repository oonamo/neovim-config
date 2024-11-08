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
					enable = true,
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
	-- {
	-- 	"hrsh7th/nvim-cmp",
	-- 	cond = false,
	-- 	event = "InsertEnter",
	-- 	dependencies = {
	-- 		"hrsh7th/cmp-nvim-lsp",
	-- 		"hrsh7th/cmp-buffer",
	-- 		{ "hrsh7th/cmp-nvim-lsp-signature-help" },
	-- 	},
	-- 	opts = function()
	-- 		local cmp = require("cmp")
	-- 		local icons = require("mini.icons")
	-- 		local function border(hl_name)
	-- 			return {
	-- 				{ "╭", hl_name },
	-- 				{ "─", hl_name },
	-- 				{ "╮", hl_name },
	-- 				{ "│", hl_name },
	-- 				{ "╯", hl_name },
	-- 				{ "─", hl_name },
	-- 				{ "╰", hl_name },
	-- 				{ "│", hl_name },
	-- 			}
	-- 		end
	-- 		local auto_select = true
	-- 		local function confirm(opts)
	-- 			opts = vim.tbl_extend("force", {
	-- 				select = true,
	-- 				behavior = cmp.ConfirmBehavior.insert,
	-- 			}, opts or {})
	-- 			return function(fallback)
	-- 				if cmp.core.view:visible() or vim.fn.pumvisible() == 1 then
	-- 					if cmp.confirm(opts) then
	-- 						return
	-- 					end
	-- 				end
	-- 				return fallback()
	-- 			end
	-- 		end
	-- 		return {
	-- 			window = {
	-- 				documentation = {
	-- 					border = border("CmpDocumentationBorder"),
	-- 					winhighlight = "Normal:CmpDocumentation",
	-- 				},
	-- 				-- completion = cmp.config.window.bordered(),
	-- 				completion = {
	-- 					scrollbar = false,
	-- 					side_padding = 1,
	-- 					-- winhighlight = "Normal:Pmenu,CursorLine:CmpSel,Search:None,FloatBorder:FloatBorder",
	-- 					winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None,FloatBorder:CmpBorder",
	-- 					border = "single",
	-- 					-- border = border("FloatBorder"),
	-- 					-- border = "single",
	-- 				},
	-- 			},
	-- 			formatting = {
	-- 				fields = { "kind", "abbr", "menu" },
	-- 				format = function(_, item)
	-- 					local kind = item.kind
	-- 					item.kind = icons.get("lsp", kind)
	-- 					item.menu = kind:gsub("(%l)(%u)", "%1 %2"):lower()
	-- 					return item
	-- 				end,
	-- 			},
	-- 			view = {
	-- 				docs = {
	-- 					auto_open = true,
	-- 				},
	-- 				entries = {
	-- 					follow_cursor = false,
	-- 				},
	-- 			},
	-- 			completion = {
	-- 				completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
	-- 			},
	-- 			preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
	-- 			mapping = cmp.mapping.preset.insert({
	-- 				["<C-b>"] = cmp.mapping.scroll_docs(-4),
	-- 				["<C-f>"] = cmp.mapping.scroll_docs(4),
	-- 				["<C-Space>"] = cmp.mapping.complete(),
	-- 				["<CR>"] = confirm({ select = auto_select }),
	-- 				["<C-y>"] = confirm({ select = true }),
	-- 				["<S-CR>"] = confirm({ behavior = cmp.ConfirmBehavior.Replace }),
	-- 				["<C-e>"] = cmp.mapping.abort(),
	-- 				["<Tab>"] = cmp.mapping(function(fallback)
	-- 					if vim.snippet.active({ direction = 1 }) then
	-- 						vim.snippet.jump(1)
	-- 					else
	-- 						fallback()
	-- 					end
	-- 				end, { "i", "s" }),
	-- 				["<S-Tab>"] = cmp.mapping(function(fallback)
	-- 					if vim.snippet.active({ direction = -1 }) then
	-- 						vim.snippet.jump(-1)
	-- 					else
	-- 						fallback()
	-- 					end
	-- 				end, { "i", "s" }),
	-- 				["<C-k>"] = cmp.mapping.open_docs(),
	-- 			}),
	-- 			sources = cmp.config.sources({
	-- 				{ name = "nvim_lsp" },
	-- 				{ name = "path" },
	-- 				{ name = "nvim_lsp_signature_help" },
	-- 			}, {
	-- 				{ name = "buffer" },
	-- 			}),
	-- 			-- matching = {
	-- 			-- 	disallow_fuzzy_matching = true,
	-- 			-- 	disallow_fullfuzzy_matching = true,
	-- 			-- 	disallow_partial_fuzzy_matching = true,
	-- 			-- 	disallow_partial_matching = true,
	-- 			-- 	disallow_prefix_unmatching = true,
	-- 			-- },
	-- 		}
	-- 	end,
	-- },
	-- {
	-- 	"akinsho/toggleterm.nvim",
	-- 	version = "*",
	-- 	opts = {
	-- 		open_mapping = "<C-\\>",
	-- 	},
	-- 	keys = {
	-- 		"<C-\\>",
	-- 		{
	-- 			"<leader>tt",
	-- 			[[<cmd>ToggleTerm<cr>]],
	-- 		},
	-- 		{
	-- 			"<leader><tab>t",
	-- 			"<cmd>ToggleTerm direction=tab<cr>",
	-- 		},
	-- 		{
	-- 			"<leader>gl",
	-- 			function()
	-- 				toggleterms.lg:toggle()
	-- 			end,
	-- 		},
	-- 		{
	-- 			"<leader>st",
	-- 			"<cmd>TermSelect<cr>",
	-- 		},
	-- 		{
	-- 			"<leader>ca",
	-- 			function()
	-- 				if toggleterms[vim.g.last_compile_command] then
	-- 					toggleterms[vim.g.last_compile_command]:toggle()
	-- 					return
	-- 				end
	-- 				local args = vim.fn.input({
	-- 					prompt = "Compile > ",
	-- 					default = (vim.g.last_compile_command or ""),
	-- 				})
	-- 				vim.g.last_compile_command = args
	-- 				toggleterms[vim.g.last_compile_command] = require("toggleterm.terminal").Terminal:new({
	-- 					cmd = vim.g.last_compile_command,
	-- 					hidden = true,
	-- 					direction = "float",
	-- 				})
	-- 				toggleterms[vim.g.last_compile_command]:toggle()
	-- 			end,
	-- 		},
	-- 		{
	-- 			"<leader>cp",
	-- 			function()
	-- 				local args = vim.fn.input({
	-- 					prompt = "Compile > ",
	-- 					default = (vim.g.last_compile_command or ""),
	-- 				})
	-- 				vim.g.last_compile_command = args
	-- 				toggleterms[vim.g.last_compile_command] = require("toggleterm.terminal").Terminal:new({
	-- 					cmd = vim.g.last_compile_command,
	-- 					hidden = true,
	-- 					direction = "float",
	-- 				})
	-- 				toggleterms[vim.g.last_compile_command]:toggle()
	-- 			end,
	-- 		},
	-- 	},
	-- 	config = function(_, opts)
	-- 		_G.toggleterms = {}
	-- 		require("toggleterm").setup(opts)
	-- 		local Terminal = require("toggleterm.terminal").Terminal
	-- 		_G.toggleterms.lg = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
	-- 	end,
	-- },
	{
		"saghen/blink.cmp",
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
			keymap = { preset = "default" },

			highlight = {
				-- sets the fallback highlight groups to nvim-cmp's highlight groups
				-- useful for when your theme doesn't support blink.cmp
				-- will be removed in a future release, assuming themes add support
				use_nvim_cmp_as_default = true,
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
					winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None,FloatBorder:CmpBorder",
					border = "single",
					draw = "reversed",
				},
			},
		},
	},
	{
		-- TODO: Setup
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
					vim.schedule(function()
						vim.w.statusline = nil
						vim.w.statuscolumn = nil
						vim.bo[ctx.buf].syntax = ctx.ft
					end)
				end,
			},
			words = { enabled = false },
			notifier = {
				enabled = true,
				timeout = 3000,
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
				"<c-\\>",
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
					_G.dd = function(...)
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
		"genchad",
		dir = "~/projects/nvim/chadschemes/",
		dev = true,
	},
	{
		"cbochs/grapple.nvim",
		opts = {
			scope = "git_branch",
			icons = true,
			status = true,
		},
		keys = {
			{ "<leader>a", "<cmd>Grapple toggle<cr>", desc = "Grapple Tag File" },
			{ "<c-e><c-e>", "<cmd>Grapple toggle_tags<cr>", desc = "Toggle tags menu" },
			{ "<c-e><c-h>", "<cmd>Grapple select index=1<cr>", desc = "Select first tag" },
			{ "<c-e><c-j>", "<cmd>Grapple select index=2<cr>", desc = "Select second tag" },
			{ "<c-e><c-k>", "<cmd>Grapple select index=3<cr>", desc = "Select third tag" },
			{ "<c-e><c-l>", "<cmd>Grapple select index=4<cr>", desc = "Select fourth tag" },
		},
	},
}
