local htils = require("heirline.utils")

local space = { provider = " " }

local TablineBufnr = {
	provider = function(self)
		return tostring(self.bufnr) .. ". "
	end,
	hl = "Comment",
}

-- we redefine the filename component, as we probably only want the tail and not the relative path
local TablineFileName = {
	provider = function(self)
		-- self.filename will be defined later, just keep looking at the example!
		local filename = self.filename
		filename = filename == "" and "[No Name]" or vim.fn.fnamemodify(filename, ":t")
		return filename
	end,
	hl = function(self)
		return { bold = self.is_active or self.is_visible, italic = true }
	end,
}

-- this looks exactly like the FileFlags component that we saw in
-- #crash-course-part-ii-filename-and-friends, but we are indexing the bufnr explicitly
-- also, we are adding a nice icon for terminal buffers.
local TablineFileFlags = {
	{
		condition = function(self)
			return vim.api.nvim_get_option_value("modified", { buf = self.bufnr })
		end,
		provider = "[+]",
		hl = { fg = "green" },
	},
	{
		condition = function(self)
			return not vim.api.nvim_get_option_value("modifiable", { buf = self.bufnr })
				or vim.api.nvim_get_option_value("readonly", { buf = self.bufnr })
		end,
		provider = function(self)
			if vim.api.nvim_get_option_value("buftype", { buf = self.bufnr }) == "terminal" then
				return "  "
			else
				return ""
			end
		end,
		hl = { fg = "orange" },
	},
	{
		condition = function()
			return package.loaded.arrow
		end,
		static = {
			keymap = {
				"H",
				"J",
				"K",
				"L",
			},
			icon = "󱡁",
		},
		hl = { fg = "orange" },
		init = function(self)
			self.number = require("arrow.persist").is_saved(vim.api.nvim_buf_get_name(self.bufnr))
		end,
		provider = function(self)
			if self.number then
				if self.keymap[self.number] then
					return " " .. self.icon .. " " .. self.keymap[self.number]
				else
					return " " .. self.icon .. " " .. self.number
				end
			end
			return ""
		end,
	},
}

-- Here the filename block finally comes together
local TablineFileNameBlock = {
	init = function(self)
		self.filename = vim.api.nvim_buf_get_name(self.bufnr)
	end,
	hl = function(self)
		if self.is_active then
			return "TabLineSel"
		-- why not?
		elseif not vim.api.nvim_buf_is_loaded(self.bufnr) then
			return { fg = "gray" }
		else
			return "TabLine"
		end
	end,
	on_click = {
		callback = function(_, minwid, _, button)
			if button == "m" then -- close on mouse middle click
				vim.schedule(function()
					vim.api.nvim_buf_delete(minwid, { force = false })
				end)
			else
				vim.api.nvim_win_set_buf(0, minwid)
			end
		end,
		minwid = function(self)
			return self.bufnr
		end,
		name = "heirline_tabline_buffer_callback",
	},
	space,
	-- TablineBufnr,
	-- FileIcon, -- turns out the version defined in #crash-course-part-ii-filename-and-friends can be reutilized as is here!
	TablineFileName,
	TablineFileFlags,
}

-- a nice "x" button to close the buffer
local TablineCloseButton = {
	condition = function(self)
		return not vim.api.nvim_get_option_value("modified", { buf = self.bufnr })
	end,
	{ provider = " " },
	{
		provider = "󰅖 ",
		hl = { fg = "red" },
		on_click = {
			callback = function(_, minwid)
				vim.schedule(function()
					vim.api.nvim_buf_delete(minwid, { force = false })
					vim.cmd.redrawtabline()
				end)
			end,
			minwid = function(self)
				return self.bufnr
			end,
			name = "heirline_tabline_close_buffer_callback",
		},
	},
}

-- The final touch!
local TablineBufferBlock = htils.surround({ "", "" }, function(self)
	if self.is_active then
		return htils.get_highlight("TabLineSel").bg
	else
		return htils.get_highlight("TabLine").bg
	end
end, { TablineFileNameBlock, TablineCloseButton, space })

-- and here we go
local BufferLine = htils.make_buflist(
	TablineBufferBlock,
	{ provider = "", hl = { fg = "gray" } }, -- left truncation, optional (defaults to "<")
	{ provider = "", hl = { fg = "gray" } } -- right trunctation, also optional (defaults to ...... yep, ">")
	-- by the way, open a lot of buffers and try clicking them ;)
)

local Tabpage = {
	provider = function(self)
		return "%" .. self.tabnr .. "T " .. self.tabpage .. " %T"
	end,
	hl = function(self)
		if not self.is_active then
			return "TabLine"
		else
			return "TabLineSel"
		end
	end,
}

local TabpageClose = {
	provider = "%999X  %X",
	hl = "TabLine",
}

local TabPages = {
	-- only show this component if there's 2 or more tabpages
	condition = function()
		return #vim.api.nvim_list_tabpages() >= 2
	end,
	{ provider = "%=" },
	htils.make_tablist(Tabpage),
	TabpageClose,
}

vim.o.showtabline = 2
vim.cmd([[au FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif]])

return {
	{
		condition = function(self)
			self.winid = vim.api.nvim_tabpage_list_wins(0)[1]
			self.winwidth = vim.api.nvim_win_get_width(self.winid)
			return self.winwidth ~= self.winid and not utils.buf_is_valid(vim.api.nvim_win_get_buf(self.winid))
		end,
		provider = function(self)
			return (" "):rep(self.winwidth + 1)
		end,
		hl = { bg = "tabline_bg" },
	},
	BufferLine,
	TabPages,
}
