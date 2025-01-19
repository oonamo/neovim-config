-- TODO: snippets
require("blink.cmp").setup({
  snippets = {
    preset = "mini_snippets",
    -- expand = function(args)
    --   local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
    --   insert({ body = args })
    -- end,
    -- active = function(_) return MiniSnippets.session.get() ~= nil end,
    -- jump = function(direction) MiniSnippets.session.jump(direction == 1 and "next" or "prev") end,
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
        columns = { { "kind_icon", "label_description", gap = 1 }, { "label", "kind", gap = 1 } },
        treesitter = { "lsp" },
        components = {
          kind_icon = {
            ellipsis = false,
            text = function(ctx)
              local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
              return kind_icon
            end,
            -- Optionally, you may also use the highlights from mini.icons
            highlight = function(ctx)
              local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
              return hl
            end,
          },
        },
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
