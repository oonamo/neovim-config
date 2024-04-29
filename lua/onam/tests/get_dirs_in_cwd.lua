-- local cwDir = vim.fn.system({ "ls, "-d", "*/" })
local cwDir = vim.fn.getcwd()
local cwdContent = vim.split(vim.fn.glob(cwDir .. "\\*"), "\n", { trimempty = true, recursive = true })
vim.print(cwdContent)
