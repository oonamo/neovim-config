---@param client vim.lsp.Client
---@param buffer number
local function on_attach(client, buffer)
  vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, {
    desc = "Preview code actions",
    buffer = buffer,
  })

  vim.keymap.set("n", "gd", vim.lsp.buf.definition, {
    desc = "go to buffer definition",
    buffer = buffer,
  })

  vim.keymap.set(
    "n",
    "gD",
    function() require("mini.extra").pickers.lsp({ scope = "definition" }) end,
    { desc = "go to multiple definition", buffer = buffer }
  )

  vim.keymap.set("n", "<leader>ld", function() vim.diagnostic.open_float() end, {
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

  vim.keymap.set("n", "<leader>lr", vim.lsp.buf.references, {
    desc = "Go to lsp references",
    buffer = buffer,
  })

  vim.keymap.set("n", "<leader>ln", vim.lsp.buf.rename, { desc = "Rename symbol", buffer = buffer, expr = true })
  vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, {
    desc = "Signature help",
    buffer = buffer,
  })

  if client.supports_method("textDocument/inlayHint") then
    vim.keymap.set(
      "n",
      "<leader>lh",
      function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,
      { desc = "Inlay Hint" }
    )
  end

  vim.keymap.set("n", "<leader>lq", vim.diagnostic.setqflist, { desc = "Quickfix [L]ist [D]iagnostics" })
  vim.keymap.set("n", "<leader>ld", vim.diagnostic.setloclist, { desc = "Quickfix [L]ist [D]iagnostics" })

  vim.keymap.set("n", "<leader>ls", function() require("config.lsp").request(true) end, {
    desc = "Request Signature",
  })

  vim.keymap.set("n", "<leader>le", function() require("config.lsp").echo_area_sig() end, {
    desc = "Request Signature (Echo Area)",
  })

  vim.keymap.set("n", "grn", vim.lsp.buf.rename)
  vim.keymap.set("n", "grr", vim.lsp.buf.references)
  vim.keymap.set("n", "gra", vim.lsp.buf.code_action)
  vim.keymap.set("n", "gO", vim.lsp.buf.document_symbol)
end

local defaults = { on_attach = on_attach }
local servers = {
  lua_ls = {
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      -- `MiniCompletion` experience
      client.server_capabilities.completionProvider.triggerCharacters = { ".", ":" }
    end,
    handlers = {
      ["textDocument/definition"] = function(err, result, ctx, config)
        if type(result) == "table" then result = { result[1] } end
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
    capabilities = {
      workspace = {
        didChangeWatchedFiles = {
          dynamicRegistration = true,
        },
      },
    },
  },
}

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

for server, settings in pairs(servers) do
  settings.capabilities = vim.tbl_deep_extend("force", vim.deepcopy(capabilities), settings.capabilities or {})
  -- settings.capabilities = require("blink.cmp").get_lsp_capabilities(settings.capabilities)
  if settings.root_dir then
    if type(settings.root_dir) == "string" and utils[settings.root_dir] then
      settings.root_dir = utils[settings.root_dir]
    else
      settings.root_dir = lspconfig.util.root_pattern(unpack(settings.root_dir))
    end
  end
  if server ~= "custom" then lspconfig[server].setup(settings) end
end

vim.diagnostic.config({
  underline = true,
  severity_sort = true,
  -- virtual_text = false, -- For tiny-inline-diagnostic
  virtual_text = {
    spacing = 4,
    prefix = "<",
    -- prefix = function(diag)
    -- 	return diagnostics_symbols[diag.severity]
    -- end,
  },
  float = {
    header = " ",
    border = "rounded",
    source = "if_many",
    title = { { " 󰌶 Diagnostics ", "FloatTitle" } },
  },
  signs = {
    numhl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
      [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
      [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
    },
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.INFO] = "󰋽 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
    },
  },
})
