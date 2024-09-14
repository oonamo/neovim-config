local hutils = require("heirline.utils")

local function get_hl(name, property)
	local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
	if hl[property] then
		return hl[property]
	elseif hl.fg then
		return hl.fg
	elseif hl.bg then
		return hl.bg
	else
		return get_hl("StatusLine", "fg")
	end
end

local function set_colors()
	local colors = {
		fg = get_hl("StatusLine", "fg"),
		bg = get_hl("StatusLine", "bg"),
		bright_bg = get_hl("Folded", "bg"),
		bright_fg = get_hl("Folded", "fg"),
		red = get_hl("DiagnosticError", "fg"),
		dark_red = get_hl("DiffDelete", "bg"),
		green = get_hl("String", "fg"),
		blue = get_hl("Function", "fg"),
		gray = get_hl("NonText", "fg"),
		orange = get_hl("Constant", "fg"),
		purple = get_hl("Statement", "fg"),
		cyan = get_hl("Special", "fg"),
		warn = get_hl("DiagnosticWarn", "fg"),
		error = get_hl("DiagnosticError", "fg"),
		hint = get_hl("DiagnosticHint", "fg"),
		info = get_hl("DiagnosticInfo", "fg"),
		del = get_hl("MiniDiffSignDelete", "fg"),
		add = get_hl("MiniDiffSignAdd", "fg"),
		change = get_hl("MiniDiffSignChange", "fg"),
		tabline_bg = get_hl("TabLine", "bg"),
	}
	require("heirline").load_colors(colors)
	return colors
end

vim.api.nvim_create_augroup("Heirline", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		hutils.on_colorscheme(set_colors)
	end,
	group = "Heirline",
})

---@param str BufMatcherPattern
---@param patterns BufMatcherPatterns
---@return boolean
local function pattern_match(str, patterns)
	if type(patterns) == "string" then
		patterns = { patterns }
	end
	for _, pattern in ipairs(patterns) do
		if str:find(pattern) then
			return true
		end
	end
	return false
end

---@type table<BufMatcherKinds, BufMatcher>
local buf_matchers = {
	filetype = function(pattern_list, bufnr)
		return pattern_match(vim.bo[bufnr].filetype, pattern_list)
	end,
	buftype = function(pattern_list, bufnr)
		return pattern_match(vim.bo[bufnr].buftype, pattern_list)
	end,
	bufname = function(pattern_list, bufnr)
		local bufname = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":t")
		---@cast bufname -nil
		return pattern_match(bufname, pattern_list)
	end,
}

--- Encode a position to a single value that can be decoded later.
---@param line integer line number of position.
---@param col integer column number of position.
---@param winnr integer a window number.
---@return integer the encoded position.
local function encode_pos(line, col, winnr)
	return bit.bor(bit.lshift(line, 16), bit.lshift(col, 6), winnr)
end
---
--- Decode a previously encoded position to it's sub parts.
---@param c integer the encoded position.
---@return integer line, integer column, integer window
local function decode_pos(c)
	return bit.rshift(c, 16), bit.band(bit.rshift(c, 6), 1023), bit.band(c, 63)
end

--- A condition function if the buffer filetype,buftype,bufname match a pattern
---@param patterns table the table of patterns to match
---@param bufnr integer? of the buffer to match (Default: 0 [current])
---@param op "and"|"or"? whether or not to require all pattern types to match or any (Default: "or")
---@return boolean # whether or not the buffer filetype,buftype,bufname match a pattern
-- @usage local heirline_component = { provider = "Example Provider", condition = function() return require("astroui.status").condition.buffer_matches { buftype = { "terminal" } } end }
local function buffer_matches(patterns, bufnr, op)
	if not op then
		op = "or"
	end
	if not bufnr then
		bufnr = vim.api.nvim_get_current_buf()
	end
	if vim.api.nvim_buf_is_valid(bufnr) then
		for kind, pattern_list in pairs(patterns) do
			if buf_matchers[kind](pattern_list, bufnr) then
				if op == "or" then
					return true
				end
			else
				if op == "and" then
					return false
				end
			end
		end
	end
	return op == "and"
end

local opts = {
	statusline = require("plugins.confs.heirline.statusline"),
	statuscolumn = require("plugins.confs.heirline.statuscolumn"),
	tabline = require("plugins.confs.heirline.tabline"),
	disable_winbar_cb = function(args)
		local disabled = { buftype = { "^terminal$", "^nofile$" } }
		return not utils.buf_is_valid(args.buf) or (disabled and buffer_matches(disabled, args.buf))
	end,
	winbar = {
		updated = "CursorMoved",
		condition = function()
			return package.loaded.aerial
		end,
		init = function(self)
			local data = require("aerial").get_location(true) or {}
			local children = {}
			local start = 0
			start = #data - 5
			if start > 0 then
				table.insert(children, { provider = "" .. " " })
			end

			for i, d in ipairs(data) do
				if i > start then
					local child = {
						{
							provider = string.gsub(d.name, "%%", "%%%%"):gsub("%s*->%s*", ""),
						},
						on_click = { -- add on click function
							minwid = encode_pos(d.lnum, d.col, self.winnr),
							callback = function(_, minwid)
								local lnum, col, winnr = decode_pos(minwid)
								vim.api.nvim_win_set_cursor(vim.fn.win_getid(winnr), { lnum, col })
							end,
							name = "heirline_breadcrumbs",
						},
					}
					local hlgroup = string.format("Aerial%sIcon", d.kind)
					table.insert(child, 1, {
						provider = string.format("%s ", d.icon),
						hl = vim.fn.hlexists(hlgroup) == 1 and hlgroup or nil,
						-- TODO: hl
					})
					if #data > 1 and i < #data then
						table.insert(child, { provider = " " })
					end
					table.insert(children, child)
				end
			end
			self[1] = self:new(children, 1)
		end,
	},
	colors = set_colors(),
}

return opts
