local function dropdown(opts)
	opts = opts or {}
	local title = vim.tbl_get(opts, "winopts", "title")
	return vim.tbl_deep_extend("force", {
		prompt = "   ",
		fzf_opts = { ["--layout"] = "reverse" },
		winopts = {
			title_pos = opts.winopts.title and "center" or nil,
			height = 0.70,
			width = 0.45,
			row = 0.1,
			preview = { hidden = "hidden", layout = "vertical", vertical = "up:50%" },
		},
	}, opts)
end

local function drop(opts)
	return {
		winopts = {
			border = "single",
			fullscreen = false,
			width = 0.8,
			height = 0.75,
			preview = {
				delay = 150,
				scrollbar = false,
				default = "builtin",
				wrap = "wrap",
				horizontal = "right:45%",
				vertical = "down:40%",
				winopts = {
					cursorlineopt = "line",
					foldcolumn = 0,
				},
			},
		},
	}
end

local function bottom_split(opts)
	return vim.tbl_deep_extend("force", {
		prompt = "   ",
		fzf_opts = { ["--layout"] = "reverse" },
		winopts = {
			title_pos = opts.winopts.title and "center" or nil,
			cursorline = true,
			border = tools.ui.cur_border,
			height = 0.35,
			width = 1,
			row = 1,
			hls = {
				border = "FloatBorder",
				header_bind = "NonText",
				header_text = "NonText",
				help_normal = "NonText",
				normal = "NormalFloat",
				preview_border = "NormalFloat",
				preview_normal = "NormalFloat",
				search = "IncSearch",
				title = "FloatTitle",
			},
			preview = {
				-- default = 'bat_native',
				-- border = "border",
				-- layout = "vertical",
				horizontal = "right:30%",
				-- vertical = "up:50%",
				-- using winopts_fn to set truncation
				-- flip_columns = truncation.truncation_limit_s_terminal
				-- builtin previewer
				-- scrollbar = false,
				-- delay = 50,
				-- border = "border",
				layout = "horizontal",
				scrollbar = "border",
				vertical = "up:65%",
			},
		},
	}, opts)
end

local function cursor_dropdown(opts)
	return dropdown(vim.tbl_deep_extend("force", {
		fzf_opts = { ["--keep-right"] = "" },
		winopts = {
			row = 1,
			relative = "cursor",
			height = 0.33,
			width = 0.25,
		},
	}, opts))
end

local fzf_lua = require("fzf-lua")

return {
	"ibhagwan/fzf-lua",
	cmd = "FzfLua",
	lazy = true,
	opts = function()
		local actions = require("fzf-lua.actions")
		-- local bg_plus_hl = { "bg", "CursorLine" }
		return {
			"max-perf",
			buffers = {
				cwd_prompt = false,
				ignore_current_buffer = true,
				prompt = "   ",
			},
			keymaps = dropdown({
				winopts = { title = "keymaps", width = 0.7 },
			}),
			files = bottom_split({
				cwd_prompt = false,
				prompt = "   ",
				-- winopts = { title = "files" },
				winopts = { title = "files" },
				-- formatter = "path.filename_first",
			}),
			grep = bottom_split({
				winopts = { title = "grep" },
				cmd = "rg -o -r '' --column --no-heading --color=never --smart-case",
				prompt = "   ",
				fzf_opts = {
					["--keep-right"] = "",
				},
			}),
			fzf_colors = {
				["bg"] = { "bg", "NormalFloat" },
				["bg+"] = { "bg", "CursorLine" },
				["fg+"] = { "fg", "Function" },
				["gutter"] = { "bg", "NormalFloat" },
				["header"] = { "fg", "NonText" },
				["info"] = { "fg", "NonText" },
				["pointer"] = { "bg", "Cursor" },
				--  ["prompt"]    = { "fg", "Number" },
				["separator"] = { "bg", "NormalFloat" },
				["spinner"] = { "fg", "NonText" },
			},
			fzf_opts = {
				["--keep-right"] = "",
				["--scrollbar"] = "▓",
			},
			winopts = {
				cursorline = true,
				border = tools.ui.cur_border,
				height = 0.35,
				width = 1,
				row = 1,
				hls = {
					border = "FloatBorder",
					header_bind = "NonText",
					header_text = "NonText",
					help_normal = "NonText",
					normal = "NormalFloat",
					preview_border = "NormalFloat",
					preview_normal = "NormalFloat",
					search = "IncSearch",
					title = "FloatTitle",
				},
				fullscreen = false,
				fzf_colors = {
					["bg"] = { "bg", "NormalFloat" },
					["bg+"] = { "bg", "CursorLine" },
					["fg+"] = { "fg", "CursorLine" },
					["gutter"] = { "bg", "NormalFloat" },
					["header"] = { "fg", "NonText" },
					["info"] = { "fg", "NonText" },
					["pointer"] = { "bg", "Cursor" },
					["separator"] = { "bg", "NormalFloat" },
					["spinner"] = { "fg", "NonText" },
				},
				preview = {
					horizontal = "right:30%",
					layout = "horizontal",
					scrollbar = "border",
					vertical = "up:65%",
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
					["ctrl-l"] = actions.file_sel_to_ll,
					["ctrl-s"] = actions.file_split,
					["ctrl-v"] = actions.file_vsplit,
					["ctrl-t"] = actions.file_tabedit,
				},
				buffers = {
					["default"] = actions.buf_edit_or_qf,
					["ctrl-l"] = actions.buf_sel_to_ll,
					["ctrl-s"] = actions.buf_split,
					["ctrl-v"] = actions.buf_vsplit,
					["ctrl-t"] = actions.buf_tabedit,
				},
			},
		}
	end,
	config = function(_, opts)
		require("fzf-lua").setup(opts)
		require("onam.utils").create_fzf_lua_hls()
		-- vim.cmd.FzfLua("register_ui_select")
	end,
	cond = vim.g.use_FZF,
	keys = {
		{
			"<leader>ff",
			function()
				fzf_lua.files(drop())
			end,
			desc = "[f]zf [f]iles",
		},
		{ "<leader>fs", fzf_lua.live_grep, desc = "fzf grep" },
		-- { "<leader>fr", "<cmd>FzfLua live_grep_resume<cr>", desc = "fzf grep resume" },
		{ "<leader>fr", fzf_lua.lsp_references, desc = "fzf grep resume" },
		{ "<leader>g?", fzf_lua.help_tags, desc = "fzf help" },
		{ "<leader>fb", fzf_lua.buffers, desc = "fzf buffers" },
		-- { "<C-p>", "<cmd>FzfLua files<cr>", desc = "Find files" },
		{
			"<C-p>",
			fzf_lua.files,
			-- function()
			-- 	require("fzf-lua").files({
			-- 		-- winopts = {
			-- 		-- 	fullscreen = false,
			-- 		-- 	height = 1.90,
			-- 		-- 	width = 1,
			-- 		-- },
			-- 	})
			-- end,
		},
		{ "<C-f>", fzf_lua.live_grep_glob, desc = "Live grep glob" },
		{
			"<leader>fc",
			function()
				require("fzf-lua").complete_path()
			end,
			desc = "fzf complete_path",
		},
		{
			"z=",
			fzf_lua.spell_suggest,
			desc = "spell suggest",
		},
	},
}
