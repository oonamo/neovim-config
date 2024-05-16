---@field colorscheme string
---@field flavour string

---@class ColorState
---@field name string|string[]
---@field current number

---@class Theme
---@field name string
---@field file_name string
---@field flavours string[][]|string[]

---@class Themes
---@field index string
---@field flavour string|string[]
---@field colors Theme[]
---@field append_file_name boolean?

---@class ThemeSwitcher
---@field themes Themes
---@field active_theme Theme
---@field color_state ColorState
---@field active_flavour_index number
---@field wezterm_sync fun(colorscheme: string, flavour: string?)
---@field load_state fun(): State
---@field save_state fun(state: State)
---@field open_plenary_popup fun()
---@field toggle_flavour fun()
---@field init fun()

---@type ThemeSwitcher
local M = {}
---@class Themes
M.themes = {
	index = "roses",
	flavour = { "prime", "main", "dawn" },
	colors = {
		{ file_name = "roses", name = "roses*", flavours = { "main", "prime", "dawn" } },
		{ file_name = "astro", name = "astro*", flavours = { "astrolight", "astrodark", "astromars" } },
		{
			file_name = "fox",
			name = "fox*",
			flavours = { "nightfox", "dayfox", "dawnfox", "nordfox", "terafox", "carbonfox" },
			append_file_name = false,
		},
		{ file_name = "darkplus", name = "darkplus*", flavours = { "" } },
		{ file_name = "borrowed", name = "borrowed*", flavours = { "mayu", "shin" } },
		{
			file_name = "gruvbox-material",
			name = "gruvbox-material*",
			flavours = {
				{ "dark", "soft" },
				{ "dark", "medium" },
				{ "dark", "hard" },
				{ "light", "soft" },
				{ "light", "medium" },
				{ "light", "hard" },
			},
		},
		{ file_name = "papercolor", name = "papercolor*", flavours = { "dark", "light" } },
		{ file_name = "kanagawa", name = "kanagawa*", flavours = { "wave", "dragon" } },
		{ file_name = "ponokai", name = "ponokai*", flavours = { "default", "sonokai", "kitty" } },
		{ file_name = "catpuccin", name = "catpuccin*", flavours = { "dark", "light" } },
		{ file_name = "modus-tinted", name = "modus-tinted*", flavours = { "dark", "light" } },
	},
}

local has_plenary, popup = pcall(require, "plenary.popup")
if not has_plenary then
	return
end
local win_id

local function persistance_path()
	return vim.fn.stdpath("data") .. "/color_switcher"
end

---@param state State
function M.save_state(state)
	if not vim.g.neovide then
		local file_path = persistance_path()
		vim.fn.writefile({ vim.json.encode(state) }, file_path)
	end
end

---@param colorscheme string
---@param flavour string|string[]
function M.wezterm_sync(colorscheme, flavour)
	if not os.getenv("IS_WEZTERM") then
		return
	end
	local file_path = vim.fn.expand("~") .. "/.config/wezterm/colorscheme"
	file_path = file_path:gsub("\\", "/")
	local file = io.open(file_path, "w")
	if file then
		if type(flavour) == "table" then
			for _, v in ipairs(flavour) do
				if v ~= "" or v ~= " " then
					colorscheme = colorscheme .. "-" .. v
				end
			end
		elseif flavour ~= "" then
			colorscheme = colorscheme .. "-" .. flavour
		end
		if colorscheme:sub(-1) == "-" then
			colorscheme = colorscheme:sub(1, -2)
		end
		file:write(colorscheme)
		file:close()
	end
	vim.notify("Saved Wezterm color scheme to: " .. file_path, vim.log.levels.INFO)
end

---@return State
function M.load_state()
	return vim.fn.json_decode(vim.fn.readfile(persistance_path()))
end

---@param schemes Themes
local function create_plenary_popup(schemes)
	-- local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
	local borderchars = tools.ui.cur_border
	local width = 40
	-- local colorschemes = M.colorschemes.colors
	local colorschemes = {}
	for _, v in pairs(schemes) do
		table.insert(colorschemes, v.file_name)
	end
	local function cb(_, choice)
		if choice ~= nil then
			for _, v in pairs(schemes) do
				if v.file_name == choice then
					M.active_theme = v
					if not vim.g.neovide then
						M.color_state = { name = v.name, current = 1 }
						M.save_state({
							colorscheme = v.file_name,
							flavour = v.flavours[1],
						})
						M.wezterm_sync(v.file_name, v.flavours[1])
					end
					require("highlights").setup(v.file_name, v.flavours[1])
					return
				end
			end
			print("could not find theme: " .. choice)
		end
	end

	---@diagnostic disable-next-line: undefined-field
	if popup.create ~= nil then
		win_id = popup.create(colorschemes, {
			title = "Colorschemes",
			minwidth = width,
			minheight = #colorschemes + 1,
			borderchars = borderchars,
			callback = cb,
			line = math.floor(((vim.o.lines - (#colorschemes + 1)) / 2) - 1),
			col = math.floor((vim.o.columns - width) / 2),
		})

		local buffer = vim.api.nvim_win_get_buf(win_id)
		vim.api.nvim_buf_set_keymap(buffer, "n", "<Esc>", "<Cmd>lua Close_plenary_popup()<CR>", { silent = true })
		vim.api.nvim_buf_set_keymap(buffer, "n", "q", "<Cmd>lua Close_plenary_popup()<CR>", { silent = true })
	else
		print("Popup not supported")
	end
end

function Close_plenary_popup()
	vim.api.nvim_win_close(win_id, true)
end

function M.open_plenary_popup()
	create_plenary_popup(M.themes.colors)
end

function M.init()
	local state = M.load_state()
	for _, v in pairs(M.themes.colors) do
		if v.file_name == state.colorscheme then
			M.active_theme = v
		end
	end
	if not M.active_theme then
		M.active_theme = M.themes.colors[1]
	end
	if state.flavour == nil then
		state.flavour = ""
		M.color_state = { name = M.active_theme.name, current = 1 }
	else
		for i, v in ipairs(M.active_theme.flavours) do
			if type(v) == "table" then
				if v[1] == state.flavour[1] and v[2] == state.flavour[2] then
					M.color_state = { name = M.active_theme.name, current = i }
					break
				end
			elseif v == state.flavour then
				M.color_state = { name = M.active_theme.name, current = i }
				break
			end
		end
	end
	if M.color_state == nil then
		vim.notify("did not find " .. state.colorscheme .. "... defaulting")
		M.color_state = { name = M.active_theme.file_name, current = 1 }
		state.colorscheme = M.color_state.name
		state.flavour = "prime"
		M.save_state({
			colorscheme = state.colorscheme,
			flavour = "prime",
		})
		M.wezterm_sync(state.colorscheme, state.flavour)
	end
	require("highlights").setup(state.colorscheme, state.flavour)
end

function M.toggle_flavour()
	if #M.active_theme.flavours == 1 then
		return
	end
	if M.color_state.name == M.active_theme.file_name then
		return
	end
	M.color_state.current = M.color_state.current == #M.active_theme.flavours and 1 or M.color_state.current + 1
	M.color_state.name = M.active_theme.flavours[M.color_state.current]
	require("highlights").setup(M.active_theme.file_name, M.color_state.name)
	if not vim.g.neovide then
		M.save_state({
			colorscheme = M.active_theme.file_name,
			flavour = M.active_theme.flavours[M.color_state.current],
		})
		M.wezterm_sync(M.active_theme.file_name, M.color_state.name)
	end
end
return M
