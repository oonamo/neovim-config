require("mini.colors")
	.get_colorscheme("gruvsquirrel", {
		new_name = "lightsquirrel",
	})
	:chan_invert("lightness", { gamut_clip = "cusp" })
	:chan_add("saturation", 20, { filter = "fg" })
	:chan_add("temperature", 50, { filter = "bg" })
	:write()
