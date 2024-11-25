local M = {}
M.hl = {}

local MAX_DEPTH = 1000

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
				link = false,
			})
			new_hl.fg = tmp[key]
		elseif v.fg:sub(1, 1) ~= "#" then
			local fg = vim.api.nvim_get_hl(0, {
				name = v.fg,
				link = false,
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
				link = false,
			})
			new_hl.bg = tmp[key]
		elseif v.bg:sub(1, 1) ~= "#" then
			local bg = vim.api.nvim_get_hl(0, {
				name = v.bg,
				link = false,
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

local function trunc(str, max_val, trunc_chars)
	if #str > max_val then
		str = str:sub(1, -max_val) .. trunc_chars
	end
	return str
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

-- HACK: precompile these components
local function build_seperators()
	M.left = stl_format("left_sep", M.separators.left, {
		fg = {
			hi = "Statusline",
			key = "bg",
		},
		bg = "Normal",
	})

	M.right = stl_format("right_sep", M.separators.right, {
		fg = {
			hi = "Statusline",
			key = "bg",
		},
		bg = "Normal",
	}, true)
end
build_seperators()

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
	if vim.bo[data.buf].ft == "" then
		return "[nofile]"
	end
	local filename = vim.fn.fnamemodify(data.fname, ":t")
	local fname = stl_format("filename", filename, {
		fg = "Normal",
		bg = "Normal",
		bold = true,
	})

	return M.left .. padding(fname, 3, { "left", "right" }) .. M.right
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

	local hasAdd = false
	local hasDelete = false

	if add and add > 0 then
		hasAdd = true
		add_format = stl_format("add", add, {
			fg = "diffAdded",
			bg = "StatusLine",
			bold = true,
		}, true)
	end
	if delete and delete > 0 then
		hasDelete = true
		delete_format = stl_format("delete", (hasAdd and " " or "") .. delete, {
			fg = "diffRemoved",
			bg = "StatusLine",
			bold = true,
		}, true)
	end
	if change and change > 0 then
		change_format = stl_format("change", (hasDelete and " " or "") .. change, {
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
---@param depth? number
---@return TSNode?
local function get_next_header(node, depth)
	-- HACK: prevent Infinite recursion in case of a bug
	if depth and depth > MAX_DEPTH then
		vim.notify("Infinite recursion reached!")
		return nil
	end
	if not node then
		return nil
	end
	if node:type() == "atx_heading" then
		return node
	end
	if node:type() == "paragraph" then
		return get_next_header(node:prev_named_sibling(), depth and depth + 1 or 0)
	end
	if node:type() == "section" then
		return get_next_header(node:child(0), depth and depth + 1 or 0)
	end
	if node:type() == "document" then
		return nil
	end
	-- HACK: Prevent calling parnet->child->parent->child ...
	if node:parent():type() == "section" then
		-- Parent -> child does not always point to itself
		local child = node:parent():child(0)
		if child and child:type() == "atx_heading" then
			return child
		end
		return nil
	end
	return get_next_header(node:parent(), depth and depth + 1 or 0)
end

local function header_format(sep, node, data, depth, text_format_fn)
	if depth > MAX_DEPTH then
		vim.notify("Max recursion reached", vim.log.levels.WARN, {
			title = "Statusline",
		})
		return ""
	end
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
	if text_format_fn and type(text_format_fn) == "function" then
		text = text_format_fn(text, fallback)
	end
	if depth ~= 0 then
		text = text .. sep
	end

	if depth > MAX_DEPTH then
		return ""
	end

	return header_format(sep, header:parent():parent(), data, depth + 1, text_format_fn) .. text
end

function M.debug_r()
	local status = header_format("->", vim.treesitter.get_node({}), M.data, 0)

	local header = get_next_header(vim.treesitter.get_node({}))
	print(status)
	if header then
		print(header:type())
	end
end

local function heading_outline(data)
	if vim.bo[data.buf].ft == "" or vim.bo[data.buf].ft ~= "markdown" then
		return
	end
	local status = ""

	local sep = stl_format("header_sep", " ", {
		fg = {
			hi = "Search",
			key = "bg",
		},
		bg = "Normal",
	})

	local max_header_size = {
		4,
		4,
		4,
		4,
		4,
		4,
		4,
	}
	local prev_header_size

	local text_format_fn = function(text, prefix)
		local header_level = #prefix
		return stl_format("header" .. header_level, trunc(text, max_header_size[header_level], "..."), {
			fg = "RenderMarkdownH" .. header_level,
			bg = "Normal",
			bold = true,
		})
	end

	status = header_format(sep, vim.treesitter.get_node({}), data, 0, text_format_fn)

	if status == "" then
		return status
	end

	return M.left .. status .. M.right
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
	local is_not_programming = non_programming_modes[vim.bo[data.buf].ft] ~= nil
	return {
		"  ",
		M.fname(data),
		diff_info(data),
		file_status(data),
		"%=",
		pos_info(data),
		" ",
		is_not_programming and heading_outline(data) or ft(data),
		"%=",
		diagnostics(data),
		is_not_programming and non_prog_mode(data) or nil,
		-- heading_outline(data),
	}
end

function M.build()
	local data = {
		win = vim.api.nvim_get_current_win(),
	}
	data.buf = vim.api.nvim_win_get_buf(data.win)
	data.fname = vim.api.nvim_buf_get_name(data.buf)
	M.data = data
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
    build_seperators()
	end,
})

return M
