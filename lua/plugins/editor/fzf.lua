return {
	"ibhagwan/fzf-lua",
	cmd = "FzfLua",
	lazy = true,
	opts = function()
		local actions = require("fzf-lua.actions")
		return {
			-- "fzf-native",
			"telescope",
			winopts = {
				hls = {},
				-- split = "aboveleft vnew",
				-- split = "belowright new",
				preview = {
					-- default = 'bat_native',
					border = "border",
					layout = "flex",
					horizontal = "right:70%",
					vertical = "up:50%",
					-- using winopts_fn to set truncation
					-- flip_columns = truncation.truncation_limit_s_terminal
					-- builtin previewer
					scrollbar = false,
					delay = 50,
				},
			},
			keymap = {
				builtin = {
					["<C-d>"] = "preview-page-down",
					["<C-u>"] = "preview-page-up",
				},
				fzf = {
					["ctrl-d"] = "preview-page-down",
					["ctrl-u"] = "preview-page-up",
					["ctrl-q"] = "select-all+accept",
				},
			},
			actions = {
				files = {
					["default"] = actions.file_edit_or_qf,
					-- ["ctrl-q"] = actions.set_qf_list,
					["ctrl-l"] = actions.file_sel_to_ll,
					["ctrl-s"] = actions.file_split,
					["ctrl-v"] = actions.file_vsplit,
					["ctrl-t"] = actions.file_tabedit,
				},
				buffers = {
					["default"] = actions.buf_edit_or_qf,

					-- ["ctrl-q"] = actions.buf_sel_to_qf,
					-- ["ctrl-q"] = actions.set_qf_list,
					["ctrl-l"] = actions.buf_sel_to_ll,
					["ctrl-s"] = actions.buf_split,
					["ctrl-v"] = actions.buf_vsplit,
					["ctrl-t"] = actions.buf_tabedit,
				},
			},
			fzf_opts = {
				["--layout"] = "reverse",
			},
			files = {
				actions = {
					["ctrl-q"] = false,
				},
			},
		}
	end,
	config = function(_, opts)
		require("fzf-lua").setup(opts)
		-- vim.cmd.FzfLua("register_ui_select")
	end,
	cond = vim.g.use_FZF,
	keys = {
		{ "<leader>ff", "<cmd>FzfLua files<cr>", desc = "[f]zf [f]iles" },
		{ "<leader>fs", "<cmd>FzfLua live_grep<cr>", desc = "fzf grep" },
		{ "<leader>fr", "<cmd>FzfLua live_grep_resume<cr>", desc = "fzf grep resume" },
		{ "<leader>flr", "<cmd>FzfLua lsp_references<cr>", desc = "fzf grep resume" },
		{ "<leader>g?", "<cmd>FzfLua help_tags<cr>", desc = "fzf help" },
		{
			"<leader>fc",
			function()
				require("fzf-lua").complete_path()
			end,
			desc = "fzf commands",
		},
	},
}
