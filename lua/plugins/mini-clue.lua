local clue = require("mini.clue")
clue.setup({
  triggers = {
    -- Leader triggers
    { mode = "n", keys = "<Leader>" },
    { mode = "x", keys = "<Leader>" },
    { mode = "n", keys = "<localleader>" },
    { mode = "x", keys = "<localleader>" },

    { mode = "n", keys = "\\" },

    -- Built-in completion
    { mode = "i", keys = "<C-x>" },

    -- `g` key
    { mode = "n", keys = "g" },
    { mode = "x", keys = "g" },

    { mode = "n", keys = "s" },
    { mode = "x", keys = "s" },

    -- Marks
    { mode = "n", keys = "'" },
    { mode = "n", keys = "`" },
    { mode = "x", keys = "'" },
    { mode = "x", keys = "`" },

    -- Registers
    { mode = "n", keys = '"' },
    { mode = "x", keys = '"' },
    { mode = "i", keys = "<C-r>" },
    { mode = "c", keys = "<C-r>" },

    -- Window commands
    { mode = "n", keys = "<C-w>" },

    -- `z` key
    { mode = "n", keys = "z" },
    { mode = "x", keys = "z" },

    { mode = "n", keys = "<C-x>" },
    { mode = "x", keys = "<C-x>" },

    { mode = "n", keys = "[" },
    { mode = "x", keys = "[" },
    { mode = "n", keys = "]" },
    { mode = "x", keys = "]" },

    { mode = "n", keys = "<M-g>" },
    { mode = "x", keys = "<M-g>" },
  },
  window = {
    delay = 0,
    config = {
      -- border = { "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", },
      border = "solid",
      footer = {
        { "Mappings:", "MiniClueDescGroup" },
        { "<C-d>/<C-u>", "MiniClueTitle" },
      },
    },
  },
  clues = {
    clue.gen_clues.builtin_completion(),
    clue.gen_clues.g(),
    clue.gen_clues.marks(),
    clue.gen_clues.registers({ show_contents = true }),
    clue.gen_clues.windows(),
    clue.gen_clues.z(),
      -- stylua: ignore start
      { mode = "n", keys = "<Leader>b",     desc = "  Buffer" },
      { mode = "n", keys = "<Leader>g",     desc = "󰊢  Git" },
      { mode = "n", keys = "<Leader>s",     desc = "  Search" },
      { mode = "n", keys = "<Leader>l",     desc = "󰘦  LSP" },
      { mode = "n", keys = "<Leader>w",     desc = "  Window" },
      { mode = "n", keys = "<Leader><tab>", desc = "  Tabs" },
      { mode = "n", keys = "<Leader>!",     desc = " Shell" },
      { mode = "n", keys = "<Leader>o",     desc = "+Other" },
      { mode = "n", keys = "<Leader>t",     desc = "  Terminal" },
      { mode = "n", keys = "<Leader>v",     desc = " Visits" },
      { mode = "n", keys = "<Leader>f",     desc = "  Find" },
      { mode = "n", keys = "<Leader>p",     desc = "  Paste" },
    --stylua: ignore end

    -- Bracketed:
    { mode = "n", keys = "]b", postkeys = "]" },
    { mode = "n", keys = "[b", postkeys = "[" },
    { mode = "n", keys = "]c", postkeys = "]" },
    { mode = "n", keys = "[c", postkeys = "[" },
    { mode = "n", keys = "]d", postkeys = "]" },
    { mode = "n", keys = "[d", postkeys = "[" },
    { mode = "n", keys = "]h", postkeys = "]" },
    { mode = "n", keys = "[h", postkeys = "[" },
    { mode = "n", keys = "]q", postkeys = "]" },
    { mode = "n", keys = "[q", postkeys = "[" },
    { mode = "n", keys = "]t", postkeys = "]" },
    { mode = "n", keys = "[t", postkeys = "[" },
    { mode = "n", keys = "]u", postkeys = "]" },
    { mode = "n", keys = "[u", postkeys = "[" },
    { mode = "n", keys = "]w", postkeys = "]" },
    { mode = "n", keys = "[w", postkeys = "[" },
    { mode = "n", keys = "]y", postkeys = "]" },
    { mode = "n", keys = "[y", postkeys = "[" },
  },
})
