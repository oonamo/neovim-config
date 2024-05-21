local function fzf_vim()
	return {
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
	}
end

return {
	{
		"ibhagwan/fzf-lua",
		cmd = "FzfLua",
		keys = function()
			local fzf_lua = require("fzf-lua")
			return {
				{ "<leader>ff", fzf_lua.file, desc = "[f]zf [f]iles" },
				{ "<leader>fs", fzf_lua.live_grep, desc = "Fzf grep" },
				-- { "<leader>fr", "<cmd>FzfLua live_grep_resume<cr>", desc = "fzf grep resume" },
				{ "<leader>fr", fzf_lua.lsp_references, desc = "Fzf grep resume" },
				{ "<leader>fh", fzf_lua.help_tags, desc = "Fzf help" },
				{ "<leader>fi", fzf_lua.highlights, desc = "Fzf Highlights" },
				{ "<leader>fb", fzf_lua.buffers, desc = "Fzf buffers" },
				{ "<C-p>", fzf_lua.files },
				{ "<C-f>", fzf_lua.live_grep_glob, desc = "Live grep glob" },
				{ "<leader>fc", fzf_lua.complete_path, desc = "fzf complete_path" },
				{ "z=", fzf_lua.spell_suggest, desc = "spell suggest" },
			}
		end,
		opts = function()
			local actions = require("fzf-lua.actions")

			return {
				-- "max-perf",
				-- Make stuff better combine with the editor.
				-- manpages = { previewer = { default = "bat" } },
				fzf_colors = {
					bg = { "bg", "Normal" },
					gutter = { "bg", "Normal" },
					info = { "fg", "Conditional" },
					scrollbar = { "bg", "Normal" },
					separator = { "fg", "Comment" },
				},
				fzf_opts = {
					["--info"] = "default",
					["--layout"] = "reverse-list",
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
				-- winopts = {
				-- 	height = 0.7,
				-- 	width = 0.55,
				-- 	preview = {
				-- 		default = "bat",
				-- 		scrollbar = false,
				-- 		layout = "vertical",
				-- 		vertical = "up:40%",
				-- 	},
				-- },
				winopts = {
					height = 0.4,
					-- width = 0.90,
					width = 1,
					row = 1,
					col = 1,
					preview = {
						vertical = "up:45%",
						hidden = "nohidden",
					},
				},
				-- fzf_vim(),
				global_git_icons = false,
				-- Configuration for specific commands.
				files = {
					-- winopts = {
					-- 	preview = { hidden = "hidden" },
					-- },
					fzf_opts = { ["--ansi"] = false },
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
				defaults = {
					git_icons = false,
					file_icons = false,
				},
				helptags = {
					-- previewer = "help_native",
					actions = {
						-- Open help pages in a vertical split.
						["default"] = actions.help_vert,
					},
				},
				oldfiles = {
					include_current_session = true,
					winopts = {
						preview = { hidden = "hidden" },
					},
				},
				lsp = {
					previewer = "codeaction_native",
					previewer_pager = "delta --side-by-side -- width=$FZF_PREVIEW_COLUMNS",
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
					grep = {
						winopts = {
							preview = {
								default = "bat",
								vertical = "up:45%",
								hidden = "nohidden",
							},
						},
					},
				},
			}
		end,
	},
}
