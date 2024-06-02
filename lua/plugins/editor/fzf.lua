return {
	"ibhagwan/fzf-lua",
	config = function()
		local fzf = require("fzf-lua")
		fzf.setup({
			buffers = {
				cwd_prompt = false,
				ignore_current_buffer = true,
				prompt = "Buffers: ",
			},
			files = {
				cwd_prompt = false,
				prompt = "Files: ",
				formatter = "path.filename_first",
				winopts = {
					height = 0.59,
					width = 0.90,
					row = 0.48,
					col = 0.45,
					preview = {
						vertical = "up:45%",
						hidden = "hidden",
					},
				},
			},
			grep = {
				cmd = "rg -o -r '' --column --no-heading --smart-case",
				prompt = "Text: ",
			},
			lsp = {
				prompt_postfix = ": ",
			},
			global_git_icons = false,
			fzf_colors = {
				["bg"] = { "bg", "NormalFloat" },
				["bg+"] = { "bg", "CursorLine" },
				["fg"] = { "fg", "Pmenu" },
				["fg+"] = { "fg", "Normal" },
				-- ["hl"] = { "fg", "CmpItemAbbrMatch" },
				-- ["hl+"] = { "fg", "CmpItemAbbrMatch" },
				["gutter"] = { "bg", "NormalFloat" },
				["header"] = { "fg", "NonText" },
				["info"] = { "fg", "NonText" },
				["pointer"] = { "bg", "Cursor" },
				["separator"] = { "bg", "NormalFloat" },
				["spinner"] = { "fg", "NonText" },
			},
			fzf_opts = {
				["--keep-right"] = "",
				-- ["--info"] = "default",
				-- ["--layout"] = "reverse-list",
			},
			winopts = {
				cursorline = true,
				border = tools.ui.cur_border,
				height = 0.35,
				width = 1,
				row = 1,
				hl = {
					border = "FloatBorder",
					header_bind = "NonText",
					header_text = "NonText",
					help_normal = "NonText",
					normal = "NormalFloat",
					preview_border = "FloatBorder",
					preview_normal = "NormalFloat",
					search = "CmpItemAbbrMatch",
					title = "FloatTitle",
				},
				preview = {
					layout = "horizontal",
					scrollbar = "border",
					vertical = "up:65%",
				},
			},
			keymap = {
				builtin = {
					["<C-d>"] = "preview-page-down",
					["<C-u>"] = "preview-page-up",
					["<C-/>"] = "toggle-help",
					["<C-a>"] = "toggle-fullscreen",
					["<C-i>"] = "toggle-preview",
				},
				fzf = {
					["ctrl-d"] = "preview-page-down",
					["ctrl-u"] = "preview-page-up",
					["ctrl-q"] = "select-all+accept",
				},
			},
		})
	end,
	keys = function()
		local fzf = require("fzf-lua")
		return {
			{ "<leader>fq", fzf.quickfix, desc = "Fzf quickfix" },
			{ "<leader>fr", fzf.lsp_references, desc = "Fzf lsp_references" },
			{ "<leader>fh", fzf.help_tags, desc = "Fzf help" },
			{ "<leader>fi", fzf.highlights, desc = "Fzf Highlights" },
			{ "<leader>fb", fzf.buffers, desc = "Fzf buffers" },
			{ "<leader>fd", fzf.lsp_document_diagnostics, desc = "Fzf lsp diagnostics" },
			{ "<C-p>", fzf.files, desc = "Fzf files" },
			{ "<C-f>", fzf.live_grep_glob, desc = "Live grep glob" },
			{ "<leader>fc", fzf.complete_path, desc = "fzf complete_path" },
			{ "z=", fzf.spell_suggest, desc = "spell suggest" },
		}
	end,
}
