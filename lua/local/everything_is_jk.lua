local M = {}
local keys = {
	{
		"buffer",
		k = { "[b", "bprev" },
		j = { "]b", "bnext" },
	},
	{
		"quickfix",
		k = { "[q", "cprev" },
		j = { "]q", "cnext" },
	},
}

local function get_old_jk()
	local j = {}
	local k = {}
	for _, v in ipairs(vim.api.nvim_get_keymap("n")) do
		if v.lhs == "j" then
			j = v
		elseif v.lhs == "k" then
			k = v
		end
	end
	M._j = j
	M._k = k
end

local function restore_keymaps()
	if M._j.callback or M._j.rhs then
		vim.keymap.set("n", "j", M._j.callback or M._j.rhs, {
			desc = M._j.desc,
			expr = M._j.expr == 1,
			silent = M._j.silent == 1,
			nowait = M._j.nowait == 1,
		})
	end
	if M._k.callback or M._k.rhs then
		vim.keymap.set("n", "k", M._k.callback or M._k.rhs, {
			desc = M._k.desc,
			expr = M._k.expr == 1,
			silent = M._k.silent == 1,
			nowait = M._k.nowait == 1,
		})
	end
end

local function gen_jk_func(j_f, k_f)
	return function()
		local char = vim.fn.getcharstr()
		if char == "j" then
			if j_f() then
				vim.keymap.del("n", "j")
				vim.keymap.del("n", "k")
				vim.api.nvim_input(vim.api.nvim_replace_termcodes(char, true, true, true))
				restore_keymaps()
			end
		elseif char == "k" then
			if k_f() then
				vim.keymap.del("n", "j")
				vim.keymap.del("n", "k")
				vim.api.nvim_input(vim.api.nvim_replace_termcodes(char, true, true, true))
				restore_keymaps()
			end
		else
			vim.keymap.del("n", "j")
			vim.keymap.del("n", "k")
			vim.api.nvim_input(vim.api.nvim_replace_termcodes(char, true, true, true))
			restore_keymaps()
		end
	end
end

local function exec_cmd(cmd)
	if type(cmd) == "string" then
		return pcall(vim.cmd, cmd)
	elseif type(cmd) == "function" then
		return pcall(cmd)
	else
		error("not a string or function")
	end
end

get_old_jk()

local function create_map(char, v)
	local function map(c)
		return function()
			local ok, err = exec_cmd(v[c][2])
			if ok then
				vim.api.nvim_input(vim.api.nvim_replace_termcodes(c, true, true, true))
				return false
			else
				vim.notify("error on '" .. v[1] .. "\n" .. err, vim.log.levels.WARN)
				return true
			end
		end
	end
	vim.keymap.set("n", v[char][1], function()
		local ok, err = exec_cmd(v[char][2])
		if not ok then
			vim.notify("error on '" .. v[1] .. "'\n" .. err, vim.log.levels.WARN)
			return
		end
		vim.keymap.set("n", "j", gen_jk_func(map("j"), map("k")))
		vim.keymap.set("n", "k", gen_jk_func(map("j"), map("k")))
		vim.api.nvim_input(vim.api.nvim_replace_termcodes(char, true, true, true))
	end)
end

for _, v in ipairs(keys) do
	create_map("j", v)
	create_map("k", v)
end
