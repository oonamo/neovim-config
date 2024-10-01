require("mini.sessions").setup({
	autowrite = true,
	force = { read = false, write = true, delete = true },
})

if vim.bo.ft == "ministarter" then
	require("mini.starter").refresh()
end

Config.sessions_aliases = {
	["Local_nvim"] = "config",
}

Config.important_dirs = {
	["DB"] = "",
	["projects"] = "",
	["onam7"] = "",
	["Local"] = "",
	["Roaming"] = "",
	["AppData"] = "",
}

---Gets the tail and cwd
---@return string tail
---@return string cwd
local function get_cwd_head()
	local cwd = vim.uv.cwd()
	local tail = vim.fn.fnamemodify(cwd, ":gs?\\?_?"):sub(3)
	local modifers = ":p:h"
	local dir = vim.fn.fnamemodify(cwd, ":p:h"):match(".*\\(.*)")
	local sessionBuilder = dir
	local depth = 0
	while not Config.important_dirs[dir] and depth < 5 do
		modifers = modifers .. ":h"
		dir = vim.fn.fnamemodify(cwd, modifers):match(".*\\(.*)")
		sessionBuilder = dir .. "_" .. sessionBuilder
	end
	return sessionBuilder, cwd
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
