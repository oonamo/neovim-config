local M = {}

function M.setup(flavour)
	vim.cmd.hi("clear")
	if flavour == "dayfox" or flavour == "dawnfox" then
		vim.o.background = "light"
	else
		vim.o.background = "dark"
	end
	if flavour == "terafox" then
		vim.opt.cursorline = false
	else
		vim.opt.cursorline = true
	end
	vim.cmd.colorscheme(flavour)

	local n_b_neg_5 = utils.brighten("Normal", -50)
	local n_f_neg_14 = utils.brighten("Normal", -40)
	local n_b_pos_2 = utils.brighten("Normal", 20)
	local normal = utils.get_single_hl("Normal")
	-- #c2c3c4
	-- #cbcccd
	-- #666767
	-- #2e3440
	utils.hl = {
		opts = {
			-- { "NormalNC", { fg = normal.foreground, bg = n_b_neg_5 } },
			-- { "VertSplit", { fg = normal.foreground, bg = n_b_neg_5 } },
			-- { "WinBar", { fg = n_f_neg_14, bg = n_b_pos_2 } },
			-- { "WinBarNC", { fg = n_f_neg_14, bg = n_b_neg_5 } },
			{ "Whitespace", { link = "Comment" } },
		},
	}
	-- hl_manager.match_hl_to_highlight("VertSplit", "Normal", { bg = -5 }) -- just use bg colr from normal
	-- hl_manager.match_hl_to_highlight("WinBar", "Normal", { fg = -14, bg = 2 })
	-- hl_manager.match_hl_to_highlight("WinBarNC", "Normal", { fg = -14, bg = -5 })
	-- hl_manager.highlight_link("Whitespace", "Comment")
	--
	-- hl_manager.match_color_to_highlight("#a4cf69", "CursorLine", "DiffAdd", "background")
	-- hl_manager.match_color_to_highlight("#63c1e6", "CursorLine", "DiffChange", "background")
	-- hl_manager.match_color_to_highlight("#d74f56", "CursorLine", "DiffDelete", "background")
	-- hl_manager.match_color_to_highlight("#FFba00", "CursorLine", "DiffText", "background")

	-- XXX: why cursor wont change color?
	utils:create_hl()
	vim.api.nvim_set_hl(0, "Cursor", { bg = "#FFba00", reverse = false, fg = "#FF0000" })
end

return M
