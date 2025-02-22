vim.g.complete_fallback = false

local M = {
  group = vim.api.nvim_create_augroup("fallback-attach-handle", { clear = true }),
  has_attached_full = false,
}

local child_cmd

local function delete_child_cmd()
  pcall(vim.api.nvim_del_autocmd, child_cmd)
end

-- vim.api.nvim_create_autocmd("LspAttach", {
--   once = true,
--   group = M.group,
--   callback = function(args)
--     local ft = vim.bo[args.buf].filetype
--     if ft == "text" or ft == "markdown" then return end
--
--     child_cmd = vim.api.nvim_create_autocmd("LspProgress", {
--       group = M.group,
--       callback = function(info)
--         if vim.tbl_get(info, "data", "params", "value", "kind") == "end" then
--           vim.b[args.buf].complete_fallback = false
--           M.has_attached_full = true
--           vim.schedule(function()
--             delete_child_cmd()
--           end)
--           return true
--         end
--       end,
--     })
--   end,
-- })

require("mini.completion").setup({
  lsp_completion = {
    source_func = "omnifunc",
    auto_setup = false,
    process_items = function(items, base)
      -- Don't show 'Text' and 'Snippet' suggestions
      items = vim.tbl_filter(function(x) return x.kind ~= 1 and x.kind ~= 15 end, items)
      return MiniCompletion.default_process_items(items, base)
    end,
  },
  fallback_action = function()
    -- HACK: Treats nil as truthy, to not have autocommand to set this every buffer
    if vim.b.complete_fallback ~= false or vim.g.complete_fallback then
      -- FROM: https://github.com/echasnovski/mini.nvim/blob/3049adbafd08b769d0700624fe9b85fa4176c88c/lua/mini/completion.lua#L757-L762
      local keys = string.format("<C-g><C-g>%s", "<C-x><C-n>")
      local trigger_keys = vim.api.nvim_replace_termcodes(keys, true, false, true)
      vim.api.nvim_feedkeys(trigger_keys, "n", false)
    end
  end,
  mappings = {
    force_fallback = "<C-f>",
  },
  window = {
    info = { border = "single" },
    signature = { border = "single" },
  },
})
