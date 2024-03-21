local M = {}
local function on_attach(client, buffer)
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
		vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, {
			desc = "Preview code actions",
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
	vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, {
		desc = "Signature help",
		buffer = buffer,
	})
	if package.loaded["corn"] == nil then
		local diag_float_grp = vim.api.nvim_create_augroup("DiagnosticFloat", { clear = true })
		vim.api.nvim_create_autocmd("CursorHold", {
			callback = function()
				vim.diagnostic.open_float(nil, { focusable = false })
			end,
			group = diag_float_grp,
		})
	end
	require("lsp_signature").on_attach({
		hint_prefix = "",
	}, buffer)
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
			powershell_es = {
				shell = "pwsh",
				bundle_path = "c:/w/PowerShellEditorServices",
			},
			clangd = defaults,
			arduino_language_server = defaults,
			-- harper_ls = defaults,
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
		"micangl/cmp-vimtex",
		ft = { "tex", "plaintex", "latex" },
	},
	{
		"f3fora/cmp-spell",
		ft = { "markdown", "norg", "tex", "latex" },
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
			local C = {}
			local cmp = require("cmp")
			if vim.g.use_custom_snippets then
				C.luasnip = require("luasnip")
			end
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
					completion = cmp.config.window.bordered(),
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
						if not C.luasnip then
							fallback()
						end
						if C.luasnip.expandable() then
							C.luasnip.expand()
						elseif C.luasnip.locally_jumpable(1) then
							C.luasnip.jump(1)
						elseif cmp.visible() then
							cmp.select_next_item()
						else
							fallback()
						end
					end),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if not C.luasnip then
							fallback()
						end
						if C.luasnip.jumpable(-1) then
							C.luasnip.jump(-1)
						elseif C.luasnip.locally_jumpable(-1) then
							C.luasnip.jump(-1)
						else
							fallback()
						end
					end),
				}),
				sources = cmp.config.sources({
					{
						name = "nvim_lsp",
					},
				}, {
					{ name = "buffer" },
					{ name = "path" },
					{ name = "luasnip" },
				}),
			})
			cmp.setup.filetype("markdown", {
				sources = cmp.config.sources({
					{ name = "obsidian" },
					{ name = "obsidian_new" },
				}, {
					{ name = "buffer" },
					{ name = "path" },
					{ name = "rg" },
					{ name = "luasnip" },
				}),
			})

			cmp.setup.filetype("norg", {
				sources = cmp.config.sources({
					{ name = "neorg" },
					{ name = "rg" },
					{ name = "buffer" },
					{ name = "path" },
				}),
			})

			cmp.setup.filetype("org", {
				sources = cmp.config.sources({
					{ name = "orgmode" },
					{ name = "luasnip" },
					{ name = "rg" },
					{ name = "buffer" },
				}),
			})

			cmp.setup.filetype("latex", {
				sources = cmp.config.sources({
					{ name = "latex_symbols" },
					{ name = "vimtex" },
					{ name = "luasnip" },
				}, {
					{ name = "buffer" },
					{ name = "path" },
					{ name = "rg" },
					{ name = "spell" },
				}),
			})

			cmp.setup.filetype("tex", {
				sources = cmp.config.sources({
					{ name = "latex_symbols" },
					{ name = "vimtex" },
					{ name = "luasnip" },
				}, {
					{ name = "buffer" },
					{ name = "path" },
					{ name = "rg" },
					{ name = "spell" },
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
		event = { "InsertEnter" },
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
			updateevents = "TextChanged,TextChangedI",
			enable_autosnippets = true,
		},
		config = function(_, opts)
			local ls = require("luasnip")
			require("luasnip.loaders.from_lua").lazy_load({ paths = "~/AppData/Local/nvim/snippets" })
			ls.config.set_config(opts)
			vim.keymap.set({ "i", "s" }, "<C-E>", function()
				if ls.choice_active() then
					ls.change_choice(1)
				end
			end, { silent = true })
		end,
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^4", -- Recommended
		ft = { "rust" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "mfussenegger/nvim-dap", lazy = true },
			{ "lvimuser/lsp-inlayhints.nvim", config = true, ft = { "rust" } },
		},
		opts = {
			server = {
				["rust-analyzer"] = {
					cargo = {
						allFeatures = true,
						loadOutDirsFromCheck = true,
						runBuildScripts = true,
					},
					files = {
						watcherExclude = {
							["**/_build"] = true,
							["**/.classpath"] = true,
							["**/.dart_tool"] = true,
							["**/.factorypath"] = true,
							["**/.flatpak-builder"] = true,
							["**/.git/objects/**"] = true,
							["**/.git/subtree-cache/**"] = true,
							["**/.idea"] = true,
							["**/.project"] = true,
							["**/.scannerwork"] = true,
							["**/.settings"] = true,
							["**/.venv"] = true,
							["**/node_modules"] = true,
							["**/.logs"] = true,
							["**/.log"] = true,
						},
						excludeDirs = {
							"_build",
							".dart_tool",
							".flatpak-builder",
							".git",
							".gitlab",
							".gitlab-ci",
							".gradle",
							".idea",
							".next",
							".project",
							".scannerwork",
							".settings",
							".venv",
							"archetype-resources",
							"bin",
							"hooks",
							"node_modules",
							"po",
							"screenshots",
							"target",
						},
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
			-- dap = {
			-- 	adapter = require("rustaceanvim.config").get_codelldb_adapter(M.codelldb_path, M.liblldb_path),
			-- },
		},
		config = function(_, opts)
			local cfg = require("rustaceanvim.config")
			local dap = {
				adapter = cfg.get_codelldb_adapter(M.codelldb_path, M.liblldb_path),
			}
			vim.tbl_deep_extend("force", opts, dap)
			vim.g.rustaceanvim = opts
		end,
	},
}
