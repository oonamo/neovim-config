local M = {}
local function on_attach(client, buffer)
	-- TODO: change to rustacean
	vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, {
		desc = "Preview code actions",
		buffer = buffer,
	})
	if client.name == "rust_analyzer" then
		vim.keymap.set("n", "<leader>h", function()
			vim.cmd.RustLsp({ "hover", "actions" })
		end, { desc = "Rust Hover Actions", buffer = buffer })
		vim.keymap.set("n", "<leader>vca", function()
			vim.cmd.RustLsp("codeAction")
		end, { desc = "Rust code actions", buffer = buffer })
	else
		vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, {
			desc = "Hover details",
			buffer = buffer,
		})
	end
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, {
		desc = "go to buffer definition",
		buffer = buffer,
	})
	vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, {
		desc = "Go to workspace_symbol",
		buffer = buffer,
	})
	vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, {
		desc = "Open float menu",
		buffer = buffer,
	})
	vim.keymap.set("n", "[d", vim.diagnostic.goto_next, {
		desc = "Got to next diagnostic",
		buffer = buffer,
	})
	vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, {
		desc = "Go to previous diagnostic",
		buffer = buffer,
	})
	vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, {
		desc = "Go to lsp references",
		buffer = buffer,
	})
	vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, {
		desc = "Rename variable",
		buffer = buffer,
	})
	vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, {
		desc = "Signature help",
		buffer = buffer,
	})
	local diag_float_grp = vim.api.nvim_create_augroup("DiagnosticFloat", { clear = true })
	vim.api.nvim_create_autocmd("CursorHold", {
		callback = function()
			vim.diagnostic.open_float(nil, { focusable = false })
		end,
		group = diag_float_grp,
	})
end

local defaults = { on_attach = on_attach }
return {
	{
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonLog" },
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		opts = {
			lua_ls = {
				on_attach = on_attach,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = {
								[vim.fn.expand("$VIMRUNTIME/lua")] = true,
								[vim.fn.stdpath("config") .. "/lua"] = true,
							},
						},
					},
				},
			},
			tsserver = defaults,
			html = defaults,
			eslint = defaults,
			powershell_es = defaults,
			clangd = defaults,
		},
		config = function(_, opts)
			local lspconfig = require("lspconfig")
			local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				has_cmp and cmp_nvim_lsp.default_capabilities() or {},
				opts.capabilities or {}
			)
			for server, settings in pairs(opts) do
				local server_opts = vim.tbl_deep_extend("force", {
					capabilities = vim.deepcopy(capabilities),
				}, settings or {})
				lspconfig[server].setup(server_opts)
			end
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			ensure_installed = { "lua_ls", "rust_analyzer" },
			automatic_installation = false,
		},
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp", -- lazy = true },
			"hrsh7th/cmp-buffer", -- lazy = true },
			"hrsh7th/cmp-path", -- lazy = true },
			"hrsh7th/cmp-cmdline", -- lazy = true },
			"onsails/lspkind.nvim",
		},
		event = "InsertEnter",
		config = function()
			local cmp = require("cmp")
			-- IMPORTANT: Run this after setting up mason
			local mason_registry = require("mason-registry")
			M.mason_registry = mason_registry
			local codelldb = mason_registry.get_package("codelldb")
			M.codelldb = codelldb
			local extension_path = codelldb:get_install_path() .. "/extension/"
			M.extension_path = extension_path
			local codelldb_path = extension_path .. "adapter/codelldb"
			M.codelldb_path = codelldb_path
			local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
			M.liblldb_path = liblldb_path

			local lspkind = require("lspkind")
			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				window = {
					completion = {
						-- winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
						documentation = cmp.config.window.bordered(),
						-- col_offset = -3,
						-- side_padding = 0,
					},
					documentation = cmp.config.window.bordered(),
				},
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol_text",
						menu = {
							buffer = "[Buffer]",
							nvim_lsp = "[LSP]",
							luasnip = "[LuaSnip]",
							nvim_lua = "[Lua]",
							latex_symbols = "[Latex]",
						},
					}),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-i>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
				}),
				sources = cmp.config.sources({
					{
						name = "nvim_lsp",
						entry_filter = function(entry, _)
							-- Filter snippets
							if vim.g.use_custom_snippets then
								return true
							end

							if entry:get_kind() == cmp.lsp.CompletionItemKind.Snippet then
								return false
							end
							return true
						end,
					},
					{ name = "obsidian" },
					{ name = "obsidian_new" },
				}, {
					{ name = "buffer" },
					{ name = "path" },
				}),
			})

			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline", keyword_length = 3 },
				}),
			})
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"nvim-cmp",
			dependencies = {
				"saadparwaiz1/cmp_luasnip",
			},
			opts = function(_, opts)
				opts.snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				}
				table.insert(opts.sources or {}, { name = "luasnip" })
			end,
		},
		opts = {
			history = true,
			delete_check_events = "TextChanged",
		},
        -- stylua: ignore
        keys = {
            {
                "<C-j>",
                function()
                    return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
                end,
                expr = true, silent = true, mode = "i",
            },
            { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
            { "<C-k>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
        },
	},
	{
		"barreiroleo/ltex_extra.nvim",
		ft = { "markdown", "latex" },
		opts = {
			capabilities = M.capabilites,
			on_attach = function(client, bufnr)
				on_attach(client, bufnr)
				require("ltex_extra").setup({})
			end,
			settings = {
				-- ltex = { your settings }
			},
		},
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^3", -- Recommended
		ft = { "rust" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "mfussenegger/nvim-dap", lazy = true },
			{ "lvimuser/lsp-inlayhints.nvim", config = true, ft = { "rust" } },
		},
		config = function()
			vim.g.rustaceanvim = {
				server = {
					["rust-analyzer"] = {
						cargo = {
							allFeatures = true,
							loadOutDirsFromCheck = true,
							runBuildScripts = true,
						},
					},
					on_attach = function(client, buffer)
						on_attach(client, buffer)

						local lsp_inlay_hints = require("lsp-inlayhints")
						lsp_inlay_hints.on_attach(client, buffer)
						lsp_inlay_hints.show()
					end,
				},
				tools = {
					hover_actions = {
						auto_focus = true,
					},
				},
				dap = {
					adapter = require("rustaceanvim.config").get_codelldb_adapter(M.codelldb_path, M.liblldb_path),
				},
			}
		end,
	},
}
