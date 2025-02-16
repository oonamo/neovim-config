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
vim.g.loaded_tutor_mode_plugin = 1

-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath("data") .. "/site/"
local mini_path = path_package .. "pack/deps/start/mini.nvim"

_G.Config = {
  path_source = vim.fn.stdpath("config") .. "/lua/",
  path_package = path_package .. "pack/deps/opt/",
  sep = package.config:sub(1, 1),
  plugs = {
    snacks = false,
  },
  completion = "mini",
  dev_dir = vim.fs.joinpath(vim.fn.expand("~"), "projects", "nvim"),
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

local add_dev = function(name)
  local path = vim.fs.joinpath(Config.dev_dir, name)
  if Config.sep == "\\" then path = path:gsub("/", "\\") end

  vim.opt.rtp:append(path)
end

--================== Settings ====================
now(function() source("settings.lua") end)
now(function() source("mappings.lua") end)
now(function() source("leader_maps.lua") end)
now(function() source("config/autocommands.lua") end)
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
  add_dev("ef-themes")
  require("ef-themes").setup({
    transparent = false,
    light = "ef-spring",
    dark = "ef-dream",
    styles = {
      pickers = "borderless",
      diagnostic = "full",
      functions = { bold = true },
    },
    modules = {
      render_markdown = true,
      snacks = Config.plugs.snacks,
      semantic_tokens = true,
      mini = true,
      blink = Config.completion ~= "mini",
    },
    on_highlights = function(his, c)
      return {
        ReadBit = { fg = c.rainbow_1 },
        WriteBit = { fg = c.rainbow_2 },
        ExeBit = { fg = c.rainbow_3 },
        SepBit = { fg = c.fg_dim },
        MiniPickExplorerSize = { fg = c.variable },
        MiniPickExplorerDate = { fg = c.date_common },
        MiniPickExplorerDirectory = { fg = c.rainbow_1 },
      }
    end,
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

now(Config.load_colorscheme)

--================== Mini Plugins ====================
-- now(function()
--   require("mini.statusline").setup()
-- end)
now(
  function()
    require("mini.basics").setup({
      options = {
        basic = true,
        extra_ui = true,
        win_borders = "single",
      },
      autocommands = {
        basic = false,
        relnum_in_visual_mode = false,
      },
    })
  end
)
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
now(function() require("mini.tabline").setup() end)
now(function() source("plugins/mini-starter.lua") end)
later(function() require("mini.cursorword").setup() end)
later(function() source("plugins/mini-pairs.lua") end)

later(function() source("plugins/mini-files.lua") end)

if Config.completion == "mini" then
  later(function() source("plugins/mini-completion.lua") end)
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
          if not ok then vim.notify("Could not compile blink.cmp binary", vim.log.levels.ERROR) end
        end,
        post_install = function(path, source, name)
          vim.notify("Installing blink.cmp binary...")
          local ok, cmd = require("tests.compile_mode").shell_cmd({ "cargo", "build", "--release" }, "cmd", {
            cwd = Config.path_package .. "blink.cmp",
          })
          if not ok then vim.notify("Could not compile blink.cmp binary", vim.log.levels.ERROR) end
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
      clue.gen_clues.builtin_completion(),
      clue.gen_clues.g(),
      clue.gen_clues.marks(),
      clue.gen_clues.registers({ show_contents = true }),
      clue.gen_clues.windows(),
      clue.gen_clues.z(),
      -- stylua: ignore start
      { mode = "n", keys = "<Leader>b",     desc = "  Buffer" },
      { mode = "n", keys = "<Leader>g",     desc = "󰊢  Git" },
      { mode = "n", keys = "<Leader>s",     desc = "  Search" },
      { mode = "n", keys = "<Leader>l",     desc = "󰘦  LSP" },
      { mode = "n", keys = "<Leader>w",     desc = "  Window" },
      { mode = "n", keys = "<Leader><tab>", desc = "  Tabs" },
      { mode = "n", keys = "<Leader>!",     desc = " Shell" },
      { mode = "n", keys = "<Leader>o",     desc = "+Other" },
      { mode = "n", keys = "<Leader>t",     desc = "  Terminal" },
      { mode = "n", keys = "<Leader>v",     desc = " Visits" },
      { mode = "n", keys = "<Leader>f",     desc = "  Find" },
      { mode = "n", keys = "<Leader>p",     desc = "  Paste" },
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
      find_right = "sn", -- Find surrounding (to the left)
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
      e = {
        {
          "%u[%l%d]+%f[^%l%d]",
          "%f[^%s%p][%l%d]+%f[^%l%d]",
          "^[%l%d]+%f[^%l%d]",
          "%f[^%s%p][%a%d]+%f[^%a%d]",
          "^[%a%d]+%f[^%a%d]",
        },
        "^().*()$",
      },
    },
  })
end)
later(function()
  --https://github.com/echasnovski/nvim/blob/731779461d233af2cf0260d80dca4a6d6da51e34/plugin/20_mini.lua#L271C1-L278C33
  local remap = function(mode, lhs_from, lhs_to)
    local keymap = vim.fn.maparg(lhs_from, mode, false, true)
    local rhs = keymap.callback or keymap.rhs
    if rhs == nil then error("Could not remap from " .. lhs_from .. " to " .. lhs_to) end
    vim.keymap.set(mode, lhs_to, rhs, { desc = keymap.desc })
  end
  remap("n", "gx", "<Leader>ox")
  remap("x", "gx", "<Leader>ox")
  require("mini.operators").setup()
end)
later(function()
  require("mini.git").setup({
    -- command = {
    --   split = "horizontal",
    -- },
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
      -- signs = { add = "+", change = "~", delete = "-" },
      -- signs = { add = "┃", change = "┃", delete = "┃" },
      signs = { add = "▍ ", change = "▍ ", delete = " " },
      -- signs = { add = "█", change = "▒", delete = "" },
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

-- later(function()
--   add({ source = "rachartier/tiny-glimmer.nvim", checkout = "main" })
--   source("plugins/tiny-glimmer.lua")
-- end)

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
later(function()
  vim.opt.rtp:append("C:\\Users\\onam7\\projects\\command_pal")
  -- add({ source = "C:/Users/onam7/projects/command_pal", checkout = "refactor_mini_pick" })
  source("plugins/command_pal.lua")
end)

later(function()
  vim.opt.rtp:append("C:\\Users\\onam7\\projects\\quicker_md.nvim")
  source("plugins/quicker-md.lua")
end)
