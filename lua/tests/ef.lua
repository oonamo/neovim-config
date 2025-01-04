local M = {}

local function hi(name, hl) vim.api.nvim_set_hl(0, name, hl) end

local function get_hi(name, prop)
  local hl = vim.api.nvim_get_hl(0, {
    name = name,
    link = false,
  })
  return hl[prop]
end

local function normalize(c)
  local sc = get_hi("SignColumn", "bg")
  hi("MiniDiffSignAdd", { fg = c["bg-added"], bg = sc })
  hi("MiniDiffSignChange", { fg = c["bg-changed"], bg = sc })
  hi("MiniDiffSignDelete", { fg = c["bg-removed"], bg = sc })
  hi("MiniDiffOverAdd", { fg = c["fg-added"], bg = c["bg-added-refine"] })
  hi("MiniDiffOverChange", { fg = c["fg-changed"], bg = c["bg-changed-refine"] })
  hi("MiniDiffOverDelete", { fg = c["fg-removed"], bg = c["bg-removed-refine"] })
  hi("MiniIconsAzure", { fg = c["blue-warmer"] })
  hi("MiniIconsBlue", { fg = c["blue"] })
  hi("MiniIconsCyan", { fg = c["cyan"] })
  hi("MiniIconsGreen", { fg = c["green"] })
  hi("MiniIconsGrey", { fg = c["bf-active"] })
  hi("MiniIconsOrange", { fg = c["bg-yellow-intense"] })
  hi("MiniIconsPurple", { fg = c["magenta"] })
  hi("MiniIconsRed", { fg = c["red"] })
  hi("MiniIconsYellow", { fg = c["yellow"] })
  hi("DiagnosticFloatingError", { fg = c["bg-red-intense"], bg = c["bg-red-subtle"] })
  hi("DiagnosticFloatingWarn", { fg = c["bg-yellow-intense"], bg = c["bg-yellow-subtle"] })
  hi("DiagnosticFloatingInfo", { fg = c["bg-green-intense"], bg = c["bg-green-subtle"] })
  hi("DiagnosticFloatingHint", { fg = c["bg-blue-intense"], bg = c["bg-blue-subtle"] })
  hi("DiagnosticError", { link = "DiagnosticFloatingError" })
  hi("DiagnosticWarn", { link = "DiagnosticFloatingWarn" })
  hi("DiagnosticInfo", { link = "DiagnosticFloatingInfo" })
  hi("DiagnosticHint", { link = "DiagnosticFloatingHint" })
end

function M.arbutus()
  local palette = {
    base00 = "#ffead8", -- Defaum. bg
    base01 = "#e8d2cb", -- Lighter bg (status bar, line number, folding mks)
    base02 = "#dbe0c0", -- Selection bg
    base03 = "#6e678f", -- Comments, invisibm.s, line hl
    base04 = "#e9a0a0", -- Dark fg (status bars)
    base05 = "#393330", -- Defaum. fg (caret, delimiters, Operators)
    base06 = "#8a5f4a", -- m.ght fg (not often used)
    base07 = "#8f97d7", -- Light bg (not often used)
    base08 = "#aa184f", -- Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
    base09 = "#906200", -- Integers, Boom.an, Constants, XML Attributes, Markup Link Url
    -- base0A = "#1e8ef3", -- Cm.sses, Markup Bold, Search Text Background
    base0A = "#b0000f",
    base0B = "#557000",
    -- base0B = "#8f97d7", -- Strings, Inherited Cm.ss, Markup Code, Diff Inserted
    base0C = "#b44405", -- Support, regex, escape chars
    base0D = "#007000", -- Function, methods, headings
    base0E = "#8f2f30", -- Keywords
    base0F = "#dc8cc3", -- Deprecated, open/close embedded tags
  }
  local c = {
    ["bg-main"] = "#ffead8",
    ["fg-main"] = "#393330",
    ["bg-dim"] = "#f0d8cf",
    ["fg-dim"] = "#6e678f",
    ["bg-alt"] = "#e7d2cb",
    ["fg-alt"] = "#8a5f4a",

    ["bg-active"] = "#c7b2ab",
    ["bg-inactive"] = "#f7e2d2",
    ["red"] = "#b0000f",
    ["red-warmer"] = "#b20f00",
    ["red-cooler"] = "#aa184f",
    ["red-faint "] = "#8f2f30",
    ["green"] = "#007000",
    ["green-warmer"] = "#557000",
    ["green-cooler"] = "#00704f",
    ["green-faint"] = "#3f712f",
    ["yellow"] = "#906200",
    ["yellow-warmer"] = "#b44405",
    ["yellow-cooler"] = "#8a6340",
    ["yellow-faint"] = "#8d6068",
    ["blue"] = "#375cc6",
    ["blue-warmer"] = "#5f55df",
    ["blue-cooler"] = "#265fbf",
    ["blue-faint"] = "#4a659f",
    ["magenta"] = "#a23ea4",
    ["magenta-warmer"] = "#bf2c90",
    ["magenta-cooler"] = "#6448ca",
    ["magenta-faint"] = "#845592",
    ["cyan"] = "#3f69af",
    ["cyan-warmer"] = "#4060a0",
    ["cyan-cooler"] = "#0f7688",
    ["cyan-faint"] = "#546f70",
    ["bg-red-intense"] = "#ff8f88",
    ["bg-green-intense"] = "#96df80",
    ["bg-yellow-intense"] = "#efbf00",
    ["bg-blue-intense"] = "#afbeff",
    ["bg-magenta-intense"] = "#bf9fff",
    ["bg-cyan-intense"] = "#88d4f0",

    ["bg-red-subtle"] = "#f9c2bf",
    ["bg-green-subtle"] = "#c4eda0",
    ["bg-yellow-subtle"] = "#efe76f",
    ["bg-blue-subtle"] = "#cfdff0",
    ["bg-magenta-subtle"] = "#f0d0f0",
    ["bg-cyan-subtle"] = "#bfe8eb",
    ["bg-added"] = "#d0e6b0",
    ["bg-added-faint"] = "#e2efc0",
    ["bg-added-refine"] = "#bbd799",
    ["fg-added"] = "#005000",

    ["bg-changed"] = "#f5e690",
    ["bg-changed-faint"] = "#f5edaf",
    ["bg-changed-refine"] = "#edd482",
    ["fg-changed"] = "#553d00",

    ["bg-removed"] = "#f8c6b6",
    ["bg-removed-faint"] = "#f5d0b0",
    ["bg-removed-refine"] = "#f0aaa9",
    ["fg-removed"] = "#8f1313",
  }
  require("mini.base16").setup({ palette = palette })
  -- hi("LineNr", { fg = c["fg-main"] })
  -- hi("LineNrAbove", { fg = c["fg-dim"] })
  -- hi("LineNrBelow", { fg = c["fg-dim"] })
  normalize(c)
  vim.cmd("doautocmd Colorscheme")
end

function M.winter()
  local c = {
    ["bg-main"] = "#0f0b15",
    ["fg-main"] = "#b8c6d5",
    ["bg-dim"] = "#1d202f",
    ["fg-dim"] = "#807c9f",
    ["bg-alt"] = "#2a2f42",
    ["fg-alt"] = "#bf8f8f",

    ["bg-active"] = "#4a4f62",
    ["bg-inactive"] = "#19181f",

    ["red"] = "#f47359",
    ["red-warmer"] = "#ef6560",
    ["red-cooler"] = "#ff6a7a",
    ["red-faint"] = "#d56f72",
    ["green"] = "#29a444",
    ["green-warmer"] = "#6aad0f",
    ["green-cooler"] = "#00a392",
    ["green-faint"] = "#61a06c",
    ["yellow"] = "#b58a52",
    ["yellow-warmer"] = "#d1803f",
    ["yellow-cooler"] = "#df9080",
    ["yellow-faint"] = "#c0a38a",
    ["blue"] = "#3f95f6",
    ["blue-warmer"] = "#6a9fff",
    ["blue-cooler"] = "#029fff",
    ["blue-faint"] = "#7a94df",
    ["magenta"] = "#d369af",
    ["magenta-warmer"] = "#e580e0",
    ["magenta-cooler"] = "#af85ea",
    ["magenta-faint "] = "#c57faf",
    ["cyan"] = "#4fbaef",
    ["cyan-warmer"] = "#6fafdf",
    ["cyan-cooler"] = "#35afbf",
    ["cyan-faint"] = "#8aa0df",

    ["bg-red-intense"] = "#b02930",
    ["bg-green-intense"] = "#0a7040",
    ["bg-yellow-intense"] = "#8f5040",
    ["bg-blue-intense"] = "#4648d0",
    ["bg-magenta-intense"] = "#a04fc5",
    ["bg-cyan-intense"] = "#2270cf",

    ["bg-red-subtle"] = "#67182f",
    ["bg-green-subtle"] = "#10452f",
    ["bg-yellow-subtle"] = "#54362a",
    ["bg-blue-subtle"] = "#2a346e",
    ["bg-magenta-subtle"] = "#572454",
    ["bg-cyan-subtle"] = "#133d56",

    ["bg-added"] = "#00371f",
    ["bg-added-faint"] = "#002918",
    ["bg-added-refine"] = "#004c2f",
    ["fg-added"] = "#a0e0a0",

    ["bg-changed"] = "#363300",
    ["bg-changed-faint"] = "#2a1f00",
    ["bg-changed-refine"] = "#4a4a00",
    ["fg-changed"] = "#efef80",

    ["bg-removed"] = "#450f1f",
    ["bg-removed-faint"] = "#2f060f",
    ["bg-removed-refine"] = "#641426",
    ["fg-removed"] = "#ffbfbf",
  }
  local palette = {
    base00 = c["bg-main"], -- Defaum. bg
    base01 = c["bg-alt"], -- Lighter bg (status bar, line number, folding mks)
    base02 = "#342464", -- Selection bg
    base03 = c["yellow-faint"], -- Comments, invisibm.s, line hl
    base04 = c["fg-dim"], -- Dark fg (status bars)
    base05 = c["fg-main"], -- Defaum. fg (caret, delimiters, Operators)
    base06 = c["fg-dim"], -- m.ght fg (not often used)
    base07 = c["bg-dim"], -- Light bg (not often used)
    base08 = c["blue-warmer"], -- Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
    base09 = c["magenta"], -- Integers, Boom.an, Constants, XML Attributes, Markup Link Url
    -- base0A = "#1e8ef3", -- Cm.sses, Markup Bold, Search Text Background
    base0A = c["cyan"],
    -- base0B = c["cyan-faint"],
    base0B = c["yellow-cooler"],
    -- base0B = "#8f97d7", -- Strings, Inherited Cm.ss, Markup Code, Diff Inserted
    base0C = c["green"], -- Support, regex, escape chars
    base0D = c["cyan-cooler"], -- Function, methods, headings
    base0E = c["magenta-cooler"], -- Keywords
    base0F = c["yellow"], -- Deprecated, open/close embedded tags
  }

  require("mini.base16").setup({ palette = palette })
  hi("LineNr", { fg = c["fg-dim"] })
  hi("LineNrAbove", { fg = c["fg-dim"] })
  hi("LineNrBelow", { fg = c["fg-dim"] })
  hi("SignColumn", { fg = c["fg-dim"] })
  hi("Pmenu", { bg = "#19181f", fg = "#b8c6d5" })
  hi("PmenuSel", { bg = "#1f2a7a", fg = "#b8c6d5" })
  hi("MiniPickMatchCurrent", { bg = "#1f2a7a" })
  hi("MiniPickMatchRanges", { fg = "#af85ea", bold = true })
  hi("StatusLine", { bg = "#5f1f5f", fg = "#dedeff" })
  hi("MiniPickNormal", { bg = "#0f0b15", fg = "#b8c6d5" })
  hi("MiniPickBorder", { bg = "#5f1f5f", fg = "#5f1f5f" })
  hi("MiniPickHeader", { fg = "#e580e0" })
  hi("MiniPickBorderText", { fg = "#e580e0" })
  normalize(c)
  vim.cmd("doautocmd Colorscheme")
end

-- M.arbutus()
M.winter()

-- local test_16 = {
--   base00 = "#352718",
--   base01 = "#90918A",
--   base02 = "#60518F",
--   base03 = "#EAB780",
--   base04 = "#704F00",
--   base05 = "#E8E4B1",
--   base06 = "#90918A",
--   base07 = "#483426",
--   base08 = "#6FCAD0",
--   base09 = "#98BFFF",
--   base0A = "#65D590",
--   base0B = "#FFA21F",
--   base0C = "#6FD560",
--   base0D = "#6FD560",
--   base0E = "#E4B53F",
--   base0F = "#FF7F4F",
-- }
--
-- vim.cmd.hi("clear")
-- require("mini.base16").setup({ palette = test_16 })
