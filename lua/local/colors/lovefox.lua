require("mini.colors")
	.get_colorscheme("dayfox", {
		new_name = "lovefox",
	})
	:chan_add("saturation", 30, { filter = "fg" })
	:chan_set("saturation", { 10, 90 }, {
		filter = "fg",
		gamut_clip = "lightness",
	})
	:chan_set("hue", { 120, 10 })
	:write()
