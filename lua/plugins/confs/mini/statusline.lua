---@class Status
---@field section_pathname function(args)
---@field cache table
---@field harpoon table
local H = {
	cache = {},
	harpoon = {},
}

H.section_pathname = function(args)
	args = vim.tbl_extend("force", {
		modified_hl = nil,
		filename_hl = nil,
		trunc_width = 80,
	}, args or {})

	if vim.bo.buftype == "terminal" then
		return "%t"
	end

	local path = vim.fn.expand("%:p")
	if H.cache.prev_path == path then
		return H.cache.prev_str_path
	end
	local cwd = vim.uv.cwd() or ""
	cwd = vim.uv.fs_realpath(cwd) or ""
	H.cache.prev_path = path

	if path:find(cwd, 1, true) == 1 then
		path = path:sub(#cwd + 2)
	end

	local sep = package.config:sub(1, 1)
	local parts = vim.split(path, sep)
	if require("mini.statusline").is_truncated(args.trunc_width) and #parts > 3 then
		parts = { parts[1], "…", parts[#parts - 1], parts[#parts] }
	end

	local dir = ""
	if #parts > 1 then
		dir = table.concat({ unpack(parts, 1, #parts - 1) }, sep) .. sep
	end

	local file = parts[#parts]
	local file_hl = ""
	if vim.bo.modified and args.modified_hl then
		file_hl = "%#" .. args.modified_hl .. "#"
	elseif args.filename_hl then
		file_hl = "%#" .. args.filename_hl .. "#"
	end
	H.cache.prev_str_path = dir .. file_hl .. file
	return H.cache.prev_str_path
end

local ok, harpoon = pcall(require, "harpoon")

function H.harpoon.harpoon_status()
	if not ok then
		return
	end

	local cur_buf = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":~:.")
	if H.harpoon.prev_buf == cur_buf then
		return H.harpoon.prev_str
	end

	local list = harpoon:list().items
	local count = #list

	local inactive = "-"
	local active = ""
	for i, v in ipairs(list) do
		if v.value == cur_buf then
			active = tostring(i)
			break
		end
	end

	H.harpoon.prev_buf = cur_buf
	H.harpoon.prev_str = (active ~= "" and active or inactive) .. "/" .. tostring(count)
	return H.harpoon.prev_str
end

require("mini.statusline").setup({
	use_icons = true,
	content = {
		active = function()
			local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
			local git = MiniStatusline.section_git({ trunc_width = 40 })
			local diff = MiniStatusline.section_diff({ trunc_width = 75, icon = "" })
			local diagnostics = MiniStatusline.section_diagnostics({
				icon = "",
				trunc_width = 75,
				-- signs = {
				-- 	ERROR = "x",
				-- 	WARN = "!",
				-- 	HINT = "?",
				-- 	INFO = "i",
				-- },
			})

			local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
			-- local filename = MiniStatusline.section_filename({ trunc_width = 140 })
			-- local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
			local location = MiniStatusline.section_location({ trunc_width = 75 })
			local search = MiniStatusline.section_searchcount({ trunc_width = 75 })

			local pathname = H.section_pathname({
				trunc_width = 100,
				-- filename_hl = "Normal",
				-- modified_hl = "Special",
				filename_hl = "Normal",
				modified_hl = "Special",
			})

			return MiniStatusline.combine_groups({
				-- { hl = mode_hl, strings = { mode } },
				{ hl = "Statusline", strings = { mode } },
				{ hl = "MiniStatuslineDevinfo", strings = { git .. diff } },
				"%#Comment#",
				"%<", -- Mark general truncate point
				"%=", -- End left alignment
				{ hl = "Comment", strings = { pathname } },
				"%=", -- End left alignment
				{ hl = "MiniStatuslineFileinfo", strings = { diagnostics, lsp } },
				{ hl = "MiniStatuslineFileinfo", strings = { location, H.harpoon.harpoon_status() } },
			})
		end,
		inactive = function()
			return [[%=%{%&bt==#''?'%t':(&bt==#'terminal'?'[Terminal] '.bufname()->substitute('^term://.\{-}//\d\+:\s*','',''):'%F')%}%=]]
		end,
	},
})
