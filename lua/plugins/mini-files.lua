local function copy_file_under_cursor(data)
  local path = (MiniFiles.get_fs_entry() or {}).path
  if path == nil then return vim.notify("Cursor is not on valid entry") end
  vim.notify("Yanked '" .. path .. "''")
  vim.fn.setreg(vim.v.register, path)
end

require("mini.files").setup({
  windows = {
    preview = true,
  },
  mappings = {
    go_in = "<cr>",
    go_in_plus = "L",
    go_out = "-",
    go_out_plus = "H",
    -- go_in = "<cr>",
    -- go_in_plus = "l",
    -- go_out = "-",
    -- go_out_plus = "H",
  },
  options = {
    use_as_default_explorer = true,
  },
})

local map_split = function(buf_id, lhs, direction, close_on_file)
  local rhs = function()
    local new_target_window
    local cur_target_window = MiniFiles.get_explorer_state().target_window
    if cur_target_window ~= nil then
      vim.api.nvim_win_call(cur_target_window, function()
        vim.cmd("belowright " .. direction .. " split")
        new_target_window = vim.api.nvim_get_current_win()
      end)

      MiniFiles.set_target_window(new_target_window)
      MiniFiles.go_in({ close_on_file = close_on_file })
    end
  end

  local desc = "Open in " .. direction .. " split"
  if close_on_file then desc = desc .. " and close" end
  vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
end

local group = vim.api.nvim_create_augroup("mini-files-augroups", { clear = true })

vim.api.nvim_create_autocmd("User", {
  group = group,
  pattern = "MiniFilesExplorerOpen",
  callback = function()
    MiniFiles.set_bookmark("c", vim.fn.stdpath("config"), { desc = "Config" })
    MiniFiles.set_bookmark("o", "C:/Users/onam7/Desktop/DB/DB", { desc = "Obsidian" })
    MiniFiles.set_bookmark("w", vim.fn.getcwd, { desc = "Working directory" })
    MiniFiles.set_bookmark("p", vim.fn.expand("~/projects"), { desc = "Working directory" })
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesBufferCreate",
  group = group,
  callback = function(args)
    local buf_id = args.data.buf_id
    vim.keymap.set("n", "g.", copy_file_under_cursor, { buffer = buf_id })
    map_split(buf_id, "<C-s>", "horizontal", true)
    map_split(buf_id, "<C-v>", "vertical", true)
  end,
})
