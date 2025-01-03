vim.loader.enable()

-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath("data") .. "/site/"
local mini_path = path_package .. "pack/deps/start/mini.nvim"

_G.Config = {
  path_source = vim.fn.stdpath("config") .. "/lua/",
  path_package = path_package .. "pack/deps/opt/",
}

if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/echasnovski/mini.nvim",
    mini_path,
  }
  vim.fn.system(clone_cmd)
  vim.cmd("packadd mini.nvim | helptags ALL")
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

require("mini.deps").setup({ path = { package = path_package } })

local now, add, later = MiniDeps.now, MiniDeps.add, MiniDeps.later
local source = function(path) dofile(Config.path_source .. path) end

--================== Colors ====================
now(function() add({ source = "folke/tokyonight.nvim" }) end)
now(function() add({ source = "EdenEast/nightfox.nvim" }) end)
now(function() add({ source = "rebelot/kanagawa.nvim" }) end)
now(function() add({ source = "sainnhe/everforest" }) end)
now(function() add({ source = "rose-pine/neovim" }) end)
now(function() add({ source = "catppuccin/nvim" }) end)

--================== Settings ====================
now(function() source("settings.lua") end)
now(function() source("mappings.lua") end)
now(function() source("leader_maps.lua") end)
now(function() source("config/autocommands.lua") end)
now(function() source("tests/nano.lua") end)

if vim.env.TERM_PROGRAM == "WezTerm" then now(function() require("config.utils").wezterm() end) end

now(function() source("functions.lua") end)
now(function() source("tests/compile_mode.lua") end)
now(function()
  source("config/statuscolumn.lua")
  vim.o.statuscolumn = "%!v:lua.require('config.statuscolumn').statuscolumn()"
end)

if vim.g.neovide or vim.g.goneovim then now(function() source("config/gui.lua") end) end

--================== UI Plugins ====================
now(function()
  require("mini.notify").setup({
    window = { config = { border = "solid" } },
    lsp_progress = { enable = false },
  })
  vim.notify = MiniNotify.make_notify()
end)
now(function() require("mini.icons").setup() end)
now(function()
  require("mini.tabline").setup({
    show_icons = false,
    tabpage_section = "right",
  })
end)
now(function() source("plugins/mini-starter.lua") end)

if vim.fn.has("gui_running") == 0 then
  now(function() require("mini.animate").setup({ scroll = { enable = false } }) end)
end

--================== Mini Plugins ====================
later(function() require("mini.pairs").setup() end)
later(function() source("plugins/mini-files.lua") end)
later(function() require("mini.extra").setup() end)
later(function() require("mini.bufremove").setup() end)
later(function() require("mini.indentscope").setup() end)
later(function() require("mini.indentscope").setup() end)
later(function()
  require("mini.misc").setup({
    make_global = { "put", "put_text" },
  })
  MiniMisc.setup_auto_root()
  MiniMisc.setup_restore_cursor()
end)
later(function() add("rafamadriz/friendly-snippets") end)
later(function()
  local snippets = require("mini.snippets")
  snippets.setup({
    snippets = {
      snippets.gen_loader.from_file(vim.fn.stdpath("config") .. "/snippets/global.json"),
      snippets.gen_loader.from_lang(),
    },
    expand = {
      select = function(...)
        local ok, b = pcall(require, "blink.cmp")
        if ok then
          pcall(b, "hide")
          pcall(vim.api.nvim_buf_clear_namespace, 0, vim.api.nvim_get_namespaces()["blink_cmp"], 0, -1)
          pcall(vim.api.nvim_buf_clear_namespace, 0, vim.api.nvim_get_namespaces()["blink_cmp_renderer"], 0, -1)
        end

        MiniSnippets.default_select(...)
      end,
    },
  })
end)

later(function()
  local hipatterns = require("mini.hipatterns")
  local hi_words = MiniExtra.gen_highlighter.words
  hipatterns.setup({
    highlighters = {
      fixme = hi_words({ "FIXME", "Fixme", "fixme" }, "MiniHipatternsFixme"),
      hack = hi_words({ "HACK", "Hack", "hack" }, "MiniHipatternsHack"),
      todo = hi_words({ "TODO", "Todo", "todo" }, "MiniHipatternsTodo"),
      note = hi_words({ "NOTE", "Note", "note" }, "MiniHipatternsNote"),

      hex_color = hipatterns.gen_highlighter.hex_color(),
    },
  })
end)
later(function()
  require("mini.pick").setup({
    window = {
      config = function()
        return {
          width = vim.o.columns,
          height = math.floor(vim.o.lines * 0.3),
          border = "solid",
        }
      end,
    },
    mappings = {
      refine = "<C-r>",
      paste = "<C-y>",
      refine_marked = "<F1>",
      choose_marked = "<C-q>",
    },
  })
  source("custom/buf_lines.lua")
  require("custom.explorer").setup()
  vim.ui.select = MiniPick.ui_select
  vim.keymap.set("n", ",", [[<Cmd>Pick buffer_lines_current<CR>]], { nowait = true })
end)

later(function()
  local clue = require("mini.clue")
  clue.setup({
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
    window = {
      delay = 0,
      config = {
        -- border = { "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", },
        border = "solid",
        footer = {
          { "Mappings:", "MiniClueDescGroup" },
          { "<C-d>/<C-u>", "MiniClueTitle" },
        },
      },
    },
    clues = {
      _G.Config.leader_groups,
      clue.gen_clues.builtin_completion(),
      clue.gen_clues.g(),
      clue.gen_clues.marks(),
      clue.gen_clues.registers(),
      clue.gen_clues.windows(),
      clue.gen_clues.z(),
      { mode = "n", keys = "<Leader>b", desc = "+Buffer" },
      { mode = "n", keys = "<Leader>g", desc = "+Git" },
      { mode = "n", keys = "<Leader>s", desc = "+Search" },
      { mode = "n", keys = "<Leader>l", desc = "+LSP" },
      { mode = "n", keys = "<Leader>w", desc = "+Window" },
      { mode = "n", keys = "<Leader><tab>", desc = "+Tabs" },
      { mode = "n", keys = "<Leader>!", desc = "+Shell" },
      { mode = "n", keys = "<Leader>L", desc = "+Lua" },
      { mode = "n", keys = "<Leader>o", desc = "+Other" },
      { mode = "n", keys = "<Leader>t", desc = "+Terminal" },
      { mode = "n", keys = "<Leader>v", desc = "+Visits" },
      { mode = "f", keys = "<Leader>f", desc = "+Find" },
    },
  })
end)

later(function() require("mini.visits").setup() end)
later(function()
  require("mini.surround").setup({
    highlight_duration = 500,
    mappings = {
      add = "gsa", -- Add surrounding in Normal and Visual modes
      delete = "gsd", -- Delete surrounding
      find = "gsn", -- Find surrounding (to the right)
      find_left = "gsN", -- Find surrounding (to the left)
      highlight = "gsh", -- Highlight surrounding
      indentscope_color = "",
      replace = "gsr", -- Replace surrounding
      update_n_lines = "", -- Update `n_lines`

      suffix_last = "l", -- Suffix to search with "prev" method
      suffix_next = "n", -- Suffix to search with "next" method
    },
    search_method = "cover_or_next",
  })
end)

later(function()
  local ai = require("mini.ai")
  ai.setup({
    mappings = {
      goto_left = "g[",
      goto_right = "g]",
    },
    custom_textobjects = {
      B = require("mini.extra").gen_ai_spec.buffer(),
      t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
      o = ai.gen_spec.treesitter({ -- code block
        a = { "@block.outer", "@conditional.outer", "@loop.outer" },
        i = { "@block.inner", "@conditional.inner", "@loop.inner" },
      }),
      f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function DEFINITION
      i = require("mini.extra").gen_ai_spec.indent(),
      u = ai.gen_spec.function_call(), -- u for Usage
      U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot
      e = { -- snake_case, camelCase, PascalCase, etc; all capitalizations
        -- Lua 5.1 character classes and the undocumented frontier pattern:
        -- https://www.lua.org/manual/5.1/manual.html#5.4.1
        -- http://lua-users.org/wiki/FrontierPattern
        {
          -- Matches a single uppercase letter followed by 1+ lowercase
          -- letters. This covers:
          -- - PascalCaseWords (or the latter part of camelCaseWords)
          "%u[%l%d]+%f[^%l%d]", -- An uppercase letter, 1+ lowercase letters, to end of lowercase letters

          -- Matches lowercase letters up until not lowercase letter.
          -- This covers:
          -- - start of camelCaseWords (just the `camel`)
          -- - snake_case_words in lowercase
          -- - regular lowercase words
          "%f[^%s%p][%l%d]+%f[^%l%d]", -- after whitespace/punctuation, 1+ lowercase letters, to end of lowercase letters
          "^[%l%d]+%f[^%l%d]", -- after beginning of line, 1+ lowercase letters, to end of lowercase letters

          -- Matches uppercase or lowercase letters up until not letters.
          -- This covers:
          -- - SNAKE_CASE_WORDS in uppercase
          -- - Snake_Case_Words in titlecase
          -- - regular UPPERCASE words
          -- (it must be both uppercase and lowercase otherwise it will
          -- match just the first letter of PascalCaseWords)
          "%f[^%s%p][%a%d]+%f[^%a%d]", -- after whitespace/punctuation, 1+ letters, to end of letters
          "^[%a%d]+%f[^%a%d]", -- after beginning of line, 1+ letters, to end of letters
        },
        -- { -- original version from mini.ai help file:
        --   '%u[%l%d]+%f[^%l%d]',
        --   '%f[%S][%l%d]+%f[^%l%d]',
        --   '%f[%P][%l%d]+%f[^%l%d]',
        --   '^[%l%d]+%f[^%l%d]',
        -- },
        "^().*()$",
      },
    },
  })
end)
later(function() require("mini.operators").setup() end)
later(function()
  require("mini.git").setup({
    command = {
      split = "horizontal",
    },
  })
  vim.api.nvim_create_autocmd("User", {
    pattern = "MiniGitCommandDone",
    callback = function(ev)
      if ev.data.git_subcommand:match("status") then
        vim.api.nvim_create_autocmd("User", {
          nested = true,
          once = true,
          callback = function(data)
            vim.bo[data.buf].filetype = "ministatus"
            return true
          end,
        })
      end
    end,
  })
end)

later(function()
  require("mini.diff").setup({
    view = {
      style = "sign",
      signs = { add = "+", change = "~", delete = "-" },
      -- signs = { add = "┃", change = "┃", delete = "┃" },
      -- signs = { add = "▍ ", change = "▍ ", delete = " " },
    },
  })
end)

later(function() require("mini.splitjoin").setup() end)
later(function() require("mini.bracketed").setup() end)
later(function() require("mini.jump").setup() end)
later(
  function()
    require("mini.jump2d").setup({
      view = {
        dim = true,
        n_steps_ahead = 10000000,
      },
      mappings = {
        start_jumping = "<C-s>",
      },
    })
  end
)

later(
  function()
    require("mini.move").setup({
      mappings = {
        left = "H",
        right = "L",
        line_left = "H",
        down = "J",
        up = "K",
      },
    })
  end
)
--================== Plugins ====================
later(function()
  add({
    source = "nvim-treesitter/nvim-treesitter-textobjects",
    depends = {
      {
        source = "nvim-treesitter/nvim-treesitter",
        checkout = "master",
        hooks = {
          post_checkout = function() vim.cmd("TSUpdate") end,
        },
      },
    },
  })
  source("plugins/nvim-treesitter.lua")
end)

later(function()
  add({
    source = "saghen/blink.cmp",
    checkout = "main",
    hooks = {
      post_install = function(path, source, name)
        vim.notify("Installing blink.cmp binary...")
        require("tests.compile_mode").shell_cmd({ "cargo", "build", "--release" }, "cmd", {
          cwd = Config.path_package .. "blink.cmp",
        })
      end,
    },
  })
  source("plugins/blink-cmp.lua")
end)

later(function()
  add({ source = "neovim/nvim-lspconfig" })
  require("plugins.nvim-lspconfig")
end)

later(function()
  add({ source = "stevearc/conform.nvim" })
  source("plugins/conform.lua")
end)

later(function()
  add({ source = "stevearc/quicker.nvim" })
  source("plugins/quicker.lua")
end)

later(function()
  add({ source = "MeanderingProgrammer/render-markdown.nvim" })
  source("plugins/render-markdown.lua")
end)

later(function()
  add({
    source = "epwalsh/obsidian.nvim",
    depends = { "nvim-lua/plenary.nvim", "MeanderingProgrammer/render-markdown.nvim" },
  })
  source("plugins/obsidian.lua")
end)

--================== Dev Plugins ====================
-- later(function() add({ source = "~/projects/nvim/chadschemes/", hooks = {} }) end)
