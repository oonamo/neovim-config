local M = {}
local attr = "previewwindow"

local function set_default_hl()
  vim.cmd([[
highlight default CompileModeMessage guifg=NONE gui=underline
highlight default CompileModeMessageRow guifg=Magenta
highlight default CompileModeMessageCol guifg=Cyan

highlight default CompileModeError guifg=Red
highlight default CompileModeWarning guifg=DarkYellow
highlight default CompileModeInfo guifg=Green

highlight default CompileModeCommandOutput guifg=#6699ff
highlight default CompileModeDirectoryMessage guifg=#6699ff
highlight default CompileModeOutputFile guifg=#9966cc
highlight default CompileModeCheckResult cterm=bold gui=bold guifg=#ff9966
highlight default CompileModeCheckTarget guifg=#ff9966

highlight link CompileModeErrorLocus Visual
]])
end
set_default_hl()

---Gets all active preview windows
---@return number[]
function M.preview_windows()
  local tab = vim.api.nvim_get_current_tabpage()
  local wins = vim.api.nvim_tabpage_list_wins(tab)
  local previewwindows = {}
  previewwindows = vim
    .iter(wins)
    :filter(function(win)
      return vim.api.nvim_get_option_value(attr, {
        win = win,
      })
    end)
    :totable()
  return previewwindows
end

---Opens Compile Mode window
function M._open_preview()
  local previews = M.preview_windows()
  local preview_win = previews[1]
  if preview_win then
    vim.api.nvim_set_current_win(preview_win)
    local bufnr = vim.api.nvim_win_get_buf(preview_win)
    return preview_win, bufnr
  end

  vim.api.nvim_command("new")
  M.height = vim.api.nvim_get_option_value(attr, {})
  M.win = vim.api.nvim_get_current_win()

  local buf = vim.api.nvim_win_get_buf(M.win)
  vim.api.nvim_set_option_value(attr, true, {
    win = M.win,
  })

  vim.api.nvim_win_set_height(M.win, M.height or 10)
  vim.bo[buf].bufhidden = "wipe"
  vim.keymap.set("n", "q", function() vim.cmd("close") end, { buffer = buf })
  vim.keymap.set("n", "<esc>", function() vim.cmd("close") end, { buffer = buf })

  return M.win, buf
end

function M.buf_init_preview(buf, win, syntax, lines)
  vim.bo[buf].filetype = "compilation"
  vim.bo[buf].undolevels = -1
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].modifiable = true
  vim.wo[win].wrap = true
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false
  vim.wo[win].spell = false
  vim.bo[buf].syntax = syntax
end

local chunks = {}

function M.update_preview(buf, win, lines)
  vim.bo[buf].modifiable = true
  vim.api.nvim_buf_set_lines(buf, -1, -1, false, lines)
  vim.bo[buf].modifiable = false
end

function M.open_preview()
  local previews = M.preview_windows()
  local preview_win = previews[1]
  if preview_win then
    vim.api.nvim_set_current_win(preview_win)
    local bufnr = vim.api.nvim_win_get_buf(preview_win)
    return preview_win, bufnr
  end

  vim.api.nvim_command("new")
  M.height = vim.api.nvim_get_option_value("previewheight", {})
  M.win = vim.api.nvim_get_current_win()

  local buf = vim.api.nvim_win_get_buf(M.win)
  vim.api.nvim_set_option_value("previewwindow", true, {
    win = M.win,
  })

  vim.api.nvim_win_set_height(M.win, M.height)
  vim.bo[buf].bufhidden = "wipe"
  vim.keymap.set("n", "q", function() vim.cmd("close") end, { buffer = buf })
  vim.keymap.set("n", "<esc>", function() vim.cmd("close") end, { buffer = buf })

  return buf, M.win
end

M.exit_codes = {
  SUCCESS = 0,
  SIGSEGV = 139, -- 128 + signal number 11
  SIGTERM = 143, -- 128 + signal number 15
}

function M.init_compile_mode(opts)
  M.height = vim.api.nvim_get_option_value("previewheight", {})
  local cwd = opts.cwd:gsub("^" .. vim.env.HOME, "~")
  local start = {
    "cwd: " .. cwd,
    -- "vim: filetype=compilation:path+=" .. cwd,
    "Compilation started at " .. vim.fn.strftime("%a %b %e %H:%M:%S"),
    "",
  }

  local prev_win = vim.api.nvim_get_current_win()
  local cursor_pos = vim.api.nvim_win_get_cursor(prev_win)
  local win, buf = M._open_preview()
  local syntax = ""
  M.buf_init_preview(buf, win, syntax, start)
  if M.restore_pos then
    vim.api.nvim_set_current_win(prev_win)
    vim.api.nvim_win_set_cursor(prev_win, cursor_pos)
    vim.api.nvim_input("zz")
  end
  return buf, win
end

M.shell_func = {
  ["cmd.exe"] = { "cmd.exe", "/c" },
  ["sh"] = { "sh", "-C" },
  ["pwsh.exe"] = { "pwsh", "-NoLogo", "-Command" },
}

-- TODO: Coroutines
-- TODO: Chunk the output handler to handle just ~50 lines at a time
---@param cmd table
---@param shell string
---@param opts table?
function M.shell_cmd(cmd, shell, opts)
  opts = opts or {}
  opts.cwd = opts.cwd or vim.uv.cwd()
  local buf, win = M.init_compile_mode(opts)
  local sep = package.config:sub(1, 1)
  local expanded_cmd = ""
  for _, arg in ipairs(cmd) do
    if arg == "~" then arg = vim.uv.os_homedir() end
    expanded_cmd = expanded_cmd .. " " .. arg
  end

  if sep == "\\" then expanded_cmd = expanded_cmd:gsub("/", "\\") end
  local shell_cmd = vim.deepcopy(M.shell_func[shell]) or vim.deepcopy(M.shell_func["sh"])
  table.insert(shell_cmd, expanded_cmd)
  M.update_preview(buf, win, { table.concat(shell_cmd, " ") })

  local output_handler = vim.schedule_wrap(function(err, data)
    if data ~= nil then
      local lines = vim
        .iter(vim.split(data, "\n", { trimempty = false }))
        :map(function(l)
          local new, _ = l:gsub("[\r\n]", "")
          return new
        end)
        :filter(function(l) return l and #l > 0 end)
        :totable()
      M.update_preview(buf, win, lines)
    end
  end)

  local on_exit = vim.schedule_wrap(function(obj)
    local exit_message = ""

    if obj.code == 0 then
      exit_message = "Compilation finished"
    elseif obj.signal == M.exit_codes.SIGSEGV then
      exit_message = "Compilation segmentation fault (core dumped)"
    elseif obj.signal == M.exit_codes.SIGTERM then
      exit_message = "Compilation terminated"
    else
      exit_message = "Compilation exited abnormally with code " .. obj.code
    end

    M.update_preview(buf, win, { "", exit_message .. " at " .. vim.fn.strftime("%a %b %e %H:%M:%S") })
    vim.notify(exit_message)
  end)

  vim.print(shell_cmd)

  local ok, ret = pcall(
    vim.system,
    shell_cmd,
    { text = true, cwd = opts.cwd, env = opts.env, stdout = output_handler, stderr = output_handler },
    on_exit
  )

  if not ok then
    vim.notify("There was an error running " .. table.concat(shell_cmd) .. ":\n" .. ret, vim.log.levels.ERROR)
  end

  return ok, ret
end

vim.api.nvim_create_user_command("Shell", function(c)
  local shell = vim.o.shell
  if c.bang then shell = "pwsh" end
  M.shell_cmd(c.fargs, shell)
end, { nargs = "*", bang = true, complete = "file" })

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function() set_default_hl() end,
})

return M
