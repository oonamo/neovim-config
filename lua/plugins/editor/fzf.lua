local fzf = require("fzf-lua")
fzf.setup({
	winopts_fn = function()
		local has_tabline = vim.o.showtabline == 2 or (vim.o.showtabline == 1 and #vim.api.nvim_list_tabpages() > 1)
		local max_height = vim.o.lines - vim.o.cmdheight - 1
		local max_width = vim.o.columns
		return {
			relative = "editor",
			anchor = "SW",
			width = math.floor(0.618 * max_width),
			height = math.floor(0.618 * max_height),
			col = 0,
			row = max_height,
			border = "single",
			style = "minimal",
			footer = "RG",
		}
	end,
	-- "max-perf",
	-- { "fzf-vim", "max-perf" },
	-- { "max-perf", "fzf-vim" },
	manpages = { previewer = "man_native" },
	helptags = { previewer = "help_native" },
	defaults = {
		git_icons = false,
		file_icons = false,
	},
	files = {
		cwd_prompt = false,
		prompt = "Files: ",
		git_icons = false, -- show git icons?
		file_icons = false, -- show file icons?
		color_icons = false, -- colorize file|git icons
		-- formatter = "path.filename_first",
		-- winopts = {
		-- 	height = 0.59,
		-- 	width = 0.90,
		-- 	row = 0.48,
		-- 	col = 0.45,
		-- 	preview = {
		-- 		vertical = "up:45%",
		-- 		hidden = "hidden",
		-- 	},
		-- },
		-- HACK: rg and fg opts from mini.pick are faster
		rg_opts = [[--files --no-follow --color=never]],
		fd_opts = [[--type=f --no-follow --color=never]],
		fzf_opts = {
			["--ansi"] = false,
		},
	},
	-- grep = {
	-- 	cmd = "rg -o -r '' --column --no-heading --smart-case",
	-- 	prompt = "Text: ",
	-- },
	-- lsp = {
	-- 	prompt_postfix = ": ",
	-- },
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
		-- ["--keep-right"] = "",
		["--info"] = "default",
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
			hidden = "hidden",
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
	previewers = {
		builtin = {
			treesitter = { enable = false },
		},
	},
})

utils.norm_lazy_to_normal({ "<leader>fq", fzf.quickfix, desc = "Fzf quickfix" })
utils.norm_lazy_to_normal({ "<leader>fr", fzf.lsp_references, desc = "Fzf lsp_references" })
utils.norm_lazy_to_normal({ "<leader>fh", fzf.help_tags, desc = "Fzf help" })
utils.norm_lazy_to_normal({ "<leader>fi", fzf.highlights, desc = "Fzf Highlights" })
utils.norm_lazy_to_normal({ "<leader>fb", fzf.buffers, desc = "Fzf buffers" })
utils.norm_lazy_to_normal({ "<leader>fd", fzf.lsp_document_diagnostics, desc = "Fzf lsp diagnostics" })
utils.norm_lazy_to_normal({ "<leader>ff", fzf.files, desc = "Fzf files" })
utils.norm_lazy_to_normal({ "<C-f>", fzf.live_grep_glob, desc = "Live grep glob" })
utils.norm_lazy_to_normal({ "<leader>fc", fzf.complete_path, desc = "fzf complete_path" })
utils.norm_lazy_to_normal({ "z=", fzf.spell_suggest, desc = "spell suggest" })
