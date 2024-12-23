require("blink.cmp").setup({
  keymap = {
    preset = "default",
    ["<C-e>"] = {},
    ["<Tab>"] = {
      function(cmp)
        if vim.fn.getcmdline() ~= "" then return cmp.accept() end
      end,
      "fallback",
    },
    ["<S-Tab>"] = {
      function(cmp)
        if vim.fn.getcmdline() ~= "" then return cmp.select_prev() end
      end,
      "fallback",
    },
  },
  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = "mono",
  },
  completion = {
    accept = {
      -- experimental auto-brackets support
      auto_brackets = {
        enabled = true,
      },
    },
    menu = {
      draw = {
        treesitter = { "lsp" },
        columns = { { "kind_icon" }, { "label", "label_description", gap = 1 } },
      },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
    },
    ghost_text = {
      enabled = true,
    },
  },
  signature = { enabled = true },
})
