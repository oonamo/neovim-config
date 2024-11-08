---@param client vim.lsp.Client
---@param buffer number
local function on_attach(client, buffer)
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
		require("mini.extra").pickers.lsp({ scope = "definition" })
	end, { desc = "go to multiple definition", buffer = buffer })
	vim.keymap.set("n", "<leader>vws", function()
		require("mini.extra").pickers.lsp({ scope = "workspace_symbol" })
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
	vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, {
		desc = "Go to lsp references",
		buffer = buffer,
	})
	vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, {
		desc = "Rename symbol",
		buffer = buffer,
	})
	vim.keymap.set("n", "<leader>vxx", function()
		require("mini.extra").pickers.diagnostic()
	end, { desc = "Find diagnostics", buffer = buffer })
	vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, {
		desc = "Signature help",
		buffer = buffer,
	})
	if client.supports_method("textDocument/inlayHint") then
		vim.keymap.set("n", "<leader>ih", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
		end, { desc = "Inlay Hint" })
	end
	vim.keymap.set("n", "<leader>qf", vim.diagnostic.setqflist, { desc = "Quickfix [L]ist [D]iagnostics" })
	vim.keymap.set("n", "<leader>ld", vim.diagnostic.setloclist, { desc = "Quickfix [L]ist [D]iagnostics" })
	vim.keymap.set("n", "<C-]>", "<C-w><C-]>")

	vim.keymap.set("n", "<leader>ss", function()
		require("config.lsp").request(true)
	end)
end
local defaults = { on_attach = on_attach }

return {
	"neovim/nvim-lspconfig",
	event = { "BufWritePre", "BufReadPost", "BufNewFile" },
	opts = {
		lua_ls = {
			on_attach = function(client, bufnr)
				on_attach(client, bufnr)
				-- `MiniCompletion` experience
				client.server_capabilities.completionProvider.triggerCharacters = { ".", ":" }
			end,
			handlers = {
				["textDocument/definition"] = function(err, result, ctx, config)
					if type(result) == "table" then
						result = { result[1] }
					end
					vim.lsp.handlers["textDocument/definition"](err, result, ctx, config)
				end,
			},
			settings = {
				Lua = {
					runtime = { version = "LuaJIT" },
					diagnostics = {
						globals = { "vim", "bit" },
						workspaceDelay = -1,
					},
					telemetry = {
						enable = false,
					},
					workspace = {
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
						ignoreSubmodules = true,
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
		clangd = {
      cmd = { "clangd", "--enable-config" },
			on_attach = on_attach,
		},
		rust_analyzer = defaults,
		markdown_oxide = {
			on_attach = on_attach,
		},
	},
	config = function(_, opts)
		local lspconfig = require("lspconfig")
		local capabilities = (function()
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
			-- local server_opts = vim.tbl_deep_extend("force", {
			-- 	capabilities = 
			-- }, settings or {})
      settings.capabilities = require("blink.cmp").get_lsp_capabilities(settings.capabilities)
			if settings.root_dir then
				settings.root_dir = lspconfig.util.root_pattern(unpack(settings.root_dir))
			end
			lspconfig[server].setup(settings)
		end
		local sign_define = vim.fn.sign_define
		sign_define("DiagnosticSignError", { text = "󰅙 ", texthl = "DiagnosticSignError" })
		sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
		sign_define("DiagnosticSignHint", { text = " ", texthl = "DiagnosticSignHint" })
		sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
		local diagnostics_symbols = {
			[vim.diagnostic.severity.ERROR] = "x",
			[vim.diagnostic.severity.WARN] = "!",
			[vim.diagnostic.severity.HINT] = "?",
			[vim.diagnostic.severity.INFO] = "i",
		}
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
			},
			signs = {
				-- text = {
				-- 	[vim.diagnostic.severity.ERROR] = " ",
				-- 	[vim.diagnostic.severity.WARN] = " ",
				-- 	[vim.diagnostic.severity.HINT] = " ",
				-- 	[vim.diagnostic.severity.INFO] = " ",
				-- },
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
}
