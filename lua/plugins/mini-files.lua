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
local mode_to_str = function(mode)
  local extra = bit.rshift(mode, 9)
  return perm_to_str(bit.band(extra, 4) ~= 0 and "s", bit.rshift(mode, 6))
    .. perm_to_str(bit.band(extra, 2) ~= 0 and "s", bit.rshift(mode, 3))
    .. perm_to_str(bit.band(extra, 1) ~= 0 and "t", mode)
end

local time_key = "mtime"
local current_year
-- Make sure we run this import-time effect in the main loop (mostly for tests)
vim.schedule(function() current_year = vim.fn.strftime("%y") end)
local time_str = function(time)
  local ret
  local year = vim.fn.strftime("%y", time.sec)
  if year ~= current_year then
    ret = vim.fn.strftime("%b %d %y", time.sec)
  else
    ret = vim.fn.strftime("%b %d %H:%M", time.sec)
  end

  return ret
end

local function size_str(stat)
  -- if stat.size == 0 then return "D" end
  if stat.size >= 1e9 then
    return string.format("%.1fG", stat.size / 1e9)
  elseif stat.size >= 1e6 then
    return string.format("%.1fM", stat.size / 1e6)
  elseif stat.size >= 1e3 then
    return string.format("%.1fk", stat.size / 1e3)
  else
    return string.format("%d", stat.size)
  end
end

local time_str_hi = "Special"

local function ensure_length(str, length)
  if not str or str == "" or str == " " then return string.rep(" ", length) end
  local ret = str
  local len = #str
  if len > length then
    ret = str:sub(0, length)
  elseif len < length then
    local diff = length - len
    for i = 0, diff do
      ret = ret .. " "
    end
  end
  return ret
end


local prefix = function(fs_entry)
  local stat = vim.uv.fs_stat(fs_entry.path)
  if not stat then return end
  return ensure_length(time_str(stat.mtime), 15) .. " " .. MiniFiles.default_prefix(fs_entry), time_str_hi
end

require("mini.files").setup({
  content = { prefix = prefix },
})
