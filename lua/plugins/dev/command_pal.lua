return {
	dir = "~/projects/command_pal",
	dev = true,
	opts = {
		actions = {
			{
				group = "Writing",
				name = "Go To My Notes",
				command = "GoToNotes",
				desc = "Open my notes using mini.sessions",
			},
			{
				group = "Harpoon",
				name = "Add File to Harpoon",
				command = function()
					require("harpoon"):list():add()
				end,
				desc = "append file to harpoon",
			},
		},
		builtin = {},
		telescope = {
			opts = {},
		},
	},
	keys = {
		{
			"<C-x>",
			function()
				require("command_pal").open({})
			end,
		},
		{
			"<leader>fp",
			function()
				require("command_pal").open({
					filter_group = { "Vim", "Quickfix" },
				})
			end,
		},
		{
			"<leader>pp",
			function()
				require("command_pal").open({
					picker = "mini_pick",
				})
			end,
		},
		{
			"<leader>pf",
			function()
				require("command_pal").open({
					picker = "fzf-lua",
				})
			end,
		},
	},
}
