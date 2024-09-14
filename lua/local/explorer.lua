local function explorer_sort(items)
	-- Sort ignoring case
	local res = vim.tbl_map(function(x)
      --stylua: ignore
      return {
        fs_type = x.fs_type, path = x.path, text = x.text,
        is_dir = x.fs_type == 'directory', lower_name = x.text:lower(),
      }
	end, items)

	local compare = function(a, b)
		-- Put directory first
		if a.is_dir and not b.is_dir then
			return true
		end
		if not a.is_dir and b.is_dir then
			return false
		end

		-- Otherwise order alphabetically ignoring case
		return a.lower_name < b.lower_name
	end

	table.sort(res, compare)

	return vim.tbl_map(function(x)
		return { fs_type = x.fs_type, path = x.path, text = x.text }
	end, res)
end

local function items(path, filter, sort)
	if vim.fn.isdirectory(path) == 0 then
		return {}
	end
	local res = { { fs_type = "directory", path = vim.fn.fnamemodify(path, ":h"), text = ".." } }
	for _, basename in ipairs(vim.fn.readdir(path)) do
		local subpath = string.format("%s/%s", path, basename)
		local fs_type = vim.fn.isdirectory(subpath) == 1 and "directory" or "file"
		table.insert(
			res,
			{ fs_type = fs_type, path = subpath, text = basename .. (fs_type == "directory" and "/" or "") }
		)
	end

	return sort(vim.tbl_filter(filter, res))
end

local _items = items(vim.fn.getcwd(), function()
	return true
end, explorer_sort)
vim.print(_items)
