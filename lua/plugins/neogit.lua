require("neogit").setup()

local map = function(mode, lhs, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc
  vim.keymap.set(mode, lhs, rhs, opts)
end

map("n", "<C-x>g", "<cmd>Neogit<cr>", "Open neogit")
