local mc = require("multicursor-nvim")

mc.setup()

local map = vim.keymap.set

local mmap = function(modes, suffix, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc
  vim.keymap.set(modes, "<leader>m" .. suffix, rhs, opts)
end

mmap({ "n", "v" }, "k", function() mc.lineAddCursor(-1) end, "Add cursor above")
mmap({ "n", "v" }, "j", function() mc.lineAddCursor(1) end, "Add cursor below")
mmap({ "n", "v" }, "K", function() mc.lineSkipCursor(-1) end, "Skip line above")
mmap({ "n", "v" }, "J", function() mc.lineSkipCursor(1) end, "Skip next line")
mmap({ "n", "v" }, "a", mc.matchAllAddCursors, "Add cursors to all matches")
mmap({ "n", "v" }, "n", function() mc.matchAddCursor(1) end, "Add cursors to all matches")
mmap({ "n", "v" }, "x", mc.toggleCursor, "Toggle Cursor")
mmap({ "n", "v" }, "d", mc.duplicateCursors, "Duplicate Cursors")

map("n", "<esc>", function()
  if not mc.cursorsEnabled() then
    mc.enableCursors()
  elseif mc.hasCursors() then
    mc.clearCursors()
  else
    return "<cmd>nohlsearch<cr><esc>"
  end
end, { expr = true })

mmap("n", "ga", function() mc.addCursor("vina") end, "Add cursor at next argument")
mmap("n", "gA", function() mc.addCursor("vila") end, "Add cursor at previous argument")

mmap("n", "r", mc.restoreCursors, "Restore Cursors")
mmap("n", "A", mc.alignCursors, "Align Cursors")
mmap("v", "S", mc.splitCursors, "Split Cursors")
mmap("v", "M", mc.matchCursors, "Match Cursors by regex")

mmap("v", "t", function() mc.transposeCursors(1) end, "Match Cursors by regex")
mmap("v", "T", function() mc.transposeCursors(-1) end, "Match Cursors by regex")
