require("quicker-md").setup()

vim.keymap.set({ "v" }, "<leader>rs", function() require("quicker-md").evaluate_selection() end)


vim.keymap.set(
  { "v" },
  "<leader>rS",
  function()
    require("quicker-md").evaluate_selection({
      strategy = "substitute",
    })
  end
)

vim.keymap.set(
  { "v" },
  "<leader>rb",
  function()
    require("quicker-md").evaluate_selection({
      local_opts = {
        inline = {
          position = "below",
        },
      },
    })
  end
)

vim.keymap.set(
  { "v" },
  "<leader>rf",
  function()
    require("quicker-md").evaluate_selection({
      strategy = "float",
    })
  end
)

vim.keymap.set({ "n" }, "<leader>rr", function() local repl = require("quicker-md.repl").toggle("js") end)
vim.keymap.set({ "n" }, "<leader>rp", function() local repl = require("quicker-md.repl").toggle("ps1") end)
