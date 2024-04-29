local M = {}
local function toggle_cmd_option(cmd_string_or_table, option_to_toggle)
	local cmd_is_table = true
	if type(cmd_string_or_table) == "string" then
		cmd_is_table = false
		-- split string to table by white space
		cmd_string_or_table = vim.split(cmd_string_or_table, "%s+")
	end

	-- if option_to_toggle in table, remove it, or add to it.
	local is_in_table = false
	for i, v in ipairs(cmd_string_or_table) do
		if v == option_to_toggle then
			table.remove(cmd_string_or_table, i)
			is_in_table = true
			break
		end
	end
	if not is_in_table then
		-- insert at start
		table.insert(cmd_string_or_table, 2, option_to_toggle)
	end

	if cmd_is_table then
		return cmd_string_or_table
	else
		return table.concat(cmd_string_or_table, " ")
	end
end
function M.files(opts)
	opts = opts or {}

	local fzflua = require("fzf-lua")

	if not opts.cwd then
		opts.cwd = safe_cwd(vim.t.Cwd)
	end
	local cmd = nil
	if vim.fn.executable("fd") == 1 then
		local fzfutils = require("fzf-lua.utils")
		-- fzf-lua.defaults#defaults.files.fd_opts
		cmd = string.format(
			[[fd --color=never --type f --follow --exclude .git -x echo {} | awk -F/ '{printf "%%s: ", $0; printf "%%s ", $NF; gsub(/^\.\//,"",$0); gsub($NF,"",$0); printf "%s ", $0; print ""}']],
			fzfutils.ansi_codes.grey("%s")
		)
		opts.fzf_opts = {
			-- process ansi colors
			["--ansi"] = "",
			["--no-hscroll"] = "",
			["--with-nth"] = "2..",
			["--delimiter"] = "\\s",
			["--tiebreak"] = "begin,index",
		}
	end
	opts.cmd = cmd

	opts.actions = {
		["ctrl-h"] = function(_, o)
			--- toggle hidden
			opts.cmd = toggle_cmd_option(o.cmd, "--hidden")
			opts.query = utils.get_last_query()
			return fzflua.files(opts)
		end,
	}

	opts.winopts = {
		fullscreen = false,
		height = 0.90,
		width = 1,
	}
	opts.ignore_current_file = false

	return fzflua.files(opts)
end

return M
