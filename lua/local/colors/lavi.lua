require("mini.colors")
	.get_colorscheme("ambition", {
		new_name = "lavi",
	})
	:chan_add("saturation", -20, { filter = "bg" })
	:chan_add("saturation", 20, { filter = "fg" })
	:chan_set("saturation", { 10, 90 }, { filter = "fg" })
	:chan_invert("pressure", { filter = "fg" })
	:chan_set("hue", { 12, 250, 315 }, { filter = "fg" })
	:chan_repel("hue", 225, 50, { filter = "fg" })
	:write()
