require("mini.colors")
	.get_colorscheme("minimal-base16", {
		new_name = "minimal",
	})
	:compress()
	:resolve_links()
	:write()
