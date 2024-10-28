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
		"hrsh7th/nvim-cmp",
		cond = true,
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			{ "hrsh7th/cmp-nvim-lsp-signature-help" },
		},
		opts = function()
			local cmp = require("cmp")
			local icons = require("mini.icons")
			local function border(hl_name)
				return {
					{ "╭", hl_name },
					{ "─", hl_name },
					{ "╮", hl_name },
					{ "│", hl_name },
					{ "╯", hl_name },
					{ "─", hl_name },
					{ "╰", hl_name },
					{ "│", hl_name },
				}
			end
			local auto_select = true
			local function confirm(opts)
				opts = vim.tbl_extend("force", {
					select = true,
					behavior = cmp.ConfirmBehavior.insert,
				}, opts or {})
				return function(fallback)
					if cmp.core.view:visible() or vim.fn.pumvisible() == 1 then
						if cmp.confirm(opts) then
							return
						end
					end
					return fallback()
				end
			end
			return {
				window = {
					documentation = {
						border = border("CmpDocumentationBorder"),
						winhighlight = "Normal:CmpDocumentation",
					},
					completion = {
						scrollbar = false,
						side_padding = 1,
						winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None,FloatBorder:CmpBorder",
						border = "single",
					},
				},
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(_, item)
						local kind = item.kind
						item.kind = icons.get("lsp", kind)
						item.menu = kind:gsub("(%l)(%u)", "%1 %2"):lower()
						return item
					end,
				},
				view = {
					docs = {
						auto_open = true,
					},
					entries = {
						follow_cursor = false,
					},
				},
				completion = {
					completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
				},
				preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = confirm({ select = auto_select }),
					["<C-y>"] = confirm({ select = true }),
					["<S-CR>"] = confirm({ behavior = cmp.ConfirmBehavior.Replace }),
					["<C-e>"] = cmp.mapping.abort(),
					["<Tab>"] = cmp.mapping(function(fallback)
						if vim.snippet.active({ direction = 1 }) then
							vim.snippet.jump(1)
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if vim.snippet.active({ direction = -1 }) then
							vim.snippet.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
					["<C-k>"] = cmp.mapping.open_docs(),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "path" },
					{ name = "nvim_lsp_signature_help" },
				}, {
					{ name = "buffer" },
				}),
				-- matching = {
				-- 	disallow_fuzzy_matching = true,
				-- 	disallow_fullfuzzy_matching = true,
				-- 	disallow_partial_fuzzy_matching = true,
				-- 	disallow_partial_matching = true,
				-- 	disallow_prefix_unmatching = true,
				-- },
			}
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = {
			open_mapping = "<C-\\>",
		},
		keys = {
			"<C-\\>",
			{
				"<leader>tt",
				[[<cmd>ToggleTerm<cr>]],
			},
			{
				"<leader>gl",
				function()
					toggleterms.lg:toggle()
				end,
			},
			{
				"<leader>st",
				"<cmd>TermSelect<cr>",
			},
			{
				"<leader>ca",
				function()
					if not vim.g.last_compile_command or vim.g.last_compile_command == "" then
						local args = vim.fn.input({
							prompt = "Compile > ",
							default = (vim.g.last_compile_command or ""),
						})
						vim.g.last_compile_command = args
					end
					require("toggleterm").exec(vim.g.last_compile_command or "")
				end,
			},
		},
		config = function(_, opts)
			_G.toggleterms = {}
			require("toggleterm").setup(opts)
			local Terminal = require("toggleterm.terminal").Terminal
			_G.toggleterms.lg = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
		end,
	},
	{},
}
