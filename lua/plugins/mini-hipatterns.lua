local hipatterns = require("mini.hipatterns")
hipatterns.setup({
  highlighters = {
      -- stylua: ignore start
      fixme       = { pattern = "() FIXME():",   group = "MiniHipatternsFixme" },
      hack        = { pattern = "() HACK():",    group = "MiniHipatternsHack" },
      todo        = { pattern = "() TODO():",    group = "MiniHipatternsTodo" },
      note        = { pattern = "() NOTE():",    group = "MiniHipatternsNote" },
      perf        = { pattern = "() PERF():",    group = "MiniHipatternsFixme" },
      fixme_colon = { pattern = " FIXME():()",   group = "MiniHipatternsFixmeColon" },
      hack_colon  = { pattern = " HACK():()",    group = "MiniHipatternsHackColon" },
      todo_colon  = { pattern = " TODO():()",    group = "MiniHipatternsTodoColon" },
      note_colon  = { pattern = " NOTE():()",    group = "MiniHipatternsNoteColon" },
      perf_colon  = { pattern = " PERF():()",    group = "MiniHipatternsFixmeColon" },
      fixme_body  = { pattern = " FIXME:().*()", group = "MiniHipatternsFixmeBody" },
      hack_body   = { pattern = " HACK:().*()",  group = "MiniHipatternsHackBody" },
      todo_body   = { pattern = " TODO:().*()",  group = "MiniHipatternsTodoBody" },
      note_body   = { pattern = " NOTE:().*()",  group = "MiniHipatternsNoteBody" },
      perf_body   = { pattern = " PERF:().*()",  group = "MiniHipatternsFixmeBody" },
    -- stylua: ignore end

    hex_color = hipatterns.gen_highlighter.hex_color({
      style = "inline",
      inline_text = "⬤  ",
    }),
  },
})

local hi = function(...) vim.api.nvim_set_hl(0, ...) end

local function create_hi_hls()
  for _, v in ipairs({ "Fixme", "Todo", "Note", "Hack", "Perf" }) do
    local hl = vim.api.nvim_get_hl(0, { name = "MiniHipatterns" .. v })
    hi("MiniHipatterns" .. v .. "Colon", hl)
    if hl.bg then
      hi("MiniHipatterns" .. v .. "Body", { fg = hl.bg })
    else
      -- hi("MiniHipatterns" .. v .. "Colon", { fg = hl.fg })
      hi("MiniHipatterns" .. v .. "Body", { fg = hl.fg })
    end
  end
end

create_hi_hls()
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function() create_hi_hls() end,
})
