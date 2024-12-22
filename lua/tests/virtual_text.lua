local ns = vim.api.nvim_create_namespace("Testing")

-- vim.api.nvim_buf_set_extmark(0, ns, 1, 10, {
--   virt_text = { { "Hello", "Special" } },
-- })

local stat = vim.uv.fs_stat(vim.api.nvim_buf_get_name(0))

local str = Config.size_str(stat.size)

vim.api.nvim_buf_set_extmark(0, ns, 11 - 1, 0, {
  virt_text = Config.mode_to_table_str(stat.mode),
  virt_text_win_col = 40,
  -- end_col = widths[1] + 14,
  hl_mode = "combine",
})
vim.api.nvim_buf_set_extmark(0, ns, 11 - 1, 0, {
  virt_text = {Config.size_str(stat.size), "Normal" }
  virt_text_win_col = 40,
  -- end_col = widths[1] + 14,
  hl_mode = "combine",
})
vim.print(str)
