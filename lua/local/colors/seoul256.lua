-- vim.g.seoul256_background = 233
vim.cmd.colorscheme("seoul256")

require("mini.colors")
	.get_colorscheme(nil, {
		new_name = "seoul256-dull",
	})
	:compress()
	:resolve_links()
	:write()
