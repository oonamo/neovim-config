local function opts(desc, silent, options)
	silent = silent or false
	options = options or {}
	options.desc = desc or ""
	options.silent = silent
	return options
end

local map = vim.keymap.set
local function map_toggle(lhs, rhs, desc)
	map("n", "\\" .. lhs, rhs, { desc = desc })
end

local function nmap_leader(lhs, rhs, desc) end

map_toggle("b", '<Cmd>lua vim.o.bg = vim.o.bg == "dark" and "light" or "dark"<CR>', "Toggle 'background'")
map_toggle("c", "<Cmd>setlocal cursorline!<CR>", "Toggle 'cursorline'")
map_toggle("C", "<Cmd>setlocal cursorcolumn!<CR>", "Toggle 'cursorcolumn'")

map_toggle("d", function()
	require("mini.basics").toggle_diagnostic()
end, "Toggle diagnostic")

map_toggle("h", "<Cmd>let v:hlsearch = 1 - v:hlsearch<CR>", "Toggle search highlight")
map_toggle("i", "<Cmd>setlocal ignorecase!<CR>", "Toggle 'ignorecase'")
map_toggle("l", "<Cmd>setlocal list!<CR>", "Toggle 'list'")
map_toggle("n", "<Cmd>setlocal number!<CR>", "Toggle 'number'")
map_toggle("r", "<Cmd>setlocal relativenumber!<CR>", "Toggle 'relativenumber'")
map_toggle("s", "<Cmd>setlocal spell!<CR>", "Toggle 'spell'")
map_toggle("w", "<Cmd>setlocal wrap!<CR>", "Toggle 'wrap'")

map({ "x", "v" }, "<leader>pp", [["_dP]], { noremap = true })
map({ "n", "x", "v" }, "<leader>d", [["_d]], { noremap = true })
-- map("n", "<C-H>", "<C-w>h", { desc = "Focus on left window" })
-- map("n", "<C-J>", "<C-w>j", { desc = "Focus on below window" })
-- map("n", "<C-K>", "<C-w>k", { desc = "Focus on above window" })
-- map("n", "<C-L>", "<C-w>l", { desc = "Focus on right window" })

map("n", "<Esc>", "<cmd>nohlsearch<cr><Esc>")
map("n", "<C-c>", "<cmd>nohlsearch<cr><C-c>", { silent = true })
map("n", "J", "mzJ'z", opts("Join and keep position"))
map(
	"n",
	"<C-Left>",
	'"<Cmd>vertical resize -" . v:count1 . "<CR>"',
	{ expr = true, replace_keycodes = false, desc = "Decrease window width" }
)
map(
	"n",
	"<C-Down>",
	'"<Cmd>resize -"          . v:count1 . "<CR>"',
	{ expr = true, replace_keycodes = false, desc = "Decrease window height" }
)
map(
	"n",
	"<C-Up>",
	'"<Cmd>resize +"          . v:count1 . "<CR>"',
	{ expr = true, replace_keycodes = false, desc = "Increase window height" }
)
map(
	"n",
	"<C-Right>",
	'"<Cmd>vertical resize +" . v:count1 . "<CR>"',
	{ expr = true, replace_keycodes = false, desc = "Increase window width" }
)

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

map("i", "<C-l>", "<End>", { noremap = true })
map("i", "<C-h>", "<Home>", { noremap = true })
map("i", "<C-e>", "<End>", { noremap = true, nowait = true })

-- COMMAND LINE BINDINGS
map({ "c", "i" }, "<C-a>", "<Home>")
map("c", "<C-e>", "<End>")
map("c", "<C-n>", "<Down>")
map("c", "<C-p>", "<Up>")
map("c", "<C-x>", "<C-f><Esc>?")
map({ "c", "i" }, "<C-d>", "<C-right>")
map({ "c", "i" }, "<C-s>", "<C-left>")

map("n", "<localleader>n", "<cmd>tabnext<cr>", { desc = "Next tab" })
map("n", "<localleader>b", "<cmd>tabprev<cr>", { desc = "Previous tab" })

-- Use snipe.nvim
-- map("n", "gb", "<cmd>ls<cr>:b ", { desc = "select buffer" })

map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>o", "<cmd>tabonly<cr>", { desc = "Close Other Tabs" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
map("n", "<leader>bad", "<cmd>%bd|e#<cr>", { desc = "Delete all buffers" })

-- map("n", "<leader>mp", function()
-- 	local args = vim.fn.input({
-- 		prompt = "Compile> " .. vim.o.makeprg .. " ",
-- 		default = (vim.g.last_make_command or ""),
-- 	})
-- 	vim.g.last_make_command = args
-- 	vim.cmd("make " .. (vim.g.last_make_command or ""))
-- end)

-- map("n", "<leader>ma", function()
-- 	if not vim.g.last_make_command or vim.g.last_make_command == "" then
-- 		local args = vim.fn.input({
-- 			prompt = "Compile> " .. vim.o.makeprg .. " ",
-- 			default = (vim.g.last_make_command or ""),
-- 		})
-- 		vim.g.last_make_command = args
-- 	end
-- 	vim.cmd("make " .. (vim.g.last_make_command or ""))
-- end)

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

local function async_grep(args)
	local cmd, num_subs = vim.o.grepprg:gsub("%$%*", args)
	if num_subs == 0 then
		cmd = cmd .. " " .. args
	end
	local expanded_cmd = vim.fn.expandcmd(cmd)
	local sys_cmd = vim.iter(vim.split(expanded_cmd, " ", { trimempty = true }))
		:filter(function(item)
			return item:len() ~= 0
		end)
		:totable()

	vim.fn.setqflist({})

	vim.system(sys_cmd, {
		stdout = vim.schedule_wrap(function(err, data)
			if err then
				vim.notify("Error grepping: '" .. vim.inspect(err) .. "'", vim.log.levels.ERROR, { title = "Grep" })
				return
			end
			if data ~= nil then
				vim.fn.setqflist({}, "a", {
					lines = vim.split(data, platform_specific.lineending, { trimempty = true }),
					efm = vim.o.grepformat,
				})
			end
			vim.cmd.redraw()
		end),
		text = true,
	})

	vim.cmd.copen()
end

vim.api.nvim_create_user_command("Grep", function(c)
	async_grep(c.args)
end, { nargs = "*", bang = true, complete = "file" })

local function async_make(args)
	local sep = package.config:sub(1, 1)
	local make_prg = vim.opt.makeprg:get()
	local expanded_cmd = vim.fn.expandcmd(make_prg)

	for _, arg in ipairs(args.fargs) do
		if arg == "~" then
			arg = vim.uv.os_homedir()
		end
		expanded_cmd = expanded_cmd .. " " .. arg
	end

	if sep == "\\" then
		expanded_cmd = expanded_cmd:gsub("/", "\\")
	end

	local make_cmd = { "cmd.exe", "/c", expanded_cmd }

	vim.fn.setqflist({})

	local output_handler = vim.schedule_wrap(function(err, data)
		if data ~= nil then
			vim.fn.setqflist({}, "a", {
				lines = vim.split(data, platform_specific.lineending, { trimempty = true }),
				efm = vim.opt.errorformat:get(),
			})
		end
		vim.cmd.redraw()
	end)

	vim.print(make_cmd)
	vim.system(make_cmd, {
		stdout = output_handler,
		stderr = output_handler,
	})

	vim.cmd.copen()
end

map("n", "<leader>!", ":Shell ", { desc = "Start Make", silent = false })
map("n", "<C-g>", ":Grep ", { desc = "Start grep" })
map("n", "<leader>sff", ":Grep %<left><left><space>", { desc = "Grep current file" })
map("n", "<leader>sfw", "<cmd>Grep <cword> % <cr>", { desc = "Grep current file" })
map("n", "<leader>sw", "<cmd>Grep <cword><cr>", { desc = "Start grep" })

map("n", "<C-p>", function()
	local pos = vim.api.nvim_win_get_cursor(0)
	vim.cmd("norm yyp")
	pos[1] = pos[1] + 1
	vim.api.nvim_win_set_cursor(0, pos)
end)

require("config.utils").wezterm()
map("n", "<leader>:", "<cmd>Pick history scope='/'<cr>", { desc = "Find commands"})
