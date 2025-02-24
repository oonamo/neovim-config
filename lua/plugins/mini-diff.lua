require("mini.diff").setup({
  view = {
    style = "sign",
    -- signs = { add = "+", change = "~", delete = "-" },
    -- signs = { add = "┃", change = "┃", delete = "┃" },
    signs = { add = "▍ ", change = "▍ ", delete = " " },
    -- signs = { add = "█", change = "▒", delete = "" },
  },
})

local function stl_format(item, hl) return string.format("%%#%s#%s%%#StatusLine#", hl, item) end

local function format_summary(data)
  local summary = vim.b[data.buf].minidiff_summary or {}
  local t = {}
  if summary.add and summary.add > 0 then table.insert(t, stl_format("+" .. summary.add, "MiniDiffSignAdd")) end
  if summary.change and summary.change > 0 then
    table.insert(t, stl_format("~" .. summary.change, "MiniDiffSignChange"))
  end
  if summary.delete and summary.delete > 0 then
    table.insert(t, stl_format("-" .. summary.delete, "MiniDiffSignDelete"))
  end
  vim.b[data.buf].minidiff_summary_string = table.concat(t, "")
end

local au_opts = { pattern = "MiniDiffUpdated", callback = format_summary }
vim.api.nvim_create_autocmd("User", au_opts)
