return {
	"stevearc/dressing.nvim",
	lazy = true,
	enabled = true,
	opts = {
		win_options = {
			inblend = 5,
			winhighlight = "FloatBorder:LspFloatWinBorder",
		},
		input = {
			enabled = true,
			insert_only = false,
			start_in_insert = false,
			prefer_width = 25,
			max_width = { 80, 0.5 },
			min_width = { 10, 0.2 },
			--- Set window transparency to 0.
			border = tools.ui.borders.invis,
			-- win_options = {
			-- 	winblend = 0,
			-- },
			title_pos = "center",
		},
		select = {
			trim_prompt = false,
			backend = { "fzf_lua" },
			get_config = function(opts)
				if opts.kind == "codeaction" then
					-- Cute and compact code action menu.
					return {
						backend = "builtin",
						builtin = {
							relative = "cursor",
							max_height = 0.33,
							min_height = 5,
							max_width = 0.40,
							mappings = { ["q"] = "Close" },
							win_options = {
								-- Same UI as the input field.
								winhighlight = "FloatBorder:LspFloatWinBorder,DressingSelectIdx:LspInfoTitle,MatchParen:Ignore",
								winblend = 5,
							},
						},
					}
				end

				local winopts = { height = 0.6, width = 0.5 }

				-- Smaller menu for snippet choices.
				if opts.kind == "luasnip" then
					opts.prompt = "Snippet choice: "
					winopts = { height = 0.35, width = 0.3 }
				end

				-- Fallback to fzf-lua.
				return {
					backend = "fzf_lua",
					fzf_lua = { winopts = winopts },
				}
			end,
		},
	},
	init = function()
		---@diagnostic disable-next-line: duplicate-set-field
		vim.ui.select = function(...)
			require("lazy").load({ plugins = { "dressing.nvim" } })
			return vim.ui.select(...)
		end
		---@diagnostic disable-next-line: duplicate-set-field
		vim.ui.input = function(...)
			require("lazy").load({ plugins = { "dressing.nvim" } })
			return vim.ui.input(...)
		end
	end,
}
