local M = {}
local function on_attach(client, buffer)
	local fzf = require("fzf-lua")
	-- local conf = require("onam.helpers.lsp.signature")
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
	-- if client.server_capabilities.documentSymbolProvider then
	-- 	require("nvim-navic").attach(client, buffer)
	-- end
	vim.keymap.set("n", "gd", function()
		vim.lsp.buf.definition()
	end, {
		desc = "go to buffer definition",
		buffer = buffer,
	})
	-- vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, {
	-- 	desc = "Go to workspace_symbol",
	-- 	buffer = buffer,
	-- })
	vim.keymap.set("n", "<leader>vws", fzf.lsp_workspace_symbols, { desc = "Find workspace_symbol", buffer = buffer })
	vim.keymap.set("n", "<leader>vd", function()
		vim.diagnostic.open_float({ border = tools.ui.cur_border })
	end, {
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
	-- vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, {
	-- 	desc = "Go to lsp references",
	-- 	buffer = buffer,
	-- })
	vim.keymap.set("n", "<leader>vrr", fzf.lsp_references, {
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
		-- vim.api.nvim_create_autocmd("CursorHold", {
		-- 	callback = function()
		-- 		vim.diagnostic.open_float(nil, { focusable = false })
		-- 	end,
		-- 	group = diag_float_grp,
		-- })
	end
	if O.ui.signature == "custom" then
		-- require("lsp_signature").on_attach(conf, buffer)
		require("onam.helpers.lsp.signature").setup(client, buffer)
	else
		require("lsp_signature").on_attach({
			hint_prefix = "",
		}, buffer)
	end
	--
	-- refresh codelens on TextChanged and InsertLeave as well
	vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave", "CursorHold", "LspAttach" }, {
		buffer = buffer,
		callback = vim.lsp.codelens.refresh,
	})

	-- trigger codelens refresh
	vim.api.nvim_exec_autocmds("User", { pattern = "LspAttached" })

	-- if vim.g.disable_semantic_tokens and client.supports_method("textDocument/semanticTokens") then
	-- 	client.server_capabilities.semanticTokensProvider = nil
	-- end

	if client.supports_method("textDocument/publishDiagnostics") then
		vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
			signs = true,
			underline = true,
			virtual_text = {
				spacing = 5,
				severity_limit = "Hint",
			},
			update_in_insert = true,
		})
		-- local ns_id = vim.api.nvim_create_namespace("lsp-highlighter-custom")
		-- require("onam.helpers.lsp.textDocument")
	end
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
							globals = { "vim", "bit" },
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
			clangd = {
				on_attach = on_attach,
			},
			omnisharp = {
				on_attach = on_attach,
				cmd = {
					"dotnet",
					"C:\\Users\\onam7\\AppData\\Local\\nvim-data\\mason\\packages\\omnisharp\\libexec\\OmniSharp.dll",
				},
				root_dir = { "*.sln", "*.csproj", "omnisharp.json", "function.json", "*.log" },
			},
			ruff_lsp = defaults,
			markdown_oxide = {
				on_attach = function(client, bufnr)
					on_attach(client, bufnr)
					-- client.server_capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true
					vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave", "CursorHold", "LspAttach" }, {
						buffer = bufnr,
						callback = vim.lsp.codelens.refresh,
					})

					-- trigger codelens refresh
					vim.api.nvim_exec_autocmds("User", { pattern = "LspAttached" })
				end,
			},
		},
		config = function(_, opts)
			local lspconfig = require("lspconfig")
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			if O.lsp.coq then
				capabilities = require("coq").lsp_ensure_capabilities(capabilities)
			else
				capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
			end
			capabilities.workspace = {
				didChangeWatchedFiles = {
					dynamicRegistration = true,
				},
			}
			-- require("lspconfig.ui.windows").default_options = tools.ui.cur_border
			-- vim.api.nvim_set_hl(0, "LspInfoBorder", { link = "FloatBorder" })
			for server, settings in pairs(opts) do
				local server_opts = vim.tbl_deep_extend("force", {
					capabilities = vim.deepcopy(capabilities),
				}, settings or {})
				if server_opts.root_dir then
					print("opts")
					server_opts.root_dir = lspconfig.util.root_pattern(unpack(server_opts.root_dir))
				end
				if server == "arduino_language_server" then
					lspconfig.arduino_language_server.setup({
						cmd = {
							"arduino-language-server",
							"-cli-config",
							"C:\\Users\\onam7\\AppData\\Local\\Arduino15\\arduino-cli.yaml",
						},
						unpack(server_opts),
					})
				else
					lspconfig[server].setup(server_opts)
				end
			end
			for _, icon in ipairs(tools.ui.lsp_signs) do
				local hl = "DiagnosticSign" .. icon.name
				vim.fn.sign_define(hl, { text = icon.sym, texthl = hl, numhl = hl })
			end
			vim.diagnostic.config({
				underline = true,
				severity_sort = true,
				virtual_text = {
					prefix = tools.ui.icons.x,
				},
				float = {
					header = " ",
					border = tools.ui.cur_border,
					source = "if_many",
					title = { { " 󰌶 Diagnostics ", "FloatTitle" } },
					prefix = function(diag)
						local severity = vim.diagnostic.severity[diag.severity]
						local level = severity:sub(1, 1) .. severity:sub(2):lower()
						local prefix = string.format(" %s  ", tools.ui.lsp_signs[diag.severity].sym)
						return prefix, "Diagnostic" .. level:gsub("^%l", string.upper)
					end,
				},
			})
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		event = { "InsertEnter" },
		ft = { "markdown" },
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
		cond = O.lsp.cmp,
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
