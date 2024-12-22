Config._cache = {
  term = {
    buf = -1,
    win = -1,
  }
}

function Config.open_lazygit()
  vim.cmd("tabedit")
  vim.cmd("setlocal nonumber signcolumn=no cmdheight=0")

  vim.fn.termopen("lazygit", {
    on_exit = function()
      vim.cmd("silent! :checktime")
      vim.cmd("silent! :bw")
    end,
  })
  vim.cmd("startinsert")
  vim.b.minipairs_disable = true
end

function Config.async_grep(args)
  local cmd, num_subs = vim.o.grepprg:gsub("%$%*", args)
  if num_subs == 0 then cmd = cmd .. " " .. args end
  local expanded_cmd = vim.fn.expandcmd(cmd)
  local sys_cmd = vim
    .iter(vim.split(expanded_cmd, " ", { trimempty = true }))
    :filter(function(item) return item:len() ~= 0 end)
    :totable()

  vim.fn.setqflist({})

  vim.system(sys_cmd, {
    stdout = vim.schedule_wrap(function(err, data)
      if err then
        vim.notify("Error grepping: '" .. vim.inspect(err) .. "'", vim.log.levels.ERROR, { title = "Grep" })
        return
      end
      if data ~= nil then
        vim.fn.setqflist({}, "a", {
          lines = vim.split(data, platform_specific.lineending, { trimempty = true }),
          efm = vim.o.grepformat,
        })
      end
      vim.cmd.redraw()
    end),
    text = true,
  })

  vim.cmd.copen()
end

vim.api.nvim_create_user_command(
  "Grep",
  function(c) Config.async_grep(c.args) end,
  { nargs = "*", bang = true, complete = "file" }
)

function Config.explorer()
  require("mini.extra").pickers.explorer({}, {
    mappings = {
      toggle_preview = "",
      go_up_level = {
        char = "<C-BS>", -- Same as C BKSP, emacs lol
        func = function()
          local query = MiniPick.get_picker_query()
          if not query[1] or query[1] == "" then
            vim.schedule(function() vim.api.nvim_input("<CR>") end)
          else
            MiniPick.set_picker_query({ "" })
          end
        end,
      },
      go_up_level_neovide = {
        char = "<C-BS>", -- Same as C BKSP, emacs lol
        func = function()
          local query = MiniPick.get_picker_query()
          if not query[1] or query[1] == "" then
            vim.schedule(function() vim.api.nvim_input("<CR>") end)
          else
            MiniPick.set_picker_query({ "" })
          end
        end,
      },
      new_file = {
        char = "<c-e>",
        func = function()
          local query = MiniPick.get_picker_query()
          if not query or #query < 1 then return end
          query = table.concat(query, "")
          local cwd = MiniPick.get_picker_opts().source.cwd
          local file = cwd .. "/" .. query
          file = file:gsub("\\", "/")

          vim.schedule(function() vim.cmd.edit(file) end)
          return true
        end,
      },
      open_in_file_explorer = {
        char = "<C-d>",
        func = function()
          local current = MiniPick.get_picker_matches().current
          if not current then return end

          vim.schedule(function() require("mini.files").open(current.path) end)
          return true
        end,
      },
      smart_tab = {
        char = "<Tab>",
        func = function()
          local current = MiniPick.get_picker_matches().current
          if not current then return end
          local state = MiniPick.get_picker_state()
          local opts = MiniPick.get_picker_opts()

          if current.fs_type == "directory" then
            opts.source.choose(current)
            return
          end

          opts.source.show(state.buffers.main, current, MiniPick.get_picker_query())
        end,
      },
    },
  })
end

function Config.create_win(opts)
  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)

  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true)
  end

  local win_config = {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = opts.style or "minimal",
    border = opts.border or "rounded",
  }

  local win = vim.api.nvim_open_win(buf, true, win_config)
  return { buf = buf, win = win }
end

function Config.toggle_term(cmd)
  if Config._cache.term ~= nil and not vim.api.nvim_win_is_valid(Config._cache.term.buf) then
    Config._cache.term = Config.create_win({ buf = Config._cache.term.buf })
    if vim.bo[Config._cache.term.buf].buftype ~= "terminal" then
      vim.cmd.terminal(cmd)
      vim.cmd.startinsert()
    end
  else
    vim.api.nvim_win_hide(Config._cache.term.win)
  end
end
