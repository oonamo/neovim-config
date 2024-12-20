return {
	{
		"stevearc/conform.nvim",
		-- event = "BufWritePre",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "black" },
				cpp = { "clang-format" },
				c = { "clang-format" },
			},
			timeout_ms = 500,
		},
		keys = {
			-- {
			-- 	"<leader>ff",
			-- 	function()
			-- 		require("conform").format({
			-- 			timeout_ms = 500,
			-- 			lsp_fallback = false,
			-- 		})
			-- 	end,
			-- },
			{
				"<leader>lf",
				function()
					require("conform").format({
						timeout_ms = 500,
						lsp_fallback = true,
					})
				end,
				desc = "Format",
			},
			{
				"gf",
				mode = "v",
				function()
					require("conform").format({
						timeout_ms = 500,
						lsp_fallback = false,
					})
				end,
			},
		},
	},
	{
		"hrsh7th/nvim-cmp",
		cond = false,
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
		},
		opts = function()
			vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
			local symbol_kinds = {
				Array = "󰅪",
				Class = "",
				Color = "󰏘",
				Constant = "󰏿",
				Constructor = "",
				Enum = "",
				EnumMember = "",
				Event = "",
				Field = "󰜢",
				File = "󰈙",
				Folder = "󰉋",
				Function = "󰆧",
				Interface = "",
				Keyword = "󰌋",
				Method = "󰆧",
				Module = "",
				Operator = "󰆕",
				Property = "󰜢",
				Reference = "󰈇",
				Snippet = "",
				Struct = "",
				Text = "",
				TypeParameter = "",
				Unit = "",
				Value = "",
				Variable = "󰀫",
			}
			local cmp = require("cmp")
			local defaults = require("cmp.config.default")()
			return {
				snippet = function(args)
					vim.snippet.expand(args.body)
				end,
				window = {
					completion = {},
				},
				auto_brackets = {}, -- configure any filetype to auto add brackets
				completion = {
					completeopt = "menu,menuone,noinsert,noselect",
				},
				preselect = cmp.PreselectMode.None,
				mapping = {
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
				},
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
				}, {
					{ name = "buffer" },
				}),
				formatting = {
					fields = { "abbr", "kind", "menu" },
					-- fields = { "kind", "abbr", "menu" },
					format = function(_, vim_item)
						local MAX_ABBR_WIDTH, MAX_MENU_WIDTH = 25, 30
						local ellipsis = "…"

						-- Add the icon (if given a kind).
						if vim_item.kind then
							vim_item.kind = symbol_kinds[vim_item.kind] .. " " .. vim_item.kind
						end

						-- Truncate the label.
						if vim.api.nvim_strwidth(vim_item.abbr) > MAX_ABBR_WIDTH then
							vim_item.abbr = vim.fn.strcharpart(vim_item.abbr, 0, MAX_ABBR_WIDTH) .. ellipsis
						end

						-- Truncate the description part.
						if vim.api.nvim_strwidth(vim_item.menu or "") > MAX_MENU_WIDTH then
							vim_item.menu = vim.fn.strcharpart(vim_item.menu, 0, MAX_MENU_WIDTH) .. ellipsis
						end

						return vim_item
					end,
				},
				experimental = {
					-- only show ghost text when we show ai completions
					ghost_text = vim.g.ai_cmp and {
						hl_group = "CmpGhostText",
					} or false,
				},
				sorting = defaults.sorting,
			}
		end,
	},
	{
		"saghen/blink.cmp",
		version = "*",
		build = "cargo build --release",
		event = "InsertEnter",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		opts = {
			keymap = {
				preset = "default",
				["<C-e>"] = {},
				["<A-1>"] = {
					function(cmp)
						cmp.accept({ index = 1 })
					end,
				},
				["<A-2>"] = {
					function(cmp)
						cmp.accept({ index = 2 })
					end,
				},
				["<A-3>"] = {
					function(cmp)
						cmp.accept({ index = 3 })
					end,
				},
				["<A-4>"] = {
					function(cmp)
						cmp.accept({ index = 4 })
					end,
				},
				["<A-5>"] = {
					function(cmp)
						cmp.accept({ index = 5 })
					end,
				},
				["<A-6>"] = {
					function(cmp)
						cmp.accept({ index = 6 })
					end,
				},
				["<A-7>"] = {
					function(cmp)
						cmp.accept({ index = 7 })
					end,
				},
				["<A-8>"] = {
					function(cmp)
						cmp.accept({ index = 8 })
					end,
				},
				["<A-9>"] = {
					function(cmp)
						cmp.accept({ index = 9 })
					end,
				},
			},
			appearance = {
				-- sets the fallback highlight groups to nvim-cmp's highlight groups
				-- useful for when your theme doesn't support blink.cmp
				-- will be removed in a future release, assuming themes add support
				use_nvim_cmp_as_default = true,
				-- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- adjusts spacing to ensure icons are aligned
				nerd_font_variant = "mono",
			},
			completion = {
				accept = {
					-- experimental auto-brackets support
					auto_brackets = {
						enabled = true,
					},
				},
				menu = {
					draw = {
						treesitter = { "lsp" },
						columns = { { "item_idx" }, { "kind_icon" }, { "label", "label_description", gap = 1 } },
						components = {
							item_idx = {
								text = function(ctx)
									return tostring(ctx.idx)
								end,
								highlight = "BlimkCmpItemIdx",
							},
						},
					},
					-- draw = {
					-- 	treesitter = { "lsp" },
					-- },
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 200,
				},
				ghost_text = {
					enabled = true,
				},
			},
			-- experimental signature help support
			-- signature = { enabled = true },

			sources = {
				-- adding any nvim-cmp sources here will enable them
				-- with blink.compat
				completion = {
					enable_providers = { "lsp", "path", "snippets", "buffer" },
				},
				cmdline = {},
			},
		},
	},
}
