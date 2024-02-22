local popup = require("plenary.popup")
local Win_id

---@class Colorscheme
---@field index string
---@field colors string[]

---@class ColorSwitcher
---@field prefer_base16 boolean
---@field colorschemes Colorscheme
---@field base16_colors Colorscheme
local M = {}

---@class State
---@field prefer_base16 boolean
---@field colorschemes Colorscheme
---@field base16_colors Colorscheme

local function persistance_path()
	return vim.fn.stdpath("data") .. "/color_switcher"
end

M.colorschemes = {
	index = "grim-pine",
	colors = {
		"prime-pine",
		"newpaper",
		"mellow",
		"everforest",
		"new-prime",
		"poimandres",
		"sakura",
		"gruvbox",
		"grim-pine",
		"low-pine",
		"paramount",
	},
}

M.base16_colors = {
	index = "irblack",
	colors = {
		"mocha",
		"ashes",
		"chalk",
		"decaf",
		"porple",
		"circus",
		"qualia",
		"irblack",
	},
}

M.wezterm_sync = function(colorscheme)
	local file_path = vim.fn.expand("~") .. "/.config/wezterm/colorscheme"
	file_path = file_path:gsub("\\", "/")
	local file = io.open(file_path, "w")
	if file then
		file:write(colorscheme)
		file:close()
	end
	vim.notify("Saved Wezterm color scheme to: " .. file_path, vim.log.levels.INFO)
end

---@return State
M.load_state = function()
	local file_path = persistance_path()
	if vim.fn.filereadable(file_path) == 1 then
		local state = vim.fn.json_decode(vim.fn.readfile(file_path))
		return state
	else
		print("No state file found at: " .. file_path)
		return {
			prefer_base16 = true,
			base16_colors = M.base16_colors,
			colorschemes = M.colorschemes,
		}
	end
end

---@param state State
M.save_state = function(state)
	local file_path = persistance_path()
	vim.fn.writefile({ vim.json.encode(state) }, file_path)
end

---@param use_base16 boolean
local function create_plenary_popup(use_base16)
	local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
	local width = 40
	local colorschemes = use_base16 and M.base16_colors.colors or M.colorschemes.colors

	local function cb(_, choice)
		if choice ~= nil then
			if use_base16 then
				vim.cmd("colorscheme base16-" .. choice)
				M.base16_colors.index = choice
				M.prefer_base16 = true
			else
				O.fn = choice
				require("highlights").setup()
				M.colorschemes.index = choice
				M.prefer_base16 = false
			end
			M.save_state({
				prefer_base16 = M.prefer_base16,
				base16_colors = M.base16_colors,
				colorschemes = M.colorschemes,
			})
			M.wezterm_sync(choice)
		end
	end

	Win_id = popup.create(colorschemes, {
		title = "Colorschemes",
		minwidth = width,
		minheight = #colorschemes + 1,
		borderchars = borderchars,
		callback = cb,
		line = math.floor(((vim.o.lines - (#colorschemes + 1)) / 2) - 1),
		col = math.floor((vim.o.columns - width) / 2),
	})

	local buffer = vim.api.nvim_win_get_buf(Win_id)
	vim.api.nvim_buf_set_keymap(buffer, "n", "<Esc>", "<Cmd>lua Close_plenary_popup()<CR>", { silent = true })
	vim.api.nvim_buf_set_keymap(buffer, "n", "q", "<Cmd>lua Close_plenary_popup()<CR>", { silent = true })
end

function Close_plenary_popup()
	vim.api.nvim_win_close(Win_id, true)
end

function Cycle_base16_colors(index, i)
	vim.cmd("colorscheme base16-" .. M.base16_colors.colors[index])
	return index + (i or 1)
end

M.show_plenary_popup = function(use_base16)
	create_plenary_popup(use_base16)
end

M.setup_persistence = function()
	local state = M.load_state()
	O.fn = state.colorschemes.index
	if state.prefer_base16 then
		vim.cmd("colorscheme base16-" .. state.base16_colors.index)
		return
	end
	require("highlights").setup()
end

return M
