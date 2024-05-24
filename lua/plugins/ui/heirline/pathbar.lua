-- local folder_icon = require("icons").symbol_kinds.Folder
local Winbar = {
	condition = function()
		if
			not vim.api.nvim_win_get_config(0).zindex -- Not a floating window
			and vim.bo.buftype == "" -- Normal buffer
			and vim.api.nvim_buf_get_name(0) ~= "" -- Has a file name
			and not vim.wo[0].diff -- Not in diff mode
		then
			return true
		end
		return false
	end,
	update = { "BufEnter" },
	init = function(self)
		self.path = vim.fs.normalize(vim.fn.expand("%:p") --[[@as string]])
		if vim.api.nvim_win_get_width(0) < math.floor(vim.o.columns / 3) then
			self.path = vim.fn.pathshorten(self.path)
		end
		-- print("hello", self.path)
	end,
	static = {
		separator = "  ",
		special_dirs = {
			CODE = vim.g.projects_dir,
			DOTFILES = vim.env.XDG_CONFIG_HOME,
			HOME = vim.env.HOME,
			PERSONAL = vim.g.personal_projects_dir,
			Notes = vim.g.note_path,
		},
	},
	{
		init = function(self)
			self.path = vim.fs.normalize(vim.fn.expand("%:p") --[[@as string]])
			if vim.api.nvim_win_get_width(0) < math.floor(vim.o.columns / 3) then
				self.path = vim.fn.pathshorten(self.path)
			end
			-- print("hello", self.path)
		end,
		provider = function(self)
			local prefix, prefix_path = "", ""
			for dir_name, dir_path in pairs(self.special_dirs) do
				if vim.startswith(self.path, vim.fs.normalize(dir_path)) and #dir_path > #prefix_path then
					prefix, prefix_path = dir_name, dir_path
				end
			end
			if prefix ~= nil then
				self.path = self.path:gsub("^/", "")
				return string.format("%s %s%s", tools.ui.icons.Folder, prefix, self.separator)
			end
		end,
		hl = { fg = "cyan", bg = "winbar_bg" },
	},
	{
		init = function(self)
			self.path = vim.fs.normalize(vim.fn.expand("%:p") --[[@as string]])
			if vim.api.nvim_win_get_width(0) < math.floor(vim.o.columns / 3) then
				self.path = vim.fn.pathshorten(self.path)
			end
		end,
		provider = function(self)
			self.path = self.path:gsub("^/", "")
			return table.concat(vim.split(self.path, "/"), self.separator)
		end,
		hl = "Winbar",
	},
}
return Winbar
