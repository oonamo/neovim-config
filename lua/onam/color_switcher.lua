local popup = require("plenary.popup")
local Win_id
local M = {}

local function persistance_path()
	return vim.fn.stdpath("data") .. "/color_switcher"
end

local colorschemes = {
	"prime-pine",
	"newpaper",
	"mellow",
	"nord",
	"cafe",
	"rusticated",
	"whiteout",
	-- "offwhite",
	"everforest",
	"oxocarbon",
	"poimandres",
	"sakura",
	"gruvbox",
	"miasma",
	"temple-pine",
}

M.load_state = function()
	local file_path = persistance_path()
	if vim.fn.filereadable(file_path) == 1 then
		local state = vim.fn.json_decode(vim.fn.readfile(file_path))
		return state
	else
		return { colorschemes = {}, index = "prime-pine" }
	end
end

M.save_state = function(state)
	local file_path = persistance_path()
	vim.fn.writefile({ vim.json.encode(state) }, file_path)
end

local function create_popup()
	vim.ui.select(colorschemes, {
		prompt = "Select colorscheme",
	}, function(choice)
		if choice ~= nil then
			O.fn = choice
			require("highlights").setup()
			M.save_state({ colorschemes = colorschemes, index = choice })
		end
	end)
end

local function create_plenary_popup(opts)
	local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
	local width = 40

	local function cb(_, choice)
		if choice ~= nil then
			O.fn = choice
			require("highlights").setup()
			M.save_state({ colorschemes = colorschemes, index = choice })
		end
	end

	Win_id = popup.create(opts, {
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
M.show_popup = function()
	vim.defer_fn(create_popup, 0)
end

M.show_plenary_popup = function()
	create_plenary_popup(colorschemes)
end

M.setup_persistence = function()
	local state = M.load_state()
	O.fn = state.index
	require("highlights").setup()
end

return M
