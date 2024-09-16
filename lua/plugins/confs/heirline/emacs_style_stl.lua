local Git = {
	condition = function()
		return vim.b.minigit_summary ~= nil and vim.b.minigit_summary.head_name ~= nil
	end,
	init = function(self)
		self.status = vim.b.minigit_summary or {}
		if vim.b.minidiff_summary and vim.b.minidiff_summary.add then
			self.changes = vim.b.minidiff_summary
		else
			self.changes = {
				add = 0,
				change = 0,
				delete = 0,
			}
		end
	end,
	{
		provider = function(self)
			return (self.status.head_name or "") .. " "
		end,
		hl = { fg = "change", bold = true },
	},
	{
		condition = function(self)
			return self.changes.add ~= nil
		end,
		provide = "[",
	},
	{
		provider = function(self)
			if self.changes.add > 0 then
				return self.changes.add
			end
			return ""
		end,
		hl = { fg = "add" },
	},
	{
		provider = function(self)
			return self.changes.change
		end,
		hl = { fg = "change" },
	},
	{
		provider = function(self)
			if self.changes.delete > 0 then
				return self.changes.delete
			end
			return ""
		end,
		hl = { fg = "del" },
	},
	{
		condition = function(self)
			return self.changes.add ~= nil
		end,
		provide = "]",
	},
}
