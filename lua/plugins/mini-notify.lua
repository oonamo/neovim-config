local n_progress = 0
local in_lsp_progress = function() return n_progress > 0 end

local lsp_progress_plus = function() n_progress = n_progress + 1 end
vim.api.nvim_create_autocmd("LspProgress", { pattern = "begin", callback = lsp_progress_plus })
local lsp_progress_minus = function()
  vim.defer_fn(function() n_progress = n_progress - 1 end, MiniNotify.config.lsp_progress.duration_last + 1)
end
vim.api.nvim_create_autocmd("LspProgress", { pattern = "end", callback = lsp_progress_minus })

--- Helpers for custom setup
local format = function(notif)
  if not in_lsp_progress() then return MiniNotify.default_format(notif) end
  -- Weird that this works, as this is not the right place to do it (not sure
  -- if there is the one better, though)
  notif.hl_group = "Comment"
  return notif.msg
end

local win_config = function()
  if not in_lsp_progress() then
    local opts = { title = (vim.b.notify_config or {}).title }
    vim.b.notify_config = nil
    return opts
  end

  -- Customize window to be more "fidget" like
  local pad = vim.o.cmdheight + (vim.o.laststatus > 0 and 1 or 0) -- 2 looks better than 1
  return { anchor = "SE", col = vim.o.columns, row = vim.o.lines - pad, border = "none" }
end

require("mini.notify").setup({
  lsp_progress = {
    -- enable = false,
  },
  window = {
    config = win_config,
  },
  content = { format = format },
})

vim.notify = function(msg, level, opts)
  vim.b.notify_config = opts
  MiniNotify.make_notify()(msg, level)
end
