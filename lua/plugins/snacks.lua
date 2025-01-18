require("snacks").setup({
  picker = {
    formatters = {
      file = {
        filename_first = true,
      },
    },
    enabled = true,
    layout = {
      -- preset = "dropdown",
      -- preset = "default",
      -- preset = "dropdown",
      preset = "ivy",
      -- preset = "select",
      -- preset = "telescope",
      -- preset = "vertical",
      -- preset = "vscode",
    },
  },
})

local function map_leader(modes, suffix, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc
  vim.keymap.set(modes, "<leader>" .. suffix, rhs, opts)
end

local function cx_leader(modes, suffix, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc
  vim.keymap.set(modes, "<C-x>" .. suffix, rhs, opts)
end

map_leader("n", ":", function() Snacks.picker.command_history() end)
map_leader("n", ",", function() Snacks.picker.buffers() end, "Find buffers")
map_leader("n", ".", function() Snacks.picker.files() end, "Find files")
map_leader("n", "?", function() Snacks.picker.help() end, "Find help")
map_leader("n", "/", function() Snacks.picker.grep() end, "Grep live")
map_leader("n", "o", function() Snacks.picker.recent() end, "Find oldfiles")

map_leader("n", "fb", function() Snacks.picker.buffers() end, "Buffers")
map_leader("n", "fc", function() Snacks.picker.git_log() end, "Commits (all)")
map_leader("n", "fd", function() Snacks.picker.diagnostics() end, "Diagnostic workspace")
map_leader("n", "fD", function() Snacks.picker.diagnostics_buffer() end, "Diagnostic buffer")
map_leader("n", "ff", function() Snacks.picker.files() end, "Files")
map_leader("n", "fg", function() Snacks.picker.grep() end, "Grep live")
map_leader("n", "fH", function() Snacks.picker.highlights() end, "Highlight groups")
map_leader("n", "fl", function() Snacks.picker.lines() end, "Lines (all)")
map_leader("n", "fR", function() Snacks.picker.lsp_references() end, "References (LSP)")
map_leader("n", "fs", function() Snacks.picker.lsp_symbols() end, "Symbols workspace (LSP)")

cx_leader("n", "b", function() Snacks.picker.buffers() end, "Pick Buffers")
cx_leader("n", "h", function() Snacks.picker.help() end, "Pick help")

vim.keymap.set("n", ",", function() Snacks.picker.lines() end)
