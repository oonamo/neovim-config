return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
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

			local diffadd_lighter = utils.brighten("DiffAdd", 75)
			local diffrm_lighter = utils.brighten("DiffDelete", 75)
			-- set_hl(0, "GitSignsAddInline", { link = "DiffAdd" })
			-- set_hl(0, "GitSignsAddLnInline", { fg = "fg", bg = diffadd_lighter })
			-- set_hl(0, "GitSignsChangeInline", { link = "DiffText" })
			-- set_hl(0, "GitSignsChangeLnInline", { link = "DiffChange" })
			-- set_hl(0, "GitSignsDeleteInline", { link = "DiffDelete" })
			-- set_hl(0, "GitSignsDeleteLnInline", { fg = "fg", bg = diffrm_lighter })
		end,
		config = true,
	},
}
