vim.loader.enable()

vim.g.loaded_gzip = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_matchit = 1
-- vim.g.loaded_matchparen = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1
vim.g.loaded_tutor_mode_plugin = 1

-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath("data") .. "/site/"

_G.Config = {
  path_source = vim.fn.stdpath("config") .. "/lua/",
  path_package = path_package .. "pack/deps/opt/",
  sep = package.config:sub(1, 1),
  plugs = {
    snacks = false,
    neogit = true,
  },
  completion = "mini",
  dev_dir = vim.fs.joinpath(vim.fn.expand("~"), "projects", "nvim"),
}

require("config.deps")
