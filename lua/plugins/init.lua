local now, later = MiniDeps.now, MiniDeps.later

local sd = require("config.superdeps")

--- NOTE: s_use is not very useful, just looks nice
local add, s_use = sd.add, sd.use

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
        timing = animate.gen_timing.linear({ duration = 200, unit = "total" }),
        path = animate.gen_path.line({ predicate = function() return true end })
      },
      scroll = {
        timing = animate.gen_timing.linear({ duration = 200, unit = "total" }),
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
      neogit = true,
    },
    on_highlights = function(hl, c)
      return {
        EndOfBuffer = { fg = hl.LineNr.fg },
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


now(
  s_use ("mini.notify", {
    lsp_progress = {
      enable = false,
    },
    window = {
      config = function()
        local opts = { title = (vim.b.notify_config or {}).title }
        vim.b.notify_config = nil
        return opts
      end
    }
  })
  :next
  {
    function()
      vim.notify = function(msg, level, opts)
        vim.b.notify_config = opts
        MiniNotify.make_notify()(msg, level)
      end
    end
  }
)

now(
  s_use "mini.icons"
  :next
  {
    function()
      MiniIcons.mock_nvim_web_devicons()
      later(MiniIcons.tweak_lsp_kind)
    end
  }
)

now(use "mini.tabline")
now(source "plugins/mini-starter.lua")

later(source "plugins/mini-completion.lua")
later(use "mini.cursorword")
later(use "mini.trailspace")
later(source "plugins/mini-pairs.lua")
later(use "mini.extra")
later(use "mini.bufremove")
later(use "mini.indentscope")
later(
  s_use ("mini.misc", { make_global = { "put", "put_text" } })
  :next
  {
    function()
      MiniMisc.setup_auto_root()
      MiniMisc.setup_restore_cursor()
    end
  }
)
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


later(source "plugins/mini-hipatterns.lua")
later(source "plugins/mini-pick.lua")
later(use "mini.align")
later(source "plugins/mini-clue.lua")

later(use "mini.visits")
later(
  s_use("mini.surround", {
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
  :next
  { function() vim.keymap.set({ "n", "x" }, "s", "<Nop>") end }
)

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

later(
  s_use "mini.git"
  :next
  {
    function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniGitCommandSplit",
        callback = function(data) vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = data.buf }) end,
      })
    end
  }
)


later(source "plugins/mini-diff.lua")
-- later(use "mini.basics")
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
  { source "plugins/quicker.lua" }
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

-- NOTE: trying this out
later(
  add {
    source = "NeogitOrg/neogit",
    depends = {  "nvim-lua/plenary.nvim" },
  }
  :next
  { source "plugins/neogit.lua" }
)
