local matchadd = vim.fn.matchadd
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

vim.opt_local.conceallevel = 2

vim.cmd([[
highlight link GitBranch WarningMsg
highlight link GitCommit Title
]])
