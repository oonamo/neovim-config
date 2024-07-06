require("mini.colors")
	.get_colorscheme("blie", {
		new_name = "grei",
	})
	:chan_invert("pressure")
	:chan_add("saturation", 10, { filter = "bg" })
	:chan_add("saturation", 20, { filter = "fg" })
	:write()
