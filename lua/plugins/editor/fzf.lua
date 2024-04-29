return {
	"ibhagwan/fzf-lua",
	cmd = "FzfLua",
	lazy = true,
	opts = function()
		local actions = require("fzf-lua.actions")
		local bg_plus_hl =
			{ vim.o.background == "dark" and "bg" or "fg", vim.o.background == "dark" and "CursorLine" or "Normal" }
		-- local bg_plus_hl = { "bg", "CursorLine" }
		return {
			"max-perf",
			buffers = {
				cwd_prompt = false,
				ignore_current_buffer = true,
				prompt = "   ",
			},
			files = {
				cwd_prompt = false,
				prompt = "   ",
			},
			grep = {
				cmd = "rg -o -r '' --column --no-heading --color=never --smart-case",
				prompt = "   ",
				fzf_opts = {
					["--keep-right"] = "",
				},
			},
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
			fzf_opts = { ["--keep-right"] = "" },
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
				-- border = "single",
				fullscreen = false,
				-- preview = {
				-- 	delay = 150,
				-- 	scrollbar = false,
				-- 	default = "builtin",
				-- 	wrap = "wrap",
				-- 	horizontal = "right:45%",
				-- 	vertical = "down:40%",
				-- 	winopts = {
				-- 		cursorlineopt = "line",
				-- 		foldcolumn = 0,
				-- 	},
				-- },
				fzf_colors = {
					["bg"] = { "bg", "NormalFloat" },
					["bg+"] = { "bg", "CursorLine" },
					["fg+"] = { "fg", "CursorLine" },
					["gutter"] = { "bg", "NormalFloat" },
					["header"] = { "fg", "NonText" },
					["info"] = { "fg", "NonText" },
					["pointer"] = { "bg", "Cursor" },
					--  ["prompt"]    = { "fg", "Number" },
					["separator"] = { "bg", "NormalFloat" },
					["spinner"] = { "fg", "NonText" },
				},
				-- split = "aboveleft vnew",
				-- split = "belowright new",
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
				-- height = 0.85, -- window height
				-- width = 0.80, -- window width
				-- row = 0.35, -- window row position (0=top, 1=bottom)
				-- col = 0.50, -- window col position (0=left, 1=right)
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
			-- TODO: OLD
			--
			-- fzf_opts = {
			-- 	-- 	["--ansi"] = "",
			-- 	-- 	["--info"] = "inline",
			-- 	-- 	["--height"] = "100%",
			-- 	["--layout"] = "reverse",
			-- 	-- 	["--border"] = "none",
			-- 	-- 	["--prompt"] = "❯",
			-- 	-- 	["--pointer"] = "❯",
			-- 	-- 	["--marker"] = "❯",
			-- 	-- 	["--no-scrollbar"] = "",
			-- },

			-- fzf_colors = {
			-- 	["fg"] = { "fg", "FzfLuaColorsFg" },
			-- 	["fg+"] = { "fg", "FzfLuaColorsFgSel", "reverse:-1" },
			-- 	["bg"] = { "fg", "FzfLuaColorsBg" },
			-- 	["bg+"] = { "fg", "FzfLuaColorsBgSel" },
			-- 	["hl"] = { "fg", "FzfLuaColorsHl" },
			-- 	["hl+"] = { "fg", "FzfLuaColorsHlSel", "underline:reverse:-1" },
			-- 	["info"] = { "fg", "FzfLuaColorsInfo" },
			-- 	["prompt"] = { "fg", "FzfLuaColorsPrompt" },
			-- 	["pointer"] = { "fg", "FzfLuaColorsPointer" },
			-- 	["marker"] = { "fg", "FzfLuaColorsMarker" },
			-- 	["spinner"] = { "fg", "FzfLuaColorsSpinner" },
			-- 	["header"] = { "fg", "FzfLuaColorsHeader" },
			-- },
			-- OLD
			-- fzf_colors = {
			-- 	["fg"] = { "fg", "CursorLine" },
			-- 	["bg"] = { "bg", "Normal" },
			-- 	["hl"] = { "fg", "Comment" },
			-- 	["fg+"] = { "fg", "Normal" },
			-- 	["bg+"] = { "bg", "CursorLine" },
			-- 	["hl+"] = { "fg", "Statement" },
			-- 	["info"] = { "fg", "PreProc" },
			-- 	["prompt"] = { "fg", "Conditional" },
			-- 	["pointer"] = { "fg", "Exception" },
			-- 	["marker"] = { "fg", "Keyword" },
			-- 	["spinner"] = { "fg", "Label" },
			-- 	["header"] = { "fg", "Comment" },
			-- 	["gutter"] = { "bg", "Normal" },
			-- },
			-- files = {
			-- 	actions = {
			-- 		["ctrl-q"] = false,
			-- 	},
			-- },
		}
	end,
	config = function(_, opts)
		require("fzf-lua").setup(opts)
		require("onam.utils").create_fzf_lua_hls()
		-- vim.cmd.FzfLua("register_ui_select")
	end,
	cond = vim.g.use_FZF,
	keys = {
		{ "<leader>ff", "<cmd>FzfLua files<cr>", desc = "[f]zf [f]iles" },
		{ "<leader>fs", "<cmd>FzfLua live_grep<cr>", desc = "fzf grep" },
		-- { "<leader>fr", "<cmd>FzfLua live_grep_resume<cr>", desc = "fzf grep resume" },
		{ "<leader>fr", "<cmd>FzfLua lsp_references<cr>", desc = "fzf grep resume" },
		{ "<leader>g?", "<cmd>FzfLua help_tags<cr>", desc = "fzf help" },
		{ "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "fzf commands" },
		-- { "<C-p>", "<cmd>FzfLua files<cr>", desc = "Find files" },
		{
			"<C-p>",
			function()
				require("fzf-lua").files({
					-- winopts = {
					-- 	fullscreen = false,
					-- 	height = 0.90,
					-- 	width = 1,
					-- },
				})
			end,
		},
		{ "<C-f>", "<cmd>FzfLua live_grep_glob<cr>", desc = "Live grep glob" },
		{
			"<leader>fc",
			function()
				require("fzf-lua").complete_path()
			end,
			desc = "fzf commands",
		},
	},
}
