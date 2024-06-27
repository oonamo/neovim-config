return {
	"nvim-telescope/telescope.nvim",
	lazy = true,
	tag = "0.1.6",
	-- or                              , branch = '0.1.x',
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
		},
	},
	config = function()
		require("plugins.editor.confs.telescope")
	end,
	keys = function()
		local builtin = require("telescope.builtin")
		return {
			{
				"<C-P>",
				builtin.find_files,
				desc = "find files",
			},
			{
				"<C-F>",
				builtin.live_grep,
				desc = "grep live",
			},
			{
				"<leader>fh",
				builtin.help_tags,
				desc = "help tags",
			},
			{
				"<leader>gw",
				builtin.grep_string,
				desc = "grep word",
			},
			{
				"<leader>gw",
				builtin.grep_string,
				desc = "grep word",
			},
			{
				"<leader>\\",
				builtin.current_buffer_fuzzy_find,
				desc = "find from current buffer",
			},
			{
				"z=",
				builtin.spell_suggest,
				desc = "find from current buffer",
			},
			{
				"<leader>fe",
				function()
					require("telescope.builtin").find_files({
						prompt_title = "Open in Mini.Files",
						find_command = {
							"fd",
							"--type",
							"d",
							".",
							vim.uv.cwd(),
						},
						attach_mappings = function(_, map)
							local state = require("telescope.actions.state")
							local actions = require("telescope.actions")
							map("i", "<CR>", function(prompt_buffer)
								local content = state.get_selected_entry()
								actions.close(prompt_buffer)
								local dir = content.value
								require("mini.files").open(dir, false)
							end)
							return true
						end,
					})
				end,
				desc = "Open dir in mini files",
			},
		}
	end,
}
