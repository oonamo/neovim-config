return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			signcolumn = true,
			-- signs = {
			-- 	add = {
			-- 		hl = "GitSignsAdd",
			-- 		text = tools.ui.icons.BoldLineMiddle,
			-- 		numhl = "GitSignsAddNr",
			-- 		linehl = "GitSignsAddLn",
			-- 	},
			-- 	change = {
			-- 		hl = "GitSignsChange",
			-- 		text = tools.ui.icons.BoldLineDashedMiddle,
			-- 		numhl = "GitSignsChangeNr",
			-- 		linehl = "GitSignsChangeLn",
			-- 	},
			-- 	delete = {
			-- 		hl = "GitSignsDelete",
			-- 		text = tools.ui.icons.TriangleShortArrowRight,
			-- 		numhl = "GitSignsDeleteNr",
			-- 		linehl = "GitSignsDeleteLn",
			-- 	},
			-- 	topdelete = {
			-- 		hl = "GitSignsDelete",
			-- 		text = tools.ui.icons.TriangleShortArrowRight,
			-- 		numhl = "GitSignsDeleteNr",
			-- 		linehl = "GitSignsDeleteLn",
			-- 	},
			-- 	changedelete = {
			-- 		hl = "GitSignsChange",
			-- 		text = tools.ui.icons.BoldLineMiddle,
			-- 		numhl = "GitSignsChangeNr",
			-- 		linehl = "GitSignsChangeLn",
			-- 	},
			-- },
			watch_gitdir = {
				interval = 1000,
				follow_files = true,
			},
		},
		config = function(_, opts)
			local set_hl = vim.api.nvim_set_hl

			local red = "DiagnosticError"
			local ylw = "DiagnosticWarn"
			local add_sym = "┃"
			local change_sym = "┃"
			local del_sym = "▶"

			local sign_tbl = {}
			local dim_hl, fg
			for grp, cfg in pairs({
				Add = { "DiagnosticOk", add_sym },
				Change = { ylw, change_sym },
				Changedelete = { ylw, change_sym },
				Delete = { red, del_sym },
				Topdelete = { red, del_sym },
			}) do
				dim_hl = utils.brighten(cfg[1], -25)
				set_hl(0, "GitSigns" .. grp, { fg = dim_hl })

				sign_tbl[string.lower(grp)] = { text = cfg[2] }
			end

			set_hl(0, "GitSignsUntracked", { link = "NonText" })
			sign_tbl["untracked"] = { text = add_sym }
			local s_fg, bg, status_hl = utils.get_hl("StatusLine")
			local bright_fg, bright_bg, folded_hl = utils.get_hl("Folded")
			if not bright_bg then
				-- bright_bg = bg
				-- bright_fg = fg
				_, bright_bg, _ = utils.get_hl("CursorLine")
			end
			if not bright_fg then
				bright_fg, _, _ = utils.get_hl("CursorLine")
			end

			-- local _, diffadd_bg, _ = utils.get_hl("DiffAdd")
			-- local _, diffrm_bg, _ = utils.get_hl("DiffDelete")
			local diffadd_lighter = utils.brighten("DiffAdd", 75, "background")
			local diffrm_lighter = utils.brighten("DiffDelete", 75, "background")

			set_hl(0, "GitSignsAddInline", { link = "DiffAdd" })
			set_hl(0, "GitSignsAddLnInline", { fg = fg, bg = diffadd_lighter })
			set_hl(0, "GitSignsChangeInline", { link = "DiffText" })
			set_hl(0, "GitSignsChangeLnInline", { link = "DiffChange" })
			set_hl(0, "GitSignsDeleteInline", { link = "DiffDelete" })
			set_hl(0, "GitSignsDeleteLnInline", { fg = fg, bg = diffrm_lighter })
			-- set_hl(0, "GitSignsAddLn", { bg = bg })
			opts.signs = sign_tbl
			require("gitsigns").setup(opts)
		end,
	},
}
