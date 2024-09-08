require("mini.colors")
	.get_colorscheme("oh-lucy", {
		new_name = "oh-lucy-light",
	})
	:chan_invert("lightness", { gamut_clip = "cusp" })
	:write()

require("mini.colors")
	.get_colorscheme("oh-lucy-evening", {
		new_name = "oh-lucy-evening-light",
	})
	:chan_invert("lightness", { gamut_clip = "cusp" })
	:write()
