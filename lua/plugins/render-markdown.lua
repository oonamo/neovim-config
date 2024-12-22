require("render-markdown").setup({
  preset = "obsidian",
  -- render_modes = { "n", "c" },
  quote = { repeat_linebreak = true },
  callout = {
    schedule = { raw = "[!SCHEDULE]", rendered = " Schedule", highlight = "Special" },
    formula = { raw = "[!FORMULA]", rendered = "󰡱 Formula", highlight = "Boolean" },
  },
  win_options = {
    -- showbreak = { default = "", rendered = "  " },
    breakindent = { default = true, rendered = true },
    wrap = { default = true, rendered = true },
    -- breakindentopt = { default = "list:-1", rendered = "" },
  },
  code = {
    sign = false,

    -- Obsidian Style
    width = "block",
    min_width = 60,
    left_pad = 3,
    position = "right",
    border = "thick",
  },
  heading = {
    border = false,
    border_virtual = true,
    border_prefix = true,
    sign = false,
    icons = { " " },
    position = "inline",
  },
  pipe_table = {
    preset = "round",
    alignment_indicator = "┅",
  },
  latex = {
    enabled = false,
    top_pad = 1,
    bottom_pad = 1,
  },
  signs = {
    enabled = false,
  },
})
