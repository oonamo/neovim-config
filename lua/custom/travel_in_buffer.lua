local M = {}

local has_lnum = function(item) return item.lnum ~= nil end

M.old = MiniPick.default_show
MiniPick.default_show = function(buf_id, items, query, opts)
  M.old(buf_id, items, query, opts)
  if has_lnum(items[1]) then
    vim.notify("haslnum")
  end
end

function M.is_valid_buf() end

function M.override() end
