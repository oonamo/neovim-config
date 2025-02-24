vim.api.nvim_set_keymap("i", "<C-c>", "<Esc>", { desc = "escape insert mode", noremap = true })

local function map(mode, key, rhs, opts)
  opts = opts or {}
  if opts.silent == nil then
    if not (type(mode) == "string" and mode == "c" or type(mode) == "table" and vim.tbl_contains(mode, "c")) then
      opts.silent = true
    end
  end
  vim.keymap.set(mode, key, rhs, opts)
end

local function map_toggle(lhs, rhs, desc) map("n", "\\" .. lhs, rhs, { desc = desc }) end

local function cmap(trig, command)
  vim.keymap.set(
    "c",
    trig,
    function() return vim.fn.getcmdcompltype() == "command" and command or trig end,
    { expr = true }
  )
end

--================== Toggles ====================
map_toggle("b", '<Cmd>lua vim.o.bg = vim.o.bg == "dark" and "light" or "dark"<CR>', "Toggle 'background'")
map_toggle("c", "<Cmd>setlocal cursorline!<CR>", "Toggle 'cursorline'")
map_toggle("C", "<Cmd>setlocal cursorcolumn!<CR>", "Toggle 'cursorcolumn'")
map_toggle("d", function() require("mini.basics").toggle_diagnostic() end, "Toggle diagnostic")
map_toggle("h", "<Cmd>let v:hlsearch = 1 - v:hlsearch<CR>", "Toggle search highlight")
map_toggle("i", "<Cmd>setlocal ignorecase!<CR>", "Toggle 'ignorecase'")
map_toggle("l", "<Cmd>setlocal list!<CR>", "Toggle 'list'")
map_toggle("n", "<Cmd>setlocal number!<CR>", "Toggle 'number'")
map_toggle("r", "<Cmd>setlocal relativenumber!<CR>", "Toggle 'relativenumber'")
map_toggle("s", "<Cmd>setlocal spell!<CR>", "Toggle 'spell'")
map_toggle("w", "<Cmd>setlocal wrap!<CR>", "Toggle 'wrap'")
map_toggle("f", function() vim.g.autoformat = not vim.g.autoformat end, "Toggle 'autoformat'")
map_toggle("B", function() vim.g.complete_fallback = not vim.g.complete_fallback end, "Toggle 'complete_fallback'")

map_toggle("o", function()
  local formatoptions = vim.bo.formatoptions
  if formatoptions:match("[oc]") then
    vim.cmd("setlocal formatoptions-=o formatoptions-=c")
  else
    vim.cmd("setlocal formatoptions+=o formatoptions+=c")
  end
end, "Toggle 'auto insert comments'")

--================== Hlsearch ====================
map("n", "<Esc>", "<cmd>nohlsearch<cr><Esc>")
map("n", "<C-c>", "<cmd>nohlsearch<cr><C-c>", { silent = true })
map("n", "J", "mzJ'z", { desc = "Join and keep position" })

--================== Window Navigation ====================
map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
map("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to Left Window" })
map("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to Lower Window" })
map("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to Upper Window" })
map("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to Right Window" })
map("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })

--================== Insert Navigation ====================
map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
map("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to Left Window" })
map("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to Lower Window" })
map("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to Upper Window" })
map("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to Right Window" })
map("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })

map("i", "<C-l>", "<End>", { noremap = true })
map("i", "<C-h>", "<Home>", { noremap = true })
map("i", "<C-e>", "<End>", { noremap = true, nowait = true })

--================== Commandline Navigation ====================
map({ "c", "i" }, "<C-a>", "<Home>")
map("c", "<C-e>", "<End>")
map("c", "<C-n>", "<Down>")
map("c", "<C-p>", "<Up>")
map("c", "<C-x>", "<C-f><Esc>?")
cmap(":", "lua ")
map({ "c" }, "<C-d>", "<C-right>")
map({ "c" }, "<C-s>", "<C-left>")
vim.cmd.cabbr({ args = { "<expr>", "%%", "expand(%:p:h)" } })

--================== Quickfix Navigation ====================
vim.keymap.set("n", "<C-n>", "<cmd>cnext<cr>", { desc = "Quickfix Next" })
vim.keymap.set("n", "<C-y>", "<cmd>cprev<cr>", { desc = "Quickfix Last" })

--================== Grep ====================
map("n", "<C-g>", ":Grep ", { desc = "Start grep", silent = false })

--================== Paste ====================
map("n", "<C-p>", function()
  local pos = vim.api.nvim_win_get_cursor(0)
  vim.cmd("norm gmm")
  pos[1] = pos[1] + 1
  vim.api.nvim_win_set_cursor(0, pos)
end)

map("n", "-", function() require("mini.files").open() end, { desc = "File directory" })

map(
  { "x", "v" },
  "gf",
  function() require("comform").format({ lsp_fallback = false }) end,
  { desc = "Format current selection" }
)

--================== Paste ====================
map("o", "o", function()
  local operator = vim.v.operator
  if operator == "d" then
    local scope = MiniIndentscope.get_scope()
    local top = scope.border.top
    local bottom = scope.border.bottom
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local move = ""
    if row == bottom then
      move = "k"
    elseif row == top then
      move = "j"
    end
    local ns = vim.api.nvim_create_namespace("border")
    vim.api.nvim_buf_add_highlight(0, ns, "Substitute", top - 1, 0, -1)
    vim.api.nvim_buf_add_highlight(0, ns, "Substitute", bottom - 1, 0, -1)
    vim.defer_fn(function()
      vim.api.nvim_buf_set_text(0, top - 1, 0, top - 1, -1, {})
      vim.api.nvim_buf_set_text(0, bottom - 1, 0, bottom - 1, -1, {})
      vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
    end, 150)
    return "<esc>" .. move
  else
    return "o"
  end
end, { expr = true })

--- Dev stuff
map({ "n", "v", "c", "t", "x" }, "<F2>", function()
  MiniNotify.clear()
  local name = vim.ui.input({
    prompt = "Name: ",
  }, function(selection)
    if not selection then return end
    local outfile = selection .. ".png"
    vim.system({
      "pwsh.exe",
      "-NoProfile",
      "-NonInteractive",
      "-Command",
      vim.fs.joinpath(vim.fn.expand("~"), ".common", "termshot.ps1"),
      outfile,
    })
  end)
end)
