vim.cmd.new()
vim.cmd.messages("clear")

local find_files = {
  "rg",
  "--color=never",
  "--files",
  "--hidden",
  "--follow",
  "-g",
  "!.git",
}

local current = {}
local prev = {}

vim.fn.termopen("fzf", {
  pty = true,
  env = {
    ["FZF_DEFAULT_COMMAND"] = table.concat(find_files, " "),
  },
  on_exit = function(...)
    vim.print(...)
    vim.cmd("bw!")
  end,
  on_stdout = function(_, data, _)
    prev = current
    current = data
  end,
})

vim.cmd.startinsert()
