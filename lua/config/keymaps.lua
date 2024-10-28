local function opts(desc, silent, options)
	silent = silent or false
	options = options or {}
	options.desc = desc or ""
	options.silent = silent
	return options
end

local map = vim.keymap.set
map("n", "<Esc>", "<cmd>nohlsearch<cr><Esc>")
map("n", "<C-c>", "<cmd>nohlsearch<cr><C-c>", { silent = true })

vim.api.nvim_set_keymap("i", "<C-c>", "<Esc>", opts("escape insert mode", true, { noremap = true }))

map({ "n", "v" }, "<leader>y", '"+y', opts("copy to clipboard", true))
map({ "n", "v" }, "<leader>yy", '"+yy', opts("copy to clipboard", true))
--Paste from Keyboard
map({ "n", "v" }, "<leader>ps", '"+p', opts("paste from clipboard", true))
map({ "n", "v" }, "<leader>P", '"+P', opts("paste from clipboard", true))

map("n", "<leader>vs", "<CMD>vsplit<CR>", opts("vertical split", true))
map("n", "<leader>vh", "<CMD>split<CR>", opts("horizontal split", true))
map("n", "<leader>vn", "<CMD>vnew<CR>", opts("horizontal split", true))
map("n", "<leader>nh", "<CMD>noh<CR>", opts("remove highlights", true))

map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
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
map("c", "<C-x>", "<C-f><Esc>?")
map({ "c", "i" }, "<C-d>", "<C-right>")
map({ "c", "i" }, "<C-s>", "<C-left>")

map("n", "<localleader>n", "<cmd>tabnext<cr>", { desc = "Next tab" })
map("n", "<localleader>b", "<cmd>tabprev<cr>", { desc = "Previous tab" })

map("n", "gb", "<cmd>ls<cr>:b ", { desc = "select buffer" })

map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>o", "<cmd>tabonly<cr>", { desc = "Close Other Tabs" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
map("n", "<leader>bad", "<cmd>%bd|e#<cr>", { desc = "Delete all buffers" })

map("n", "<leader>cp", function()
	local args = vim.fn.input({
		prompt = "Compile > ",
		default = (vim.g.last_compile_command or ""),
	})
	vim.g.last_compile_command = args
	vim.cmd("tab term " .. args)
end, { desc = "Open compile in terminal " })

map("n", "<leader>mp", function()
	local args = vim.fn.input({
		prompt = "Compile > " .. vim.o.makeprg .. " ",
		default = (vim.g.last_make_command or ""),
	})
	vim.g.last_make_command = args
	vim.cmd("make " .. (vim.g.last_make_command or ""))
end)

map("n", "<leader>ma", function()
	if not vim.g.last_make_command or vim.g.last_make_command == "" then
		local args = vim.fn.input({
			prompt = "Compile > " .. vim.o.makeprg .. " ",
			default = (vim.g.last_make_command or ""),
		})
		vim.g.last_make_command = args
	end
	vim.cmd("make " .. (vim.g.last_make_command or ""))
end)

vim.keymap.set("n", "<C-n>", "<cmd>cnext<cr>")
vim.keymap.set("n", "<C-y>", "<cmd>cprev<cr>")

map("n", "<localleader>tc", function()
	vim.cmd.new()
	vim.cmd.wincmd("j")
	vim.api.nvim_win_set_height(0, 12)
	vim.wo.winfixheight = true
	vim.cmd.term("cmd.exe")
end, { desc = "Open cmd (split)" })

map("n", "<localleader>tp", function()
	vim.cmd.new()
	vim.cmd.wincmd("j")
	vim.api.nvim_win_set_height(0, 12)
	vim.wo.winfixheight = true
	vim.cmd.term(vim.o.shell)
end, { desc = "Open pwsh (split)" })
