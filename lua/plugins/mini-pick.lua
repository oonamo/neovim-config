local highlight = vim.api.nvim_set_hl

local win_config = function()
  -- local height, width, starts, ends
  -- local win_width = vim.o.columns
  -- local win_height = vim.o.lines
  --
  -- width = win_width
  -- height = math.floor(win_height * 0.4) -- 40%
  -- starts = 1
  -- ends = win_height
  --
  -- if win_height <= 25 then
  --   -- height = math.min(win_height, 18)
  --   width = win_width
  --   height = math.floor(win_height * 0.4) -- 40%
  --   starts = 1
  --   ends = win_height
  -- else
  --   width = math.floor(win_width * 0.5) -- 50%
  --   height = math.floor(win_height * 0.4) -- 40%
  --   starts = math.floor((win_width - width) / 2)
  --   ends = math.floor(win_height * 0.65)
  -- end
  --
  -- return {
  --   col = starts,
  --   row = ends,
  --   height = height,
  --   width = width,
  --   -- border = "single",
  --   border = { " ", " ", " ", " ", " ", " ", " ", " " },
  -- }

  -- local height = math.floor(0.618 * vim.o.lines)
  -- local width = math.floor(0.4 * vim.o.columns)
  -- return {
  --   anchor = "NW",
  --   height = height,
  --   width = width,
  --   border = "solid",
  --   row = math.floor(0.5 * (vim.o.lines - height)),
  --   col = math.floor(0.5 * (vim.o.columns - width)),
  -- }
  --

  -- Floating Consult style
  local height = math.floor(0.3 * vim.o.lines)
  local width = math.floor(0.8 * vim.o.columns)

  -- stylua: ignore
  -- local bold_border = {
  --   "╔", "━", "╗", "┃", "╝","━", "╚", "┃"
  -- }

  -- bold   = 'vert:┃,horiz:━,horizdown:┳,horizup:┻,verthoriz:╋,vertleft:┫,vertright:┣',
  return {
    anchor = "NW",
    height = height,
    width = width,
    -- border = bold_border,
    border = "solid",
    row = math.floor(0.5 * (vim.o.lines - height)),
    col = math.floor(0.5 * (vim.o.columns - width)),
  }
end

require("mini.pick").setup({
  window = {
    config = win_config,
    prompt_prefix = "",
  },
  mappings = {
    refine = "<A-x>",
    refine_marked = "<F1>",

    paste = "<C-r>",
    choose_marked = "<C-q>",
    scroll_up = "<C-u>",
    scroll_down = "<C-d>",
    scroll_left = "<C-h>",
    scroll_right = "<C-l>",

    mark_all = "<C-j>",

    go_to_beginning = {
      char = "<C-a>",
      func = function()
        local caret_pos = MiniPick.get_picker_state().caret
        while caret_pos ~= 1 do
          vim.api.nvim_input("<left>")
          caret_pos = caret_pos - 1
        end
      end,
    },
    go_to_end = {
      char = "<C-e>",
      func = function()
        local caret_pos = MiniPick.get_picker_state().caret
        local query = MiniPick.get_picker_query()

        if not query then return end

        while (caret_pos - 1) ~= #query do
          vim.api.nvim_input("<right>")
          caret_pos = caret_pos + 1
        end
      end,
    },
  },
})

MiniPick.registry.git_status = function()
  local selection = MiniPick.builtin.cli({
    command = {
      "git",
      "status",
      "-s",
    },
  }, {
    source = {
      name = "Git Status",
      preview = function(bufnr, item)
        local file = vim.trim(item):match("%s+(.+)")
        -- get diff and show
        local append_data = function(_, data)
          if data then
            vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, data)
            vim.api.nvim_set_option_value("filetype", "diff", { buf = bufnr })
            vim.api.nvim_set_option_value("modifiable", false, { buf = bufnr })
          end
        end

        vim.fn.jobstart({ "git", "diff", "HEAD", file }, {
          stdout_buffered = true,
          on_stdout = append_data,
          on_stderr = append_data,
        })
      end,
    },
  })

  if selection then vim.cmd.edit(vim.trim(selection):match("%s+(.+)")) end
end

MiniPick.registry.projects = function()
  local cwd = vim.fn.expand("~/projects"):gsub("\\", "/")
  local choose = function(item)
    vim.schedule(function() MiniPick.builtin.files(nil, { source = { cwd = item.path } }) end)
  end
  return Config.explorer(cwd, { source = { choose = choose } })
  -- return MiniExtra.pickers.explorer({ cwd = cwd }, { source = { choose = choose, cwd = cwd } })
  -- return MiniPick.builtin.files(nil, { source = { choose = choose, cwd = cwd } })
end

require("custom.buf_lines")
require("custom.buffers")
require("custom.show_in_buffer")

require("custom.explorer").setup()

local get_cursor_anchor = function() return vim.fn.screenrow() < 0.5 * vim.o.lines and "NW" or "SW" end
local win_config_at_cursor = function(height)
  height = height or math.floor(0.45 * vim.o.lines)
  local anchor = get_cursor_anchor()

  return function()
    return {
      relative = "cursor",
      anchor = anchor,
      row = anchor == "SW" and 0 or 1,
      col = 0,
      width = math.floor(0.618 * vim.o.columns),
      height = height,
    }
  end
end

---@diagnostic disable-next-line: duplicate-set-field
vim.ui.select = function(items, opts, on_choice)
  local start_opts = {
    options = { content_from_bottom = get_cursor_anchor() == "SW" },
    window = { config = win_config_at_cursor(#items) },
  }
  MiniPick.ui_select(items, opts, on_choice, start_opts)
end

vim.keymap.set("n", ",", function()
  MiniPick.registry.buffer_inline(nil, {
    window = {
      -- config = function()
      --   local height, width, starts, ends
      --   local win_width = vim.o.columns
      --   local win_height = vim.o.lines
      --   width = win_width
      --   height = math.floor(win_height * 0.3) -- 30%
      --   starts = 1
      --   ends = win_height
      --
      --   return {
      --     col = starts,
      --     row = ends,
      --     height = 4,
      --     width = width,
      --     border = "single",
      --     -- style = "minimal",
      --     -- border = { " ", " ", " ", " ", " ", " ", " ", " " },
      --     -- border = "shadow",
      --   }
      -- end,
    },
  })
end)

vim.keymap.set(
  "n",
  "z=",
  function()
    MiniExtra.pickers.spellsuggest(nil, {
      options = { content_from_bottom = get_cursor_anchor() == "SW" },
      window = {
        config = win_config_at_cursor(),
      },
    })
  end,
  { desc = "Show Spell suggestion" }
)

vim.keymap.set("n", "<C-x>b", function()
  MiniPick.registry.buffer_preview(nil, {
    window = {
      -- config = function()
      --   local height, width, starts, ends
      --   local win_width = vim.o.columns
      --   local win_height = vim.o.lines
      --   width = win_width
      --   height = math.floor(win_height * 0.3) -- 30%
      --   starts = 1
      --   ends = win_height
      --
      --   return {
      --     col = starts,
      --     row = ends,
      --     height = height,
      --     width = width,
      --     -- style = "minimal",
      --     border = { " ", " ", " ", " ", " ", " ", " ", " " },
      --     -- border = "shadow",
      --   }
      -- end,
    },
  })
end, { desc = "Pick Buffers" })
