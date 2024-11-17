local M = {
	light_bg_min = 252,
	light_bg_max = 256,
	light_default = 253,
	dark_bg_max = 233,
	dark_bg_min = 239,
	dark_default = 237,
}

---@alias bg "light"|"dark"

---@param color_map_num number
---@param background bg
function M.genseoul_colors(color_map_num, background, name)
	vim.cmd.hi("clear")
	if background == "light" then
		vim.g.seoul256_light_background = color_map_num
		vim.cmd.colorscheme("seoul256-light")
  else
		vim.g.seoul256_background = color_map_num
		vim.cmd.colorscheme("seoul256")
  end
  require("mini.colors")
    .get_colorscheme(nil, {
      new_name = name,
    })
    :compress()
    :add_cterm_attributes()
    :write()
end

function M.build()
  local light_high = M.light_bg_max
  local light_low = M.light_bg_min
  local dark_high = M.dark_bg_max
  local dark_low = M.dark_bg_min
  local dark_mid = math.floor((dark_low + dark_high) / 2)
  local default_light = M.light_default
  local default_dark = M.dark_default
  local light_mid = math.floor((light_low + light_high) / 2)
  M.genseoul_colors(default_dark, "dark", "seoul256")
  M.genseoul_colors(dark_high, "dark", "seoul256-soft")
  M.genseoul_colors(dark_low, "dark", "seoul256-hard")
  M.genseoul_colors(dark_mid, "dark", "seoul256-mix")
  M.genseoul_colors(default_light, "light", "seoul256-light")
  M.genseoul_colors(light_high, "light", "seoul256-soft-light")
  M.genseoul_colors(light_low, "light", "seoul256-hard-light")
  M.genseoul_colors(light_mid, "light", "seoul256-mix-light")
end
M.build()
