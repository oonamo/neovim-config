require("mini.colors")
	.get_colorscheme("darkplus", {
		new_name = "beachone",
	})
	:chan_add("saturation", 20, { filter = "fg" })
	:chan_invert("pressure", { filter = "fg" })
	:compress()
	:resolve_links()
	:write()

require("mini.colors")
	.get_colorscheme("darkplus", {
		new_name = "sunset",
	})
	:compress()
	:resolve_links()
	-- :chan_add("saturation", 20, { filter = "fg" })
	-- :chan_invert("pressure", { filter = "fg" })
	-- :chan_invert("temperature", { filter = "fg" })
	-- :chan_set("hue", { 12, 250, 315 }, { filter = "fg" })
	-- :chan_set("hue", { 12, 250, 315 }, { filter = "fg" })
	-- :chan_repel("hue", 225, 50, { filter = "fg" })
	:chan_add(
		"saturation",
		20,
		{ filter = "fg" }
	)
	:chan_invert("pressure", { filter = "fg" })
	:chan_invert("temperature", { filter = "fg" })
	:chan_set("hue", { 12, 30, 225, 315 })
	:chan_repel("hue", 225, 50, { filter = "fg" })
	:write()
