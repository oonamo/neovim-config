-- HACK Disable semantic tokens for highlights that already incorporate the highlight
-- vim.highlight.priorities.semantic_tokens = 95

---@param use_code_lens boolean|nil
local function on_attach(client, buffer, use_code_lens)
	local methods = vim.lsp.protocol.Methods
	local picker = MiniExtra.pickers
	require("onam.helpers.lsp.codeaction")
	-- if client.name == "rust_analyzer" then
	-- 	vim.keymap.set("n", "K", function()
	-- 		vim.cmd.RustLsp({ "hover", "actions" })
	-- 	end, { desc = "Rust Hover Actions", buffer = buffer })
	-- 	vim.keymap.set("n", "<leader>vca", function()
	-- 		vim.cmd.RustLsp("codeAction")
	-- 	end, { desc = "Rust code actions", buffer = buffer })
	-- else
	vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, {
		desc = "Preview code actions",
		buffer = buffer,
	})
	-- end
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, {
		desc = "go to buffer definition",
		buffer = buffer,
	})
	vim.keymap.set("n", "gD", function()
		picker.lsp({ scope = "definition" })
	end, { desc = "go to multiple definition", buffer = buffer })
	vim.keymap.set("n", "<leader>vws", function()
		picker.lsp({ scope = "workspace_symbol" })
	end, { desc = "Find workspace_symbol", buffer = buffer })
	vim.keymap.set("n", "<leader>vd", function()
		vim.diagnostic.open_float()
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
	vim.keymap.set("n", "<leader>vrr", function()
		picker.lsp({ scope = "references" })
	end, {
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
	if client.supports_method(methods.textDocument_codeLens) and use_code_lens then
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

	if client.supports_method(methods.textDocument_publishDiagnostics) then
		-- vim.lsp.handlers[methods.textDocument_publishDiagnostics] =
		-- 	vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
		-- 		signs = true,
		-- 		underline = true,
		-- 		virtual_text = {
		-- 			spacing = 5,
		-- 			min = "Hint",
		-- 		},
		-- 		update_in_insert = true,
		-- 	})
	end

	if client.supports_method("textDocument/inlayHint") then
		vim.keymap.set("n", "<leader>h", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
		end, { desc = "Inlay Hint" })
		-- vim.api.nvim_create_autocmd({ "LspAttach", "InsertEnter", "InsertLeave" }, {
		-- 	callback = function(args)
		-- 		local enable = args.event ~= "InsertEnter"
		-- 		vim.lsp.inlay_hint.enable(enable, { bufnr = args.buf })
		-- 	end,
		-- })
	end
	-- if client.supports_method(methods.textDocument_documentHighlight) then
	-- 	require("onam.helpers.lsp.documentHighlight")(buffer)
	-- end

	vim.keymap.set("n", "<leader>ld", vim.diagnostic.setqflist, { desc = "Quickfix [L]ist [D]iagnostics" })
end

local defaults = { on_attach = on_attach }
return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
		},
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		opts = {
			lua_ls = {
				on_attach = on_attach,
				on_init = function(client)
					if not client.workspace_folders or not client.workspace_folders[1] then
						return
					end
					local path = client.workspace_folders[1].name
					-- if has luarc but not neovim
					if
						(vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc"))
						and not vim.loop.fs_stat(path .. "/init.lua")
					then
						client.config.settings.Lua = {
							workspace = {
								library = {
									["C:\\Users\\onam7\\projects\\manage_my_home\\lua"] = true,
								},
							},
							runtime = { version = "Lua 5.4" },
						}
						-- client.config.settings.Lua = {}
						return
					end
				end,
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = {
							globals = { "vim", "bit" },
						},
						workspace = {
							library = {
								[vim.fn.expand("$VIMRUNTIME/lua")] = true,
								[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
								[vim.fn.stdpath("config") .. "/lua"] = true,
							},
						},
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
			powershell_es = {
				-- shell = "pwsh",
				bundle_path = "C:/Users/onam7/.vscode/extensions/ms-vscode.powershell-2024.0.0/modules/",
			},
			clangd = {
				on_attach = on_attach,
			},
			rust_analyzer = defaults,
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
					vim.api.nvim_exec_autocmds("User", { pattern = "LspAttached" })
				end,
			},
		},
		config = function(_, opts)
			local lspconfig = require("lspconfig")
			-- capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
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
			local diagnostics_symbols = {
				[vim.diagnostic.severity.ERROR] = "x",
				[vim.diagnostic.severity.WARN] = "!",
				[vim.diagnostic.severity.HINT] = "?",
				[vim.diagnostic.severity.INFO] = "i",
			}
			local sign_define = vim.fn.sign_define
			sign_define("DiagnosticSignError", { text = "󰅙 ", texthl = "DiagnosticSignError" })
			sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
			sign_define("DiagnosticSignHint", { text = " ", texthl = "DiagnosticSignHint" })
			sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })

			vim.diagnostic.config({
				underline = true,
				severity_sort = true,
				virtual_text = {
					prefix = function(diag)
						return diagnostics_symbols[diag.severity]
					end,
					-- suffix = " ",
				},
				float = {
					header = " ",
					border = "rounded",
					source = "if_many",
					title = { { " 󰌶 Diagnostics ", "FloatTitle" } },
					prefix = function(diag)
						local severity = vim.diagnostic.severity[diag.severity]
						local level = severity:sub(1, 1) .. severity:sub(2):lower()
						local prefix = string.format(" %s  ", tools.ui.lsp_signs[diag.severity].sym)
						return prefix, "Diagnostic" .. level:gsub("^%l", string.upper)
					end,
				},
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "󰅙 ",
						[vim.diagnostic.severity.WARN] = " ",
						[vim.diagnostic.severity.HINT] = " ",
						[vim.diagnostic.severity.INFO] = " ",
					},
					-- text = signs,
					linehl = {
						[vim.diagnostic.severity.ERROR] = "ErrorMsg",
					},
					numhl = {
						[vim.diagnostic.severity.WARN] = "WarningMsg",
					},
				},
			})
		end,
	},
}
