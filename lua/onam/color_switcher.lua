local ok, popup = pcall(require, "plenary.popup")
if not ok then
	return
end
local Win_id

---@class Colorscheme
---@field index string
---@field flavour string
---@field colors string[]

---@class ColorSwitcher
---@field prefer_base16 boolean
---@field colorschemes Colorscheme
---@field base16_colors Colorscheme
---@field light_colorschemes Colorscheme
local M = {}

---@class State
---@field prefer_base16 boolean
---@field colorschemes Colorscheme
---@field base16_colors Colorscheme
---@field light_colorschemes Colorscheme
---@field prefer_light boolean

local function persistance_path()
	return vim.fn.stdpath("data") .. "/color_switcher"
end

M.colorschemes = {
	index = "grim-pine",
	use_light = false,
	flavour = "grim-pine",
	colors = {
		"prime-pine",
		"kanagawa",
		"newpaper",
		"gruvbox",
		"grim-pine",
		"normal-pine",
		"rose-moon",
		"rose-light",
		"flesh-and-blood",
		"noirbuddy",
		"astro",
	},
}

M.flavours = {
	index = "roses",
	use_light = false,
	colors = {
		{ "rose", name = "rose-pine*", flavours = { "", "prime", "dawn" } },
		{ "kanagawa", name = "kanagawa*", flavours = { "kanagawa-wave", "kanagawa-dragon", "kanagawa-lotus" } },
		{ "gruvbox", name = "gruvbox*", flavours = { { "dark", "soft" }, { "light", "soft" } } },
		{ "noirbuddy", name = "noirbuddy*" },
		{ "astro", name = "astro*" },
		{ "everforest", name = "everforest*", flavours = { "medium", "hard", "soft" } },
	},
}

-- M.light_colorschemes = {
-- 	index = "rose-light",
-- 	colors = {
-- 		"everforest",
-- 		"gruvbox",
-- 		"gruvbox-material",
-- 		"paramount",
-- 		"rose-light",
-- 	},
-- }

-- M.base16_colors = {
-- 	index = "irblack",
-- 	colors = {
-- 		"mocha",
-- 		"ashes",
-- 		"chalk",
-- 		"decaf",
-- 		"porple",
-- 		"circus",
-- 		"qualia",
-- 		"irblack",
-- 	},
-- }

M.wezterm_sync = function(colorscheme, light)
	local file_path = vim.fn.expand("~") .. "/.config/wezterm/colorscheme"
	file_path = file_path:gsub("\\", "/")
	local file = io.open(file_path, "w")
	if file then
		if light then
			colorscheme = colorscheme .. ":l"
		end
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
			light_colorschemes = M.light_colorschemes,
		}
	end
end

---@param state State
M.save_state = function(state)
	if not vim.g.neovide then
		local file_path = persistance_path()
		vim.fn.writefile({ vim.json.encode(state) }, file_path)
	end
end

---@param use_base16 boolean?
---@param light boolean?
local function create_plenary_popup(use_base16, light)
	local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
	local width = 40
	local colorschemes = use_base16 and M.base16_colors.colors or M.colorschemes.colors
	if light then
		colorschemes = M.light_colorschemes.colors
	end
	local function cb(_, choice)
		if choice ~= nil then
			if use_base16 then
				vim.cmd("colorscheme base16-" .. choice)
				M.base16_colors.index = choice
				M.prefer_base16 = true
			else
				O.fn = choice
				require("highlights").setup(light)
				if light then
					M.light_colorschemes.index = choice
				else
					M.colorschemes.index = choice
					M.colorschemes.flavour = M.colorschemes.colors[choice]
				end
				M.prefer_base16 = false
			end
			if not vim.g.neovide then
				M.save_state({
					prefer_base16 = M.prefer_base16,
					base16_colors = M.base16_colors,
					colorschemes = M.colorschemes,
					light_colorschemes = M.light_colorschemes,
					prefer_light = light or false,
				})
				M.wezterm_sync(choice, light)
			end
		end
	end

	---@diagnostic disable-next-line: undefined-field
	if popup.create ~= nil then
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
	else
		print("Popup not supported")
	end
end

function Close_plenary_popup()
	vim.api.nvim_win_close(Win_id, true)
end

function Cycle_base16_colors(index, i)
	vim.cmd("colorscheme base16-" .. M.base16_colors.colors[index])
	return index + (i or 1)
end

---@param use_base16 boolean?
---@param light boolean?
M.show_plenary_popup = function(use_base16, light)
	create_plenary_popup(use_base16, light)
end

---@class FlavourOpts
-- -@field name string
-- -@field flavours string[]
-- -@field toggle fun(flavour: string)?
local color_state = {}
---@param opts table
local function change_flavour(opts)
	if opts.name == color_state.name then
		return
	end
	color_state.name = opts.name
	color_state.current = 1
	vim.keymap.set("n", "<leader>cf", function()
		color_state.current = color_state.current == #opts.flavours and 1 or color_state.current + 1
		local flavour = opts.flavours[color_state.current]
		if opts.toggle then
			opts.toggle(flavour)
		else
			require("highlights").setup(flavour)
		end
	end)
end
M.setup_persistence = function()
	local state = M.load_state()
	O.fn = state.colorschemes.index
	if state.prefer_base16 then
		vim.cmd("colorscheme base16-" .. state.base16_colors.index)
	else
		require("highlights").setup(state.colorschemes.flavour)
		change_flavour({
			name = state.colorschemes.flavour,
			flavours = state.colorschemes.colors,
			toggle = function(flavour)
				require("highlights").setup(flavour)
			end,
		})
	end
	G.__color_loaded = true
end

---@param pattern string|table
---@param opts FlavourOpts
function M.add_flavour(pattern, opts)
	vim.api.nvim_create_autocmd("ColorScheme", {
		pattern = type(pattern) == "string" and { pattern } or pattern,
		callback = function()
			change_flavour(opts)
		end,
	})
end

return M
