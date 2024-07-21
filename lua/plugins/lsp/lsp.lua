-- HACK Disable semantic tokens for highlights that already incorporate the highlight
-- vim.highlight.priorities.semantic_tokens = 95

---@param client vim.lsp.Client
---@param buffer number
---@param use_code_lens boolean?
local function on_attach(client, buffer, use_code_lens)
	local methods = vim.lsp.protocol.Methods
	local telescope = require("telescope.builtin")
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
		telescope.lsp_definitions({ jump_type = "split" })
	end, { desc = "go to multiple definition", buffer = buffer })
	vim.keymap.set("n", "<leader>vws", function()
		telescope.lsp_workspace_symbols()
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
		telescope.lsp_references()
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
	vim.keymap.set("n", "<leader>vxx", function()
		telescope.diagnostics()
	end, { desc = "Find diagnostics", buffer = buffer })
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
	vim.keymap.set("n", "<leader>qf", vim.diagnostic.setqflist, { desc = "Quickfix [L]ist [D]iagnostics" })
	vim.keymap.set("n", "<leader>ld", vim.diagnostic.setloclist, { desc = "Quickfix [L]ist [D]iagnostics" })
	vim.keymap.set("n", "<C-]>", "<C-w><C-]>")
	-- vim.keymap.set("n", "<C-[>", "<C-w>v<C-]>")
end

local defaults = { on_attach = on_attach }
return {
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		build = ":MasonUpdate",
		opts = {
			ensure_installed = {
				"stylua",
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"mason.nvim",
		},
		event = "LazyFile",
		opts = {
			lua_ls = {
				on_attach = on_attach,
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
				on_attach = on_attach,
			},
		},
		config = function(_, opts)
			local lspconfig = require("lspconfig")
			local capabilities = (function()
				if O.lsp.cmp then
					return require("cmp_nvim_lsp").default_capabilities()
				end
				return {
					workspace = {},
				}
			end)()
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
				lspconfig[server].setup(server_opts)
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
