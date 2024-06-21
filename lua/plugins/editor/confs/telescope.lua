local actions = require("telescope.actions")
local layout = require("telescope.actions.layout")
local rg_args = {
	-- "rg",
	-- "--vimgrep",
	-- "--files",
	-- "--color=never",
	-- "--hidden",
	-- "--follow",
	-- "--smart_case",
	-- "-g",
	-- '"!.git"',
	"rg",
	"--vimgrep",
	"--color=never",
	"--files",
	"--follow",
	"--hidden",
	"--no-ignore-vcs",
	"--smart-case",
	"-g",
	"!.git",
}
require("telescope").setup({
	defaults = {
		prompt_prefix = "  ", -- ❯  
		selection_caret = "▍ ",
		multi_icon = " ",
		color_devicons = false,
		-- layout_config = {
		-- 	horizontal = {
		-- 		height = 0.85,
		-- 	},
		-- },
		-- To disable
		-- preview = false,
		preview = {
			hide_on_startup = true,
		},
		mappings = {
			n = {
				["<ESC>"] = actions.close,
				["<C-c>"] = actions.close,
				["<C-y>"] = layout.toggle_preview,
			},
			i = {
				["<C-y>"] = layout.toggle_preview,
			},
		},
	},
	pickers = {
		find_files = {
			disable_devicons = true,
			find_command = rg_args,
			theme = "dropdown",
			sorting_strategy = "descending",
		},
		live_grep = {
			border = true,
			borderchars = {
				prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
				results = { " " },
				preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
			},
			sorting_strategy = "ascending",
			layout_strategy = "bottom_pane",
			layout_config = {
				height = function()
					return math.floor(vim.o.columns * 0.15)
				end,
			},
		},
		spell_suggest = {
			spell_suggest = {
				theme = "cursor",
				layout_config = { height = 0.45 },
			},
		},
	},
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
