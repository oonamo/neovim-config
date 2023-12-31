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
			print("selected " .. choice)
			O.fn = choice
			require("highlights").setup()
			M.save_state({ colorschemes = colorschemes, index = choice })
		end
	end)
end

M.show_popup = function()
	vim.defer_fn(create_popup, 0)
end

M.setup_persistence = function()
	local state = M.load_state()
	O.fn = state.index
	require("highlights").setup()
end

return M
