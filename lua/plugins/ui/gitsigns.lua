return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			signcolumn = true,
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
			local sign_bg = utils.get_single_hl("SignColumn").background or "NONE"

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
				set_hl(0, "GitSigns" .. grp, { fg = dim_hl, bg = sign_bg })

				sign_tbl[string.lower(grp)] = { text = cfg[2] }
			end

			set_hl(0, "GitSignsUntracked", { link = "NonText" })
			sign_tbl["untracked"] = { text = add_sym }
			local bright_fg, bright_bg, _ = utils.get_hl("Folded")
			if not bright_bg then
				_, bright_bg, _ = utils.get_hl("CursorLine")
			end
			if not bright_fg then
				bright_fg, _, _ = utils.get_hl("CursorLine")
			end

			local diffadd_lighter = utils.brighten("DiffAdd", 75, "background")
			local diffrm_lighter = utils.brighten("DiffDelete", 75, "background")

			set_hl(0, "GitSignsAddInline", { link = "DiffAdd" })
			set_hl(0, "GitSignsAddLnInline", { fg = fg, bg = diffadd_lighter })
			set_hl(0, "GitSignsChangeInline", { link = "DiffText" })
			set_hl(0, "GitSignsChangeLnInline", { link = "DiffChange" })
			set_hl(0, "GitSignsDeleteInline", { link = "DiffDelete" })
			set_hl(0, "GitSignsDeleteLnInline", { fg = fg, bg = diffrm_lighter })
			opts.signs = sign_tbl
			require("gitsigns").setup(opts)
		end,
	},
}
