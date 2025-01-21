return {
  {
    "echasnovski/mini.nvim",
    event = "VeryLazy",
    config = function()
      require("plugins.mini.keymaps")
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
      require("mini.animate").setup()
      vim.ui.select = require("mini.pick").ui_select
      require("mini.pick").setup({
        mappings = {
          paste = "<C-y>",
          refine = "<C-g>",
          refine_marked = "<C-r>",
          choose_marked = "<C-q>",
        },
        window = {
          -- prompt_prefix = "| ",
          config = function()
            return {
              width = vim.o.columns,
              height = math.floor(vim.o.lines * 0.3),
              border = "none",
            }
          end,
        },
      })
      require("mini.move").setup({
        mappings = {
          left = "H",
          right = "L",
          line_left = "H",
          down = "J",
          up = "K",
        },
      })
      require("mini.operators").setup()
      require("mini.splitjoin").setup()
      require("mini.bracketed").setup()
      require("mini.align").setup()
      require("mini.surround").setup({
        highlight_duration = 500,
        mappings = {
          add = "gsa", -- Add surrounding in Normal and Visual modes
          delete = "gsd", -- Delete surrounding
          find = "gsn", -- Find surrounding (to the right)
          find_left = "gsN", -- Find surrounding (to the left)
          highlight = "gsh", -- Highlight surrounding
          replace = "gsr", -- Replace surrounding
          update_n_lines = "", -- Update `n_lines`

          suffix_last = "l", -- Suffix to search with "prev" method
          suffix_next = "n", -- Suffix to search with "next" method
        },
        search_method = "cover_or_next",
      })

      require("mini.hipatterns").setup({
        highlighters = {
          fixme = { pattern = "() FIXME():", group = "MiniHipatternsFixme" },
          hack = { pattern = "() HACK():", group = "MiniHipatternsHack" },
          todo = { pattern = "() TODO():", group = "MiniHipatternsTodo" },
          note = { pattern = "() NOTE():", group = "MiniHipatternsNote" },
          fixme_colon = { pattern = " FIXME():()", group = "MiniHipatternsFixmeColon" },
          hack_colon = { pattern = " HACK():()", group = "MiniHipatternsHackColon" },
          todo_colon = { pattern = " TODO():()", group = "MiniHipatternsTodoColon" },
          note_colon = { pattern = " NOTE():()", group = "MiniHipatternsNoteColon" },
          fixme_body = { pattern = " FIXME:().*()", group = "MiniHipatternsFixmeBody" },
          hack_body = { pattern = " HACK:().*()", group = "MiniHipatternsHackBody" },
          todo_body = { pattern = " TODO:().*()", group = "MiniHipatternsTodoBody" },
          note_body = { pattern = " NOTE:().*()", group = "MiniHipatternsNoteBody" },
          hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
        },
      })
      local function gen_colors()
        for _, v in ipairs({ "Fixme", "Hack", "Todo", "Note" }) do
          local basename = "MiniHipatterns" .. v
          local hl = vim.api.nvim_get_hl(0, { name = basename })
          if not hl.bg then
            vim.api.nvim_set_hl(0, basename .. "Body", { link = basename })
            vim.api.nvim_set_hl(0, basename .. "Colon", { link = basename })
          else
            vim.api.nvim_set_hl(0, basename .. "Colon", { fg = hl.bg, bg = hl.bg })
            vim.api.nvim_set_hl(0, basename .. "Body", { fg = hl.bg })
          end
        end
      end
      gen_colors()

      vim.api.nvim_create_autocmd("Colorscheme", {
        callback = gen_colors,
      })
      require("mini.git").setup()
      require("mini.align").setup()
      require("mini.jump").setup()
      require("mini.diff").setup({
        view = {
          style = "sign",
          signs = { add = "┃", change = "┃", delete = "┃" },
          -- signs = { add = "▍ ", change = "▍ ", delete = " " },
        },
      })
      local ai = require("mini.ai")
      require("mini.ai").setup({
        custom_textobjects = {
          B = require("mini.extra").gen_ai_spec.buffer(),
          i = require("mini.extra").gen_ai_spec.indent(),
          F = ai.gen_spec.argument({ brackets = { "%b()" } }),
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
          d = { "%f[%d]%d+" }, -- digits
          e = { -- Word with case
            {
              "%u[%l%d]+%f[^%l%d]",
              "%f[%S][%l%d]+%f[^%l%d]",
              "%f[%P][%l%d]+%f[^%l%d]",
              "^[%l%d]+%f[^%l%d]",
            },
            "^().*()$",
          },
          u = ai.gen_spec.function_call(), -- u for Usage
          U = ai.gen_spec.function_call({ name_pattern = "[%w_" }), -- without dot
        },
      })

      local pairs = require("mini.pairs")
      pairs.setup({
        mappings = {
          ['"'] = { action = "closeopen", pair = '""', neigh_pattern = "[^\\].", register = { cr = true } },
        },
      })
      local open = pairs.open
      pairs.open = function(pair, neigh_pattern)
        if vim.fn.getcmdline() ~= "" then return open(pair, neigh_pattern) end
        local o, c = pair:sub(1, 1), pair:sub(2, 2)
        local line = vim.api.nvim_get_current_line()
        local cursor = vim.api.nvim_win_get_cursor(0)
        local next = line:sub(cursor[2] + 1, cursor[2] + 1)
        local before = line:sub(1, cursor[2])
        if vim.bo.filetype == "markdown" and before:match("^%s*``") then
          return "`\n```" .. vim.api.nvim_replace_termcodes("<up>", true, true, true)
        end
        if next ~= "" and next:match([=[[%w%%%'%[%"%.%`%$]]=]) then
          print("Found next!")
          print(next)
          return o
        end
        local ok, captures = pcall(vim.treesitter.get_captures_at_pos, 0, cursor[1] - 1, math.max(cursor[2] - 1, 0))
        for _, capture in ipairs(ok and captures or {}) do
          if vim.tbl_contains({ "string " }, capture.capture) then return o end
        end
        if next == c and c ~= o then
          local _, count_open = line:gsub(vim.pesc(pair:sub(1, 1)), "")
          local _, count_close = line:gsub(vim.pesc(pair:sub(2, 2)), "")
          if count_close > count_open then return o end
        end
        return open(pair, neigh_pattern)
      end
    end,
  },
  {
    "mini.clue",
    virtual = true,
    event = "VeryLazy",
    opts = {},
    config = function(_, opts)
      local clue = require("mini.clue")
      require("mini.clue").setup({
        triggers = {
          -- Leader triggers
          { mode = "n", keys = "<Leader>" },
          { mode = "x", keys = "<Leader>" },

          -- Built-in completion
          { mode = "i", keys = "<C-x>" },

          -- `g` key
          { mode = "n", keys = "g" },
          { mode = "x", keys = "g" },

          -- Marks
          { mode = "n", keys = "'" },
          { mode = "n", keys = "`" },
          { mode = "x", keys = "'" },
          { mode = "x", keys = "`" },

          -- Registers
          { mode = "n", keys = '"' },
          { mode = "x", keys = '"' },
          { mode = "i", keys = "<C-r>" },
          { mode = "c", keys = "<C-r>" },

          -- Window commands
          { mode = "n", keys = "<C-w>" },

          -- `z` key
          { mode = "n", keys = "z" },
          { mode = "x", keys = "z" },

          { mode = "n", keys = "<C-x>" },
          { mode = "x", keys = "<C-x>" },
        },
        clues = {
          clue.gen_clues.builtin_completion(),
          clue.gen_clues.g(),
          clue.gen_clues.marks(),
          clue.gen_clues.registers(),
          clue.gen_clues.windows(),
          clue.gen_clues.z(),
          { mode = "n", keys = "<Leader>b", desc = "+Buffer" },
          { mode = "n", keys = "<Leader>g", desc = "+Git" },
          { mode = "n", keys = "<Leader>l", desc = "+LSP" },
          { mode = "n", keys = "<Leader>L", desc = "+Lua" },
          { mode = "n", keys = "<Leader>o", desc = "+Other" },
          { mode = "n", keys = "<Leader>t", desc = "+Terminal" },
          { mode = "n", keys = "<Leader>v", desc = "+Visits" },

          { mode = "x", keys = "<Leader>l", desc = "+LSP" },
        },
      })
    end,
  },
  {
    "mini.statusline",
    event = "VeryLazy",
    virtual = true,
    config = function(_, opts) require("mini.statusline").setup(opts) end,
  },
  {
    "mini.files",
    virtual = true,
    opts = {},
    config = function(_, opts)
      require("mini.files").setup(opts)
      local show_dotfiles = false

      local filter_show = function(fs_entry) return true end

      local filter_hide = function(fs_entry) return not vim.startswith(fs_entry.name, ".") end

      local toggle_dotfiles = function()
        show_dotfiles = not show_dotfiles
        local new_filter = show_dotfiles and filter_show or filter_hide
        MiniFiles.refresh({ content = { filter = new_filter } })
      end

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
          local buf_id = args.data.buf_id
          -- Tweak left-hand side of mapping to your liking
          vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = buf_id })
        end,
      })
    end,
    keys = {
      {
        "<leader>e",
        function() require("mini.files").open() end,
      },
      {
        "-",
        function() require("mini.files").open(vim.api.nvim_buf_get_name(0)) end,
      },
    },
  },
}
-- tyep
