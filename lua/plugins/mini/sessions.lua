require("mini.sessions").setup()

function Config._sessions_complete(arg_lead)
	return vim.tbl_filter(function(v)
		return v:find(arg_lead, 1, true) ~= nil
	end, vim.tbl_keys(MiniSessions.detached))
end

local function get_session_from_user(prompt)
	local completion = "customlist,v:lua.Config._session_complete"
	local ok, res = pcall(vim.fn.input, {
		prompt = prompt,
		cancelreturn = false,
		completion = completion,
	})
	if not ok or res == false then
		return nil
	end
	return res
end

local function delete()
	local res = get_session_from_user("Delete session: ")
	if res ~= nil then
		MiniSessions.delete(res, { force = true })
	end
end

local function save()
	local res = get_session_from_user("Save session as: ")
	if res ~= nil then
		MiniSessions.write(res)
	end
end

vim.keymap.set("n", "<leader>ss", save, { desc = "save sessions" })
vim.keymap.set("n", "<leader>sd", delete, { desc = "save sessions" })
vim.keymap.set("n", "<leader>ms", MiniSessions.select, { desc = "select session" })
