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
local function on_attach(client, buffer)
	print("Called attach")
	local opts = { buffer = buffer }
	if client.name == "rust_analyzer" then
		vim.keymap.set("n", "<leader>h", ":RustHoverActions<cr>", opts)
		vim.keymap.set("n", "<leader>gp", ":RustParentModule<cr>", opts)
		print("detected rust")
	else
		vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, opts)
	end
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
	vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
	vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
	vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
	vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
	vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
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
		})
	end,
})

vim.wo.signcolumn = "yes"
