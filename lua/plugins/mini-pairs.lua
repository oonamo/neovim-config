local mini_pairs = require("mini.pairs")
mini_pairs.setup({
  mappings = {
    -- ['"'] = { action = "closeopen", pair = '""', neigh_pattern = "[^%w][^%w]", register = { cr = false } },
    -- ["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^%w][^%w]", register = { cr = false } },
    ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^%w][^%w]", register = { cr = false } },

    ["["] = { action = "open", pair = "[]", neigh_pattern = "[^\\]." },
    ["{"] = { action = "open", pair = "{}", neigh_pattern = "[^\\]." },
    [")"] = { action = "close", pair = "()", neigh_pattern = "[^\\]." },
    ["]"] = { action = "close", pair = "[]", neigh_pattern = "[^\\]." },
    ["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\]." },

    ['"'] = { action = "closeopen", pair = '""', neigh_pattern = "[^\\].", register = { cr = false } },
    ["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^%a\\].", register = { cr = false } },
  },
})

-- FROM: https://github.com/LazyVim/LazyVim/blob/597cd8ffa3c54471df860c4036a8c20e123292b9/lua/lazyvim/util/mini.lua#L97-L129
local open = mini_pairs.open
mini_pairs.open = function(pair, neigh_pattern)
  if vim.fn.getcmdline() ~= "" then return open(pair, neigh_pattern) end
  local o, c = pair:sub(1, 1), pair:sub(2, 2)
  local line = vim.api.nvim_get_current_line()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local next = line:sub(cursor[2] + 1, cursor[2] + 1)
  local before = line:sub(1, cursor[2])
  if o == "`" and vim.bo.filetype == "markdown" and before:match("^%s*``") then
    return "`\n```" .. vim.api.nvim_replace_termcodes("<up>", true, true, true)
  end
  if next ~= "" and next:match([=[[%w%%%'%[%"%.%`%$]]=]) then return o end

  if next == c and c ~= o then
    local _, count_open = line:gsub(vim.pesc(pair:sub(1, 1)), "")
    local _, count_close = line:gsub(vim.pesc(pair:sub(2, 2)), "")
    if count_close > count_open then return o end
  end

  return open(pair, neigh_pattern)
end
