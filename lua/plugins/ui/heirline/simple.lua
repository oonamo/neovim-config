local M = {}
local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
local o_tools = require("onam.utils")

M.FilePath = {
	condition = function()
		return package.loaded["incline"] == nil
	end,
	init = function(self)
		self.filename = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":p:.")
	end,
	provider = function(self)
		return tools.ui.icons.file .. " " .. self.filename
	end,
	hl = utils.get_highlight("NonText").fg,
}

M.obsidian_path = {
	init = function(self)
		self.filename = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":.")
	end,
}

M.trunc = { provider = "%<" }

M.GitInfo = {
	condition = conditions.is_git_repo,
	static = {
		icon = tools.ui.icons.branch,
	},
	init = function(self)
		self.remote = o_tools.get_git_remote_name()
		self.branch = o_tools.get_git_branch()
	end,
	provider = function(self)
		if self.remote and self.branch then
			return string.format("%s %s:%s", self.icon, self.branch, self.remote)
		end
		return string.format("%s %s", self.icon, self.branch)
	end,
	hl = utils.get_highlight("DiagnosticOk").fg,
}

return M
