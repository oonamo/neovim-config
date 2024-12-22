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

vim.fn.termopen("fzf", {
  pty = true,
  env = {
    ["FZF_DEFAULT_COMMAND"] = table.concat(find_files, " ")
  },
  on_exit = function(...)
    vim.print(...)
  end
})

vim.cmd.startinsert()
