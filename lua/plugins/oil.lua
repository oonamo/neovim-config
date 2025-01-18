local permission_hlgroups = setmetatable({
  ["-"] = "SepBit",
  ["r"] = "ReadBit",
  ["w"] = "WriteBit",
  ["x"] = "ExeMod",
}, {
  __index = function() return "OilDir" end,
})

local type_hlgroups = setmetatable({
  ["-"] = "OilTypeFile",
  ["d"] = "MiniPickExplorerDirectory",
  ["p"] = "OilTypeFifo",
  ["l"] = "OilTypeLink",
  ["s"] = "OilTypeSocket",
}, {
  __index = function() return "OilTypeFile" end,
})

require("oil").setup({
  columns = {
    {
      "type",
      icons = {
        directory = "d",
        fifo = "p",
        file = "-",
        link = "l",
        socket = "s",
      },
      highlight = function(type_str) return type_hlgroups[type_str] end,
    },
    {
      "permissions",
      highlight = function(permission_str)
        local hls = {}
        for i = 1, #permission_str do
          local char = permission_str:sub(i, i)
          table.insert(hls, { permission_hlgroups[char], i - 1, i })
        end
        return hls
      end,
    },
    { "size", highlight = "Special" },
    { "mtime", highlight = "Number" },
    "icon",
  },
})

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "oil",
--   group = vim.api.nvim_create_augroup("OilCursor", { clear = true }),
--   callback = function(data)
--     vim.notify("in oil!")
--     local old = vim.api.nvim_get_hl(0, { name = "CursorLine" })
--     vim.api.nvim_set_hl(0, "CursorLine", { underline = true })
--
--     vim.api.nvim_create_autocmd("BufLeave", {
--       once = true,
--       callback = function(inner_data)
--         if vim.bo[inner_data.buf].filetype == "oil" then
--           vim.notify("restoring...")
--           vim.api.nvim_set_hl(0, "CusrorLine", { bg = "#000000" })
--           vim.api.nvim_create_autocmd("WinLeave", {
--             callback = vim.schedule_wrap(function()
--               vim.notify("restoring...")
--               vim.api.nvim_set_hl(0, "CusrorLine", { bg = "#000000" })
--             end),
--           })
--           -- vim.schedule(vim.schedule_wrap(function() vim.api.nvim_set_hl(0, "CursorLine", old) end) end)
--         end
--       end,
--     })
--   end,
-- })
