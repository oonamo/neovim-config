--TODO: Switch to nvim-cmp
--TODO: Switch to rustaceanvim
--https://github.com/mrcjkb/rustaceanvim
return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"neovim/nvim-lspconfig",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"onsails/lspkind.nvim",
		},
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local mason = require("mason")
			local mason_lspconfig = require("mason-lspconfig")
			local cmp = require("cmp")

			mason.setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})

			mason_lspconfig.setup({
				ensure_installed = {
					"html",
					"lua_ls",
					"rust_analyzer",
				},
				-- enable automatic install
				automatic_installation = false,
			})

			-- IMPORTANT: Run this after setting up mason
			local mason_registry = require("mason-registry")
			local codelldb = mason_registry.get_package("codelldb")
			local extension_path = codelldb:get_install_path() .. "/extension/"
			local codelldb_path = extension_path .. "adapter/codelldb"
			local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

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
				-- vim.keymap.set("n", "[d", vim.diagnostic.goto_next, {
				-- 	desc = "Got to next diagnostic",
				-- 	buffer = buffer,
				-- })
				-- vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, {
				-- 	desc = "Go to previous diagnostic",
				-- 	buffer = buffer,
				-- })
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
			local luasnip = require("luasnip")
			vim.keymap.set({ "i", "s" }, "<C-k>", function()
				if luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				end
			end, { silent = true })

			vim.keymap.set({ "i", "s" }, "<C-j>", function()
				if luasnip.jumpable(-1) then
					luasnip.jump(-1)
				end
			end, { silent = true })

			vim.keymap.set("i", "<C-l>", function()
				if luasnip.choice_active() then
					luasnip.change_choice(1)
				end
			end)
			local lspkind = require("lspkind")
			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				window = {
					completion = {
						winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
						col_offset = -3,
						side_padding = 0,
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
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						elseif luasnip.expandable() then
							luasnip.expand()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				}, {
					{ name = "buffer" },
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

			local capabilites = require("cmp_nvim_lsp").default_capabilities()
			require("mason-lspconfig").setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({ capabilities = capabilites, on_attach = on_attach })
				end,
				["lua_ls"] = function()
					require("lspconfig").lua_ls.setup({
						on_attach = on_attach,
						capabilites = capabilites,
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
					})
				end,

				-- ["rust_analyzer"] = function()
				-- 	require("rust-tools").setup({
				-- 		on_attach = on_attach,
				-- 		capabilites = capabilites,
				-- 		tools = {
				-- 			hover_actions = {
				-- 				auto_focus = true,
				-- 			},
				-- 		},
				-- 		dap = {
				-- 			adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
				-- 		},
				-- 	})
				-- end,
			})
			vim.g.rustaceanvim = {
				on_attach = on_attach,
				capabilities = capabilites,
				tools = {
					hover_actions = {
						auto_focus = true,
					},
				},
				dap = {
					adapter = require("rustaceanvim.config").get_codelldb_adapter(codelldb_path, liblldb_path),
				},
			}
		end,
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^3", -- Recommended
		ft = { "rust" },
	},
	-- {
	-- 	"ms-jpq/coq_nvim",
	-- 	dependencies = {
	-- 		"simrat39/rust-tools.nvim",
	-- 		"neovim/nvim-lspconfig",
	-- 		"williamboman/mason.nvim",
	-- 		"williamboman/mason-lspconfig.nvim",
	-- 		"neovim/nvim-lspconfig",
	-- 		"ms-jpq/coq_nvim",
	-- 		"ms-jpq/coq.artifacts",
	-- 	},
	-- 	event = { "BufReadPre", "BufNewFile" },
	-- 	init = function()
	-- 		vim.g.coq_settings = {
	-- 			auto_start = true,
	-- 			keymap = {
	-- 				jump_to_mark = "<C-x>",
	-- 				bigger_preview = "<C-s>",
	-- 				recommended = false,
	-- 			},
	-- 			display = {
	-- 				ghost_text = {
	-- 					enabled = false,
	-- 				},
	-- 				preview = {
	-- 					border = "rounded",
	-- 					enabled = true,
	-- 					positions = { north = nil, south = 2, west = 3, east = 4 },
	-- 				},
	-- 				pum = {
	-- 					x_max_len = 45,
	-- 					fast_close = true,
	-- 				},
	-- 				statusline = {
	-- 					helo = false,
	-- 				},
	-- 			},
	-- 		}
	-- 	end,
	-- 	config = function()
	-- 		local mason = require("mason")
	-- 		local mason_lspconfig = require("mason-lspconfig")
	-- 		local coq = require("coq")
	--
	-- 		--enable mason
	--
	-- 		mason.setup({
	-- 			ui = {
	-- 				icons = {
	-- 					package_installed = "✓",
	-- 					package_pending = "➜",
	-- 					package_uninstalled = "✗",
	-- 				},
	-- 			},
	-- 		})
	--
	-- 		mason_lspconfig.setup({
	-- 			ensure_installed = {
	-- 				"html",
	-- 				"lua_ls",
	-- 				"rust_analyzer",
	-- 			},
	-- 			-- enable automatic install
	-- 			automatic_installation = false,
	-- 		})
	--
	-- 		-- IMPORTANT: Run this after setting up mason
	-- 		local mason_registry = require("mason-registry")
	-- 		local codelldb = mason_registry.get_package("codelldb")
	-- 		local extension_path = codelldb:get_install_path() .. "/extension/"
	-- 		local codelldb_path = extension_path .. "adapter/codelldb"
	-- 		local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
	--
	-- 		local function on_attach(client, buffer)
	-- 			vim.keymap.set({ "i", "n" }, "<C-x>", function()
	-- 				COQ.Nav_mark()
	-- 			end)
	--
	-- 			if client.name == "rust_analyzer" then
	-- 				vim.keymap.set("n", "<leader>h", ":RustHoverActions<cr>", {
	-- 					desc = "Rust Hover Actions",
	-- 					buffer = buffer,
	-- 				})
	-- 				vim.keymap.set("n", "<leader>gp", ":RustParentModule<cr>", {
	-- 					desc = "Rust Parent Module",
	-- 					buffer = buffer,
	-- 				})
	-- 			else
	-- 				vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, {
	-- 					desc = "Hover details",
	-- 					buffer = buffer,
	-- 				})
	-- 			end
	-- 			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {
	-- 				desc = "go to buffer definition",
	-- 				buffer = buffer,
	-- 			})
	-- 			vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, {
	-- 				desc = "Go to workspace_symbol",
	-- 				buffer = buffer,
	-- 			})
	-- 			vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, {
	-- 				desc = "Open float menu",
	-- 				buffer = buffer,
	-- 			})
	-- 			-- vim.keymap.set("n", "[d", vim.diagnostic.goto_next, {
	-- 			-- 	desc = "Got to next diagnostic",
	-- 			-- 	buffer = buffer,
	-- 			-- })
	-- 			-- vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, {
	-- 			-- 	desc = "Go to previous diagnostic",
	-- 			-- 	buffer = buffer,
	-- 			-- })
	-- 			vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, {
	-- 				desc = "Preview code actions",
	-- 				buffer = buffer,
	-- 			})
	-- 			vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, {
	-- 				desc = "Go to lsp references",
	-- 				buffer = buffer,
	-- 			})
	-- 			vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, {
	-- 				desc = "Rename variable",
	-- 				buffer = buffer,
	-- 			})
	-- 			vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, {
	-- 				desc = "Signature help",
	-- 				buffer = buffer,
	-- 			})
	-- 			local diag_float_grp = vim.api.nvim_create_augroup("DiagnosticFloat", { clear = true })
	-- 			vim.api.nvim_create_autocmd("CursorHold", {
	-- 				callback = function()
	-- 					vim.diagnostic.open_float(nil, { focusable = false })
	-- 				end,
	-- 				group = diag_float_grp,
	-- 			})
	-- 		end
	--
	-- 		local rust_tools_rust_server = {
	-- 			on_attach = on_attach,
	-- 		}
	--
	-- 		require("mason-lspconfig").setup_handlers({
	-- 			function(server_name)
	-- 				require("lspconfig")[server_name].setup({ coq.lsp_ensure_capabilities({}) })
	-- 			end,
	-- 			["lua_ls"] = function()
	-- 				require("lspconfig").lua_ls.setup({
	-- 					on_attach = on_attach,
	-- 					capabilites = coq.lsp_ensure_capabilities,
	-- 					settings = {
	-- 						Lua = {
	-- 							diagnostics = {
	-- 								globals = { "vim", "COQ" },
	-- 							},
	-- 							workspace = {
	-- 								library = {
	-- 									[vim.fn.expand("$VIMRUNTIME/lua")] = true,
	-- 									[vim.fn.stdpath("config") .. "/lua"] = true,
	-- 								},
	-- 							},
	-- 						},
	-- 					},
	-- 				})
	-- 			end,
	--
	-- 			["rust_analyzer"] = function()
	-- 				require("rust-tools").setup({
	-- 					on_attach = on_attach,
	-- 					capabilites = coq.lsp_ensure_capabilities(),
	-- 					server = rust_tools_rust_server,
	-- 					tools = {
	-- 						hover_actions = {
	-- 							auto_focus = true,
	-- 						},
	-- 					},
	-- 					dap = {
	-- 						adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
	-- 					},
	-- 					-- dap = {
	-- 					--	adapter = {
	-- 					--		type = "server",
	-- 					--		port = "27",
	-- 					--		host = "127.0.0.1",
	-- 					--		executable = {
	-- 					--			command = codelldb_path,
	-- 					--			args = { "--liblldb", liblldb_path, "--port", "21111" },
	-- 					--		},
	-- 					--	},
	-- 					--},
	-- 				})
	-- 			end,
	-- 		})
	--
	-- 		vim.wo.signcolumn = "yes"
	-- 	end,
	-- }
}
