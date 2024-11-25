local M = {}
M.hl = {}

local non_programming_modes = {
	markdown = {},
	org = {},
	neorg = {},
	latex = {},
}

local function group_number(num, sep)
	if num < 999 then
		return tostring(num)
	else
		local tmp = tostring(num) --[[@as string]]
		return tmp:reverse():gsub("(%d%d%d)", "%1" .. sep):reverse():gsub("^,", "")
	end
end

---@class status.Data
---@field buf number
---@field fname string

---@param hl string
---@param v table
---@return string
local function get_hl(hl, v)
	if M.hl[hl] then
		return M.hl[hl]
	end
	local new_hl = v
	if v.fg then
		if type(v.fg) == "table" then
			local key = v.fg.key
			local hi = v.fg.hi
			local tmp = vim.api.nvim_get_hl(0, {
				name = hi,
			})
			new_hl.fg = tmp[key]
		elseif v.fg:sub(1, 1) ~= "#" then
			local fg = vim.api.nvim_get_hl(0, {
				name = v.fg,
			})
			new_hl.fg = fg.fg
		end
	end
	if v.bg then
		if type(v.bg) == "table" then
			local key = v.bg.key
			local hi = v.bg.hi
			local tmp = vim.api.nvim_get_hl(0, {
				name = hi,
			})
			new_hl.bg = tmp[key]
		elseif v.bg:sub(1, 1) ~= "#" then
			local bg = vim.api.nvim_get_hl(0, {
				name = v.bg,
			})
			new_hl.bg = bg.bg
		end
	end
	vim.api.nvim_set_hl(0, "status" .. hl, new_hl)
	M.hl[hl] = "status" .. hl
	return M.hl[hl]
end

---@param hl string
---@param value any
---@param hl_keys table
---@param reset boolean?
---@return string
local function stl_format(hl, value, hl_keys, reset)
	local mod_hl = get_hl(hl, hl_keys)
	return string.format("%%#%s#%s%s", mod_hl, value, reset and "%#Statusline#" or "")
end

function M.make_his(hl_list)
	for k, v in pairs(hl_list) do
		vim.api.nvim_set_hl(0, "status" .. k, v)
	end
end

M.separators = {
	left = "",
	right = "",
	left_side = {
		before = "",
		after = "",
	},
	right_side = {
		before = "",
		after = "",
	},
}

local function padding(str, count, dir)
	local new_str = ""
	local left_str = ""
	local right_str = ""
	local rep = string.rep(" ", count)
	for _, v in ipairs(dir) do
		if v == "left" then
			left_str = rep
		end
		if v == "right" then
			right_str = rep
		end
	end
	new_str = left_str .. str .. right_str
	return new_str
end

function M.fname(data)
	local left = stl_format("left_sep", M.separators.left, {
		fg = {
			hi = "Statusline",
			key = "bg",
		},
		bg = "Normal",
	})
	local right = stl_format("right_sep", M.separators.right, {
		fg = {
			hi = "Statusline",
			key = "bg",
		},
		bg = "Normal",
	}, true)
	local filename = vim.fn.fnamemodify(data.fname, ":t")
	local fname = stl_format("filename", filename, {
		fg = "Normal",
		bg = "Normal",
		bold = true,
	})

	return left .. padding(fname, 3, { "left", "right" }) .. right
end

local function diff_info(data)
	local summary = vim.b.minidiff_summary
	if not summary or not summary.source_name then
		return ""
	end
	local add = summary.add
	local change = summary.change
	local delete = summary.delete

	local add_format = ""
	local delete_format = ""
	local change_format = ""

	if add and add > 0 then
		add_format = stl_format("add", add, {
			fg = "diffAdded",
			bg = "StatusLine",
			bold = true,
		}, true)
	end
	if delete and delete > 0 then
		delete_format = stl_format("delete", " " .. delete, {
			fg = "diffRemoved",
			bg = "StatusLine",
			bold = true,
		}, true)
	end
	if change and change > 0 then
		change_format = stl_format("change", " " .. change, {
			fg = "diffChanged",
			bg = "StatusLine",
			bold = true,
		}, true)
	end
	return "[" .. add_format .. change_format .. delete_format .. "] %#StatusLine# "
end

local colors = {
	{ hi = "Visual", key = "bg" },
	"Special",
	-- { hi = "Special", key = "fg" },
	{ hi = "IncSearch", key = "bg" },
	"Substitute",
}

local function ft(data)
	local filetype = vim.bo[data.buf].ft
	if not filetype then
		return ""
	end
	filetype = filetype:sub(1, 1):upper() .. filetype:sub(2)
	return stl_format("ft", filetype, {
		fg = "StatusLine",
		bg = "StatusLine",
		bold = true,
	})
end

local function file_status(data)
	local lines = vim.api.nvim_buf_line_count(0)
	local cur_line = vim.api.nvim_win_get_cursor(data.win)[1]
	local i = math.floor((cur_line - 1) / lines * 8) + 1
	local color = math.floor(i / 2)

	local advbar = ""
	for index = 1, color do
		advbar = advbar
			.. stl_format("sbar_part_" .. index, " ", {
				fg = colors[index],
				bg = "Statusline",
			}, true)
	end

	-- Make the scrollbar constant length
	for _ = color, 4 do
		advbar = advbar .. " "
	end

	return advbar
end

---@return string, nil|integer: Vline count
local function vline_count()
	local raw_count = vim.fn.line(".") - vim.fn.line("v")
	raw_count = raw_count < 0 and raw_count - 1 or raw_count + 1

	if raw_count < 999 then
		return tostring(raw_count)
	else
		local raw_count_str = tostring(raw_count) --[[@as string]]
		return raw_count_str:reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
	end
end

---@param node? TSNode
---@return TSNode?
local function get_next_header(node)
	if not node then
		return nil
	end
	if node:type() == "atx_heading" then
		return node
	end
	if node:type() == "paragraph" then
		return get_next_header(node:prev_named_sibling())
	end
	if node:type() == "section" then
		return get_next_header(node:child(0))
	end
	return get_next_header(node:parent())
end

local function header_format(status, sep, node, data, depth)
	local header = get_next_header(node)
	if not header then
		return ""
	end

	local header_child = header:child(0)
	if not header_child then
		return ""
	end

	local text
	local fallback = vim.treesitter.get_node_text(header_child, data.buf)
	local header_child_sibling = header_child:next_named_sibling()

	if header_child_sibling then
		text = vim.treesitter.get_node_text(header_child_sibling, data.buf)
	else
		text = fallback
	end
	if depth ~= 0 then
		text = text .. sep
	end

	return header_format(status, sep, header:parent():parent(), data, depth + 1) .. text
end

function M.debug_r()
	local status = header_format("", "->", vim.treesitter.get_node({}), { buf = 0 }, 0)
	print(status)
end

local function heading_outline(data)
	if not vim.bo[data.buf].ft == "markdown" then
		return
	end
	local status = ""
	local sep = "->"
	status = header_format(status, sep, vim.treesitter.get_node({}), data, 0)
	return status
end

local function non_prog_mode(data)
	local raw_lines = vim.api.nvim_buf_line_count(0)
	local lines = group_number(raw_lines, ",")
	local wc_table = vim.fn.wordcount()
	if not wc_table.visual_words or not wc_table.visual_chars then
		local raw_word_count
		if raw_lines < 999 then
			raw_word_count = tostring(wc_table.words)
		else
			local wc_table_words_str = tostring(wc_table.words) --[[@as string]]
			raw_word_count = wc_table.words_str:reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
		end
		return stl_format("fileinfo", "≡", {
			fg = "DiagnosticInfo",
			bg = "Statusline",
		}, true) .. " " .. lines .. " lines  " .. raw_word_count .. " words "
	else
		return stl_format("fileinfo", "‹›", {
			fg = "DiagnosticInfo",
			bg = "Statusline",
		}, true) .. " " .. vline_count() .. " lines  ",
			group_number(wc_table.visual_words, ",") .. " words  ",
			group_number(wc_table.visual_chars, ",") .. " chars"
	end
end

local function diagnostics(data)
	if #vim.diagnostic.get(0) > 0 then
		local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
		local error_format = stl_format("error", "x ", {
			fg = "DiagnosticError",
			bg = "StatusLine",
		}, true) .. errors

		local err = errors > 0 and error_format .. " " or ""

		local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
		local warn_format = stl_format("warn", "▲ ", {
			fg = "DiagnosticWarn",
			bg = "StatusLine",
		}, true) .. warnings
		local warn = warnings > 0 and warn_format .. " " or ""
		return err .. warn .. "%#StatusLine# "
	end
	return ""
end

local function pos_info(data)
	return stl_format("line", "L%l", {
		fg = "Statusline",
		bg = "Statusline",
		bold = true,
	})
end

local function default_status(data)
	return {
		"  ",
		M.fname(data),
		diff_info(data),
		file_status(data),
		"%=",
		pos_info(data),
		" ",
		ft(data),
		"%=",
		diagnostics(data),
		non_programming_modes[vim.bo[data.buf].ft] and non_prog_mode(data) or nil,
		heading_outline(data),
		-- "L%l",
	}
end

function M.build()
	local data = {
		win = vim.api.nvim_get_current_win(),
	}
	data.buf = vim.api.nvim_win_get_buf(data.win)
	data.fname = vim.api.nvim_buf_get_name(data.buf)
	local components = default_status(data)
	local statusline = ""
	for _, component in ipairs(components) do
		statusline = statusline .. component
	end
	return statusline
end

vim.opt.statusline = "%!v:lua.require('moody').build()"
vim.api.nvim_create_autocmd("Colorscheme", {
	group = vim.api.nvim_create_augroup("Statusline", { clear = true }),
	callback = function()
		M.hl = {}
	end,
})

return M
