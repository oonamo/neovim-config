local M = {}
M.loaded = {}
M.ft = {}
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

function M.load(spec, opts)
	return function()
		opts = opts or {}
		local slash = string.find(spec, "/[^/]*$") or 0
		local is_vim_plug = string.find(spec, "%.vim") or 0
		local name = opts.init or string.sub(spec, slash + 1)
		if slash ~= 0 then
			add(vim.tbl_deep_extend("force", { source = spec }, opts.add or {}))
		end
		if is_vim_plug ~= 0 or opts.no_setup then
			if opts.init then
				require(opts.init)
				table.insert(M.loaded, spec)
			end
			return
		end
		local req_name = string.gsub(name, ".nvim", "")
		local plug = require(opts.as or req_name)
		if opts.setup then
			plug.setup(opts.setup)
		end
		table.insert(M.loaded, spec)
	end
end

function M.cmd(command)
	return function()
		vim.cmd(command)
	end
end

function M.on_key(key, spec, opts)
	vim.keymap.set(key[1], key[2], function()
		now(function()
			vim.keymap.del(key[1], key[2], { desc = key.desc })
			M.load(spec, opts)() -- Should load plugin keymaps
			-- vim.keymap.set(key[1], key[2], key[3], { desc = key.dec })
			vim.api.nvim_input(vim.api.nvim_replace_termcodes(key[2], true, true, true))
		end)
	end, { desc = key.desc })
end

return M
