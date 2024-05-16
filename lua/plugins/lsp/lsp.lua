---@param use_code_lens boolean|nil
local function on_attach(client, buffer, use_code_lens)
	local fzf = require("fzf-lua")
	if client.name == "rust_analyzer" then
		vim.keymap.set("n", "K", function()
			vim.cmd.RustLsp({ "hover", "actions" })
		end, { desc = "Rust Hover Actions", buffer = buffer })
		vim.keymap.set("n", "<leader>vca", function()
			vim.cmd.RustLsp("codeAction")
		end, { desc = "Rust code actions", buffer = buffer })
	else
		-- vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, {
		-- 	desc = "Hover details",
		-- 	buffer = buffer,
		-- })
		vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, {
			desc = "Preview code actions",
			buffer = buffer,
		})
	end
	vim.keymap.set("n", "gd", function()
		vim.lsp.buf.definition()
	end, {
		desc = "go to buffer definition",
		buffer = buffer,
	})
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
	if O.ui.signature == "custom" then
		require("onam.helpers.lsp.signature").setup(client, buffer)
	end

	-- refresh codelens on TextChanged and InsertLeave as well
	if client.supports_method("textDocument/codeLens") and use_code_lens then
		vim.lsp.codelens.refresh()
		-- vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave", "CursorHold", "LspAttach" }, {
		-- 	buffer = buffer,
		-- 	callback = vim.lsp.codelens.refresh,
		-- })
		vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
			buffer = buffer,
			callback = vim.lsp.codelens.refresh,
		})
		-- trigger codelens refresh
		vim.api.nvim_exec_autocmds("User", { pattern = "LspAttached" })
	end

	if client.supports_method("textDocument/publishDiagnostics") then
		vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
			signs = true,
			underline = true,
			virtual_text = {
				spacing = 5,
				min = "Hint",
			},
			update_in_insert = true,
		})
	end

	if client.supports_method("textDocument/inlayHint") then
		vim.keymap.set("n", "<leader>h", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
		end)
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
						-- codeLens = {
						-- 	enable = false,
						-- },
						hint = {
							enable = true,
							setType = false,
							paramType = true,
							paramName = true,
							semicolon = "Disable",
							arrayIndex = "Disable",
						},
					},
				},
			},
			tsserver = defaults,
			html = defaults,
			eslint = defaults,
			-- powershell_es = {
			-- 	shell = "pwsh",
			-- 	-- bundle_path = "C:/Windows/PowerShellEditorServices",
			-- },
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
					on_attach(client, bufnr, true)
					-- client.server_capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true
					-- vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave", "CursorHold", "LspAttach" }, {
					-- 	buffer = bufnr,
					-- 	callback = vim.lsp.codelens.refresh,
					-- })

					-- trigger codelens refresh
					-- vim.api.nvim_exec_autocmds("User", { pattern = "LspAttached" })
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
			for server, settings in pairs(opts) do
				local server_opts = vim.tbl_deep_extend("force", {
					capabilities = vim.deepcopy(capabilities),
				}, settings or {})
				if server_opts.root_dir then
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
							["**/build"] = true,
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
							"build",
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
				end,
			},
			tools = {
				hover_actions = {
					auto_focus = true,
				},
			},
		},
		config = function(_, opts)
			vim.g.rustaceanvim = opts
		end,
	},
}
