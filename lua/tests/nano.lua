local statusline = {}
local groupid = vim.api.nvim_create_augroup("StatusLine", {})

local M = {}
M.hl = {}

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

local status_bg = "StatusLine"

---@param hl string
---@param value any
---@param hl_keys table
---@param reset boolean?
---@return string
local function stl_format(hl, value, hl_keys, reset)
  local mod_hl = get_hl(hl, hl_keys)
  return string.format("%%#%s#%s%s", mod_hl, value, reset and "%#" .. status_bg .. "#" or "")
end

local function stl_hl_pair(hl, value, reset)
  return string.format("%%#%s#%s%s", hl, value, reset and "%#" .. status_bg .. "#" or "")
end

local diag_signs_default_text = { "E", "W", "I", "H" }

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

-- stylua: ignore start 
local modes  = setmetatable({
  ["n"]      = { "NO", "MiniStatuslineModeNormal" },
  ["no"]     = { "OP", "MiniStatuslineModeOther" },
  ["nov"]    = { "OC", "MiniStatuslineModeOther" },
  ["noV"]    = { "OL", "MiniStatuslineModeOther" },
  ["no\x16"] = { "OB", "MiniStatuslineModeOther" },
  ["\x16"]   = { "VB", "MiniStatuslineModeVisual" },
  ["niI"]    = { "IN", "MiniStatuslineModeInsert" },
  ["niR"]    = { "RE", "MiniStatuslineModeReplace" },
  ["niV"]    = { "RV", "MiniStatuslineModeVisual" },
  ["nt"]     = { "NT", "MiniStatuslineModeNormal" },
  ["ntT"]    = { "TM", "MiniStatuslineModeNormal" },
  ["v"]      = { "VI", "MiniStatuslineModeVisual" },
  ["vs"]     = { "VI", "MiniStatuslineModeVisual" },
  ["V"]      = { "VL", "MiniStatuslineModeVisual" },
  ["Vs"]     = { "VL", "MiniStatuslineModeVisual" },
  ["\x16s"]  = { "VB", "MiniStatuslineModeVisual" },
  ["s"]      = { "SE", "MiniStatuslineModeVisual" },
  ["S"]      = { "SL", "MiniStatuslineModeVisual" },
  ["\x13"]   = { "SB", "MiniStatuslineModeVisual" },
  ["i"]      = { "IN", "MiniStatuslineModeInsert" },
  ["ic"]     = { "IC", "MiniStatuslineModeInsert" },
  ["ix"]     = { "IX", "MiniStatuslineModeInsert" },
  ["R"]      = { "RE", "MiniStatuslineModeReplace" },
  ["Rc"]     = { "RC", "MiniStatuslineModeReplace" },
  ["Rx"]     = { "RX", "MiniStatuslineModeReplace" },
  ["Rv"]     = { "RV", "MiniStatuslineModeReplace" },
  ["Rvc"]    = { "RC", "MiniStatuslineModeReplace" },
  ["Rvx"]    = { "RX", "MiniStatuslineModeReplace" },
  ["c"]      = { "CO", "MiniStatuslineModeReplace" },
  ["cv"]     = { "CV", "MiniStatuslineModeReplace" },
  ["r"]      = { "PR", "MiniStatuslineModeReplace" },
  ["rm"]     = { "PM", "MiniStatuslineModeReplace" },
  ["r?"]     = { "P?", "MiniStatuslineModeReplace" },
  ["!"]      = { "SH", "MiniStatuslineModeReplace" },
  ["t"]      = { "TE", "MiniStatuslineModeReplace" },
}, {
  __index    = function() return { "UNKNOWN", "MiniStatuslineModeOther" } end,
})
-- stylua: ignore end

---Get string representation of the current mode
---@return string
function statusline.mode()
  local mode = vim.fn.mode()
  local mode_pair = (mode == "n" and (vim.bo.ro or not vim.bo.ma)) and { "RO", "MiniStatuslineModeOther" }
    or modes[mode]
  local mode_str, mode_hl = mode_pair and mode_pair[1], mode_pair and mode_pair[2]
  -- if vim.bo.mod then
  --   return stl_format("modified", string.format(" %s ", mode_str), {
  --     bg = {
  --       hi = "Special",
  --       key = "fg",
  --     },
  --     fg = "Normal",
  --   }, true)
  -- else
  return stl_format("mode" .. mode_str, string.format(" %s ", mode_str), {
    fg = mode_pair[2],
    bg = mode_pair[2],
    -- bg = { hi = "Folded", key = "bg" },
    -- fg = "Normal",
    -- fg = {
    --   fg = "Normal"
    -- },
  }, true)
  -- end
end

---Get diff stats for current buffer
---@return string
function statusline.gitdiff()
  -- Integration with gitsigns.nvim
  ---@diagnostic disable-next-line: undefined-field
  local diff = vim.b.minidiff_summary
  if not diff then diff = {
    added = 0,
    changed = 0,
    removed = 0,
  } end
  local added = diff.add or 0
  local changed = diff.change or 0
  local removed = diff.delete or 0
  if added == 0 and removed == 0 and changed == 0 then return "" end
  return string.format(
    "+%s~%s-%s",
    stl_format("added", added, {
      fg = "MiniDiffSignAdd",
      bg = status_bg,
    }, true),
    stl_format("changed", changed, {
      fg = "MiniDiffSignChange",
      bg = status_bg,
    }, true),
    stl_format("removed", removed, {
      fg = "MiniDiffSignDelete",
      bg = status_bg,
    }, true)
  )
end

---Get string representation of current git branch
---@return string
function statusline.branch()
  ---@diagnostic disable-next-line: undefined-field
  local branch = vim.b.minigit_summary and vim.b.minigit_summary.head_name or ""
  return branch == "" and ""
    or (
      stl_format("gitbranch_hash", "#", {
        fg = "MiniIconsRed",
        bg = "StatusLine",
      }, true) .. stl_format("gitbranch", branch, {
        fg = "MiniIconsYellow",
        bg = "StatusLine",
      }, true)
    )
  -- or stl_format("gitbranch", "#" .. branch, {
  --   fg = "NeoGitBranch",
  --   bg = "StatusLine",
  -- }, true)
end

---Get current filetype
---@return string
function statusline.ft()
  return vim.bo.ft == "" and ""
    or stl_format("filetype", vim.bo.ft:gsub("^%l", string.upper), {
      fg = "NonText",
      bg = "StatusLine",
    }, true)
end

---@return string
function statusline.wordcount()
  local stats = nil
  local nwords, nchars = 0, 0 -- luacheck: ignore 311
  if vim.b.wc_words and vim.b.wc_chars and vim.b.wc_changedtick == vim.b.changedtick then
    nwords = vim.b.wc_words
    nchars = vim.b.wc_chars
  else
    stats = vim.fn.wordcount()
    nwords = stats.words
    nchars = stats.chars
    vim.b.wc_words = nwords
    vim.b.wc_chars = nchars
    vim.b.wc_changedtick = vim.b.changedtick
  end

  local vwords, vchars = 0, 0
  if vim.fn.mode():find("^[vsVS\x16\x13]") then
    stats = stats or vim.fn.wordcount()
    vwords = stats.visual_words
    vchars = stats.visual_chars
  end

  if nwords == 0 and nchars == 0 then return "" end

  return string.format(
    "%s%d word%s, %s%d char%s",
    vwords > 0 and vwords .. "/" or "",
    nwords,
    nwords > 1 and "s" or "",
    vchars > 0 and vchars .. "/" or "",
    nchars,
    nchars > 1 and "s" or ""
  )
end

function statusline.fname()
  local bname = vim.api.nvim_buf_get_name(0)

  -- Normal buffer
  if vim.bo.bt == "" then
    -- Unnamed normal buffer
    if bname == "" then return "[Buffer %n]" end
    -- Named normal buffer, show file name, if the file name is not unique,
    -- show local cwd (often project root) after the file name
    local fname = vim.fs.basename(bname)
    return fname
  end

  -- Terminal buffer, show terminal command and id
  if vim.bo.bt == "terminal" then
    local id, cmd = bname:match("^term://.*/(%d+):(.*)")
    return id and cmd and string.format("[Terminal] %s (%s)", cmd, id) or "[Terminal] %F"
  end

  -- Other special buffer types
  local prefix, suffix = bname:match("^%s*(%S+)://(.*)")
  if prefix and suffix then return string.format("[%s] %s", prefix, suffix) end

  return "%F"
end

---Text filetypes
---@type table<string, true>
local ft_text = {
  [""] = true,
  ["tex"] = true,
  ["markdown"] = true,
  ["text"] = true,
}

---Additional info for the current buffer enclosed in parentheses
---@return string
function statusline.info()
  if vim.bo.bt ~= "" then return "" end
  local info = {}
  ---@param section string
  local function add_section(section)
    if section ~= "" then table.insert(info, section) end
  end
  add_section(statusline.ft())
  if ft_text[vim.bo.ft] and not vim.b.bigfile then add_section(statusline.wordcount()) end
  add_section(statusline.branch())
  add_section(statusline.gitdiff())
  return vim.tbl_isempty(info) and "" or string.format("(%s) ", table.concat(info, ", "))
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

---Get string representation of diagnostics for current buffer
---@return string
function statusline.diag()
  if vim.b.diag_str_cache then return vim.b.diag_str_cache end
  local str = ""
  local buf_cnt = vim.b.diag_cnt_cache or {}
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
        .. cnt
    end
  end
  if str:find("%S") then str = str .. " " end
  vim.b.diag_str_cache = str
  return str
end

local spinner_end_keep = 2000 -- ms
local spinner_status_keep = 600 -- ms
local spinner_progress_keep = 80 -- ms
local spinner_timer = vim.uv.new_timer()

vim.g.has_nf = true
local spinner_icons ---@type string[]
local spinner_icon_done ---@type string

if vim.g.has_nf then
  -- spinner_icon_done = { vim.trim("󰄬 "), "Constant" }
  spinner_icon_done = stl_format("spinnerdone", vim.trim("󰄬 "), { fg = "Constant", bg = "Statusline" }, true)
  spinner_icons = {
    stl_format("spinnera", "⣷", {
      fg = "Constant",
      bg = "Statusline",
    }, true),
    stl_format("spinnerb", "⣯", { fg = "Constant", bg = "StatusLine" }, true),
    stl_format("spinnerc", "⣟", { fg = "Constant", bg = "StatusLine" }, true),
    stl_format("spinnerd", "⡿", { fg = "Constant", bg = "StatusLine" }, true),
    stl_format("spinnere", "⢿", { fg = "Constant", bg = "StatusLine" }, true),
    stl_format("spinnerf", "⣻", { fg = "Constant", bg = "StatusLine" }, true),
    stl_format("spinnerg", "⣽", { fg = "Constant", bg = "StatusLine" }, true),
    stl_format("spinnerh", "⣾", { fg = "Constant", bg = "StatusLine" }, true),
  }
else
  spinner_icon_done = "[done]"
  spinner_icons = {
    { "[    ]", "Constant" },
    { "[=   ]", "Constant" },
    { "[==  ]", "Constant" },
    { "[=== ]", "Constant" },
    { "[ ===]", "Constant" },
    { "[  ==]", "Constant" },
    { "[   =]", "Constant" },
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
      spinner_timer:start(spinner_progress_keep, spinner_progress_keep, vim.schedule_wrap(vim.cmd.redrawstatus))
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

---@return string
function statusline.lsp_progress()
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
    -- stl_hl_pair(vim.b.spinner_icon[2], vim.b.spinner_icon[1], true)
  )
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



-- stylua: ignore start
---Statusline components
---@type table<string, string>
local components = {
  align        = [[%=]],
  flag         = [[%{%&bt==#''?'':(&bt==#'help'?'%h ':(&pvw?'%w ':''))%}]],
  diag         = [[%{%v:lua.require'tests.nano'.diag()%}]],
  fname        = [[%{%v:lua.require'tests.nano'.fname()%} ]],
  info         = [[%{%v:lua.require'tests.nano'.info()%}]],
  lsp_progress = [[%{%v:lua.require'tests.nano'.lsp_progress()%}]],
  mode         = [[%{%v:lua.require'tests.nano'.mode()%}]],
  padding      = [[ ]],
  pos          = [[%{%&ru?"%l:%c ":""%}]],
  truncate     = [[%<]],
}
-- stylua: ignore end

local stl = table.concat({
  components.mode,
  components.padding,
  components.flag,
  components.fname,
  components.info,
  components.align,
  components.truncate,
  components.lsp_progress,
  components.diag,
  components.pos,
})

local stl_nc = table.concat({
  components.padding,
  components.flag,
  components.fname,
  components.align,
  components.truncate,
  components.pos,
})

---Get statusline string
---@return string
function statusline.get() return vim.g.statusline_winid == vim.api.nvim_get_current_win() and stl or stl_nc end

vim.api.nvim_create_autocmd("ColorScheme", {
  group = groupid,
  callback = function()
    M.hl = {}

    spinner_icon_done = stl_format("spinnerdone", vim.trim("󰄬 "), { fg = "Constant", bg = "Statusline" }, true)
    spinner_icons = {
      stl_format("spinnera", "⣷", {
        fg = "Constant",
        bg = "Statusline",
      }, true),
      stl_format("spinnerb", "⣯", { fg = "Constant", bg = "StatusLine" }, true),
      stl_format("spinnerc", "⣟", { fg = "Constant", bg = "StatusLine" }, true),
      stl_format("spinnerd", "⡿", { fg = "Constant", bg = "StatusLine" }, true),
      stl_format("spinnere", "⢿", { fg = "Constant", bg = "StatusLine" }, true),
      stl_format("spinnerf", "⣻", { fg = "Constant", bg = "StatusLine" }, true),
      stl_format("spinnerg", "⣽", { fg = "Constant", bg = "StatusLine" }, true),
      stl_format("spinnerh", "⣾", { fg = "Constant", bg = "StatusLine" }, true),
    }
  end,
})

vim.o.statusline = [[%!v:lua.require'tests.nano'.get()]]

return statusline
