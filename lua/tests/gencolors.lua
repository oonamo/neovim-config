local colors = require("mini.colors")

local l = { 5, 10, 20, 35 }

local c = { grey = 1, light = 10, dark = 15 }

local h = {
	grey = 270,
	red = 25,
	yellow = 90,
	green = 150,
	cyan = 195,
	blue = 240,
	magenta = 330,
}

local convert = function(L, C, H)
	return colors.convert({ l = L, c = C, h = H }, "hex", { gamut_clip = "cusp" })
end
local round = function(x)
	return math.floor(10 * x + 0.5) / 10
end

local palette_dark = {
	grey1 = convert(l[1], c.grey, h.grey), -- NormalFloat
	grey2 = convert(l[2], c.grey, h.grey), -- Normal bg
	grey3 = convert(l[3], c.grey, h.grey), -- CursorLine
	grey4 = convert(l[4], c.grey, h.grey), -- Visual

	red = convert(l[2], c.dark, h.red), -- DiffDelete
	yellow = convert(l[2], c.dark, h.yellow), -- Search
	green = convert(l[2], c.dark, h.green), -- DiffAdd
	cyan = convert(l[2], c.dark, h.cyan), -- DiffChange
	blue = convert(l[2], c.dark, h.blue),
	magenta = convert(l[2], c.dark, h.magenta),
}

local palette_light = {
	grey1 = convert(100 - l[1], c.grey, h.grey),
	grey2 = convert(100 - l[2], c.grey, h.grey), -- Normal fg
	grey3 = convert(100 - l[3], c.grey, h.grey),
	grey4 = convert(100 - l[4], c.grey, h.grey), -- Comment

	red = convert(100 - l[2], c.light, h.red), -- DiagnosticError
	yellow = convert(100 - l[2], c.light, h.yellow), -- DiagnosticWarn
	green = convert(100 - l[2], c.light, h.green), -- String,     DiagnosticOk
	cyan = convert(100 - l[2], c.light, h.cyan), -- Function,   DiagnosticInfo
	blue = convert(100 - l[2], c.light, h.blue), -- Identifier, DiagnosticHint
	magenta = convert(100 - l[2], c.light, h.magenta),
}

local correct_channel = function(x)
	return x <= 0.04045 and (x / 12.92) or math.pow((x + 0.055) / 1.055, 2.4)
end

-- Source: https://www.w3.org/TR/2008/REC-WCAG20-20081211/#relativeluminancedef
local get_luminance = function(hex)
	local rgb = colors.convert(hex, "rgb")

	-- Convert decimal color to [0; 1]
	local r, g, b = rgb.r / 255, rgb.g / 255, rgb.b / 255

	-- Correct channels
	local R, G, B = correct_channel(r), correct_channel(g), correct_channel(b)

	return 0.2126 * R + 0.7152 * G + 0.0722 * B
end

-- Source: https://www.w3.org/TR/2008/REC-WCAG20-20081211/#contrast-ratiodef
local get_contrast_ratio = function(hex_fg, hex_bg)
	local lum_fg, lum_bg = get_luminance(hex_fg), get_luminance(hex_bg)
	local res = (math.max(lum_bg, lum_fg) + 0.05) / (math.min(lum_bg, lum_fg) + 0.05)
	-- Track only one decimal digit
	return round(res)
end

--stylua: ignore
local contrast_ratios = {
  dark_normal   = get_contrast_ratio(palette_light.grey2, palette_dark.grey2),
  dark_cur_line = get_contrast_ratio(palette_light.grey2, palette_dark.grey3),
  dark_visual   = get_contrast_ratio(palette_light.grey2, palette_dark.grey4),

  light_normal   = get_contrast_ratio(palette_dark.grey2, palette_light.grey2),
  light_cur_line = get_contrast_ratio(palette_dark.grey2, palette_light.grey3),
  light_visual   = get_contrast_ratio(palette_dark.grey2, palette_light.grey4),

  dark_comment     = get_contrast_ratio(palette_light.grey4, palette_dark.grey2),
  dark_comment_cur = get_contrast_ratio(palette_light.grey4, palette_dark.grey3),
  dark_comment_vis = get_contrast_ratio(palette_light.grey4, palette_dark.grey4),

  light_comment     = get_contrast_ratio(palette_dark.grey4, palette_light.grey2),
  light_comment_cur = get_contrast_ratio(palette_dark.grey4, palette_light.grey3),
  light_comment_vis = get_contrast_ratio(palette_dark.grey4, palette_light.grey4),

  dark_red  = get_contrast_ratio(palette_light.red, palette_dark.grey2),
  light_red = get_contrast_ratio(palette_dark.red, palette_light.grey2),

  dark_yellow  = get_contrast_ratio(palette_light.yellow, palette_dark.grey2),
  light_yellow = get_contrast_ratio(palette_dark.yellow, palette_light.grey2),

  dark_green  = get_contrast_ratio(palette_light.green, palette_dark.grey2),
  light_green = get_contrast_ratio(palette_dark.green, palette_light.grey2),

  dark_cyan  = get_contrast_ratio(palette_light.cyan, palette_dark.grey2),
  light_cyan = get_contrast_ratio(palette_dark.cyan, palette_light.grey2),

  dark_blue  = get_contrast_ratio(palette_light.blue, palette_dark.grey2),
  light_blue = get_contrast_ratio(palette_dark.blue, palette_light.grey2),

  dark_magenta  = get_contrast_ratio(palette_light.magenta, palette_dark.grey2),
  light_magenta = get_contrast_ratio(palette_dark.magenta, palette_light.grey2),
}

vim.print(palette_light, palette_dark)
