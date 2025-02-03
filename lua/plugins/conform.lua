require("conform").setup({
  notify_on_error = false,
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "black" },
    cpp = { "clang-format" },
    c = { "clang-format" },
  },
  timeout_ms = 500,

  format_on_save = function()
    if not vim.g.autoformat then return nil end

    return {}
  end,
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
