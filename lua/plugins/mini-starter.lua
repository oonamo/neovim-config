local starter = require("mini.starter")

local pick = function()
  return {
    {
      action = 'Pick history scope=":"',
      name = "Command history",
      section = "Pick",
    },
    {
      action = function() Config.explorer() end,
      name = "Explorer",
      section = "Pick",
    },
    {
      action = "Pick files",
      name = "Files",
      section = "Pick",
    },
    {
      action = "Pick grep_live",
      name = "Grep live",
      section = "Pick",
    },
    {
      action = "Pick help",
      name = "Help tags",
      section = "Pick",
    },
    {
      action = "Pick visit_paths",
      name = "Visited paths",
      section = "Pick",
    },
  }
end

starter.setup({
  evaluate_single = true,
  items = {
    pick,
    starter.sections.builtin_actions(),
    starter.sections.recent_files(10, true),
  },
  content_hooks = {
    starter.gen_hook.adding_bullet(">> "),
    starter.gen_hook.aligning("center", "center"),
    -- starter.gen_hook.adding_bullet(),
    -- starter.gen_hook.indexing("all", { "Builtin actions" }),
    -- starter.gen_hook.padding(3, 2),
  },
})

if vim.fn.argc() == 0 then
  vim.api.nvim_create_autocmd("UIEnter", {
    group = vim.api.nvim_create_augroup("starter_cb", { clear = true }),
    once = true,
    callback = vim.schedule_wrap(function()
      MiniStarter.refresh()
      return true
    end),
  })
end
