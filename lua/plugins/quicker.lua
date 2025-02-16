require("quicker").setup({
  opts = {
    number = true,
    signcolumn = "no",
  },
  borders = {
  },
  keys = {
    {
      ">",
      function() require("quicker").expand({ before = 2, after = 2, add_to_existing = true }) end,
      desc = "Expand quickfix context",
    },
    {
      "<",
      function() require("quicker").collapse() end,
      desc = "Collapse quickfix context",
    },
  },
  highlight = {
    treesitter = false,
    lsp = false,
    load_buffers = false,
  },
})
