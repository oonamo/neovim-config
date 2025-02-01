local function copy_file_under_cursor(data)
  local path = (MiniFiles.get_fs_entry() or {}).path
  if path == nil then return vim.notify("Cursor is not on valid entry") end
  vim.notify("Yanked '" .. path .. "''")
  vim.fn.setreg(vim.v.register, path)
end

require("mini.files").setup({
  windows = {
    -- width_focus = 999999,
    preview = true,
  },
  mappings = {
    -- go_in = "<cr>",
    go_in_plus = "l",
    -- go_out = "-",
    -- go_out_plus = "H",
  },
  options = {
    use_as_default_explorer = true,
  },
})

local group = vim.api.nvim_create_augroup("mini-files-keymaps", { clear = true })
local inc_search = vim.api.nvim_get_hl(0, { name = "IncSearch" })
inc_search.default = true

-- vim.api.nvim_set_hl(0, "MiniFilesNormal", { link = "Normal" })
vim.api.nvim_set_hl(0, "MiniFilesBorder", { link = "MiniFilesNormal" })

vim.api.nvim_create_autocmd("ColorScheme", {
  group = group,
  callback = function() vim.api.nvim_set_hl(0, "MiniFilesBorder", { link = "MiniFilesNormal" }) end,
})

vim.api.nvim_create_autocmd("User", {
  group = group,
  pattern = "MiniFilesWindowOpen",
  callback = function(args)
    -- vim.api.nvim_win_set_config(args.data.win_id, { border = "solid", height = vim.o.lines })
    vim.api.nvim_win_set_config(args.data.win_id, { border = "solid" })
  end,
})

vim.api.nvim_create_autocmd("User", {
  group = group,
  pattern = "MiniFilesWindowUpdate",
  callback = function(args)
    -- vim.api.nvim_win_set_config(args.data.win_id, { border = "solid", height = vim.o.lines })
    vim.api.nvim_win_set_config(args.data.win_id, { border = "solid" })
  end,
})

vim.api.nvim_create_autocmd("User", {
  group = group,
  pattern = "MiniFilesExplorerOpen",
  callback = function()
    MiniFiles.set_bookmark("c", vim.fn.stdpath("config"), { desc = "Config" })
    MiniFiles.set_bookmark("o", "C:/Users/onam7/Desktop/DB/DB", { desc = "Config" })
    MiniFiles.set_bookmark("w", vim.fn.getcwd, { desc = "Working directory" })
    MiniFiles.set_bookmark("p", vim.fn.expand("~/projects"), { desc = "Working directory" })
    local inc_search = vim.api.nvim_get_hl(0, { name = "IncSearch" })
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
