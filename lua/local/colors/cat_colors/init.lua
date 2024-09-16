local M = {}

M.gen_colors_list = {
	"box",
	"everlike",
	"gruber_dark",
	"gruvvy",
	"solarized_light",
}

M.flavours = {
	"box-latte",
	"box-mocha",
	"everlike-mocha",
	"everlike-latte",
	"gruber_dark-mocha",
	"gruvvy-mocha",
	"solarized_light-latte",
}

local function load(file)
	return require("local.colors.cat_colors." .. file)
end

function M.build_all_colors()
	for i, file in ipairs(M.gen_colors_list) do
		local opts = load(file)
		require("catppuccin").setup(opts)
		for _, flavour in ipairs(opts._gen_flavours) do
			table.insert(M.flavours, "cat-" .. file .. "-" .. flavour)
			require("mini.colors")
				.get_colorscheme("catppuccin-" .. flavour, {
					new_name = "cat-" .. file .. "-" .. flavour,
				})
				:compress()
				:resolve_links()
				:write()
		end
	end
end

function M.register()
	Colors.register("cat-colors", nil, nil):add_flavours(M.flavours, function(_, flavour)
		vim.cmd.colorscheme("cat-" .. flavour)
	end)
end

return M
