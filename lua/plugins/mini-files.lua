local function copy_file_under_cursor(data)
  local path = (MiniFiles.get_fs_entry() or {}).path
  if path == nil then return vim.notify("Cursor is not on valid entry") end
  vim.notify("Yanked '" .. path .. "''")
  vim.fn.setreg(vim.v.register, path)
end
require("mini.files").setup({})

local group = vim.api.nvim_create_augroup("mini-files-keymaps", { clear = true })

vim.api.nvim_create_autocmd("User", {
  group = group,
  pattern = "MiniFilesWindowOpen",
  callback = function(args) vim.api.nvim_win_set_config(args.data.win_id, { border = "solid" }) end,
})

vim.api.nvim_create_autocmd("User", {
  group = group,
  pattern = "MiniFilesExplorerOpen",
  callback = function()
    MiniFiles.set_bookmark("c", vim.fn.stdpath("config"), { desc = "Config" })
    MiniFiles.set_bookmark("o", "C:/Users/onam7/Desktop/DB/DB", { desc = "Config" })
    MiniFiles.set_bookmark("w", vim.fn.getcwd, { desc = "Working directory" })
    MiniFiles.set_bookmark("p", vim.fn.expand("~/projects"), { desc = "Working directory" })
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesBufferCreate",
  group = group,
  callback = function(args)
    local buf_id = args.data.buf_id
    vim.keymap.set("n", "gy", copy_file_under_cursor, { buffer = buf_id })
  end,
})
