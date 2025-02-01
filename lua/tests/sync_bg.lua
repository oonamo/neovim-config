local H = {}
local augroup = vim.api.nvim_create_augroup("TermBGSync", { clear = true })
local function f(args)
  -- Set up sync
  local sync = function()
    local normal = vim.api.nvim_get_hl_by_name("Normal", true)
    if normal.background == nil then return end
    -- NOTE: use `io.stdout` instead of `io.write` to ensure correct target
    -- Otherwise after `io.output(file); file:close()` there is an error
    io.stdout:write(string.format("\027]11;#%06x\007", normal.background))
  end
  vim.api.nvim_create_autocmd({ "VimResume", "ColorScheme" }, { group = augroup, callback = sync })

  -- Set up reset to the color returned from the very first call
  local reset = function() io.stdout:write("\027]11;" .. H.termbg_init .. "\007") end
  vim.api.nvim_create_autocmd({ "VimLeavePre", "VimSuspend" }, { group = augroup, callback = reset })

  -- Sync immediately
  sync()
end
f()
