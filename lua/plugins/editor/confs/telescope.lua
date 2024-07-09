local actions = require("telescope.actions")
local layout = require("telescope.actions.layout")

local defaults = require("telescope.themes").get_ivy({
	layout_config = { height = 0.30 },
})

defaults.prompt_prefix = "  " -- ❯  
defaults.selection_caret = "▍ "
defaults.multi_icon = " "
-- color_devicons = false,
defaults.vimgrep_arguments = {
	"rg",
	"-L",
	"--color=never",
	"--no-heading",
	"--with-filename",
	"--line-number",
	"--column",
	"--smart-case",
}

defaults.preview = {
	hide_on_startup = true,
}

defaults.mappings = {
	n = {
		["<ESC>"] = actions.close,
		["<C-c>"] = actions.close,
		["<C-y>"] = layout.toggle_preview,
	},
	i = {
		["<C-y>"] = layout.toggle_preview,
	},
}

require("telescope").setup({
	defaults = defaults,
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
	},
})

require("telescope").load_extension("fzf")
