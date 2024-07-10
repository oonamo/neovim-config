local function disable(name)
  return { name, enabled = false }
end

local disable_plugs = {
  "folke/noice.nvim",
  "nvim-neo-tree/neo-tree.nvim",
  "garymjr/nvim-snippets",
  "rafamadriz/friendly-snippets",
  "echasnovski/mini.pairs",
  "nvim-lualine/lualine.nvim",
  "lukas-reineke/indent-blankline.nvim",
  "nvimdev/dashboard-nvim",
  "rcarriga/nvim-notify",
  "folke/ts-comments.nvim",
  "folke/flash.nvim",
  "lewis6991/gitsigns.nvim",
  "mfussenegger/nvim-lint",
  "nvim-treesitter/nvim-treesitter-textobjects",
  "windwp/nvim-ts-autotag",
  "folke/persistence.nvim",
  "folke/which-key.nvim",
}

return {
  vim.tbl_map(disable, disable_plugs),
}
