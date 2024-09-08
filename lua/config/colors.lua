Colors.register("tokyonight", nil, "folke/tokyonight.nvim"):add_flavours({
	"night",
	"moon",
})

Colors.register("everforest", nil, "sainnhe/everforest")
	:add_flavours({
		"dark",
		"light",
	}, function(_, flavour)
		vim.o.bg = flavour or "dark"
		vim.cmd.colorscheme("everforest")
	end)
	:before(function()
		vim.g.everforest_better_performance = 1
		vim.g.everforest_background = "hard"
	end)

Colors.register("gruvbox-material", nil, "sainnhe/gruvbox-material"):before(function()
	vim.g.gruvbox_material_enable_bold = 1
	vim.g.gruvbox_material_background = "hard"
	vim.g.gruvbox_material_better_performance = 1
end)

Colors.register("rose-pine", nil, "rose-pine/neovim")
	:add_flavours({
		"main",
		"moon",
		"dawn",
	})
	:set_variant_name("variant")
	:set_spec({
		opts = {
			styles = {
				italic = false,
			},
		},
	})

Colors.register("nightfox", nil, "EdenEast/nightfox.nvim"):add_flavours({
	"night",
	"dusk",
	"tera",
	"nord",
	"day",
	"dawn",
	"carbon",
}, function(_, flavour)
	if flavour then
		vim.cmd.colorscheme(flavour .. "fox")
	else
		vim.cmd.colorscheme("duskfox")
	end
end)

Colors.register("base46")
	:add_flavours({
		"aquarium",
		"ashes",
		"ayu_dark",
		"ayu_light",
		"bearded-arc",
		"blossom_light",
		"catppuccin",
		"chadracula-evondev",
		"chadracula",
		"chadtain",
		"chocolate",
		"dark_horizon",
		"decay",
		"doomchad",
		"everblush",
		"everforest",
		"everforest_light",
		"falcon",
		"flex-light",
		"flexoki-light",
		"flexoki",
		"gatekeeper",
		"github_dark",
		"github_light",
		"gruvbox",
		"gruvbox_light",
		"gruvchad",
		"jabuti",
		"jellybeans",
		"kanagawa",
		"material-darker",
		"material-lighter",
		"melange",
		"mito-laser",
		"monekai",
		"monochrome",
		"mountain",
		"nano-light",
		"nightfox",
		"nightlamp",
		"nightowl",
		"nord",
		"oceanic-light",
		"oceanic-next",
		"one_light",
		"onedark",
		"onenord",
		"onenord_light",
		"oxocarbon",
		"palenight",
		"pastelDark",
		"pastelbeans",
		"penumbra_dark",
		"penumbra_light",
		"poimandres.lua",
		"radium",
		"rosepine-dawn",
		"rosepine",
		"rxyhn",
		"solarized_dark",
		"solarized_osaka",
		"sweetpastel",
		"tokyodark",
		"tokyonight",
		"tomorrow_night",
		"tundra",
		"vscode_dark",
		"wombat",
		"yoru",
	}, function(_, theme)
		require("base46").setup({
			ui = {
				theme = theme or "rosepine",
			},
		})
	end)
	:set_spec({
		dir = "~/projects/base46/",
	}, true)

Colors.register("zenbones", nil, "zenbones-theme/zenbones.nvim")
	:add_flavours({
		"zenwritten",
		"neobones",
		"vimbones",
		"rosebones",
		"forestbones",
		"nordbones",
		"tokyobones",
		"seoulbones",
		"duckbones",
		"zenburned",
		"kanagawabones",
		"randombones",
	}, function(_, flavour)
		vim.cmd.colorscheme(flavour)
	end)
	:before(function(self)
		vim.g.bones_compat = 1
		-- for flavour, _ in pairs(self.flavours) do
		--           vim.g.[flavour ..
		-- end
	end)

Colors.register("cyberdream", nil, "scottmckendry/cyberdream.nvim"):set_spec({
	opts = {
		-- cache = true,
		borderless_telescope = false,
		transparent = true,
		theme = {
			variant = "auto",
		},
	},
})

Colors.register("nordern", function()
	vim.cmd.colorscheme("nordern")
	vim.api.nvim_set_hl(0, "CursorLineNr", {
		fg = "#eceff4",
		bg = "NONE",
	})
end, "fcancelinha/nordern.nvim")

Colors.register("oh-lucy", nil, "Yazeed1s/oh-lucy.nvim")
	:before(function()
		-- oh-lucy
		vim.g.oh_lucy_italic_functions = false
		vim.g.oh_lucy_italic_comments = false
		-- The key is 'oh_lucy_'

		-- oh-lucy-evening
		vim.g.oh_lucy_evening_italic_functions = false
		vim.g.oh_lucy_evening_italic_comments = false
	end)
	:set_spec({
		dir = "~/projects/nvim/oh-lucy.nvim",
		dev = true,
	})
	:add_flavours({ "oh-lucy", "evening", "light", "evening-light" }, function(_, flavour)
		if flavour == "oh-lucy" then
			vim.cmd.colorscheme("oh-lucy")
		else
			vim.cmd.colorscheme("oh-lucy-" .. flavour)
		end
	end)
	:override({
		StatusLine = { link = "Normal" },
	})

Colors.register("lackluster", function()
	vim.cmd("hi clear")
	vim.cmd.colorscheme("lackluster")
end, "slugbyte/lackluster.nvim"):set_spec({
	opts = function()
		local lackluster = require("lackluster")
		return {
			tweak_syntax = {
				comment = lackluster.color.gray4,
			},
		}
	end,
})
Colors.register("astrotheme", nil, "AstroNvim/astrotheme")
	:add_flavours({
		"dark",
		"light",
		"jupiter",
		"mars",
	}, function(_, flavour)
		vim.cmd.colorscheme("astro" .. flavour)
	end)
	:set_variant_name("palette")
	:set_spec({
		style = {
			neotree = false,
		},
		highlights = {
			global = { -- Add or modify hl groups globally, theme specific hl groups take priority.
				modify_hl_groups = function(hl, c)
					hl.PluginColor4 = { fg = c.my_grey, bg = c.none }
				end,
				["@String"] = { fg = "#ff00ff", bg = "NONE" },
			},
			astrodark = {
				-- first parameter is the highlight table and the second parameter is the color palette table
				modify_hl_groups = function(hl, c) -- modify_hl_groups function allows you to modify hl groups,
					hl.Comment.fg = c.my_color
					hl.Comment.italic = true
				end,
				["@String"] = { fg = "#ff00ff", bg = "NONE" },
			},
		},
	})
Colors.register("enfocado", nil, "wuelnerdotexe/vim-enfocado"):add_flavours({
	"nature",
	"neon",
}, function(_, flavour)
	vim.g.enfocado_style = flavour
	vim.cmd.colorscheme("enfocado")
end)
