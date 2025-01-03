local create_norm_bg = function()
  local norm = vim.api.nvim_get_hl(0, { name = "Normal" })
  vim.api.nvim_set_hl(0, "NormalBG", { bg = norm.bg })
end

create_norm_bg()

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = create_norm_bg,
})

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
    enabled = true,
    icons = { "◈  ", "◇  ", "◆  ", "⋄  ", "❖  ", "⟡  " },

    backgrounds = {
      "NormalBG",
      "NormalBG",
      "NormalBG",
      "NormalBG",
      "NormalBG",
      "NormalBG",
    },

    -- foregrounds = {
    --   "@markup.heading.1.markdown",
    --   "@markup.heading.2.markdown",
    --   "@markup.heading.3.markdown",
    --   "@markup.heading.4.markdown",
    --   "@markup.heading.5.markdown",
    --   "@markup.heading.6.markdown",
    -- },

    border = true,
    border_virtual = true,
    border_prefix = true,
    sign = false,
    -- icons = { " " },
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
