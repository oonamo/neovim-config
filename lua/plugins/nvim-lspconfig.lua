---@param client vim.lsp.Client
---@param buffer number
local function on_attach(client, buffer)
  local function map_if_supported(method, lhs, rhs, desc, opts)
    if client:supports_method(method, buffer) then
      opts = opts or {}
      opts.desc = desc
      opts.buffer = buffer
      vim.keymap.set("n", lhs, rhs, opts)
    end
  end

  if Config.completion == "mini" then vim.bo[buffer].omnifunc = "v:lua.MiniCompletion.completefunc_lsp" end

  map_if_supported("textDocument/codeAction", "<leader>la", vim.lsp.buf.code_action, "Apply Code Action")
  map_if_supported("textDocument/definition", "<leader>ld", vim.lsp.buf.definition, "Go to defnition")
  map_if_supported("textDocument/implementation", "<leader>li", vim.lsp.buf.implementation, "Go to implementation")
  map_if_supported("textDocument/references", "<leader>lr", vim.lsp.buf.references, "Go to implementation")
  map_if_supported("textDocument/typeDefinition", "<leader>lt", vim.lsp.buf.type_definition, "Go to type definition")
  map_if_supported("textDocument/declaration", "<leader>lD", vim.lsp.buf.declaration, "Go to type definition")
  map_if_supported("textDocument/rename", "<leader>ln", vim.lsp.buf.rename, "Rename symbol")
  map_if_supported("textDocument/rename", "<leader>ln", vim.lsp.buf.rename, "Rename symbol")
  map_if_supported("textDocument/signatureHelp", "<leader>k", vim.lsp.buf.signature_help, "Rename symbol")

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

  vim.keymap.set("n", "<leader>ll", function() vim.diagnostic.open_float() end, {
    desc = "Open float menu",
    buffer = buffer,
  })

  -- vim.keymap.set("n", "[d", vim.diagnostic.goto_next, {
  --   desc = "Got to next diagnostic",
  --   buffer = buffer,
  -- })
  --
  -- vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, {
  --   desc = "Go to previous diagnostic",
  --   buffer = buffer,
  -- })

  -- vim.keymap.set("n", "<leader>ln", vim.lsp.buf.rename, { desc = "Rename symbol", buffer = buffer, expr = true })
  -- vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, {
  --   desc = "Signature help",
  --   buffer = buffer,
  -- })

  -- if client.supports_method("textDocument/inlayHint") then
  --   vim.keymap.set(
  --     "n",
  --     "<leader>lh",
  --     function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,
  --     { desc = "Inlay Hint" }
  --   )
  -- end

  vim.keymap.set(
    "n",
    "<leader>lq",
    vim.diagnostic.setqflist,
    { desc = "Quickfix [L]ist [D]iagnostics", buffer = buffer }
  )

  vim.keymap.set("n", "<leader>ls", function() require("config.lsp").request(true) end, {
    desc = "Request Signature",
    buffer = buffer,
  })

  -- vim.keymap.set("n", "<leader>le", function() require("config.lsp").echo_area_sig() end, {
  --   desc = "Request Signature (Echo Area)",
  --   buffer = buffer,
  -- })

  vim.keymap.set("n", "gO", function() vim.lsp.buf.document_symbol({ loclist = true }) end, { buffer = buffer })
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
  virtual_lines = {
    format = function(s)
      if s.severity ~= vim.diagnostic.severity.ERROR then return end
      return s.message
    end,
  },
  virtual_text = {
    spacing = 4,
    prefix = "<",
    format = function(s)
      if s.severity == vim.diagnostic.severity.ERROR then return end
      return s.message
    end
    -- prefix = function(diag)
    -- 	return diagnostics_symbols[diag.severity]
    -- end,
  },
  float = {
    header = " ",
    border = "rounded",
    source = "if_many",
    title = { { "󰌶  Diagnostics ", "FloatTitle" } },
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
      -- [vim.diagnostic.severity.ERROR] = "x ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      -- [vim.diagnostic.severity.WARN] = "▲ ",
      [vim.diagnostic.severity.INFO] = "󰋽 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
    },
  },
})
