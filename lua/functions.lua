Config._cache = {
  term = {
    buf = -1,
    win = -1,
  },
}
Config.opts = {}

function Config.open_lazygit()
  vim.cmd("tabedit")
  vim.cmd("setlocal nonumber signcolumn=no cmdheight=0")

  vim.fn.termopen("lazygit", {
    on_exit = function()
      vim.cmd("silent! :checktime")
      vim.cmd("silent! :bw")
    end,
  })
  vim.cmd("startinsert")
  vim.b.minipairs_disable = true
end

function Config.async_grep(args)
  local cmd, num_subs = vim.o.grepprg:gsub("%$%*", args)
  if num_subs == 0 then cmd = cmd .. " " .. args end
  local expanded_cmd = vim.fn.expandcmd(cmd)
  local sys_cmd = vim
    .iter(vim.split(expanded_cmd, " ", { trimempty = true }))
    :filter(function(item) return item:len() ~= 0 end)
    :totable()

  vim.fn.setqflist({})

  vim.system(sys_cmd, {
    stdout = vim.schedule_wrap(function(err, data)
      if err then
        vim.notify("Error grepping: '" .. vim.inspect(err) .. "'", vim.log.levels.ERROR, { title = "Grep" })
        return
      end
      if data ~= nil then
        vim.fn.setqflist({}, "a", {
          lines = vim.split(data, platform_specific.lineending, { trimempty = true }),
          efm = vim.o.grepformat,
        })
      end
      vim.cmd.redraw()
    end),
    text = true,
  })

  vim.cmd.copen()
end

vim.api.nvim_create_user_command(
  "Grep",
  function(c) Config.async_grep(c.args) end,
  { nargs = "*", bang = true, complete = "file" }
)

---@param exe_modifier false|string
---@param num integer
---@return string
local function perm_to_str(exe_modifier, num)
  local str = (bit.band(num, 4) ~= 0 and "r" or "-") .. (bit.band(num, 2) ~= 0 and "w" or "-")
  if exe_modifier then
    if bit.band(num, 1) ~= 0 then
      return str .. exe_modifier
    else
      return str .. exe_modifier:upper()
    end
  else
    return str .. (bit.band(num, 1) ~= 0 and "x" or "-")
  end
end

---@param mode integer
---@return string
Config.mode_to_str = function(mode)
  local extra = bit.rshift(mode, 9)
  return perm_to_str(bit.band(extra, 4) ~= 0 and "s", bit.rshift(mode, 6))
    .. perm_to_str(bit.band(extra, 2) ~= 0 and "s", bit.rshift(mode, 3))
    .. perm_to_str(bit.band(extra, 1) ~= 0 and "t", mode)
end

---@param exe_modifier false|string
---@param num integer
local function perm_to_table_str(exe_modifier, num, tbl)
  table.insert(tbl, (bit.band(num, 4) ~= 0 and { "r", "ReadBit" } or { "-", "SepBit" }))
  table.insert(tbl, (bit.band(num, 2) ~= 0 and { "w", "WriteBit" } or { "-", "SepBit" }))
  if exe_modifier then
    if bit.band(num, 1) ~= 0 then
      table.insert(tbl, { exe_modifier, "ExeMod" })
    else
      table.insert(tbl, { exe_modifier:upper(), "ExeMod" })
    end
  else
    table.insert(tbl, (bit.band(num, 1) ~= 0 and { "x", "ExeBit" } or { "-", "SepBit" }))
  end
end

---@param tbl table
---@return table
function Config.flatten(tbl)
  local flattened = {}
  for _, v in pairs(tbl) do
    if type(v) == "table" then
      for inner_k, inner_v in pairs(v) do
        flattened[inner_k] = inner_v
      end
    else
      table.insert(flattened, v)
    end
  end
  return flattened
end

-- TODO: Can't get file attributes from libuv for windows
-- https://learn.microsoft.com/en-us/windows/win32/fileio/file-attribute-constants
Config.mode_to_table_str = function(stat)
  local extra = bit.rshift(stat.mode, 9)
  local tbl = {}
  perm_to_table_str(bit.band(extra, 4) ~= 0 and "s", bit.rshift(stat.mode, 6), tbl)
  perm_to_table_str(bit.band(extra, 2) ~= 0 and "s", bit.rshift(stat.mode, 3), tbl)
  perm_to_table_str(bit.band(extra, 1) ~= 0 and "t", stat.mode, tbl)
  return tbl
end

function Config.ensure_length(str, length)
  local ret = str
  local len = #str
  if len < length then
    for _ = 0, length - len do
      ret = ret .. " "
    end
  elseif str > length then
    ret = str:sub(0, length)
  end
  return ret
end

function Config.pad_str(str, len)
  if str and #str > len then return str:sub(0, len - 2) .. "..." end
  str = str or ""
  for _ = 0, (len - #str) do
    str = str .. " "
  end
  return str
end

function Config._compile_widths(opts)
  local width = 0
  if Config.opts.minipick.ivy then
    width = vim.o.columns
  else
    width = MiniPick.config.window.width or math.floor(vim.o.columns * 0.618)
  end
  local total = 0
  local compiled_width = {}
  for i, v in ipairs(opts.items) do
    if v.width < 1 then
      local result = math.floor(v.width * width)
      total = total + result
      compiled_width[i] = result
    else
      local result = math.floor(v.width)
      total = total + result
      compiled_width[i] = result
    end
  end
  if opts.items[#opts.items].remaining then compiled_width[#compiled_width] = (width or vim.o.columns) - total end
  return compiled_width
end

local current_year
-- Make sure we run this import-time effect in the main loop (mostly for tests)
vim.schedule(function() current_year = vim.fn.strftime("%y") end)
Config.time_str = function(time)
  local ret
  local year = vim.fn.strftime("%y", time.sec)
  if year ~= current_year then
    ret = vim.fn.strftime("%b %d %y", time.sec)
  else
    ret = vim.fn.strftime("%b %d %H:%M", time.sec)
  end

  return ret
end

function Config.size_str(size)
  if size == 0 then return "D" end
  if size >= 1e9 then
    return string.format("%.1fG", size / 1e9)
  elseif size >= 1e6 then
    return string.format("%.1fM", size / 1e6)
  elseif size >= 1e3 then
    return string.format("%.1fk", size / 1e3)
  else
    return string.format("%d", size)
  end
end

function Config.explorer()
  Config._cache.explorer_parent = nil
  require("custom.explorer").explorer({
    mappings = {
      scroll_left = "", -- HACK: Prevent it from stealing <c-h>
      go_up_level = {
        char = "<C-h>",
        func = function()
          local query = MiniPick.get_picker_query()
          if not query[1] or query[1] == "" then
            vim.schedule(function() vim.api.nvim_input("<CR>") end)
          else
            MiniPick.set_picker_query({ "" })
          end
        end,
      },
      go_up_level_neovide = {
        char = "<c-bs>", -- Same as C BKSP, emacs lol
        func = function()
          local query = MiniPick.get_picker_query()
          if not query[1] or query[1] == "" then
            vim.schedule(function() vim.api.nvim_input("<CR>") end)
          else
            MiniPick.set_picker_query({ "" })
          end
        end,
      },
      new_file = {
        char = "<c-e>",
        func = function()
          local query = MiniPick.get_picker_query()
          if not query or #query < 1 then return end
          query = table.concat(query, "")
          local cwd = MiniPick.get_picker_opts().source.cwd
          local file = cwd .. "/" .. query
          file = file:gsub("\\", "/")

          vim.schedule(function() vim.cmd.edit(file) end)
          return true
        end,
      },
      open_in_file_explorer = {
        char = "<C-d>",
        func = function()
          local current = MiniPick.get_picker_matches().current
          if not current then return end

          vim.schedule(function() require("mini.files").open(current.path) end)
          return true
        end,
      },
    },
  })
end

function Config.create_win(opts)
  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)

  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true)
  end

  local win_config = {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = opts.style or "minimal",
    border = opts.border or "rounded",
  }

  local win = vim.api.nvim_open_win(buf, true, win_config)
  return { buf = buf, win = win }
end

function Config.toggle_term(cmd)
  if Config._cache.term ~= nil and not vim.api.nvim_win_is_valid(Config._cache.term.buf) then
    Config._cache.term = Config.create_win({ buf = Config._cache.term.buf })
    if vim.bo[Config._cache.term.buf].buftype ~= "terminal" then
      vim.cmd.terminal(cmd)
      vim.cmd.startinsert()
    end
  else
    vim.api.nvim_win_hide(Config._cache.term.win)
  end
end
