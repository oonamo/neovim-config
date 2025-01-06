-- TODO: snippets
require("blink.cmp").setup({
  snippets = {
    expand = function(args)
      local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
      insert({ body = args })
    end,
    active = function(_) return MiniSnippets.session.get() ~= nil end,
    jump = function(direction) MiniSnippets.session.jump(direction == 1 and "next" or "prev") end,
  },
  keymap = {
    preset = "default",
    ["<C-e>"] = {},
    ["<Tab>"] = {
      function(cmp)
        if cmp.snippet_active() then
          return cmp.accept()
        else
          return cmp.select_and_accept()
        end
      end,
      "snippet_forward",
      "fallback",
    },
    ["<S-Tab>"] = {
      "snippet_backward",
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
      border = "solid",
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
