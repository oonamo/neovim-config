local highlight = vim.api.nvim_set_hl

-- highlight(0, "MiniPickPrompt", { link = "MiniPickNormal" })
-- highlight(0, "MiniPickBorder", { link = "MiniPickNormal" })
-- highlight(0, "MiniPickBorderBusy", { link = "MiniPickNormal" })
-- highlight(0, "MiniPickBorderText", { link = "MiniPickNormal" })
-- highlight(0, "MiniPickIconDirectory", { link = "MiniPickNormal" })
-- highlight(0, "MiniPickIconFile", { link = "MiniPickNormal" })
--
-- vim.api.nvim_create_autocmd("ColorScheme", {
--   callback = function()
--     highlight(0, "MiniPickPrompt", { link = "MiniPickNormal" })
--     highlight(0, "MiniPickBorder", { link = "MiniPickNormal" })
--     highlight(0, "MiniPickBorderBusy", { link = "MiniPickNormal" })
--     highlight(0, "MiniPickBorderText", { link = "MiniPickNormal" })
--     highlight(0, "MiniPickIconDirectory", { link = "MiniPickNormal" })
--     highlight(0, "MiniPickIconFile", { link = "MiniPickNormal" })
--   end,
-- })

-- highlight(0, 'MiniPickNormal',        { link='Pmenu' })
-- highlight(0, 'MiniPickHeader',        { link='Title' })
-- highlight(0, 'MiniPickMatchCurrent',  { link='PmenuThumb' })
-- highlight(0, 'MiniPickMatchMarked',   { link='FloatTitle' })
-- highlight(0, 'MiniPickMatchRanges',   { link='Title' })
-- highlight(0, 'MiniPickPreviewLine',   { link='PmenuThumb' })
-- highlight(0, 'MiniPickPreviewRegion', { link='PmenuThumb' })

local buf, win
local old_pos
local function floating_preview(item, opts)
  buf = vim.api.nvim_create_buf(false, true)
  local state = MiniPick.get_picker_state()
  local conf = vim.api.nvim_win_get_config(state.windows.main)
  local height = vim.o.lines
  local winopts = {
    relative = "editor",
    width = conf.width,
    height = conf.height,
    row = conf.row - (conf.height * 2) - 3,
    col = conf.col,
    border = "solid",
  }
  win = vim.api.nvim_open_win(buf, false, winopts)
  MiniPick.default_preview(buf, item, opts)
end

vim.api.nvim_create_autocmd("User", {
  pattern = "MiniPickStop",
  callback = function()
    if win and vim.api.nvim_win_is_valid(win) then vim.api.nvim_win_close(win, true) end
    -- if vim.api.nvim_buf_is_valid(buf) then vmi.api.nvim_buf
  end,
})

require("mini.pick").setup({
  window = {
    config = function()
      local height, width, starts, ends
      local win_width = vim.o.columns
      local win_height = vim.o.lines

      if win_height <= 25 then
        -- height = math.min(win_height, 18)
        width = win_width
        height = math.floor(win_height * 0.3) -- 30%
        starts = 1
        ends = win_height
      else
        width = math.floor(win_width * 0.5) -- 50%
        height = math.floor(win_height * 0.3) -- 30%
        starts = math.floor((win_width - width) / 2)
        -- center prompt: height * (50% + 30%)
        -- center window: height * [50% + (30% / 2)]
        ends = math.floor(win_height * 0.65)
      end

      return {
        col = starts,
        row = ends,
        height = height,
        width = width,
        -- border = "solid",
        -- style = "minimal",
        border = { " ", " ", " ", " ", " ", " ", " ", " " },
        -- border = "shadow",
      }
    end,
    -- config = function()
    --   return {
    --     width = vim.o.columns,
    --     height = math.floor(vim.o.lines * 0.3),
    --     border = "solid",
    --   }
    -- end,
    -- String to use as cursor in prompt
    prompt_cursor = "|",
    -- String to use as prefix in prompt
    -- prompt_prefix = ":",
  },
  mappings = {
    refine = "<C-r>",
    paste = "<C-y>",
    refine_marked = "<F1>",
    choose_marked = "<C-q>",
    scroll_up = "<C-u>",
    scroll_down = "<C-d>",
    scroll_left = "<C-h>",
    scroll_right = "<C-l>",
    -- tester = {
    --   char = "<C-h>",
    --   func = function()
    --     if win and vim.api.nvim_win_is_valid(win) then vim.api.nvim_win_close(win, true) end
    --     local cur_buf = vim.api.nvim_win_get_buf(0)
    --     if buf and cur_buf == buf then
    --       vim.api.nvim_win_set_cursor(MiniPick.get_picker_state().windows.main, old_pos)
    --       return
    --     end
    --     old_pos = vim.api.nvim_win_get_cursor(MiniPick.get_picker_state().windows.main)
    --     local item = MiniPick.get_picker_matches().current
    --     if not item then return end
    --     floating_preview(item)
    --     vim.schedule(function() vim.api.nvim_win_set_cursor(win, { 1, 0 }) end)
    --   end,
    -- },
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
  local current_line = vim.api.nvim_win_get_cursor(0)
  height = height or math.floor(0.45 * vim.o.lines)
  local anchor = get_cursor_anchor()
  vim.notify(anchor)

  return function()
    return {
      relative = "cursor",
      anchor = anchor,
      row = anchor == "SW" and 0 or 1,
      col = 0,
      -- row = current_line[1] - 1 + height,
      -- col = current_line[2],
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
      config = function()
        local height, width, starts, ends
        local win_width = vim.o.columns
        local win_height = vim.o.lines
        width = win_width
        height = math.floor(win_height * 0.3) -- 30%
        starts = 1
        ends = win_height

        return {
          col = starts,
          row = ends,
          height = 4,
          width = width,
          border = "single",
          -- style = "minimal",
          -- border = { " ", " ", " ", " ", " ", " ", " ", " " },
          -- border = "shadow",
        }
      end,
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
      config = function()
        local height, width, starts, ends
        local win_width = vim.o.columns
        local win_height = vim.o.lines
        width = win_width
        height = math.floor(win_height * 0.3) -- 30%
        starts = 1
        ends = win_height

        return {
          col = starts,
          row = ends,
          height = height,
          width = width,
          -- style = "minimal",
          border = { " ", " ", " ", " ", " ", " ", " ", " " },
          -- border = "shadow",
        }
      end,
    },
  })
end, { desc = "Pick Buffers" })
