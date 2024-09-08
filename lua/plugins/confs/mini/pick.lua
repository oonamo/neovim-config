local pick = require("mini.pick")
local function win_config()
	return {
		height = math.floor(0.4 * vim.o.lines),
		width = vim.o.columns,
	}
end

local function float_center()
	local height = math.floor(0.618 * vim.o.lines)
	local width = math.floor(0.618 * vim.o.columns)
	return {
		anchor = "NE",
		height = height,
		width = math.floor(vim.o.columns * 1),
		row = math.floor(0.5 * (vim.o.lines - height)),
		col = math.floor(0.5 * (vim.o.columns - width)),
	}
end

local function send_all_to_qf()
	local mappings = MiniPick.get_picker_opts().mappings
	vim.api.nvim_input(vim.api.nvim_replace_termcodes(mappings.mark_all, true, true, true))
	vim.schedule(function()
		vim.api.nvim_input(vim.api.nvim_replace_termcodes(mappings.choose_marked, true, true, true))
	end)
	-- vim.api.nvim_input(vim.api.nvim_replace_termcodes(keys, true, true, true))
end

pick.setup({
	-- window = { config = win_config },
	mappings = {
		choose_marked = "<C-l>",
		send_all_to_qf = {
			char = "<C-q>",
			func = send_all_to_qf,
		},
	},
	options = {
		use_cache = true,
	},
	window = {
		config = function()
			return {
				height = math.floor(0.2 * vim.o.lines),
				width = vim.o.columns,
			}
		end,
	},
})

function MiniPick.registry.center_grep()
	vim.b.minipick_config = { window = { config = float_center() } }
	local res = MiniPick.builtin.grep_live()
	vim.b.minipick_config = {}
	return res
end
