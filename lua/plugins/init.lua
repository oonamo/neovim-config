local now, later = MiniDeps.now, MiniDeps.later

local add = require("config.superdeps").add

local source = function(path)
  return function() dofile(Config.path_source .. path) end
end

local add_dev = function(name)
  local path = vim.fs.joinpath(Config.dev_dir, name)
  if Config.sep == "\\" then path = path:gsub("/", "\\") end

  vim.opt.rtp:append(path)
end

local build = function(cmd, opts)
  local path = opts.path
  if not vim.fn.isdirectory(path) then path.path = vim.fn.fnamemodify(path, ":h") end

  local ok, _ = require("tests.compile_mode").shell_cmd(cmd, vim.o.shell, {
    cwd = path,
  })
  if not ok then vim.notify("Could not execute the build command") end
end

local use = function(name, opts)
  return function()
    local ok, pack = pcall(require, name)
    if not ok then
      return vim.notify("Error loading " .. tostring(name) .. ":\n" .. tostring(pack), vim.log.levels.WARN)
    end
    if pack.setup then pack.setup(opts) end
  end
end

-- stylua: ignore start
now(source "settings.lua")
now(source "mappings.lua")
now(source "leader_maps.lua")
now(source "config/autocommands.lua")
now(source "functions.lua")
now(source "tests/compile_mode.lua")
now(source "config/statuscolumn.lua")
now(Config.load_colorscheme)

later(function()
  if vim.env.TERM_PROGRAM == "WezTerm" then
    require("config.utils").wezterm()
  end
end)

if not vim.g.neovide then
  later(function()
    local animate = require("mini.animate")
    animate.setup({
      cursor = {
        -- Animate for 200 milliseconds with linear easing
        timing = animate.gen_timing.linear({ duration = 200, unit = "total" }),

        -- Animate with shortest line for any cursor move
        path = animate.gen_path.line({
          predicate = function() return true end,
        }),
      },
      scroll = {
        -- Animate for 200 milliseconds with linear easing
        timing = animate.gen_timing.linear({ duration = 200, unit = "total" }),

        -- Animate equally but with at most 120 steps instead of default 60
        subscroll = animate.gen_subscroll.equal({ max_output_steps = 120 }),
      },
    })
  end)
else
  now(source "config/gui.lua")
end

now(function()
  add_dev("ef-themes")
  require("ef-themes").setup({
    transparent = false,
    light = "ef-spring",
    dark = "ef-tint",
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
    on_highlights = function(_, c)
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
end)

-- stylua: ignore start
now(source "plugins/mini-statusline.lua" )

now(function()
  local function win_config()
    local opts = { title = (vim.b.notify_config or {}).title }
    vim.b.notify_config = nil
    return opts
  end

  require("mini.notify").setup({
    lsp_progress = {
      enable = false,
    },
    window = {
      config = win_config,
    }
  })

  vim.notify = function(msg, level, opts)
    vim.b.notify_config = opts
    MiniNotify.make_notify()(msg, level)
  end
end)

now(function()
  require("mini.icons").setup()
  MiniIcons.mock_nvim_web_devicons()
  later(MiniIcons.tweak_lsp_kind)
end)

now(use "mini.tabline")
now(source "plugins/mini-starter.lua")

later(source "plugins/mini-completion.lua")
later(use "mini.cursorword")
later(use "mini.trailspace")
later(source "plugins/mini-pairs.lua")
later(use "mini.extra")
later(use "mini.bufremove")
later(use "mini.indentscope")
later(function()
  require("mini.misc").setup({ make_global = { "put", "put_text" } })
  MiniMisc.setup_auto_root()
  MiniMisc.setup_restore_cursor()
end)
later(source "plugins/mini-files.lua")

later(add "rafamadriz/friendly-snippets")
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

later(source "plugins/mini-pick.lua")
later(use "mini.align")

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
      { mode = "n", keys = "]h", postkeys = "]" },
      { mode = "n", keys = "[h", postkeys = "[" },
      { mode = "n", keys = "]q", postkeys = "]" },
      { mode = "n", keys = "[q", postkeys = "[" },
      { mode = "n", keys = "]t", postkeys = "]" },
      { mode = "n", keys = "[t", postkeys = "[" },
      { mode = "n", keys = "]u", postkeys = "]" },
      { mode = "n", keys = "[u", postkeys = "[" },
      { mode = "n", keys = "]w", postkeys = "]" },
      { mode = "n", keys = "[w", postkeys = "[" },
      { mode = "n", keys = "]y", postkeys = "]" },
      { mode = "n", keys = "[y", postkeys = "[" },
    },
  })
end)

later(use "mini.visits")
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
  require("mini.git").setup()

  vim.api.nvim_create_autocmd("User", {
    pattern = "MiniGitCommandSplit",
    callback = function(data) vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = data.buf }) end,
  })
end)


later(source "plugins/mini-diff.lua")
later(use("mini.basics"))
later(use "mini.splitjoin")
later(use "mini.bracketed")
later(use "mini.jump")
later(source "plugins/mini-jump2d.lua")
later(use("mini.move", {
  mappings = {
    left = "H",
    right = "L",
    line_left = "H",
    down = "J",
    up = "K",
  },
}))

--================== Plugins ====================
later(
  add {
    source = "nvim-treesitter/nvim-treesitter-textobjects",
    depends = {
      {
        source = "nvim-treesitter/nvim-treesitter",
        checkout = "master",
        hooks = {
          post_checkout = function() vim.cmd("TSUpdate") end,
          post_install = function() vim.cmd("TSUpdate") end,
        },
      },
    },
  }
  :next
  { source "plugins/nvim-treesitter.lua" }
)

later(
  add "neovim/nvim-lspconfig"
  :next
  { source "plugins/nvim-lspconfig.lua" }
)

later(
  add "stevearc/conform.nvim"
  :next
  { source "plugins/conform.lua" }
)

later(
  add "stevearc/quicker.nvim"
  :next
  { source "plugins/conform.lua" }
)

later(
  add "MeanderingProgrammer/render-markdown.nvim"
  :next
  { source "plugins/render-markdown.lua" }
)

if Config.plugs.snacks then
  later(
    add "folke/snacks.nvim"
    :next
    { source "plugins/snacks.lua" }
  )
end

later(
  add {
    source = "toppair/peek.nvim",
    hooks = {
      post_install = function(opts)
        later(function()
          build({"deno", "task", "--quiet", "build:fast" }, opts)
        end)
      end
    }
  }
  :next
  {
    (use ("peek", {
      close_on_bdelete = false,
      app = { "chromium", "--new-window" },
    })),
    (function()
      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end)
  }
)
