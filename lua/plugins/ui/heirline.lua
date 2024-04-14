return {
	"rebelot/heirline.nvim",
	cond = function()
		return true
	end,
	lazy = true,
	event = { "VeryLazy" },
	config = function(_, opts)
		local heirline_utils = require("heirline.utils")
		local heirline = require("heirline")
		local function get_colors()
			local onam_utils = require("onam.utils")
			local fg, bg, hl = onam_utils.get_hl("StatusLine")
			local colors = {
				bright_bg = heirline_utils.get_highlight("Folded").bg,
				bright_fg = heirline_utils.get_highlight("Folded").fg,
				red = heirline_utils.get_highlight("DiagnosticError").fg,
				dark_red = heirline_utils.get_highlight("DiffDelete").bg,
				green = heirline_utils.get_highlight("String").fg,
				blue = heirline_utils.get_highlight("Function").fg,
				gray = heirline_utils.get_highlight("NonText").fg,
				orange = heirline_utils.get_highlight("Constant").fg,
				purple = heirline_utils.get_highlight("Statement").fg,
				cyan = heirline_utils.get_highlight("Special").fg,
				diag_warn = heirline_utils.get_highlight("DiagnosticWarn").fg,
				diag_error = heirline_utils.get_highlight("DiagnosticError").fg,
				diag_hint = heirline_utils.get_highlight("DiagnosticHint").fg,
				diag_info = heirline_utils.get_highlight("DiagnosticInfo").fg,
				git_del = heirline_utils.get_highlight("diffDeleted").fg,
				git_add = heirline_utils.get_highlight("diffAdded").fg,
				git_change = heirline_utils.get_highlight("diffChanged").fg,
				fg = fg,
				bg = bg,
			}
			if vim.g.colors_name == "gruvbox" or vim.g.colors_name == "hybrid" then
				local fg, bg, _ = onam_utils.get_hl("StatusLine")
				colors.fg = bg
				colors.bg = fg
				fg, bg, _ = onam_utils.get_hl("Folded")
				colors.bright_fg = bg
				colors.bright_bg = fg
			end
			if not vim.g.use_noice then
				vim.o.cmdheight = 1
				vim.g.noshowmode = true
				-- require("onam.autocmds").setup_status_cmds()
			end
			return colors
		end
		local statusline = require("plugins.ui.heirline.statusline")
		local conditions = require("heirline.conditions")
		heirline.setup({
			statusline = statusline.statusline,
			-- tabline = tabline,
			statuscolumn = require("plugins.ui.heirline.statuscolumn"),
			winbar = require("plugins.ui.heirline.winbar").winbar,
			opts = {
				colors = get_colors(),
				disable_winbar_cb = function(args)
					return conditions.buffer_matches({
						buftype = { "nofile", "prompt", "help", "quickfix" },
						filetype = { "^git.*", "fugitive", "Trouble", "dashboard" },
					}, args.buf)
				end,
			},
		})
		-- vim.o.showtabline = 2
		vim.cmd([[au FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif]])
		vim.api.nvim_create_augroup("Heirline", { clear = true })
		vim.api.nvim_create_autocmd({ "ColorScheme" }, {
			callback = function()
				heirline_utils.on_colorscheme(get_colors)
			end,
			group = "Heirline",
		})
	end,
}
