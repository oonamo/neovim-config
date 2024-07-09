return {
  "nvim-telescope/telescope.nvim",
  lazy = true,
  branch = "0.1.x",
  -- tag = "0.1.6",
  -- or                              , branch = '0.1.x',
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    },
  },
  opts = function()
    local actions = require("telescope.actions")
    local layout = require("telescope.actions.layout")
    local ivy = require("telescope.themes").get_ivy({
      layout_config = {
        height = 0.30,
      },
      prompt_prefix = "  ",
      selection_caret = "▍ ",
      multi_icon = " ",
      vimgrep_arguments = {
        "rg",
        "-L",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
      },
      preview = {
        hide_on_startup = true,
      },
      mappings = {
        n = {
          ["<ESC>"] = actions.close,
          ["<C-c>"] = actions.close,
          ["<C-y>"] = layout.toggle_preview,
        },
        i = {
          ["<C-y>"] = layout.toggle_preview,
        },
      },
    })
    return {
      defaults = ivy,
      extensions = {
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case", -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        },
      },
    }
  end,
  keys = function()
    local builtin = require("telescope.builtin")
    return {
      {
        "<C-P>",
        builtin.find_files,
        desc = "find files",
      },
      {
        "<C-F>",
        builtin.live_grep,
        desc = "grep live",
      },
      {
        "<leader>fh",
        builtin.help_tags,
        desc = "help tags",
      },
      {
        "<leader>gw",
        builtin.grep_string,
        desc = "grep word",
      },
      {
        "<leader>gw",
        builtin.grep_string,
        desc = "grep word",
      },
      {
        "<leader>\\",
        builtin.current_buffer_fuzzy_find,
        desc = "find from current buffer",
      },
      {
        "z=",
        builtin.spell_suggest,
        desc = "find from current buffer",
      },
      {
        "<leader>fe",
        function()
          require("telescope.builtin").find_files({
            prompt_title = "Open in Mini.Files",
            find_command = {
              "fd",
              "--type",
              "d",
              ".",
              vim.uv.cwd(),
            },
            attach_mappings = function(_, map)
              local state = require("telescope.actions.state")
              local actions = require("telescope.actions")
              map("i", "<CR>", function(prompt_buffer)
                local content = state.get_selected_entry()
                actions.close(prompt_buffer)
                local dir = content.value
                require("mini.files").open(dir, false)
              end)
              return true
            end,
          })
        end,
        desc = "Open dir in mini files",
      },
      {
        "<leader>fi",
        builtin.highlights,
        desc = "highlights",
      },
      {
        "<leader>fm",
        builtin.marks,
        desc = "marks",
      },
    }
  end,
}
