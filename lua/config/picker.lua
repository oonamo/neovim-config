local Picker = {}

function Picker.find_files(picker)
	if picker == "telescope" then
		require("telescope.builtin").find_files()
	else
		require("mini.pick").registry.files()
	end
end

function Picker.keys(picker)
	return {
		{
			"<leader>,",
			"<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
			desc = "Switch Buffer",
		},
		{
			"<C-P>",
			function()
				require("telescope.builtin").find_files()
			end,
			desc = "find files",
		},
		{
			"<C-F>",
			function()
				require("telescope.builtin").live_grep()
			end,
			desc = "grep live",
		},
		{
			"<leader>fh",
			function()
				require("telescope.builtin").help_tags()
			end,
			desc = "help tags",
		},
		{
			"<leader>gw",
			function()
				require("telescope.builtin").grep_string()
			end,
			desc = "grep word",
		},
		{
			"<leader>gw",
			function()
				require("telescope.builtin").grep_string()
			end,
			desc = "grep word",
		},
		{
			"<leader>\\",
			function()
				require("telescope.builtin").current_buffer_fuzzy_find()
			end,
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
		{
			"<leader>fi",
			function()
				require("telescope.builtin").highlights()
			end,
			desc = "highlights",
		},
		{
			"<leader>fm",
			function()
				require("telescope.builtin").marks()
			end,
			desc = "marks",
		},
		{
			"<leader>ss",
			"<cmd>Telescope aerial<cr>",
			desc = "Goto Symbol (aerial)",
		},
		{
			"<leader>gb",
			"<cmd>Telescope buffers<cr>",
			desc = "Find Buffers",
		},
		{
			"<C-x><C-f>",
			function()
				require("telescope").extensions.file_browser.file_browser()
			end,
			desc = "Open File Browser",
		},
		{
			"<leader>of",
			"<cmd>Telescope frecency workspace=CWD<cr>",
			desc = "Old files (cwd)",
		},
		{
			"<leader>oF",
			"<cmd>Telescope frecency<cr>",
			desc = "Old files",
		},
	}
end
