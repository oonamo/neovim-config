require("blink.cmp").setup({
  keymap = {
    preset = "default",
    ["<C-e>"] = {},
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
        columns = { { "item_idx" }, { "kind_icon" }, { "label", "label_description", gap = 1 } },
        components = {
          item_idx = {
            text = function(ctx)
              return tostring(ctx.idx)
            end,
            highlight = "BlimkCmpItemIdx",
          },
        },
      },
      -- draw = {
      -- 	treesitter = { "lsp" },
      -- },
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
