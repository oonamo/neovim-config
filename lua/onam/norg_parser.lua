local uv = vim.loop
local function match_todos()
	local bufnr = vim.api.nvim_get_current_buf()
	local tree = vim.treesitter.get_parser()

	if tree == nil then
		print("No parser for norg")
		return
	end
	local syntax_tree = tree:parse()
	local root = syntax_tree[1]:root()
	local query = vim.treesitter.query.parse(
		"norg",
		[[
    state: (detached_modifier_extension) @state
 ]]
		-- content: (paragraph) @content
	)

	local tasks = {}
	for id, match, _ in query:iter_matches(root, bufnr) do
		local name = query.captures[id]
		local task = {}
		for k, v in pairs(match) do
			if name == "state" then
				task.state = vim.treesitter.get_node_text(v, bufnr)
				local next_sibling = v:next_sibling()
				local r1, c1, r2, c2 = next_sibling:range()
				task.content = vim.treesitter.get_node_text(next_sibling, bufnr)
				if r1 > r2 then
					task.row = r1
				else
					task.row = r2
				end

				if c1 > c2 then
					task.col = c1
				else
					task.col = c2
				end
			end
		end
		if task.state ~= nil and task.content ~= nil then
			task.as_string = task.row .. "/" .. task.col .. ": " .. task.state .. " " .. task.content
			table.insert(tasks, task)
		end
	end
	vim.ui.select(tasks, {
		prompt = "Pick a task",
		format_item = function(item)
			return item.as_string
		end,
	}, function(item)
		if item == nil then
			return
		end
		vim.api.nvim_win_set_cursor(0, { item.row, item.col })
	end)
end

local function tempname()
	local tmpname = vim.fn.tempname()
	local parent = vim.fn.fnamemodify(tmpname, ":h")
	-- parent must exist for `mkfifo` to succeed
	-- if the neovim temp dir was deleted or the
	-- tempname already exists, we use 'os.tmpname'
	if not uv.fs_stat(parent) or uv.fs_stat(tmpname) then
		tmpname = os.tmpname()
		-- 'os.tmpname' touches the file which
		-- will also fail `mkfifo`, delete it
		vim.fn.delete(tmpname)
	end
	return tmpname
end

local function populate_todos()
	local cmd = "rg"
	local cmd_args = {
		-- '"\\s+[-] ((.*))(.*)"',
		'"\\s+[-] ((.*))(.*)"',
		"-g",
		"*.norg",
		"-r",
		'"$1 $2"',
		"--hidden",
		"--no-heading",
		"--color=never",
		"C:\\Users\\onam7\\Documents\\School",
	}
	-- local args_as_str = "s+[-] ((.*))(.*) -g *.norg -r $1 $2 C:\\Users\\onam7\\Documents\\School\\spring2024"

	local stdout = uv.new_pipe()
	local stderr = uv.new_pipe()
	local options = {
		args = cmd_args,
		stdio = { nil, stdout, stderr },
		-- verbatim = true,
	}

	local handle
	local on_exit = function(code)
		uv.read_stop(stdout)
		uv.close(stdout)
		uv.close(handle)
		print("norg exited with code " .. code)
	end

	handle = uv.spawn("rg", {
		stdio = { nil, stdout, stderr },
		args = {
			-- '"\\s+[-] \\((.*)\\)(.*)"',
			'"\\s+[-] \\(.*\\).*"',
			"-g",
			"*.norg",
			"-r",
			'"$1 $2"',
			-- "--hidden",
			"--no-heading",
			"--column",
			"--color=never",
			"C:\\Users\\onam7\\Documents\\School\\spring2024",
		},
		cwd = "C:\\Users\\onam7\\Documents\\School",
		verbatim = true,
	}, on_exit)
	print("proccess started")
	-- handle = uv.spawn("ls", {}, on_exit)
	uv.read_start(stdout, function(err, data)
		if err then
			print(err)
		end
		if data then
			vim.print(data)
		end
	end)
	uv.read_start(stderr, function(err, chunk)
		if err then
			print(err)
		end
		if chunk then
			print(chunk)
		end
	end)
end

populate_todos()

vim.keymap.set("n", "<leader>mt", function()
	-- match_todos()
	populate_todos()
end)
