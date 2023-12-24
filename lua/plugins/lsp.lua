return {
	{
		"ms-jpq/coq_nvim",
		dependencies = {
			"simrat39/rust-tools.nvim",
			"neovim/nvim-lspconfig",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
			"ms-jpq/coq_nvim",
			"ms-jpq/coq.artifacts",
		},
		event = { "BufReadPre", "BufNewFile" },
		init = function()
			vim.g.coq_settings = {
				auto_start = true,
				keymap = {
					bigger_preview = "<C-R>",
					jump_to_mark = "<C-M>",
					recommended = false,
				},
				display = {
					preview = {
						border = "rounded",
						enabled = true,
						positions = { north = 1, south = 2, west = 3, east = 4 },
					},
					pum = {
						x_max_len = 45,
						y_max_len = 10,
						fast_close = false,
					},
					statusline = {
						helo = false,
					},
				},
			}
		end,
		config = function()
			local mason = require("mason")
			local mason_lspconfig = require("mason-lspconfig")
			local coq = require("coq")

			--enable mason

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
				if client.name == "rust_analyzer" then
					vim.keymap.set("n", "<leader>h", ":RustHoverActions<cr>", {
						desc = "Rust Hover Actions",
						buffer = buffer,
					})
					vim.keymap.set("n", "<leader>gp", ":RustParentModule<cr>", {
						desc = "Rust Parent Module",
						buffer = buffer,
					})
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
				vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, {
					desc = "Preview code actions",
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

			local rust_tools_rust_server = {
				on_attach = on_attach,
			}

			require("mason-lspconfig").setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({ coq.lsp_ensure_capabilities({}) })
				end,
				["lua_ls"] = function()
					require("lspconfig").lua_ls.setup({
						on_attach = on_attach,
						capabilites = coq.lsp_ensure_capabilities,
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

				["rust_analyzer"] = function()
					require("rust-tools").setup({
						on_attach = on_attach,
						capabilites = coq.lsp_ensure_capabilities(),
						server = rust_tools_rust_server,
						tools = {
							hover_actions = {
								auto_focus = true,
							},
						},
						dap = {
							adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
						},
						-- dap = {
						--	adapter = {
						--		type = "server",
						--		port = "27",
						--		host = "127.0.0.1",
						--		executable = {
						--			command = codelldb_path,
						--			args = { "--liblldb", liblldb_path, "--port", "21111" },
						--		},
						--	},
						--},
					})
				end,
			})

			vim.wo.signcolumn = "yes"
		end,
	},
	{},
}
