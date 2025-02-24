require("mini.jump2d").setup({
  -- Just use the easy keys
  labels = "asdfghjkl",
  view = {
    dim = true,
    n_steps_ahead = 10000000,
  },
  mappings = {
    start_jumping = "<C-s>",
  },
})

local cache = {}

local function echo(msg, is_important)
  -- Construct message chunks
  msg = type(msg) == "string" and { { msg } } or msg
  table.insert(msg, 1, { "(mini.jump2d) ", "WarningMsg" })

  -- Avoid hit-enter-prompt
  local max_width = vim.o.columns * math.max(vim.o.cmdheight - 1, 0) + vim.v.echospace
  local chunks, tot_width = {}, 0
  for _, ch in ipairs(msg) do
    local new_ch = { vim.fn.strcharpart(ch[1], 0, max_width - tot_width), ch[2] }
    table.insert(chunks, new_ch)
    tot_width = tot_width + vim.fn.strdisplaywidth(new_ch[1])
    if tot_width >= max_width then break end
  end

  -- Echo. Force redraw to ensure that it is effective (`:h echo-redraw`)
  vim.cmd([[echo '' | redraw]])
  vim.api.nvim_echo(chunks, is_important, {})
end

local function unecho()
  if cache.msg_shown then vim.cmd([[echo '' | redraw]]) end
end

local function getcharstr(msg)
  local needs_help_msg = true
  if msg ~= nil then
    vim.defer_fn(function()
      if not needs_help_msg then return end
      echo(msg)
      cache.msg_shown = true
    end, 1000)
  end

  cache.is_in_getcharstr = true
  local _, char = pcall(vim.fn.getcharstr)
  cache.is_in_getcharstr = false
  needs_help_msg = false
  unecho()

  return char
end

-- Produce `opts` which modifies spotter based on user input
local function user_input_opts(input_fun)
  local res = {
    spotter = function() return {} end,
    allowed_lines = { blank = false, fold = false },
  }

  res.hooks = {
    before_start = function()
      local input = input_fun()
      if input == nil then
        res.spotter = function() return {} end
      else
        local pattern = vim.pesc(input)
        res.spotter = MiniJump2d.gen_pattern_spotter(pattern)
      end
    end,
  }

  return res
end

local uppercase_letter = MiniJump2d.gen_pattern_spotter("%u[%l%d]+%f[^%l%d]")
local camel_snake_spotter = MiniJump2d.gen_pattern_spotter("%f[^%s%p][%l%d]+%f[^%l%d]")
local camel_snake_spotter_after_line = MiniJump2d.gen_pattern_spotter("^[%l%d]+%f[^%l%d]")
local screaming_case_spotter = MiniJump2d.gen_pattern_spotter("%f[^%s%p][%a%d]+%f[^%a%d]")
local screaming_case_spotter_after_line = MiniJump2d.gen_pattern_spotter("^[%a%d]+%f[^%a%d]")

local word_spotter = MiniJump2d.gen_union_spotter(
  uppercase_letter,
  camel_snake_spotter,
  camel_snake_spotter_after_line,
  screaming_case_spotter,
  screaming_case_spotter_after_line
)

local function gen_nchars(n)
  return user_input_opts(function()
    local chars = ""
    for i = 1, n do
      local ret = getcharstr(string.format("(%i): %s", i, chars))
      if ret then chars = chars .. ret end
    end
    if #chars == 0 then return nil end

    return chars
  end)
end

local get_2_chars = gen_nchars(2)

vim.keymap.set(
  { "n", "v", "x", "o" },
  "gw",
  function()
    MiniJump2d.start({
      spotter = word_spotter,
    })
  end,
  { desc = "Jump to word" }
)

vim.keymap.set(
  { "n", "v", "x" },
  "<M-g>f",
  function() MiniJump2d.start(MiniJump2d.builtin_opts.line_start) end,
  { desc = "Jump to line start" }
)

-- local jump_2_word = MiniJump2d.gen_union_spotter(get_2_chars.spotter, word_spotter)
vim.keymap.set({ "n", "v", "x", "o" }, "<M-g>w", function() MiniJump2d.start(get_2_chars) end, { desc = "Jump 2 word" })
