local M = {}
M.hl = {}

local groupid = vim.api.nvim_create_augroup("status", { clear = true })

local status_bg = "Statusline"

local MAX_DEPTH = 1000

local non_programming_modes = {
  markdown = {},
  org = {},
  neorg = {},
  latex = {},
  help = {},
}

local function group_number(num, sep)
  if num < 999 then
    return tostring(num)
  else
    local tmp = tostring(num) --[[@as string]]
    return tmp:reverse():gsub("(%d%d%d)", "%1" .. sep):reverse():gsub("^,", "")
  end
end

---@param hl string
---@param v table
---@return string
local function get_hl(hl, v)
  if M.hl[hl] then return M.hl[hl] end
  local new_hl = v
  if v.fg then
    if type(v.fg) == "table" then
      local key = v.fg.key
      local hi = v.fg.hi
      local tmp = vim.api.nvim_get_hl(0, {
        name = hi,
        link = false,
      })
      new_hl.fg = tmp[key]
    elseif v.fg:sub(1, 1) ~= "#" then
      local fg = vim.api.nvim_get_hl(0, {
        name = v.fg,
        link = false,
      })
      new_hl.fg = fg.fg
    end
  end
  if v.bg then
    if type(v.bg) == "table" then
      local key = v.bg.key
      local hi = v.bg.hi
      local tmp = vim.api.nvim_get_hl(0, {
        name = hi,
        link = false,
      })
      new_hl.bg = tmp[key]
    elseif v.bg:sub(1, 1) ~= "#" then
      local bg = vim.api.nvim_get_hl(0, {
        name = v.bg,
        link = false,
      })
      new_hl.bg = bg.bg
    end
  end
  vim.api.nvim_set_hl(0, "status" .. hl, new_hl)
  M.hl[hl] = "status" .. hl
  return M.hl[hl]
end

---@param hl string
---@param value any
---@param hl_keys table
---@param reset boolean?
---@return string
local function stl_format(hl, value, hl_keys, reset)
  local mod_hl = get_hl(hl, hl_keys)
  return string.format("%%#%s#%s%s", mod_hl, value, reset and "%#" .. status_bg .. "#" or "")
end

function M.make_his(hl_list)
  for k, v in pairs(hl_list) do
    vim.api.nvim_set_hl(0, "status" .. k, v)
  end
end

M.separators = {
  left = "",
  right = "",
  left_side = {
    before = "",
    after = "",
  },
  right_side = {
    before = "",
    after = "",
  },
}

-- HACK: precompile these components
local function build_seperators()
  M.left = stl_format("left_sep", M.separators.left, {
    fg = {
      hi = status_bg,
      key = "bg",
    },
    bg = "Normal",
  })

  M.right = stl_format("right_sep", M.separators.right, {
    fg = {
      hi = status_bg,
      key = "bg",
    },
    bg = "Normal",
  }, true)
end
build_seperators()

local function padding(str, count, dir)
  local new_str = ""
  local left_str = ""
  local right_str = ""
  local rep = string.rep(" ", count)
  for _, v in ipairs(dir) do
    if v == "left" then left_str = rep end
    if v == "right" then right_str = rep end
  end
  new_str = left_str .. str .. right_str
  return new_str
end

function M.fname(data)
  local filename, mod
  if vim.bo[data.buf].ft == "" then
    filename = "**scratch**"
  else
    filename = vim.fn.fnamemodify(data.fname, ":t")
  end
  mod = vim.bo[data.buf].mod

  local fname = stl_format("filename" .. (mod and "mod" or ""), filename, {
    fg = data.active and "StatusLine" or "StatusLineNC",
    bg = (mod or not data.active) and "StatusLineNC" or "StatusLine",
    -- fg = "StatusLine",
    -- bg = mod and "StatusLineNC" or "StatusLine",
    bold = true,
  }, data.active)

  return fname
end

function M.fname_prefix(data)
  local is_readonly = vim.bo[data.buf].ro
  if is_readonly then return "🔒" end

  if vim.bo[data.buf].ft == "oil" then
    return stl_format("oiltype", " @ ", {
      fg = "Normal",
      bg = "DiffDelete",
    }, true)
  end

  return ""
end

local function diff_info(data)
  local summary = vim.b.minidiff_summary
  if not summary or not summary.source_name then return "" end
  local add = summary.add
  local change = summary.change
  local delete = summary.delete

  local add_format = ""
  local delete_format = ""
  local change_format = ""

  local hasAdd = false
  local hasDelete = false

  if add and add > 0 then
    hasAdd = true
    add_format = stl_format("add", add, {
      fg = "diffAdded",
      bg = "StatusLine",
    }, true)
  end
  if delete and delete > 0 then
    hasDelete = true
    delete_format = stl_format("delete", delete, {
      fg = "diffRemoved",
      bg = "StatusLine",
    }, true)
  end
  if change and change > 0 then
    change_format = stl_format("change", change, {
      fg = "diffChanged",
      bg = "StatusLine",
    }, true)
  end
  return string.format("%s %s %s", add_format, change_format, delete_format)
  -- return add_format .. change_format .. delete_format .. "%#StatusLine#"
end

local colors = {
  { hi = "Visual", key = "bg" },
  "Special",
  -- { hi = "Special", key = "fg" },
  { hi = "IncSearch", key = "bg" },
  "Substitute",
}

local modes = {
  text_mode = "§ ",
  prog_mode = "λ ",
  term_mode = ">_ ",
}

function M.ft_prefix(data)
  if non_programming_modes[vim.bo[data.buf].ft] then
    return stl_format("nonprogpre", modes.text_mode, {
      fg = "Keyword",
      bg = "StatusLine",
    }, true)
  end
  if vim.bo[data.buf].buftype == "terminal" then
    return stl_format("progmode", modes.term_mode, {
      fg = "Keyword",
      bg = "StatusLine",
    }, true)
  end
  return stl_format("progmode", modes.prog_mode, {
    fg = "Keyword",
    bg = "StatusLine",
  }, true)
end

local function ft(data)
  local filetype = vim.bo[data.buf].ft
  filetype = filetype:sub(1, 1):upper() .. filetype:sub(2)

  return stl_format("ft", filetype, {
    fg = "NonText",
    bg = "StatusLine",
    italic = true,
  }, true)
end

local function scrollbar(data)
  local lines = vim.api.nvim_buf_line_count(0)
  local cur_line = vim.api.nvim_win_get_cursor(data.win)[1]
  local i = math.floor((cur_line - 1) / lines * 8) + 1
  local color = math.floor(i / 2)

  local advbar = ""
  for index = 1, color do
    advbar = advbar
      .. stl_format("sbar_part_" .. index, " ", {
        fg = colors[index],
        bg = status_bg,
      }, true)
  end

  -- Make the scrollbar constant length
  for _ = color, 4 do
    advbar = advbar .. " "
  end

  return advbar
end

---@return string, nil|integer: Vline count
local function vline_count()
  local raw_count = vim.fn.line(".") - vim.fn.line("v")
  raw_count = raw_count < 0 and raw_count - 1 or raw_count + 1

  if raw_count < 999 then
    return tostring(raw_count)
  else
    local raw_count_str = tostring(raw_count) --[[@as string]]
    return raw_count_str:reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
  end
end

---@param node? TSNode
---@return TSNode?
local function get_next_header(node)
  -- HACK: prevent Infinite recursion in case of a bug
  if not node then return nil end
  if node:type() == "atx_heading" then return node end
  if node:type() == "paragraph" then return get_next_header(node:prev_named_sibling()) end
  if node:type() == "section" then return get_next_header(node:child(0)) end
  if node:type() == "document" then return nil end
  -- HACK: Prevent calling parnet->child->parent->child ...
  if node:parent():type() == "section" then
    -- Parent -> child does not always point to itself
    local child = node:parent():child(0)
    if child and child:type() == "atx_heading" then return child end
    return nil
  end
  return get_next_header(node:parent())
end

local function header_format(sep, node, data, depth, text_format_fn)
  if depth > MAX_DEPTH then
    vim.notify("Max recursion reached", vim.log.levels.WARN, {
      title = "Statusline",
    })
    return ""
  end
  local header = get_next_header(node)
  if not header then return "" end

  local header_child = header:child(0)
  if not header_child then return "" end

  local text
  local fallback = vim.treesitter.get_node_text(header_child, data.buf)
  local header_child_sibling = header_child:next_named_sibling()

  if header_child_sibling then
    text = vim.treesitter.get_node_text(header_child_sibling, data.buf)
  else
    text = fallback
  end
  if text_format_fn and type(text_format_fn) == "function" then text = text_format_fn(text, fallback) end
  if depth ~= 0 then text = text .. sep end

  if depth > MAX_DEPTH then return "" end

  return header_format(sep, header:parent():parent(), data, depth + 1, text_format_fn) .. text
end

local header_distribution = {
  active = 0.8,
  inactive = 0.2,
}

local icons = {
  "󰉫",
  "󰉬",
  "󰉭",
  "󰉮",
  "󰉯",
  "󰉰",
}

local function heading_outline(data)
  if vim.bo[data.buf].ft == "" or vim.bo[data.buf].ft ~= "markdown" then return end
  local status = ""

  local sep = stl_format("header_sep", " ", {
    fg = {
      hi = "Search",
      key = "bg",
    },
    bg = "Normal",
  })

  local max_header_size = {
    4,
    4,
    4,
    4,
    4,
    4,
    4,
  }
  local has_high = false

  -- Highest level is the first
  local text_format_fn = function(text, prefix)
    local header_level = #prefix
    if not has_high then
      has_high = true
      return stl_format("header" .. header_level, text, {
        fg = "RenderMarkdownHH" .. header_level,
        bg = "Normal",
        bold = true,
      })
    end
    -- return icons[header_level]
    return stl_format("header" .. header_level, prefix .. " " .. text, {
      fg = "RenderMarkdownH" .. header_level,
      bg = "Normal",
      bold = true,
    })
    -- return stl_format("header" .. header_level, trunc(prefix .. " " .. text, 3, ""), {
    -- 	fg = "RenderMarkdownH" .. header_level,
    -- 	bg = "Normal",
    -- 	bold = true,
    -- })
  end

  status = header_format(sep, vim.treesitter.get_node({}), data, 0, text_format_fn)

  if status == "" then return status end

  return M.left .. status .. M.right
end

local function non_prog_mode(data)
  local raw_lines = vim.api.nvim_buf_line_count(0)
  local lines = group_number(raw_lines, ",")
  local wc_table = vim.fn.wordcount()
  if not wc_table.visual_words or not wc_table.visual_chars then
    local raw_word_count
    if raw_lines < 999 then
      raw_word_count = tostring(wc_table.words)
    else
      local wc_table_words_str = tostring(wc_table.words) --[[@as string]]
      raw_word_count = wc_table_words_str:reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
    end
    return stl_format("fileinfo", "≡", {
      fg = "DiagnosticInfo",
      bg = status_bg,
    }, true) .. " " .. lines .. " lines  " .. raw_word_count .. " words "
  else
    return stl_format("fileinfo", "‹›", {
      fg = "DiagnosticInfo",
      bg = status_bg,
    }, true) .. " " .. vline_count() .. " lines  ",
      group_number(wc_table.visual_words, ",") .. " words  ",
      group_number(wc_table.visual_chars, ",") .. " chars"
  end
end

local function diagnostics(data)
  if #vim.diagnostic.get(0) > 0 then
    local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    local error_format = stl_format("error", "x ", {
      fg = "DiagnosticError",
      bg = "StatusLine",
    }, true) .. errors

    local err = errors > 0 and error_format .. " " or ""

    local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    local warn_format = stl_format("warn", "▲ ", {
      fg = "DiagnosticWarn",
      bg = "StatusLine",
    }, true) .. warnings
    local warn = warnings > 0 and warn_format .. " " or ""
    return err .. warn .. "%#StatusLine# "
  end
  return ""
end

local diag_signs_default_text = { "x ", "▲ ", "I", "H" }

local diag_severity_map = {
  [1] = "ERROR",
  [2] = "WARN",
  [3] = "INFO",
  [4] = "HINT",
  ERROR = 1,
  WARN = 2,
  INFO = 3,
  HINT = 4,
}

---@param severity integer|string
---@return string
local function get_diag_sign_text(severity)
  local diag_config = vim.diagnostic.config()
  local signs_text = diag_config and diag_config.signs and type(diag_config.signs) == "table" and diag_config.signs.text
  return signs_text and (signs_text[severity] or signs_text[diag_severity_map[severity]])
    or (diag_signs_default_text[severity] or diag_signs_default_text[diag_severity_map[severity]])
end

function M.diag(data)
  if vim.b[data.buf].diag_str_cache then return vim.b[data.buf].diag_str_cache end
  local str = ""
  local buf_cnt = vim.b[data.buf].diag_cnt_cache or {}
  for serverity_nr, severity in ipairs({ "Error", "Warn", "Info", "Hint" }) do
    local cnt = buf_cnt[serverity_nr] ~= vim.NIL and buf_cnt[serverity_nr] or 0
    if cnt > 0 then
      local icon_text = get_diag_sign_text(serverity_nr)
      str = str
        .. (str == "" and "" or " ")
        .. stl_format("diagnostic" .. severity, icon_text, {
          fg = "DiagnosticSign" .. severity,
          bg = status_bg,
        }, true)
        .. stl_format("count", cnt, {
          fg = "StatusLine",
          bg = status_bg,
        }, true)
    end
  end
  if str:find("%S") then str = str .. " " end
  if str == "" then str = stl_format("count", " ", {
    fg = "StatusLine",
    bg = status_bg,
  }, true) end

  vim.b[data.buf].diag_str_cache = str
  return str
end

vim.api.nvim_create_autocmd("DiagnosticChanged", {
  group = groupid,
  desc = "Update diagnostics cache for the status line.",
  callback = function(info)
    vim.b[info.buf].diag_cnt_cache = vim.diagnostic.count(info.buf)
    vim.b[info.buf].diag_str_cache = nil

    vim.cmd.redrawstatus({
      mods = { emsg_silent = true },
    })
  end,
})

function M.gitinfo(data)
  local branch = vim.b[data.buf].minigit_summary and vim.b[data.buf].minigit_summary.head_name or ""
  if branch == "" then return branch end

  branch = branch:sub(1, 1):upper() .. branch:sub(2)
  return stl_format("giticon", " ", {
    fg = "Keyword",
    bg = "StatusLine",
  }) .. stl_format("gitbranch", branch .. " ", {
    fg = "NonText",
    bg = "StatusLine",
    italic = true,
  })
end

local spinner_end_keep = 2000 -- ms
local spinner_status_keep = 600 -- ms
local spinner_progress_keep = 80 -- ms
local spinner_timer = vim.uv.new_timer()

vim.g.has_nf = true
local spinner_bg = status_bg
local spinner_icons ---@type string[]
local spinner_icon_done ---@type string
if vim.g.has_nf then
  spinner_icon_done = stl_format("spinnerdone", vim.trim("󰄬 "), { fg = "Constant", bg = "Statusline" }, true)
  spinner_icons = {
    stl_format("spinnera", "⣷", {
      fg = "Constant",
      bg = "Statusline",
    }, true),
    stl_format("spinnerb", "⣯", { fg = "Constant", bg = spinner_bg }, true),
    stl_format("spinnerc", "⣟", { fg = "Constant", bg = spinner_bg }, true),
    stl_format("spinnerd", "⡿", { fg = "Constant", bg = spinner_bg }, true),
    stl_format("spinnere", "⢿", { fg = "Constant", bg = spinner_bg }, true),
    stl_format("spinnerf", "⣻", { fg = "Constant", bg = spinner_bg }, true),
    stl_format("spinnerg", "⣽", { fg = "Constant", bg = spinner_bg }, true),
    stl_format("spinnerh", "⣾", { fg = "Constant", bg = spinner_bg }, true),
  }
else
  spinner_icon_done = "[done]"
  spinner_icons = {
    stl_format("spinnera", "[    ]", { fg = "Constant", bg = spinner_bg }),
    stl_format("spinnerb", "[=   ]", { fg = "Constant", bg = spinner_bg }),
    stl_format("spinnerc", "[==  ]", { fg = "Constant", bg = spinner_bg }),
    stl_format("spinnerd", "[=== ]", { fg = "Constant", bg = spinner_bg }),
    stl_format("spinnere", "[ ===]", { fg = "Constant", bg = spinner_bg }),
    stl_format("spinnerf", "[  ==]", { fg = "Constant", bg = spinner_bg }),
    stl_format("spinnerg", "[   =]", { fg = "Constant", bg = spinner_bg }),
  }
end

---Id and additional info of language servers in progress
---@type table<integer, { name: string, timestamp: integer, type: 'begin'|'report'|'end' }>
local server_info = {}

vim.api.nvim_create_autocmd("LspProgress", {
  desc = "Update LSP progress info for the status line.",
  group = groupid,
  callback = function(info)
    if spinner_timer then
      spinner_timer:start(
        spinner_progress_keep,
        spinner_progress_keep,
        vim.schedule_wrap(function() vim.cmd.redrawstatus() end)
      )
    end

    local id = info.data.client_id
    local now = vim.uv.now()
    server_info[id] = {
      name = vim.lsp.get_client_by_id(id).name,
      timestamp = now,
      type = info.data and info.data.params and info.data.params.value and info.data.params.value.kind,
    } -- Update LSP progress data
    -- Clear client message after a short time if no new message is received
    vim.defer_fn(function()
      -- No new report since the timer was set
      local last_timestamp = (server_info[id] or {}).timestamp
      if not last_timestamp or last_timestamp == now then
        server_info[id] = nil
        if vim.tbl_isempty(server_info) and spinner_timer then spinner_timer:stop() end
        vim.cmd.redrawstatus()
      end
    end, spinner_end_keep)

    vim.cmd.redrawstatus({
      mods = { emsg_silent = true },
    })
  end,
})

function M.lsp_progress()
  if vim.tbl_isempty(server_info) then return "" end
  local buf = vim.api.nvim_get_current_buf()
  local server_ids = {}
  for id, _ in pairs(server_info) do
    if vim.tbl_contains(vim.lsp.get_buffers_by_client_id(id), buf) then table.insert(server_ids, id) end
  end
  if vim.tbl_isempty(server_ids) then return "" end

  local now = vim.uv.now()
  ---@return boolean
  local function allow_changing_state()
    return not vim.b.spinner_state_changed or now - vim.b.spinner_state_changed > spinner_status_keep
  end

  if #server_ids == 1 and server_info[server_ids[1]].type == "end" then
    if vim.b.spinner_icon ~= spinner_icon_done and allow_changing_state() then
      vim.b.spinner_state_changed = now
      vim.b.spinner_icon = spinner_icon_done
    end
  else
    local spinner_icon_progress = spinner_icons[math.ceil(now / spinner_progress_keep) % #spinner_icons + 1]
    if vim.b.spinner_icon ~= spinner_icon_done then
      vim.b.spinner_icon = spinner_icon_progress
    elseif allow_changing_state() then
      vim.b.spinner_state_changed = now
      vim.b.spinner_icon = spinner_icon_progress
    end
  end

  return string.format(
    "%s %s ",
    table.concat(vim.tbl_map(function(id) return server_info[id].name end, server_ids), ", "),
    vim.b.spinner_icon
  )
end

function M.custom(data)
  local custom_info = ""
  if vim.g.autoformat then
    custom_info = custom_info
      .. stl_format("format", "󰁨  ", {
        fg = "Function",
        bg = status_bg,
      }, true)
  end
  if vim.wo[data.win].spell then
    custom_info = custom_info
      .. stl_format("spell", "󰓆 ", {
        fg = "Constant",
        bg = status_bg,
      }, true)
  end
  return custom_info
end

local function default_status(data)
  local is_not_programming = non_programming_modes[vim.bo[data.buf].ft] ~= nil
  return {
    M.fname_prefix(data),
    M.fname(data),
    " ",
    M.ft_prefix(data),
    ft(data),
    " ",
    M.gitinfo(data),
    -- scrollbar(data),
    " ",
    "%=",
    vim.bo[data.buf].ft == "markdown" and heading_outline(data) or "",
    "%=",
    M.lsp_progress(),
    " ",
    diff_info(data),
    " ",
    M.diag(data),
    " ",
    M.custom(data),
    " ",
    not is_not_programming and [[%{%&ru?"%l:%c ":""%}]] or nil,
    is_not_programming and non_prog_mode(data) or nil,
    -- heading_outline(data),
  }
end

local function inactive(_)
  return {
    " ",
    [[%{%&bt==#''?'':(&bt==#'help'?'%h ':(&pvw?'%w ':''))%}]],
    [[%f]],
    -- M.fname(data),
    "%=",
    "%<",
    [[%{%&ru?"%l:%c ":""%}]],
  }
end

function M.build()
  local data = {
    win = vim.g.statusline_winid,
  }
  data.buf = vim.api.nvim_win_get_buf(data.win)
  data.fname = vim.api.nvim_buf_get_name(data.buf)
  data.active = data.win == vim.api.nvim_get_current_win()

  M.data = data

  local components = data.active and default_status(data) or inactive(data)
  local statusline = ""
  for _, component in ipairs(components) do
    statusline = statusline .. component
  end
  return statusline
end

vim.opt.statusline = "%!v:lua.require('custom.simpstatus').build()"
vim.api.nvim_create_autocmd("Colorscheme", {
  group = groupid,
  callback = function()
    M.hl = {}
    spinner_icons = {
      stl_format("spinnera", "⣷", {
        fg = "Constant",
        bg = "Statusline",
      }, true),
      stl_format("spinnerb", "⣯", { fg = "Constant", bg = spinner_bg }, true),
      stl_format("spinnerc", "⣟", { fg = "Constant", bg = spinner_bg }, true),
      stl_format("spinnerd", "⡿", { fg = "Constant", bg = spinner_bg }, true),
      stl_format("spinnere", "⢿", { fg = "Constant", bg = spinner_bg }, true),
      stl_format("spinnerf", "⣻", { fg = "Constant", bg = spinner_bg }, true),
      stl_format("spinnerg", "⣽", { fg = "Constant", bg = spinner_bg }, true),
      stl_format("spinnerh", "⣾", { fg = "Constant", bg = spinner_bg }, true),
    }
  end,
})

return M
