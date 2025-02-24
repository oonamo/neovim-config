local diag_signs = {
  ERROR = "%#DiagnosticError#x %#MiniStatuslineDevinfo#",
  WARN = "%#DiagnosticWarn#▲ %#MiniStatuslineDevinfo#",
  INFO = "%#DiagnosticInfo#I %#MiniStatuslineDevinfo#",
  HINT = "%#DiagnosticHint#H %#MiniStatuslineDevinfo#",
}

local function statusline()
  local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
  local git = MiniStatusline.section_git({ trunc_width = 40 })
  local diff = MiniStatusline.section_diff({ trunc_width = 75, icon = "" })
  local diagnostics = MiniStatusline.section_diagnostics({
    trunc_width = 75,
    signs = diag_signs,
    icon = "",
  })
  local filename = MiniStatusline.section_filename({ trunc_width = 140 })
  local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
  local location = MiniStatusline.section_location({ trunc_width = 75 })
  local search = MiniStatusline.section_searchcount({ trunc_width = 75 })
  local spell = vim.wo.spell and (MiniStatusline.is_truncated(120) and "S" or "SPELL") or ""

  return MiniStatusline.combine_groups({
    { hl = mode_hl, strings = { mode } },
    { hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics } },
    "%<", -- Mark general truncate point
    { hl = "MiniStatuslineFilename", strings = { filename } },
    "%=", -- End left alignment
    { hl = "MiniStatuslineFileinfo", strings = { fileinfo, spell } },
    { hl = mode_hl, strings = { search, location } },
  })
end

require("mini.statusline").setup({
  content = {
    active = statusline,
  },
})
