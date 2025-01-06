local M = {}
vim.opt_local.conceallevel = 2

local ids = {
  add = vim.api.nvim_create_namespace("minigitstatusadd"),
  delete = vim.api.nvim_create_namespace("minigitstatusdelete"),
  change = vim.api.nvim_create_namespace("minigitstatuschange"),
  header = vim.api.nvim_create_namespace("minigitstatusheader"),
}

local git = Config._cache.git
local contents = vim.api.nvim_buf_get_lines(0, 0, -1, false)

if not contents or #contents == 0 then
  vim.print(contents)
  return
end

M.modified = {}
M.deleted = {}
M.untracked = {}
M.staged = {}

M.order = {
  "staged",
  "modified",
  "deleted",
  "untracked",
}

M.hls = {
  staged = {
    { "Staged", "DiffAdd" },
  },
  modified = {
    { "Modified", "DiffChange" },
  },
  deleted = {
    { "Deleted", "DiffDelete" },
  },
  untracked = {
    { "Untracked", "DiffDelete" },
  },
}

local file = {}

local patterns = {
  staged = {
    "^MM?%s",
    "^A%s",
    "^R%s",
  },
  modified = {
    "^%sM%s",
  },
  deleted = {
    "^%sD%s",
  },
  untracked = {
    "^%?%?%s",
  },
}

for i, content in ipairs(contents) do
  for _, ord in ipairs(M.order) do
    local found = false
    for _, pattern in ipairs(patterns[ord]) do
      if content:match(pattern) then
        table.insert(M[ord], content)
        found = true
        break
      end
    end
    if found then break end
  end
end

local prepend = {
  "Branch: " .. git.head_name,
  "Commit: " .. git.head,
}

for i, v in ipairs(prepend) do
  table.insert(file, i, v)
end

table.insert(file, "")

local locations = {}

local line = 3
for i, ord in ipairs(M.order) do
  locations[ord] = line
  for _, v in ipairs(M[ord] or {}) do
    table.insert(file, v)
  end
  line = line + #M[ord] + 1
  table.insert(file, "")
end

vim.api.nvim_buf_set_lines(0, 0, -1, false, file)

for _, ord in ipairs(M.order) do
  vim.api.nvim_buf_set_extmark(0, ids.header, locations[ord], 0, {
    virt_lines_above = true,
    virt_lines = {
      M.hls[ord],
    },
  })
end

if git then
  vim.api.nvim_buf_set_extmark(0, ids.header, 0, 0, {
    virt_text_pos = "overlay",
    virt_text = { { "Branch: ", "Special" }, { git.head_name, "DiffAdd" } },
    hl_mode = "combine",
  })
  vim.api.nvim_buf_set_extmark(0, ids.header, 1, 0, {
    virt_text_pos = "overlay",
    virt_text = { { "Commit: ", "Special" }, { git.head, "DiffAdd" } },
    hl_mode = "combine",
  })
end

local hls = {
  ["M "] = {
    ext = { virt_text = { { "M", "DiffAdd" } }, hl_mode = "combine", virt_text_win_col = 0 },
    staged = true,
  },
  ["MM "] = {
    ext = { virt_text = { { "MM", "DiffAdd" } }, hl_mode = "combine", virt_text_win_col = 0 },
    staged = true,
  },
  [" M "] = {
    ext = { virt_text = { { "M", "DiffChange" } }, hl_mode = "combine", virt_text_win_col = 1 },
  },
  ["?? "] = {
    ext = { virt_text = { { "??", "DiffDelete" } }, hl_mode = "combine", virt_text_win_col = 0 },
  },
  [" D "] = {
    ext = { virt_text = { { "D", "DiffDelete" } }, hl_mode = "combine", virt_text_win_col = 1 },
  },
  ["A "] = {
    ext = { virt_text = { { "A", "DiffAdd" } }, hl_mode = "combine", virt_text_win_col = 0 },
    staged = true,
  },
  ["R "] = {
    ext = { virt_text = { { "R", "DiffAdd" } }, hl_mode = "combine", virt_text_win_col = 0 },
    staged = true,
  },
}

for i, content in ipairs(file) do
  local state
  for _, ord in ipairs(M.order) do
    local found = false
    for _, pattern in ipairs(patterns[ord]) do
      state = content:match(pattern)
      if state then
        found = true
        break
      end
    end
    if found then break end
  end
  local hls_opts = hls[state]

  if hls_opts then vim.api.nvim_buf_set_extmark(0, ids.add, i - 1, 0, hls_opts.ext) end
end

vim.bo.modifiable = false

local is_renamed_file = function(l) return l:match("^(%s?[?MDRA][?MDRA]?%s)%s(.*)->%s(.*)") end

local get_current_hover_file = function()
  local cur_line = vim.api.nvim_get_current_line()
  local f

  local state, old_f, new_f = is_renamed_file(cur_line)
  if state then return state, old_f, new_f end

  state, f = cur_line:match("^(%s?[?MDRA][?MDRA]?%s)(.*)")
  return state, f
end

local function is_staged(state) return state and hls[state].staged end

local function stage_file(cur_file)
  if not cur_file then return end
  vim.cmd("Git add " .. cur_file)
  local pos = vim.api.nvim_win_get_cursor(0)
  vim.cmd.close()
  vim.notify("Staged '" .. cur_file .. "'")
  vim.cmd("Git status -s")
  vim.api.nvim_win_set_cursor(0, pos)
end

local function unstage_file(cur_file)
  if not cur_file then return end
  vim.cmd("Git reset " .. cur_file)
  local pos = vim.api.nvim_win_get_cursor(0)
  vim.cmd.close()
  vim.notify("Unstaged '" .. cur_file .. "'")
  vim.cmd("Git status -s")
  vim.api.nvim_win_set_cursor(0, pos)
end

local toggle_stage_status = function()
  local state, f, renamed_file = get_current_hover_file()
  if not state or not f then
    return vim.notify("No file under cursor", vim.log.levels.WARN, { title = "Git Status" })
  end
  local staged = is_staged(state)
  if staged then
    unstage_file(renamed_file or f)
  else
    stage_file(f)
  end
end

vim.keymap.set("n", "<CR>", toggle_stage_status, { buffer = true })
vim.keymap.set("n", "<CR>", toggle_stage_status, { buffer = true })
vim.keymap.set("n", "q", function() vim.cmd("close") end, { buffer = true })
vim.keymap.set("n", "<esc>", function() vim.cmd("close") end, { buffer = true })
