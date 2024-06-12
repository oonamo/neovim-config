local buf_list = {}
require("mini.tabline").setup({
	show_icons = false,
	format = function(buf_id, label)
		return "|  " .. MiniTabline.default_format(buf_id, label) .. "   "
	end,
})

vim.keymap.set("n", "gbp", function()
	local pickers = {}
	MiniTabline.config = {
		show_icons = false,
		format = function(buf_id, label)
			local bufname = label:sub(1, 3)
			label = label:sub(1, 1)
			local i = 2
			while pickers[label] do
				if i > #bufname then
					break
				end
				label = bufname:sub(i, i)
				i = i + 1
			end
			pickers[label] = buf_id
			return "| " .. label .. ":" .. bufname .. " "
			-- buf_list[buf_id] = label
			-- return "|  " .. buf_id .. MiniTabline.default_format(buf_id, label) .. "   "
		end,
	}
	vim.cmd.redrawtabline()
	-- print(MiniTabline.make_tabline_string())
	local char = vim.fn.getcharstr()
	local bufnr = pickers[char]
	if bufnr then
		vim.api.nvim_win_set_buf(0, bufnr)
	end
	MiniTabline.config = {
		show_icons = false,
		format = function(buf_id, label)
			return "|  " .. MiniTabline.default_format(buf_id, label) .. "   "
		end,
	}
	vim.cmd.redrawtabline()
end)
