local M = {}

function M.status_path()
  local path = vim.fn.expand("%:~:.")
  if path == "" or vim.bo.buftype ~= "" then return "%t" end
  return path
end

function M.line_nr(bufnr)
  local count = vim.api.nvim_buf_line_count(bufnr)
  local pad = #vim.fn.string(count)
  return "%0" .. pad .. "l"
end

---append to diagnostic string
---@param src string
---@param value string
local function append(src, value)
  if #src > 0 then return src .. " " .. value end
  return value
end

local important_sign = "→"
local not_important_sign = "•"

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = important_sign,
      [vim.diagnostic.severity.WARN] = important_sign,
      [vim.diagnostic.severity.INFO] = not_important_sign,
      [vim.diagnostic.severity.HINT] = not_important_sign,
    },
  },
})

-- local ok_diagnostic = "│ OK │"
local ok_diagnostic = "OK •"

function M.get_diagnostic_count()
  if vim.diagnostic.is_enabled() then
    ---@type number[]
    local diagnostics = vim.diagnostic.count(nil)
    local res = ""
    if diagnostics[vim.diagnostic.severity.HINT] ~= nil then
      local c = diagnostics[vim.diagnostic.severity.HINT]
      res = append(res, "%#DiagnosticHint#" .. c .. "%*")
    end
    if diagnostics[vim.diagnostic.severity.INFO] ~= nil then
      local c = diagnostics[vim.diagnostic.severity.INFO]
      res = append(res, "%#DiagnosticInfo#" .. c .. "%*")
    end
    if diagnostics[vim.diagnostic.severity.WARN] ~= nil then
      local c = diagnostics[vim.diagnostic.severity.WARN]
      res = append(res, "%#DiagnosticWarn#" .. c .. "%*")
    end
    if diagnostics[vim.diagnostic.severity.ERROR] ~= nil then
      local c = diagnostics[vim.diagnostic.severity.ERROR]
      res = append(res, "%#DiagnosticError#" .. c .. "%*")
    end
    if #res > 0 then return res .. " •" end
  end
  return ok_diagnostic
end

vim.opt.statusline = [[ %(%H%q%)]]
  .. [[%( %<%{%v:lua.require('custom.df-line').status_path()%}%M%)]]
  .. [[%=%( %{%v:lua.require('custom.df-line').get_diagnostic_count()%}]]
  .. [[ →%02c ↓%{%v:lua.require('custom.df-line').line_nr(0)%}/%L %03p%%%)  ]]

return M
