require("mini.colors")
	.get_colorscheme("256_noir", {
		new_name = "256noir",
	})
	:compress()
	:resolve_links()
	:write()
