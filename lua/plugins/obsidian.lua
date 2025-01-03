vim.g.obsidian_loaded = vim.g.obsidian_loaded or false
local base_bath = vim.fn.expand("~/Desktop/DB/DB/")

local function setup()
  if vim.g.obsidian_loaded then return end

  local daily_path = "100 dailies/"
  local daily_folder = os.date("%b %Y")
  daily_path = daily_path .. "/" .. daily_folder

  require("obsidian").setup({
    workspaces = {
      {
        name = "DB",
        path = "~/Desktop/DB/DB/",
      },
    },
    completion = {
      -- Set to false to disable completion.
      nvim_cmp = false,
      -- Trigger completion at 2 chars.
      min_chars = 2,
    },

    templates = {
      subdir = "templates",
    },

    daily_notes = {
      folder = daily_path,
      date_format = "%Y-%m-%d",
      alias_format = "%B %d, %Y",
    },

    -- disable_front
    -- disable_frontmatter = true,
    note_id_func = function(title)
      if title ~= nil then
        return title
      else
        local note_title
        vim.ui.input({ prompt = "Title: " }, function(new_title) note_title = new_title end)
        return note_title
      end
    end,

    note_frontmatter_func = function(note)
      if note.title then note:add_alias(note.title) end

      local out = { id = note.id, aliases = note.aliases, tags = note.tags, hubs = note.hubs or { "[[]]" } }

      if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
        for k, v in pairs(note.metadata) do
          out[k] = v
        end
      end

      return out
    end,

    notes_subdir = "900 Unordered",
    new_notes_location = "notes_subdir",

    -- For windows only
    follow_url_func = function(url)
      -- Open the URL in the default web browser.
      local local_file = string.match(url, "file://(.*)")
      local is_pdf = string.sub(url, #url - 2, -1)
      if is_pdf then
        vim.fn.jobstart({
          "sumatrapdf",
          "-reuse-instance",
          local_file,
        })
        return
      end
      if local_file ~= nil then
        vim.cmd("e " .. local_file)
      else
        vim.fn.jobstart({ "explorer", url })
      end
    end,
    picker = {
      name = "mini.pick",
      mappings = {
        -- Create a new note from your query.
        new = "<C-x>",
        -- Insert a link to the selected note.
        insert_link = "<C-l>",
      },
    },

    callbacks = {
      enter_note = function()
        vim.schedule(function() vim.opt.shiftwidth = 2 end)
      end,
    },

    ui = { enable = false },
  })
  -- Using ft instead
  -- vim.g.markdown_folding = 1

  local mdtils = require("tests.mini_pick")
  vim.keymap.set("n", "<leader>gf", function() mdtils.current_link() end)
  vim.keymap.set("n", "<leader>og", "<cmd>Pick goodnotes<cr>", { desc = "insert goodnotes pdf" })
  vim.keymap.set("n", "<leader>nn", "<cmd>ObsidianTemplate notes<cr>", { desc = "Obisidan note template" })
  vim.keymap.set("n", "<leader>ow", "<cmd>ObsidianWorkspace<CR>", { desc = "[O]bsidian [G]o" })
  vim.keymap.set("n", "<leader>oq", "<cmd>ObsidianQuickSwitch<CR>", { desc = "[O]bsidian [F]ind" })
  vim.keymap.set("n", "<leader>on", function()
    vim.ui.input({ prompt = "Note name (optional): " }, function(name)
      if name == nil then return end
      vim.cmd("ObsidianNew " .. name)
    end)
  end, { desc = "[O]bsidian [N]ew" })
  vim.keymap.set("n", "<leader>os", "<cmd>ObsidianSearch<CR>", { desc = "[O]bsidian [S]earch" })
  vim.keymap.set("n", "<leader>ot", "<cmd>ObsidianToday<CR>", { desc = "[O]bsidian [T]oday" })
  vim.keymap.set("n", "<leader>oy", "<cmd>ObsidianYesterday<CR>", { desc = "[O]bsidian [Y]esterday" })
  vim.keymap.set("n", "<leader>oo", "<cmd>ObsidianOpen<CR>", { desc = "[O]bsidian [O]pen" })
  vim.keymap.set("n", "<leader>ol", "<cmd>ObsidianLinks<CR>", { desc = "[O]bsidian [L]inks" })
  vim.keymap.set("n", "<leader>ob", "<cmd>ObsidianBacklinks<CR>", { desc = "[O]bsidian [B]acklinks" })
  vim.keymap.set("n", "<leader>or", "<cmd>ObsidianRename<CR>", { desc = "[O]bsidian [R]ename" })
  vim.keymap.set("n", "<leader>oe", function()
    vim.ui.input({ prompt = "Enter title (optional): " }, function(input) vim.cmd("ObsidianExtractNote " .. input) end)
  end, { desc = "[O]bsidian [E]xtract" })
  vim.keymap.set("n", "<leader>ol", function() vim.cmd("ObsidianLink") end, { desc = "[O]bsidian [L]ink" })
  vim.keymap.set("n", "<leader>od", function()
    local day_of_week = os.date("%A")
    assert(type(day_of_week) == "string")
    local offset_start
    require("onam.fn").switch(day_of_week, {
      ["Monday"] = function() offset_start = 1 end,
      ["Tuesday"] = function() offset_start = 0 end,
      ["Wednesday"] = function() offset_start = -1 end,
      ["Thursday"] = function() offset_start = -2 end,
      ["Friday"] = function() offset_start = -3 end,
      ["Saturday"] = function() offset_start = -4 end,
      ["Sunday"] = function() offset_start = 2 end,
    })
    if offset_start ~= nil then vim.cmd(string.format("ObsidianDailies %d %d", offset_start, offset_start + 4)) end
  end, { desc = "[O]bsidian [D]ailies" })

  local writing_group = vim.api.nvim_create_augroup("Writing", { clear = true })
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = writing_group,
    pattern = { "*.md", "*.norg", "*.org", "*.tex" },
    callback = function()
      require("mini.trailspace").trim()
      vim.cmd("silent! mkview")
    end,
  })
  vim.api.nvim_create_autocmd({ "BufNew", "BufEnter" }, {
    group = writing_group,
    pattern = { "*.md", "*.norg", "*.org", "*.tex" },
    callback = function()
      vim.schedule(function() vim.cmd("silent! loadview") end)
    end,
  })

  vim.g.obsidian_loaded = true
end

local pattern = (base_bath .. "/**.md"):gsub("\\", "/")

if vim.fn.argc() >= 1 then
  local cwd = vim.uv.cwd()
  local file = cwd .. package.config:sub(1, 1) .. vim.fn.argv()[1]
  if file:match(base_bath) then
    vim.api.nvim_exec_autocmds("FileType", {
      -- group = require("render-markdown.manager").group,
      data = {
        buf = vim.api.nvim_get_current_buf(),
        event = "FileType",
        match = "base.md",
      },
    })
    setup()
    vim.schedule(function()
      vim.api.nvim_exec_autocmds("BufEnter", {
        -- group = vim.api.nvim_create_augroup("obsidian_setup", { clear = true}),
        pattern = "*.md",
        data = {
          match = vim.api.nvim_buf_get_name(0),
        },
      })
    end)
    vim.g.obsidian_loaded = true
    return
  end
end

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
  pattern = "C:/Users/onam7/Desktop/DB/DB/**.md",
  once = true,
  callback = function() setup() end,
})
