local function save_key()
	return vim.loop.cwd
end
local function save_path()
	return vim.fn.stdpath("cache") .. "/arrow"
end
-- FIX: Breaks on Windows Here
local function normalize(path)
	print(path)
	if vim.fn.has("win32") == 1 then
		return path:gsub("\\", "_")
	end
	-- print("normalized: " .. path:gsub("\\", "_"))
	return path:gsub("/", "_")
end

local function handle_save_key()
	return normalize(save_key()())
end

local save_p = save_path()
save_p = save_p:gsub("/$", "")
-- save_p = vim.fn.fnamemodify(save_p, ":p:h")
print("modified: " .. save_p)

print("save_p: " .. save_p .. "/" .. handle_save_key())
