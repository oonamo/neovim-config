return {
	{
		"rebelot/heirline.nvim",
		cond = function()
			return true
		end,
		lazy = true,
		event = { "VeryLazy" },
		config = function()
			local heirline_utils = require("heirline.utils")
			local heirline = require("heirline")
			local function get_colors()
				local onam_utils = require("onam.utils")
				local fg, bg, _ = onam_utils.get_hl("StatusLine")
				local bright_fg, bright_bg, _ = onam_utils.get_hl("Folded")
				if not bright_bg then
					_, bright_bg, _ = onam_utils.get_hl("CursorLine")
				end
				if not bright_fg then
					bright_fg, _, _ = onam_utils.get_hl("CursorLine")
				end
				local colors = {
					bright_bg = bright_bg,
					bright_fg = bright_fg,
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
					text = heirline_utils.get_highlight("Normal").bg,
					fg = fg,
					bg = bg,
				}
				if not vim.g.use_noice then
					vim.o.cmdheight = 1
					vim.g.noshowmode = true
				end
				return colors
			end

			local statusline = require("plugins.ui.heirline.statusline")
			local conditions = require("heirline.conditions")
			local statuscolumn = require("plugins.ui.heirline.statuscolumn")
			heirline.setup({
				-- statusline = statusline.statusline,
				statusline = require("plugins.ui.heirline.everybody_wants_this_line").statusline,
				statuscolumn = statuscolumn,
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
	},
	{
		{
			"sainttttt/everybody-wants-that-line.nvim",
			branch = "saint",
			cond = false,
			config = function()
				vim.keymap.set("n", "<leader>nn", require("everybody-wants-that-line.components.filename").toggle_float)
				require("everybody-wants-that-line").setup({
					buffer = {
						enabled = true,
						prefix = "B:",
						symbol = "0",
						max_symbols = 5,
					},
					diagnostics = {
						enabled = true,
					},
					quickfix_list = {
						enabled = true,
					},
					git_status = {
						enabled = true,
					},
					filepath = {
						enabled = true,
						path = "relative",
						shorten = false,
					},
					filesize = {
						enabled = true,
						metric = "decimal",
					},
					ruller = {
						enabled = true,
					},
					filename = {
						enabled = true,
					},
					separator = "│",
				})
			end,
		},
	},
}
