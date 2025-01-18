local M = {}

M.ids = {
  inline = vim.api.nvim_create_namespace("quickermd-inline"),
}

local command = "quicker_md"

M.get_visual_selection = function()
  local mode = vim.api.nvim_get_mode().mode
  local opts = {}

  if mode == "v" or mode == "V" or mode == "\22" then opts.type = mode end

  local start, stop = vim.fn.getpos("v"), vim.fn.getpos(".")
  return vim.fn.getregion(start, stop, opts), { start = start, stop = stop }
end

M.handles = {
  inline = function(start_line, end_line)
    return function(obj)
      local lines = {}
      local next_is_input = false
      local next_is_output = true
      lines = vim
        .iter(vim.split(obj.stdout, "\n", { trimempty = true }))
        :map(function(line)
          if next_is_input then
            next_is_input = false
            return { { line, "DiffAdd" } }
          end
          if next_is_output then
            next_is_output = false
            return { { line, "DiffAdd" } }
          end
          if line:match("Input:") then
            next_is_input = true
            return { { "Input:", "DiffAdd" } }
          end
          if line:match("Output:") then
            next_is_output = true
            return { { "Output:", "DiagnosticInfo" } }
          end
          if line:match("Error:") then return { { "Error:", "DiagnosticError" } } end
          return { { line, "NonText" } }
        end)
        :totable()

      vim.schedule(function()
        vim.print(lines)
        vim.api.nvim_buf_set_extmark(0, M.ids.inline, end_line - 2, 0, {
          virt_lines = lines,
        })
      end)
    end
  end,
}

M.run_snippet_with_input = function(lang, input, region, opts)
  local start_ln = math.min(region.start[2], region.stop[2])
  local end_ln = start_ln == region.start[2] and region.stop[2] or region.start[2]

  local handle = function(obj) end

  local run = { command, "--show-input", "--lang", lang }
  vim.system(run, {
    text = true,
    stdin = input,
  }, function(obj)
  end)
end

M.inline = function() end

M.resolve_selection_region = function()
  local selection, pos = M.get_visual_selection()

  local lang
  local input = {}
  for i, line in ipairs(selection) do
    if not lang then
      lang = line:match("```(.*)%s*")
    elseif not line:match("^```") then
      table.insert(input, line)
    end
  end
  return input, lang, pos
end

M.run_snippet = function(opts)
  local input, lang, pos = M.resolve_selection_region()
  if not lang then return vim.notify("Could not find language for visual selection") end
  M.run_snippet_with_input(lang, input, pos)
end

vim.api.nvim_buf_clear_namespace(0, M.ids.inline, 0, -1)

vim.keymap.set({ "v" }, "<leader>rs", M.run_snippet)

local test = [[
```js
console.log("Hello, this is cool!");
```
]]
