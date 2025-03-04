Config._cache = {
  term = {
    buf = -1,
    win = -1,
  },
}
Config.opts = {}

function Config.open_lazygit() Config.toggle_term("lazygit") end

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

local shell_maps = {
  ["sh"] = { "-c" },
  ["cmd.exe"] = { "/C" },
  ["pwsh.exe"] = { "-C" },
}

function Config.async_make(args)
  local makeprg = vim.opt.makeprg:get()
  for _, arg in ipairs(args) do
    if arg == "~" then arg = vim.uv.os_homedir() end
    makeprg = makeprg .. " " .. arg
  end
  local make_cmd = {
    unpack(shell_maps[vim.o.shell]),
    makeprg,
  }

  local output_handler = vim.schedule_wrap(function(err, data)
    if data ~= nil then
      vim.fn.setqflist({}, "a", {
        lines = vim.split(data, "\n", { trimempty = true }),
        efm = vim.opt.errorformat:get()[1],
      })
    end
    vim.cmd.redraw()
  end)

  vim.system(make_cmd, { stdout = output_handler, stderr = output_handler, text = true })

  vim.cmd.copen()
end

vim.api.nvim_create_user_command(
  "Grep",
  function(c) Config.async_grep(c.args) end,
  { nargs = "*", bang = true, complete = "file" }
)

vim.api.nvim_create_user_command("Make", function(c) Config.async_make(c.fargs) end, { nargs = "*" })

function Config.explorer(cwd, opts)
  local mappings = require("custom.explorer").mappings
  local default_opts = {
    cwd = cwd,
    mappings = {
      -- stylua: ignore start
      toggle_preview = "", -- HACK: Prevent it from stealing <tab>
      scroll_left    = "", -- HACK: Prevent it from stealing <c-h>

      complete_or_enter = mappings.complete_or_enter("<tab>"),
      go_up_level       = mappings.go_up_level      ("<C-h>"),
      go_up_level_fancy = mappings.go_up_level      ("<C-bs>"),
      new_file          = mappings.create_file      ("<A-e>"),
      open_in_mini      = mappings.explorer         ("<A-g>", function(item) MiniFiles.open(item) end),
      -- stylua: ignore end
    },
  }
  local _opts = vim.tbl_deep_extend("force", default_opts, opts or {})
  require("custom.explorer").explorer(_opts)
end

function Config.dired(opts)
  local mappings = require("custom.explorer").mappings
  local default_opts = {
    mappings = {
      -- stylua: ignore start
      toggle_preview = "", -- HACK: Prevent it from stealing <tab>
      scroll_left    = "", -- HACK: Prevent it from stealing <c-h>

      complete_or_enter = mappings.complete_or_enter("<tab>"),
      go_up_level       = mappings.go_up_level      ("<C-h>"),
      go_up_level_fancy = mappings.go_up_level      ("<C-bs>"),
      new_file          = mappings.create_file      ("<C-e>"),
      open_in_mini      = mappings.explorer         ("<A-g>", function(item) MiniFiles.open(item) end),
      -- stylua: ignore end
    },
    window = {
      config = function()
        return {
          height = vim.o.lines,
          width = vim.o.columns,
          border = "solid",
        }
      end,
    },
  }
  opts = vim.tbl_deep_extend("force", default_opts, opts or {})
  require("custom.explorer").explorer(opts)
end

function Config.create_win(opts)
  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)

  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  local buf = nil
  if opts.buf and vim.api.nvim_buf_is_valid(opts.buf) then
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
      -- vim.cmd.terminal(cmd)
      vim.fn.termopen(cmd, {
        on_exit = function()
          vim.cmd("silent! :checktime")
          vim.cmd("silent! :bw")
        end,
      })
      vim.cmd.startinsert()
    end
  else
    vim.api.nvim_win_hide(Config._cache.term.win)
  end
end

Config.load_colorscheme = function()
  local fs = require("utils.fs")
  local colors_file = vim.fs.joinpath(vim.fn.stdpath("state") --[[@as string]], "colors.json")
  local file = fs.read(colors_file)
  if file == "" then return end

  local ok, saved = pcall(vim.json.decode, file)
  if not ok then return end

  if saved.bg then vim.go.bg = saved.bg end
  if saved.colors_name and saved.colors_name ~= vim.g.colors_name then
    ok, _ = require("custom.colors").select(saved.colors_name)
    if ok then return end

    ok, _ = pcall(vim.cmd.colorscheme, saved.colors_name)
    if ok then return end

    MiniDeps.later(function()
      local err
      ok, err = pcall(vim.cmd.colorscheme, saved.colors_name)
      if not ok then
        vim.notify(
          "Could not load colorscheme '"
            .. saved.colors_name
            .. "':\n"
            .. ((err and type(err) == "string") and err or "")
        )
      end
    end)
  end
end

-- Log for personal use during debugging
Config.log = {}

local start_hrtime = vim.loop.hrtime()
_G.DD = function(...)
  local t = { ... }
  t.timestamp = 0.000001 * (vim.loop.hrtime() - start_hrtime)
  table.insert(Config.log, vim.deepcopy(t))
end

local log_buf_id
Config.log_print = function()
  if log_buf_id == nil or not vim.api.nvim_buf_is_valid(log_buf_id) then log_buf_id = Config.create_win().buf end
  vim.api.nvim_win_set_buf(0, log_buf_id)
  vim.api.nvim_buf_set_lines(log_buf_id, 0, -1, false, vim.split(vim.inspect(Config.log), "\n"))
end
