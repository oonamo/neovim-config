local function opts(desc, silent, options)
	silent = silent or false
	options = options or {}
	options.desc = desc or ""
	options.silent = silent
	return options
end

local map = vim.keymap.set

map("n", "L", "$", { silent = true })
map("n", "H", "^", { silent = true })

-- center screen
-- map("n", "<C-d>", "<C-d>zz", opts("smooth scroll down", true, { noremap = true }))
-- map("n", "<C-u>", "<C-u>zz", opts("smooth scroll up", true, { noremap = true }))
map("n", "n", "nzzzv", opts("smooth search down", true, { noremap = true }))
map("n", "N", "Nzzzv", opts("smooth search up", true, { noremap = true }))
map("n", "%", "%zz", opts("smooth match", true, { noremap = true }))
map("n", "*", "*zz", opts("smooth search up", true, { noremap = true }))
map("n", "N", "#zz", opts("smooth search up", true, { noremap = true }))

vim.api.nvim_set_keymap("i", "<C-c>", "<Esc>", opts("escape insert mode", true, { noremap = true }))

--Set Copy and Paste
--Copy to Keyboard
map({ "n", "v" }, "<leader>y", '"+y', opts("copy to clipboard", true))
map({ "n", "v" }, "<leader>yy", '"+yy', opts("copy to clipboard", true))
--Paste from Keyboard
map({ "n", "v" }, "<leader>ps", '"+p', opts("paste from clipboard", true))
map({ "n", "v" }, "<leader>P", '"+P', opts("paste from clipboard", true))
-- Search and Replace
map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], opts("search and replace"))

-- window options
map("n", "<leader>vs", "<CMD>vsplit<CR>", opts("vertical split", true))
map("n", "<leader>vh", "<CMD>split<CR>", opts("horizontal split", true))
map("n", "<leader>vn", "<CMD>vnew<CR>", opts("horizontal split", true))

map("n", "<leader>nh", "<CMD>noh<CR>", opts("remove highlights", true))

-- move in wezterm
map("n", "<C-;>", function()
	local command = { "wezterm", "cli", "activate-pane-direction", "Down" }
	return vim.fn.system(command)
end, opts("open wezterm split", true))

-- Terminal
map("n", "<leader>gl", function()
	if not package.loaded["mini.git"] then
		require("mini.git").setup()
	end
	local cwd = require("mini.git").get_buf_data(0)
	if cwd == nil then
		return
	end
	require("onam.float_term").float_term("lazygit", {
		size = { width = 0.85, height = 0.8 },
		cwd = cwd.root or "",
	})
end, opts("open lazygit float", true))

map("n", "<leader>ft", function()
	local root = utils.get_path_root(vim.api.nvim_buf_get_name(0))
	require("onam.float_term").float_term(nil, { cwd = root })
end, { desc = "Terminal (Root Dir)" })
map("n", "<leader>fT", function()
	require("onam.float_term").float_term(nil, {})
end, { desc = "Terminal (Root Dir)" })

map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
map("n", "<localleader>t", function()
	vim.cmd.new()
	vim.cmd.wincmd("j")
	vim.api.nvim_win_set_height(0, 12)
	vim.wo.winfixheight = true
	vim.cmd.term()
end)

map("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to Left Window" })
map("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to Lower Window" })
map("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to Upper Window" })
map("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to Right Window" })
map("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })

-- COMMAND LINE BINDINGS
map({ "c", "i" }, "<C-h>", "<Home>")
map({ "c", "i" }, "<C-l>", "<End>")
map("c", "<C-n>", "<Down>")
map("c", "<C-p>", "<Up>")
map("c", "<C-x>", "<C-f>?")

-- Lua binds
map("n", "<leader>Lcc", function()
	require("colors.picker").pick_color()
end)
