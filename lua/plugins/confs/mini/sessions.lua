require("mini.sessions").setup({
	autowrite = true,
	force = { read = false, write = true, delete = true },
})

if vim.bo.ft == "ministarter" then
	require("mini.starter").refresh()
end

Config.sessions_aliases = {
	["nvim"] = "config",
}

---Gets the tail and cwd
---@return string tail
---@return string cwd
local function get_cwd_head()
	local cwd = vim.uv.cwd()
	local tail = vim.fn.fnamemodify(cwd, ":t")
	return tail, cwd
end

---Gets the name of the session, according to the aliases
---@return string Name of session
function Config.get_session()
	local tail, cwd = get_cwd_head()
	if Config.sessions_aliases[tail] then
		return Config.sessions_aliases[tail]
	elseif Config.sessions_aliases[cwd] then
		return Config.sessions_aliases[cwd]
	end
	return tail
end
