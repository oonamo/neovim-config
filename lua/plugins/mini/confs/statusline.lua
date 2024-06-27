local function create_status_hl()
	local stl_fg, stl_bg, _ = utils.get_hl("Statusline")
	local _, norm_bg, _ = utils.get_hl("Normal")

	if norm_bg == stl_fg then
		vim.api.nvim_set_hl(0, "stl_fill", { fg = stl_bg, bg = "NONE" })
	else
		vim.api.nvim_set_hl(0, "stl_fill", { fg = stl_fg, bg = "NONE" })
	end
end

vim.api.nvim_create_autocmd("Colorscheme", {
	callback = create_status_hl,
})

create_status_hl()

local H = {}

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
	local cwd = vim.uv.cwd() or ""
	cwd = vim.uv.fs_realpath(cwd) or ""

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
	return dir .. file_hl .. file
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
				signs = {
					ERROR = "x",
					WARN = "!",
					HINT = "?",
					INFO = "i",
				},
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
				{ hl = mode_hl, strings = { mode } },
				{ hl = "MiniStatuslineDevinfo", strings = { git .. diff } },
				"%#Comment#",
				"%<", -- Mark general truncate point
				"%=", -- End left alignment
				{ hl = "Comment", strings = { pathname } },
				"%=", -- End left alignment
				{ hl = "MiniStatuslineFileinfo", strings = { diagnostics, lsp } },
				{ hl = mode_hl, strings = { search .. location } },
			})
		end,
		inactive = function()
			return [[%=%{%&bt==#''?'%t':(&bt==#'terminal'?'[Terminal] '.bufname()->substitute('^term://.\{-}//\d\+:\s*','',''):'%F')%}%=]]
		end,
	},
})
