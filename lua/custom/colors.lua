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
}

---@param color string Name of color to select
---@return boolean,string? Whether the selected color was correctly applied
M.select = function(color)
  if M.colors[color] then
    M.colors[color]()
    return true, ""
  end
  local ok, err
  ok, err = pcall(vim.cmd.colorscheme, color)
  return ok, err
end

return M
