---@param client vim.lsp.Client
---@param buffer number
local function on_attach(client, buffer)
  vim.bo[buffer].omnifunc = "v:lua.MiniCompletion.completefunc_lsp"
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
	vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, { desc = "Rename symbol", buffer = buffer, expr = true })
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
	-- vim.keymap.set("n", "<C-]>", "<C-w><C-]>")

	vim.keymap.set("n", "<leader>ss", function()
		require("config.lsp").request(true)
	end)
end
local defaults = { on_attach = on_attach }

return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufWritePre", "BufReadPost", "BufNewFile" },
		dependencies = "netmute/ctags-lsp.nvim",
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
			-- ccls = {
			-- 	init_options = {
			-- 		-- compilationDatabaseDirectory = "build",
			-- 		index = {
			-- 			threads = 0,
			-- 		},
			-- 		clang = {
			-- 			excludeArgs = { "-frounding-math" },
			-- 		},
			-- 	},
			--     on_attach = on_attach,
			-- },
			clangd = {
				-- cmd = { "clangd" },
				on_attach = on_attach,
				capabilities = {
					semanticTokensProvider = false,
				},
			},
			rust_analyzer = defaults,
			markdown_oxide = {
				on_attach = on_attach,
			},
			-- ctags_lsp = {
			-- 	on_attach = on_attach,
			-- 	-- FROM: https://github.com/netmute/ctags-lsp.nvim/blob/main/lua/lspconfig/configs/ctags_lsplua
			-- 	cmd = { "C:/Users/onam7/projects/go/ctags-lsp/ctags-lsp.exe" },
			-- 	filetypes = { "c" },
			-- },
			-- custom = {
			-- 	ctags_lsp = {
			-- 		default_config = {
			-- 			cmd = { "C:/Users/onam7/projects/go/ctags-lsp/ctags-lsp.exe" },
			-- 			filetypes = nil,
			-- 			-- root_dir = "find_git_ancestor",
			-- 			root_dir = { ".git" },
			-- 		},
			-- 		docs = {
			-- 			description = [[
			-- https://github.com/netmute/ctags-lsp
			--
			-- CTags Language Server
			-- 		]],
			-- 		},
			-- 	},
			-- },
		},
		config = function(_, opts)
			local lspconfig = require("lspconfig")
			local utils = require("lspconfig.util")
			local has_blink, blink = pcall(require, "blink.cmp")
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				has_blink and blink.get_lsp_capabilities() or {}
				-- require("blink.cmp").get_lsp_capabilities() or {}
			)

			for server, settings in pairs(opts) do
				settings.capabilities =
					vim.tbl_deep_extend("force", vim.deepcopy(capabilities), settings.capabilities or {})
				-- settings.capabilities = require("blink.cmp").get_lsp_capabilities(settings.capabilities)
				if settings.root_dir then
					if type(settings.root_dir) == "string" and utils[settings.root_dir] then
						settings.root_dir = utils[settings.root_dir]
					else
						settings.root_dir = lspconfig.util.root_pattern(unpack(settings.root_dir))
					end
				end
				if server ~= "custom" then
					lspconfig[server].setup(settings)
				end
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
	},
}
