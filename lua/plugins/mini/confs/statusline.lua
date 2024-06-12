local cache = {}

local function init()
	cache.root = utils.get_path_root(vim.api.nvim_buf_get_name(0))
	cache.branch = utils.get_git_branch(cache.root)
	cache.remote = utils.get_git_remote_name(cache.root)
	for _, v in ipairs({ "MiniDiffSignAdd", "MiniDiffSignChange", "MiniDiffSignDelete" }) do
		local fg, bg, _ = utils.get_hl(v)
		vim.api.nvim_set_hl(0, "__stl_" .. v, { fg = fg, bg = bg or "NONE" })
	end
end
vim.schedule(function()
	init()
end)

local function put(hl, str, surround)
	surround = surround or ""
	return "%#" .. hl .. "#" .. str
end

local function GitDiff()
	local summary = vim.b.minidiff_summary
	local any_has_change = false
	local t = {}
	if summary == nil or summary.add == nil then
		return ""
	end
	if summary.add > 0 then
		table.insert(t, put("__stl_MiniDiffSignAdd", "+" .. summary.add))
		any_has_change = true
	end
	if summary.change > 0 then
		table.insert(t, put("__stl_MiniDiffSignChange", "~" .. summary.change))
		any_has_change = true
	end
	if summary.delete > 0 then
		table.insert(t, put("__stl_MiniDiffSignDelete", "-" .. summary.delete))
		any_has_change = true
	end
	if any_has_change then
		return "," .. table.concat(t, "")
	end
	return table.concat(t, "")
end

local function git_remote()
	return cache.remote
end

local function git_branch()
	return cache.branch
end

local function GitInfo()
	local str = ""
	if cache.branch ~= nil then
		str = str .. "(" .. put("Statusline", cache.branch)
	end
	if cache.remote ~= nil then
		str = str .. ":" .. put("Statusline", cache.remote:gsub("%s+", ""))
	end
	return str .. GitDiff() .. ")"
end

local function fileInfo()
	return vim.bo.ft == "" and "" or vim.bo.ft:gsub("^%l", string.upper)
end

require("mini.statusline").setup({
	content = {
		active = function()
			-- returns mode_hl aswell
			local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
			local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
			local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
			local location = MiniStatusline.section_location({ trunc_width = 75 })
			local search = MiniStatusline.section_searchcount({ trunc_width = 75 })
			local git = MiniStatusline.section_git({ trunc_width = 40 })
			local diff = MiniStatusline.section_diff({ trunc_width = 75 })
			local file = fileInfo()
			local branch = git_branch()
			local remote = git_remote()
			-- local git = GitInfo()

			-- Use Statusline hl for transparency support with base16 helper
			return MiniStatusline.combine_groups({
				{ hl = mode_hl, strings = { mode:upper() } },
				{ hl = "Statusline", strings = { file } },
				{ hl = "MiniStatuslineDevinfo", strings = { branch, diff } },
				"%#Statusline#",
				"%=",
				[[%{%&bt==#''?'%t':(&bt==#'terminal'?'[Terminal] '.bufname()->substitute('^term://.\{-}//\d\+:\s*','',''):'%F')%} ]],
				"%=",
				{ hl = "Statusline", strings = { diagnostics, lsp } },
				{ hl = mode_hl, strings = { search .. location } },
			})
		end,
		inactive = function()
			return [[%=%{%&bt==#''?'%t':(&bt==#'terminal'?'[Terminal] '.bufname()->substitute('^term://.\{-}//\d\+:\s*','',''):'%F')%}%=]]
		end,
	},
})

-- require("mini.statusline").setup()
