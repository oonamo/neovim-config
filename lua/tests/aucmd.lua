local group = vim.api.nvim_create_augroup("obsidian_setup", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  group = group,
  pattern = "*.md",
  callback = function(ev) vim.print(ev) end,
})

vim.defer_fn(
  function()
    vim.api.nvim_exec_autocmds("BufEnter", {
      -- group = vim.api.nvim_create_augroup("obsidian_setup", { clear = true }),
      pattern = "*.md",
      data = {
        match = vim.api.nvim_buf_get_name(0),
      },
    })
  end,
  1000
)

-- Complete setup and update workspace (if needed) when entering a markdown buffer.
