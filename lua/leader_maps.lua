local function map_leader(modes, suffix, rhs, desc, opts)
	opts = opts or {}
	opts.desc = desc
	vim.keymap.set(modes, "<leader>" .. suffix, rhs, opts)
end

Config.leader_groups = {
	{ mode = "n", keys = "<Leader>b", desc = "+Buffer" },
	{ mode = "n", keys = "<Leader>e", desc = "+Explore" },
	{ mode = "n", keys = "<Leader>f", desc = "+Find" },
	{ mode = "n", keys = "<Leader>g", desc = "+Git" },
	{ mode = "n", keys = "<Leader>l", desc = "+LSP" },
	{ mode = "n", keys = "<Leader>L", desc = "+Lua" },
	{ mode = "n", keys = "<Leader>o", desc = "+Other" },
	{ mode = "n", keys = "<Leader>t", desc = "+Terminal/Minitest" },
	-- { mode = 'n', keys = '<Leader>T', desc = '+Test' },
	{ mode = "n", keys = "<Leader>v", desc = "+Visits" },
	{ mode = "x", keys = "<Leader>l", desc = "+LSP" },
	-- { mode = 'x', keys = '<Leader>r', desc = '+R' },
}

--================== Y (yank) ====================
map_leader({ "n", "v" }, "y", '"+y', "Copy motion to Clipboard")
map_leader({ "n", "v" }, "yy", '"+yy', "Copy line to Clipboard")

--================== P (paste) ====================
map_leader({ "n", "v" }, "ps", '"+p', "Paste from clipboard")
map_leader({ "n", "v" }, "P", '"+P', "Paste from clipboard")

--================== w (window) ====================
map_leader("n", "ws", "<cmd>vsplit<cr>", "Vertical Split")
map_leader("n", "wh", "<cmd>split<cr>", "horizontal Split")

--================== <tab> (Tabs) ====================
map_leader("n", "<tab>n", "<cmd>tabnext<cr>", "Next Tab")
map_leader("n", "<tab>b", "<cmd>tabprevious<cr>", "Previous Tab")
map_leader("n", "<tab>o", "<cmd>tabonly<cr>", "Close other Tabs")
map_leader("n", "<tab>f", "<cmd>tabfirst<cr>", "First Tab")
map_leader("n", "<tab>l", "<cmd>tablast<cr>", "Last Tab")

--================== <tab> (Tabs) ====================
map_leader("n", "ba", "<Cmd>b#<CR>", "Alternate")
map_leader("n", "bd", "<Cmd>lua MiniBufremove.delete()<CR>", "Delete")
map_leader("n", "bD", "<Cmd>lua MiniBufremove.delete(0, true)<CR>", "Delete!")
-- map_leader("n", 'bs', '<Cmd>lua Config.new_scratch_buffer()<CR>', 'Scratch')
map_leader("n", "bw", "<Cmd>lua MiniBufremove.wipeout()<CR>", "Wipeout")
map_leader("n", "bW", "<Cmd>lua MiniBufremove.wipeout(0, true)<CR>", "Wipeout!")

--================== ! (Async/Important) ====================
map_leader("n", "!s", ":Shell ", "Shell Command", { silent = false })

--================== Search ====================
--File search (f)
map_leader("n", "sff", ":Grep %<left><left><space>", "Grep current file")
map_leader("n", "sfw", "<cmd>Grep <cword> %<cr>", "Grep current word in file")

map_leader("n", "sw", "<cmd>Grep <cword><cr>", "Grep current word")

--================== Find ====================
map_leader("n", "f/", '<Cmd>Pick history scope="/"<CR>', '"/" history')
map_leader("n", "f:", '<Cmd>Pick history scope=":"<CR>', '":" history')
map_leader("n", "fa", '<Cmd>Pick git_hunks scope="staged"<CR>', "Added hunks (all)")
map_leader("n", "fA", '<Cmd>Pick git_hunks path="%" scope="staged"<CR>', "Added hunks (current)")
map_leader("n", "fb", "<Cmd>Pick buffers<CR>", "Buffers")
map_leader("n", "fc", "<Cmd>Pick git_commits<CR>", "Commits (all)")
map_leader("n", "fC", '<Cmd>Pick git_commits path="%"<CR>', "Commits (current)")
map_leader("n", "fd", '<Cmd>Pick diagnostic scope="all"<CR>', "Diagnostic workspace")
map_leader("n", "fD", '<Cmd>Pick diagnostic scope="current"<CR>', "Diagnostic buffer")
map_leader("n", "ff", "<Cmd>Pick files<CR>", "Files")
map_leader("n", "fg", "<Cmd>Pick grep_live<CR>", "Grep live")
map_leader("n", "fG", '<Cmd>Pick grep pattern="<cword>"<CR>', "Grep current word")
map_leader("n", "fh", "<Cmd>Pick help<CR>", "Help tags")
map_leader("n", "fH", "<Cmd>Pick hl_groups<CR>", "Highlight groups")
map_leader("n", "fl", '<Cmd>Pick buf_lines scope="all"<CR>', "Lines (all)")
map_leader("n", "fL", '<Cmd>Pick buf_lines scope="current"<CR>', "Lines (current)")
map_leader("n", "fm", "<Cmd>Pick git_hunks<CR>", "Modified hunks (all)")
map_leader("n", "fM", '<Cmd>Pick git_hunks path="%"<CR>', "Modified hunks (current)")
map_leader("n", "fr", "<Cmd>Pick resume<CR>", "Resume")
map_leader("n", "fp", "<Cmd>Pick projects<CR>", "Projects")
map_leader("n", "fR", '<Cmd>Pick lsp scope="references"<CR>', "References (LSP)")
map_leader("n", "fs", '<Cmd>Pick lsp scope="workspace_symbol"<CR>', "Symbols workspace (LSP)")
map_leader("n", "fS", '<Cmd>Pick lsp scope="document_symbol"<CR>', "Symbols buffer (LSP)")
map_leader("n", "fv", '<Cmd>Pick visit_paths cwd="" preserve_order=true<CR>', "Visit paths (all)")
map_leader("n", "fV", "<Cmd>Pick visit_paths preserve_order=true<CR>", "Visit paths (cwd)")

--================== LSP (l) ====================
map_leader("n", "lf", function()
	require("conform").format({ lsp_fallback = true })
end, "Format Buffer")

--================== Git (g) ====================
local git_log_cmd = [[Git log --pretty=format:\%h\ \%as\ │\ \%s --topo-order]]
map_leader("n", "ga", "<Cmd>Git diff --cached<CR>", "Added diff")
map_leader("n", "gA", "<Cmd>Git diff --cached -- %<CR>", "Added diff buffer")
map_leader("n", "gc", "<Cmd>Git commit<CR>", "Commit")
map_leader("n", "gC", "<Cmd>Git commit --amend<CR>", "Commit amend")
map_leader("n", "gd", "<Cmd>Git diff<CR>", "Diff")
map_leader("n", "gD", "<Cmd>Git diff -- %<CR>", "Diff buffer")
map_leader("n", "gg", "<Cmd>lua Config.open_lazygit()<CR>", "Git tab")
map_leader("n", "gl", "<Cmd>" .. git_log_cmd .. "<CR>", "Log")
map_leader("n", "gL", "<Cmd>" .. git_log_cmd .. " --follow -- %<CR>", "Log buffer")
map_leader("n", "go", "<Cmd>lua MiniDiff.toggle_overlay()<CR>", "Toggle overlay")
map_leader("n", "gs", "<Cmd>lua MiniGit.show_at_cursor()<CR>", "Show at cursor")

map_leader("x", "gs", "<Cmd>lua MiniGit.show_at_cursor()<CR>", "Show at selection")

local function cx_leader(modes, suffix, rhs, desc, opts)
	opts = opts or {}
	opts.desc = desc
	vim.keymap.set(modes, "<C-x>" .. suffix, rhs, opts)
end

--================== C-x (emacs) ====================
cx_leader("n", "<C-f>", function()
	Config.explorer()
end, "File Explorer")
cx_leader("n", "b", "<cmd>Pick buffers<cr>", "Pick Buffers")
cx_leader("n", "1", function()
	require("mini.misc").zoom()
end, "Only Buffer")

map_leader("n", "e", function()
	require("mini.files").open(vim.api.nvim_buf_get_name(0))
end, "File directory")