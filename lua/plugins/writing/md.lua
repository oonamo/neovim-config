return {
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && npm install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	{
		"lukas-reineke/headlines.nvim",
		dependencies = "nvim-treesitter/nvim-treesitter",
		ft = { "norg", "markdown", "org" },
		opts = {
			headline_highlights = { "Headline", "Headline2", "Headline3" },
			bullets = { "❯", "❯", "❯", "❯" },
			norg = {
				-- headline_highlights = { "Headline", "Headline2" },
				-- fat_headlines = false,
			},
			markdown = {},
			org = {},
			rmd = {},
		},
		config = function(_, opts)
			local _, has_highlight = pcall(require, vim.api.nvim_get_hl_by_name, "Headline")
			if not has_highlight then
				for i, v in ipairs(opts.headline_highlights) do
					-- local md_hl = vim.api.nvim_get_hl_by_name("markdownH" .. i, true)
					local hl = "markdownH" .. i
					local md_hl = {}
					---@diagnostic disable-next-line: undefined-field
					if vim.opt.background:get() == "dark" then
						md_hl.bg = utils.brighten(hl, -80)
					else
						md_hl.bg = utils.brighten(hl, 80)
					end
					if #md_hl.bg < 7 then
						print(md_hl.bg)
						md_hl.bg = md_hl.bg .. string.sub(md_hl.bg, string.len(md_hl.bg))
					end
					vim.api.nvim_set_hl(0, v, { bg = md_hl.bg, fg = "NONE" })
				end
			end
			if vim.g.neovide then
				opts.markdown.fat_headlines = false
				opts.norg.fat_headlines = false
				opts.org.fat_headlines = false
				opts.rmd.fat_headlines = false
			end

			opts.norg.headline_highlights = opts.headline_highlights
			opts.rmd.headline_highlights = opts.headline_highlights
			opts.markdown.headline_highlights = opts.headline_highlights
			opts.org.headline_highlights = opts.headline_highlights

			if opts.bullets then
				opts.norg.bullets = opts.bullets
				opts.rmd.bullets = opts.bullets
				opts.markdown.bullets = opts.bullets
				opts.org.bullets = opts.bullets
			end
			require("headlines").setup(opts)
		end,
	},
	{
		"dhruvasagar/vim-table-mode",
		ft = { "markdown" },
		keys = { "<leader>tm" },
	},
	{
		"jbyuki/nabla.nvim",
		ft = { "markdown" },
		config = function()
			local nabla_float_grp = vim.api.nvim_create_augroup("nabla_float", { clear = true })
			vim.api.nvim_create_autocmd("CursorHold", {
				callback = function()
					require("nabla").popup()
				end,
				group = nabla_float_grp,
			})
		end,
		keys = {
			{
				"<leader>nt",
				"<cmd>lua require('nabla').popup()<cr>",
				desc = "nabla",
			},
			{
				"<leader>nv",
				function()
					require("nabla").toggle_virt()
				end,
				desc = "nabla",
			},
		},
	},
}
