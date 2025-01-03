local function copy_file_under_cursor(data)
  local path = (MiniFiles.get_fs_entry() or {}).path
  if path == nil then return vim.notify("Cursor is not on valid entry") end
  vim.notify("Yanked '" .. path .. "''")
  vim.fn.setreg(vim.v.register, path)
end
require("mini.files").setup({})

local augrup = vim.api.nvim_create_augroup("mini-files-keymaps", { clear = true })

vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesBufferCreate",
  group = augrup,
  callback = function(args)
    local buf_id = args.data.buf_id
    vim.keymap.set("n", "gy", copy_file_under_cursor, { buffer = buf_id })
  end,
})
