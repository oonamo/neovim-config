local tg = require("tiny-glimmer")
tg.setup({
  overwrite = {
    auto_map = true,
    paste = {
      enabled = true,
      default_animation = "fade",
    },
  },
  support = {
    substitute = {
      enabled = true,
    }

  },
  -- animations = {
  --   fade = {
  --     max_duration = 1000,
  --     min_duration = 1000,
  --     easing = "linear",
  --     chars_for_max_duration = 10,
  --   },
  -- },
  presets = {
    -- Enable animation on cursorline when an event in `on_events` is triggered
    -- Similar to `pulsar.el`
    pulsar = {
      enabled = true,
      on_event = {  "WinEnter", "CmdlineLeave",  },
      default_animation = {
        name = "fade",

        settings = {
          max_duration = 400,
          min_duration = 200,

          from_color = "DiffDelete",
          to_color = "Normal",
        },
      },
    },
  },
})

tg.change_hl("all", { from_color = "DiffDelete", to_color = "Normal" })
