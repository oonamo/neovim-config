require("tiny-glimmer").setup({
  overwrite = {
    auto_map = true,
    paste = {
      default_animation = "pulse",
    },
    search = {
      enabled = true,
    },
  },
  animations = {
    pulse = {
      from_color = "DiffDelete",
      to_color = "DiffAdd",
    },
  },
})
-- vim.keymap.set("n", "n", function() require("tiny-glimmer").search_next() end)
-- vim.keymap.set("n", "N", function() require("tiny-glimmer").search_prev() end)
-- vim.keymap.set("n", "p", function() require("tiny-glimmer").paste() end)
-- vim.keymap.set("n", "P", function() require("tiny-glimmer").Paste() end)
-- vim.keymap.set("n", "y", function() require("tiny-glimmer").yank() end)
-- vim.keymap.set("n", "P", function() require("tiny-glimmer").Yank() end)
