require("mini.colors")
	.get_colorscheme("ambition", {
		new_name = "light-ambition",
	})
	:chan_invert("lightness", { gamut_clip = "cusp" })
	:chan_add("lightness", 20, { filter = "bg" })
	:chan_add("lightness", 20, { filter = "fg" })
	:chan_set("saturation", { 10, 100 }, { filter = "fg" })
	:chan_set("hue", { 0, 90, 320 })
	:write()
