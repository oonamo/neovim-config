local group = vim.api.nvim_create_augroup("config group", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  group = group,
  callback = function() vim.highlight.on_yank() end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = {
    "help",
    "man",
    "qf",
    "query",
    "scratch",
  },
  callback = function(args)
    vim.keymap.set("n", "q", "<cmd>quit<cr>", { buffer = args.buf })
    if args.match == "qf" then return end
    vim.bo.bufhidden = "unload"
    vim.cmd.wincmd("K")
    vim.cmd.wincmd("=")
  end,
  desc = "Close with 'q'",
})

vim.api.nvim_create_autocmd("BufReadPre", {
  pattern = "*",
  callback = function(ev)
    local stat = vim.uv.fs_stat(ev.match)
    if stat and stat.size > 1048567 then
      vim.bo.bigfile = true
      vim.opt_local.spell = false
      vim.opt_local.swapfile = false
      vim.opt_local.undofile = false
      vim.opt_local.breakindent = false
      vim.opt_local.colorcolumn = ""
      vim.opt_local.statuscolumn = ""
      vim.opt_local.signcolumn = "no"
      vim.opt_local.foldcolumn = "0"
      vim.opt_local.winbar = ""
      vim.opt_local.syntax = ""

      vim.bo[ev.buf].minianimate_disable = true
      vim.bo[ev.buf].minidiff_disable = true
      vim.bo[ev.buf].miniindentscope_disable = true

      vim.api.nvim_create_autocmd("BufReadPost", {
        once = true,
        buffer = ev.buf,
        callback = function()
          vim.opt_local.syntax = ""
          return true
        end,
      })
    end
  end,
})

local fs = require("utils.fs")

local colors_file = vim.fs.joinpath(vim.fn.stdpath("state") --[[@as string]], "colors.json")
vim.api.nvim_create_autocmd("ColorScheme", {
  group = group,
  desc = "Set background + colors on colorscheme",
  callback = function()
    vim.schedule(function()
      local contents = fs.read(colors_file)
      local ok, data = pcall(vim.json.decode, contents)
      if not ok then
        vim.notify("Could not decode colors_file")
        return
      end
      if data.colors_name ~= vim.g.colors_name or data.bg ~= vim.go.bg then
        data.colors_name = vim.g.colors_name
        data.bg = vim.go.bg
        local write = vim.json.encode(data)
        fs.write_file(colors_file, write)
      end
    end)
  end,
})

vim.api.nvim_create_autocmd("VimResized", {
  command = "wincmd =",
})

-- vim.api.nvim_create_autocmd({ "BufWritePost", "CmdlineLeave" }, {
--   callback = function()
--     vim.o.cmdheight = 0
--     vim.cmd([[echo '' | redraw]])
--   end,
-- })
--
-- vim.api.nvim_create_autocmd({ "CmdlineChanged", "CmdlineEnter" }, {
--   callback = function() vim.o.cmdheight = 1 end,
-- })
