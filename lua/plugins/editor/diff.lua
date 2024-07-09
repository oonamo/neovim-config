return {
  "echasnovski/mini.diff",
  event = "VeryLazy",
  keys = {
    {
      "<leader>go",
      function()
        require("mini.diff").toggle_overlay(0)
      end,
      desc = "Toggle mini.diff overlay",
    },
  },
  opts = {
    view = {
      style = "sign",
      signs = {
        add = "▎",
        change = "▎",
        delete = "",
      },
    },
  },
  config = function(_, opts)
    require("mini.diff").setup(opts)

    local function gen_hls()
      local hls = {
        "MiniDiffSignAdd",
        "MiniDiffSignChange",
        "MiniDiffSignDelete",
      }

      for _, hl in ipairs(hls) do
        -- local fg, bg, _ = utils.get_hl(hl)
        local hl_t = vim.api.nvim_get_hl(0, {
          name = hl,
        })
        vim.api.nvim_set_hl(0, hl .. "_stl", { fg = hl_t.fg })
      end
    end

    gen_hls()

    vim.keymap.set("n", "<leader>gdo", MiniDiff.toggle_overlay, { desc = "MiniDiff toggle overlay" })
    vim.keymap.set("n", "<leader>gdf", MiniDiff.toggle_overlay, { desc = "MiniDiff show overlay" })

    vim.api.nvim_create_autocmd("Colorscheme", {
      callback = gen_hls,
    })

    local function hi_str(hi, str)
      return "%#" .. hi .. "#" .. str
    end

    local format_summary = function(data)
      local summary = vim.b[data.buf].minidiff_summary
      if summary == nil or summary.add == nil then
        return ""
      end
      local t = {}
      if summary.add > 0 then
        table.insert(t, hi_str("MiniDiffSignAdd_stl", " " .. summary.add))
      end
      if summary.change > 0 then
        -- table.insert(t, " " .. summary.change)
        table.insert(t, hi_str("MiniDiffSignChange_stl", " " .. summary.change))
      end
      if summary.delete > 0 then
        -- table.insert(t, " " .. summary.delete)
        table.insert(t, hi_str("MiniDiffSignDelete_stl", " " .. summary.delete))
      end
      vim.b[data.buf].minidiff_summary_string = table.concat(t, " ")
    end

    local au_opts = { pattern = { "MiniDiffUpdated", "BufEnter" }, callback = format_summary }
    vim.api.nvim_create_autocmd("User", au_opts)
  end,
}
