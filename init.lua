vim.loader.enable()

vim.g.loaded_gzip = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_matchit = 1
-- vim.g.loaded_matchparen = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1
vim.g.loaded_tutor_mode_plugin = 0

-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath("data") .. "/site/"
local mini_path = path_package .. "pack/deps/start/mini.nvim"

_G.Config = {
  path_source = vim.fn.stdpath("config") .. "/lua/",
  path_package = path_package .. "pack/deps/opt/",
  plugs = {
    snacks = false,
  },
  completion = "mini",
}

if not (vim.uv or vim.loop).fs_stat(mini_path) then
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

--================== Settings ====================
now(function() source("settings.lua") end)
now(function() source("mappings.lua") end)
now(function() source("leader_maps.lua") end)
now(function() source("config/autocommands.lua") end)
-- now(function() source("tests/nano.lua") end)
-- now(function() source("custom/galaxyline.lua") end)
now(function() source("custom/simpstatus.lua") end)

if vim.env.TERM_PROGRAM == "WezTerm" then now(function() require("config.utils").wezterm() end) end

now(function() source("functions.lua") end)
now(function() source("tests/compile_mode.lua") end)
now(function()
  source("config/statuscolumn.lua")
  vim.o.statuscolumn = "%!v:lua.require('config.statuscolumn').statuscolumn()"
end)

if vim.g.neovide or vim.g.goneovim then now(function() source("config/gui.lua") end) end

--================== UI Plugins ====================
--================== Colors ====================
now(function()
  vim.g.ef_themes_debug = true
  -- add("oonamo/ef-themes.nvim")
  vim.opt.rtp:append("C:\\Users\\onam7\\projects\\nvim\\ef-themes")
  require("ef-themes").setup({
    transparent = false,
    light = "ef-spring",
    dark = "ef-dream",
    modules = {
      render_markdown = true,
    },
    on_highlights = function(highlights, colors, name) end,
  })

  local last = 0
  local dark_complete = true
  local ef_themes = require("ef-themes")
  vim.keymap.set("n", "<F1>", function()
    local list = dark_complete and ef_themes.list.light or ef_themes.list.dark
    if last == #list then
      if not dark_complete then
        dark_complete = true
      else
        last = 0
        dark_complete = false
        list = ef_themes.list.light
      end
    end
    last = last + 1
    vim.cmd.colorscheme(list[last])

    vim.defer_fn(function()
      MiniNotify.clear()
      vim
        .system({
          "pwsh.exe",
          "-NoProfile",
          "-NonInteractive",
          "-Command",
          vim.fs.joinpath(vim.fn.expand("~"), ".common", "termshot.ps1"),
          list[last] .. ".png",
        })
        :wait()
      vim.notify("took screenshot of " .. list[last])
    end, 3000)
  end)
end)

now(function()
  add({ source = "EdenEast/nightfox.nvim" })
  local S = require("nightfox.lib.shade")
  local C = require("nightfox.lib.color")
  local bg0 = C.new("#192330")
  local black = C.new("#000000")
  local nightfox = {
    bg0 = bg0:blend(black, 0.75):to_hex(),
    bg1 = "#192330",
    comment = "#526175",
    black = S.new("#393b44", "#475072", "#32343b"),
    red = S.new("#c94f6d", "#d6616b", "#ad425c"),
    green = S.new("#81b29a", "#58cd8b", "#689c83"),
    yellow = S.new("#dbc074", "#ffe37e", "#c7a957"),
    blue = S.new("#719cd6", "#84cee4", "#5483c1"),
    magenta = S.new("#9d79d6", "#b8a1e3", "#835dc1"),
    cyan = S.new("#63cdcf", "#59f0ff", "#4ab8ba"),
    white = S.new("#dfdfe0", "#f2f2f2", "#bdbdc0"),
    orange = S.new("#f4a261", "#f6a878", "#e28940"),
    pink = S.new("#d67ad2", "#df97db", "#c15dbc"),
  }
  local nightfox_spec = {
    git = {
      add = "#70a288",
      change = "#a58155",
      delete = "#904a6a",
      conflict = "#c07a6d",
    },
  }
  require("nightfox").setup({
    palettes = {
      -- dayfox = {
      --   black = S.new("#1d344f", "#24476f", "#1c2f44", true),
      --   red = S.new("#b95d76", "#c76882", "#ac5169", true),
      --   green = S.new("#618774", "#629f81", "#597668", true),
      --   yellow = S.new("#ba793e", "#ca884a", "#a36f3e", true),
      --   blue = S.new("#4d688e", "#4e75aa", "#485e7d", true),
      --   magenta = S.new("#8e6f98", "#9f75ac", "#806589", true),
      --   cyan = S.new("#6ca7bd", "#74b2c9", "#5a99b0", true),
      --   white = S.new("#cdd1d5", "#cfd6dd", "#b6bcc2", true),
      --   orange = S.new("#e3786c", "#e8857a", "#d76558", true),
      --   pink = S.new("#d685af", "#de8db7", "#c9709e", true),
      --
      --   comment = "#7f848e",
      --
      --   bg0 = "#dbdbdb", -- Dark bg (status line and float)
      --   bg1 = "#eaeaea", -- Default bg
      --   bg2 = "#dbcece", -- Lighter bg (colorcolm folds)
      --   bg3 = "#ced6db", -- Lighter bg (cursor line)
      --   bg4 = "#bebebe", -- Conceal, border fg
      --
      --   fg0 = "#182a40", -- Lighter fg
      --   fg1 = "#1d344f", -- Default fg
      --   fg2 = "#233f5e", -- Darker fg (status line)
      --   fg3 = "#2e537d", -- Darker fg (line numbers, fold colums)
      --
      --   sel0 = "#e7d2be", -- Popup bg, visual selection bg
      --   sel1 = "#a4c1c2", -- Popup sel bg, search bg
      -- },
      nightfox = nightfox,
    },
    specs = {
      nightfox = nightfox_spec,
    },
  })
end)
now(function()
  add({ source = "sainnhe/everforest" })
  vim.api.nvim_set_hl(0, "MiniPickMatchCurrent", { link = "Visual" })
  vim.g.everforest_background = "hard"
  vim.g.everforest_better_performance = true
  vim.g.everforest_diagnostic_text_highlight = true
  vim.g.everforest_diagnostic_line_highlight = true
  vim.g.everforest_diagnostic_virtual_text = true
end)
now(function()
  add("sainnhe/gruvbox-material")
  vim.g.gruvbox_material_background = "hard"
  vim.g.gruvbox_material_diagnostic_text_highlight = true
  vim.g.gruvbox_material_diagnostic_line_highlight = true
  vim.g.gruvbox_material_diagnostic_virtual_text = true
end)
now(function() add({ source = "rose-pine/neovim", name = "rose-pine" }) end)
-- now(function() vim.cmd.colorscheme("duskfox") end)

now(Config.load_colorscheme)

--================== Mini Plugins ====================
now(function()
  require("mini.notify").setup({
    -- window = { config = { border = "solid" } },
    lsp_progress = { enable = false },
  })
  vim.notify = MiniNotify.make_notify()
end)
now(function()
  require("mini.icons").setup()
  MiniIcons.mock_nvim_web_devicons()
  later(MiniIcons.tweak_lsp_kind)
end)

-- now(function() require("mini.tabline").setup({ show_icons = false, tabpage_section = "right" }) end)
now(function() source("plugins/mini-starter.lua") end)
later(
  function()
    require("mini.pairs").setup({
      opts = {
        mappings = {
          ['"'] = { action = "closeopen", pair = '""', neigh_pattern = "[^%w][^%w]", register = { cr = false } },
          ["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^%w][^%w]", register = { cr = false } },
          ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^%w][^%w]", register = { cr = false } },
        },
      },
    })
  end
)

later(function() source("plugins/mini-files.lua") end)
later(function() require("mini.test").setup() end)

if Config.completion == "mini" then
  later(function()
    require("mini.completion").setup({
      lsp_completion = {
        source_func = "omnifunc",
        auto_setup = false,
        process_items = function(items, base)
          -- Don't show 'Text' and 'Snippet' suggestions
          items = vim.tbl_filter(function(x) return x.kind ~= 1 and x.kind ~= 15 end, items)
          return MiniCompletion.default_process_items(items, base)
        end,
      },
      fallback_action = function() end,
      window = {
        info = { border = "single" },
        signature = { border = "single" },
      },
    })
  end)
else
  later(function()
    add({
      source = "Saghen/blink.cmp",
      checkout = "main",
      hooks = {
        post_checkout = function(path, source, name)
          vim.notify("Installing blink.cmp binary...")
          local ok, cmd = require("tests.compile_mode").shell_cmd({ "cargo", "build", "--release" }, "cmd", {
            cwd = Config.path_package .. "blink.cmp",
          })
          if ok then cmd:wait() end
        end,
        post_install = function(path, source, name)
          vim.notify("Installing blink.cmp binary...")
          local ok, cmd = require("tests.compile_mode").shell_cmd({ "cargo", "build", "--release" }, "cmd", {
            cwd = Config.path_package .. "blink.cmp",
          })
          if ok then cmd:wait() end
        end,
      },
    })
    source("plugins/blink-cmp.lua")
  end)
end
later(function() require("mini.extra").setup() end)
later(function() require("mini.bufremove").setup() end)
later(function() require("mini.indentscope").setup() end)
later(function()
  require("mini.misc").setup({ make_global = { "put", "put_text" } })
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
          pcall(b.hide)
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
      -- stylua: ignore start
      fixme       = { pattern = "() FIXME():",   group = "MiniHipatternsFixme" },
      hack        = { pattern = "() HACK():",    group = "MiniHipatternsHack" },
      todo        = { pattern = "() TODO():",    group = "MiniHipatternsTodo" },
      note        = { pattern = "() NOTE():",    group = "MiniHipatternsNote" },
      fixme_colon = { pattern = " FIXME():()",   group = "MiniHipatternsFixmeColon" },
      hack_colon  = { pattern = " HACK():()",    group = "MiniHipatternsHackColon" },
      todo_colon  = { pattern = " TODO():()",    group = "MiniHipatternsTodoColon" },
      note_colon  = { pattern = " NOTE():()",    group = "MiniHipatternsNoteColon" },
      fixme_body  = { pattern = " FIXME:().*()", group = "MiniHipatternsFixmeBody" },
      hack_body   = { pattern = " HACK:().*()",  group = "MiniHipatternsHackBody" },
      todo_body   = { pattern = " TODO:().*()",  group = "MiniHipatternsTodoBody" },
      note_body   = { pattern = " NOTE:().*()",  group = "MiniHipatternsNoteBody" },
      -- stylua: ignore end
      -- fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
      -- fix = { pattern = "%f[%w]()FIX()%f[%W]", group = "MiniHipatternsFixme" },
      -- hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
      -- perf = { pattern = "%f[%w]()PERF()%f[%W]", group = "MiniHipatternsHack" },
      -- todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
      -- note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
      -- fixme = hi_words({ "FIXME", "Fixme", "fixme" }, "MiniHipatternsFixme"),
      -- hack = hi_words({ "HACK", "Hack", "hack" }, "MiniHipatternsHack"),
      -- todo = hi_words({ "TODO", "Todo", "todo" }, "MiniHipatternsTodo"),
      -- note = hi_words({ "NOTE", "Note", "note" }, "MiniHipatternsNote"),

      hex_color = hipatterns.gen_highlighter.hex_color({
        style = "inline",
        inline_text = "⬤  ",
      }),
    },
  })

  local hi = function(...) vim.api.nvim_set_hl(0, ...) end

  local function create_hi_hls()
    for _, v in ipairs({ "Fixme", "Todo", "Note", "Hack" }) do
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
end)

later(function() source("plugins/mini-pick.lua") end)
later(function() require("mini.align").setup() end)

later(function()
  local clue = require("mini.clue")
  clue.setup({
    triggers = {
      -- Leader triggers
      { mode = "n", keys = "<Leader>" },
      { mode = "x", keys = "<Leader>" },
      { mode = "n", keys = "<localleader>" },
      { mode = "x", keys = "<localleader>" },

      { mode = "n", keys = "\\" },

      -- Built-in completion
      { mode = "i", keys = "<C-x>" },

      -- `g` key
      { mode = "n", keys = "g" },
      { mode = "x", keys = "g" },

      { mode = "n", keys = "s" },
      { mode = "x", keys = "s" },

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

      { mode = "n", keys = "[" },
      { mode = "x", keys = "[" },
      { mode = "n", keys = "]" },
      { mode = "x", keys = "]" },

      { mode = "n", keys = "<M-g>" },
      { mode = "x", keys = "<M-g>" },
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
      -- stylua: ignore start
      { mode = "n", keys = "<Leader>b",     desc = "+Buffer" },
      { mode = "n", keys = "<Leader>g",     desc = "+Git" },
      { mode = "n", keys = "<Leader>s",     desc = "+Search" },
      { mode = "n", keys = "<Leader>l",     desc = "+LSP" },
      { mode = "n", keys = "<Leader>w",     desc = "+Window" },
      { mode = "n", keys = "<Leader><tab>", desc = "+Tabs" },
      { mode = "n", keys = "<Leader>!",     desc = "+Shell" },
      { mode = "n", keys = "<Leader>L",     desc = "+Lua" },
      { mode = "n", keys = "<Leader>o",     desc = "+Other" },
      { mode = "n", keys = "<Leader>t",     desc = "+Terminal" },
      { mode = "n", keys = "<Leader>v",     desc = "+Visits" },
      { mode = "n", keys = "<Leader>f",     desc = "+Find" },
      --stylua: ignore end

      -- Bracketed:
      { mode = "n", keys = "]b", postkeys = "]" },
      { mode = "n", keys = "[b", postkeys = "[" },
      { mode = "n", keys = "]c", postkeys = "]" },
      { mode = "n", keys = "[c", postkeys = "[" },
      { mode = "n", keys = "]d", postkeys = "]" },
      { mode = "n", keys = "[d", postkeys = "[" },
      -- { mode = "n", keys = "]f", postkeys = "]" },
      -- { mode = "n", keys = "[f", postkeys = "[" },
      { mode = "n", keys = "]h", postkeys = "]" },
      { mode = "n", keys = "[h", postkeys = "[" },
      -- { mode = "n", keys = "]i", postkeys = "]" },
      -- { mode = "n", keys = "[i", postkeys = "[" },
      -- { mode = "n", keys = "]j", postkeys = "]" },
      -- { mode = "n", keys = "[j", postkeys = "[" },
      -- { mode = "n", keys = "]l", postkeys = "]" },
      -- { mode = "n", keys = "[l", postkeys = "[" },
      -- { mode = "n", keys = "]o", postkeys = "]" },
      -- { mode = "n", keys = "[o", postkeys = "[" },
      { mode = "n", keys = "]q", postkeys = "]" },
      { mode = "n", keys = "[q", postkeys = "[" },
      { mode = "n", keys = "]t", postkeys = "]" },
      { mode = "n", keys = "[t", postkeys = "[" },
      { mode = "n", keys = "]u", postkeys = "]" },
      { mode = "n", keys = "[u", postkeys = "[" },
      { mode = "n", keys = "]w", postkeys = "]" },
      { mode = "n", keys = "[w", postkeys = "[" },
      -- { mode = "n", keys = "]x", postkeys = "]" },
      -- { mode = "n", keys = "[x", postkeys = "[" },
      { mode = "n", keys = "]y", postkeys = "]" },
      { mode = "n", keys = "[y", postkeys = "[" },
    },
  })
end)

later(function() require("mini.visits").setup() end)
later(function()
  require("mini.surround").setup({
    highlight_duration = 500,
    mappings = {
      add = "sa", -- Add surrounding in Normal and Visual modes
      delete = "sd", -- Delete surrounding
      find = "sn", -- Find surrounding (to the right)
      find_left = "sN", -- Find surrounding (to the left)
      highlight = "sh", -- Highlight surrounding
      replace = "sr", -- Replace surrounding
      update_n_lines = "", -- Update `n_lines`

      suffix_last = "l", -- Suffix to search with "prev" method
      suffix_next = "n", -- Suffix to search with "next" method
    },
    search_method = "cover_or_next",
  })

  vim.keymap.set({ "n", "x" }, "s", "<Nop>")
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
    pattern = "MiniGitCommandSplit",
    callback = function(data) vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = data.buf }) end,
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
later(function() source("plugins/mini-jump2d.lua") end)

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

-- later(function()
--   add({
--     source = "Saghen/blink.cmp",
--     checkout = "main",
--     hooks = {
--       post_checkout = function(path, source, name)
--         vim.notify("Installing blink.cmp binary...")
--         require("tests.compile_mode").shell_cmd({ "cargo", "build", "--release" }, "cmd", {
--           cwd = Config.path_package .. "blink.cmp",
--         })
--       end,
--       post_install = function(path, source, name)
--         vim.notify("Installing blink.cmp binary...")
--         require("tests.compile_mode").shell_cmd({ "cargo", "build", "--release" }, "cmd", {
--           cwd = Config.path_package .. "blink.cmp",
--         })
--       end,
--     },
--   })
--   source("plugins/blink-cmp.lua")
-- end)

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
if Config.plugs.snacks then
  later(function()
    add({
      source = "folke/snacks.nvim",
    })
    source("plugins/snacks.lua")
  end)
end

later(function()
  add({ source = "rachartier/tiny-glimmer.nvim", checkout = "main" })
  source("plugins/tiny-glimmer.lua")
end)

later(function()
  local build = function(opts)
    local path = opts.path

    if not vim.fn.isdirectory(path) then path.path = vim.fn.fnamemodify(path, ":h") end

    local ok, cmd = require("tests.compile_mode").shell_cmd({ "deno", "task", "--quiet", "build:fast" }, "cmd", {
      cwd = path,
    })
    if ok then
      cmd:wait()
    else
      vim.notify("Could not execute the build command")
    end
  end
  add({
    source = "toppair/peek.nvim",
    hooks = {
      post_install = function(opts)
        later(function() build(opts) end)
      end,
      post_checkout = build,
    },
  })

  require("peek").setup({
    close_on_bdelete = false,
    app = { "chromium", "--new-window" },
    -- app = "browser",
  })

  vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
  vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
end)

--================== Dev Plugins ====================
-- later(function() add({ source = "~/projects/nvim/chadschemes/", hooks = {} }) end)
-- later(function()
--   vim.opt.rtp:append("C:\\Users\\onam7\\projects\\command_pal")
--   -- add({ source = "C:/Users/onam7/projects/command_pal", checkout = "refactor_mini_pick" })

--   source("plugins/command_pal.lua")
-- end)

later(function()
  vim.opt.rtp:append("C:\\Users\\onam7\\projects\\quicker_md.nvim")
  source("plugins/quicker-md.lua")
end)
