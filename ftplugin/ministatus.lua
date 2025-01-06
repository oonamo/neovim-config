local matchadd = vim.fn.matchadd
local M = {}
matchadd("GitBranch", "^On branch \\zs.*$")
matchadd("GitBranch", "'\\(.*\\)/\\(.*\\)'")
matchadd("GitCommit", "Changes to be committed:")
matchadd("GitCommit", "Changes not staged for commit:")
matchadd("GitCommit", "Untracked files:")
matchadd("Conceal", '(use ".*)', 1000, -1, {
  conceal = "!",
})
matchadd("Conceal", "modified", 1000, -1, {
  conceal = "?",
})
matchadd("Conceal", "deleted", 1000, -1, {
  conceal = "X",
})

-- matchadd("DiffChange", "^\\s\\?M")
-- matchadd("DiffDelete", "^\\s\\?D")
-- matchadd("DiffAdd", "^\\s\\???")

vim.opt_local.conceallevel = 2

vim.cmd([[
highlight link GitBranch WarningMsg
highlight link GitCommit Title
]])

local ids = {
  add = vim.api.nvim_create_namespace("minigitstatusadd"),
  delete = vim.api.nvim_create_namespace("minigitstatusdelete"),
  change = vim.api.nvim_create_namespace("minigitstatuschange"),
  header = vim.api.nvim_create_namespace("minigitstatusheader"),
}

local git = Config._cache.git
local contents = vim.api.nvim_buf_get_lines(0, 0, -1, false)

M.modified = {
  -- "Modified",
}
M.deleted = {
  -- "Deleted",
}
M.untracked = {
  -- "Untracked",
}

M.unused = {}

M.order = {
  "modified",
  "deleted",
  "untracked",
}

M.hls = {
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

for i, content in ipairs(contents) do
  local first_char = content:match("^%s*[MD?].")
  print(first_char)
  if first_char:find("D") then
    table.insert(M.deleted, content)
  elseif first_char:find("%?%?") then
    table.insert(M.untracked, content)
  elseif first_char:find("M") then
    table.insert(M.modified, content)
  else
    table.insert(M.unused, content)
  end
end
-- table.insert(contents, 1, " ")
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

vim.print(locations)

local prev
-- modified
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

for line, content in ipairs(file) do
  if content:match("^%s*M%s") then
    vim.api.nvim_buf_set_extmark(0, ids.change, line - 1, 0, {
      virt_text = { { "M", "DiffChange" } },
      hl_mode = "combine",
      virt_text_win_col = 1,
    })
  elseif content:match("^%s*%?%?%s") then
    vim.api.nvim_buf_set_extmark(0, ids.add, line - 1, 1, {
      virt_text = { { "??", "DiffAdd" } },
      hl_mode = "combine",
      virt_text_win_col = 0,
    })
  elseif content:match("^%s*D%s") then
    vim.api.nvim_buf_set_extmark(0, ids.delete, line - 1, 0, {
      virt_text = { { "D", "DiffDelete" } },
      hl_mode = "combine",
      virt_text_win_col = 1,
    })
  end
end
