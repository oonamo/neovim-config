local M = {}

M.colors = {
  ["catppuccin-mocha"] = function()
    require("catppuccin").setup({
      integrations = {
        cmp = true,
        blink_cmp = true,
        gitsigns = false,
        nvimtree = false,
        treesitter = true,
        notify = false,
        mini = { enabled = true },
      },
    })
    vim.cmd.colorscheme("catppuccin-mocha")
  end,
  ["everforest"] = function()
    vim.cmd.colorscheme("everforest")
    local norm = vim.api.nvim_get_hl(0, {
      name = "Normal",
    })
    norm.bg = "#000000"
    vim.api.nvim_set_hl(0, "MiniPickMatchCurrent", { link = "Visual" })
    vim.api.nvim_set_hl(0, "Normal", norm)
    vim.api.nvim_set_hl(0, "NormalNC", { link = "Normal" })
  end,
}

---@param color string Name of color to select
---@return boolean,string? Whether the selected color was correctly applied
M.select = function(color)
  if M.colors[color] then
    M.colors[color]()
    return true, ""
  end
  return false
end

return M
