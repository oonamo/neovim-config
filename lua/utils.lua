local M = {}
local H = {}
H.cache = {}

function M.echo(name, msg, is_important)
	-- Construct message chunks
	msg = type(msg) == "string" and { { msg } } or msg
	table.insert(msg, 1, { "(" .. name .. ") ", "WarningMsg" })

	-- Avoid hit-enter-prompt
	local max_width = vim.o.columns * math.max(vim.o.cmdheight - 1, 0) + vim.v.echospace
	local chunks, tot_width = {}, 0
	for _, ch in ipairs(msg) do
		local new_ch = { vim.fn.strcharpart(ch[1], 0, max_width - tot_width), ch[2] }
		table.insert(chunks, new_ch)
		tot_width = tot_width + vim.fn.strdisplaywidth(new_ch[1])
		if tot_width >= max_width then
			break
		end
	end

	-- Echo. Force redraw to ensure that it is effective (`:h echo-redraw`)
	vim.cmd([[echo '' | redraw]])
	vim.api.nvim_echo(chunks, is_important, {})
end

function M.unecho()
	if H.cache.msg_shown then
		vim.cmd([[echo '' | redraw]])
	end
end

function M.getcharstr(msg)
	local needs_help_msg = true
	if msg ~= nil then
		vim.defer_fn(function()
			if not needs_help_msg then
				return
			end
			M.echo("mini.jump2d", msg, false)
      H.cache.msg_shown = true
		end, 1000)
	end

  H.cache.is_in_getcharstr = true
	local _, char = pcall(vim.fn.getcharstr)
  H.cache.is_in_getcharstr = false
	needs_help_msg = false
	M.unecho()

	return char
end

return M
