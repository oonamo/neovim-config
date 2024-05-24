local M = {}

function M.getFileName()
	local name = vim.fn.expand("%:t")
	return name
end

function M.spacebar(winid)
	local name = vim.fn.expand("%:t")
	return string.rep(" ", math.ceil(vim.fn.winwidth(winid) / 2) - math.ceil(string.len(name) / 2) - 3)
end

local Winbar = {
	-- condition = function()
	-- 	if vim.bo.filetype == "markdown" then
	-- 		return true
	-- 	end
	-- 	return false
	-- end,
	init = function(self)
		self.filename = vim.fn.expand("%:t")
	end,
	provider = function(self)
		local space = M.spacebar(0)
		return space .. "( " .. self.filename .. " )" .. space
	end,
}

return Winbar
