return {
	{
		"junegunn/seoul256.vim",
		-- lazy = false,
		-- priority = 1000,
		config = function()
			-- DARK: 233 - 239
			-- vim.g.seoul256_background = 233
			-- LIGHT: 252 - 256
			if vim.o.bg == "light" then
				vim.g.seoul256_background = 256
			else
        vim.g.seoul256_background = 235
			end
			local hi = function(name, v)
				vim.api.nvim_set_hl(0, name, v)
			end
			if vim.o.background == "light" then
				vim.cmd.colorscheme("seoul256-light")
			else
				vim.cmd.colorscheme("seoul256")
				-- hi("Boolean", { fg = "#98bede" })
				-- hi("Constant", { fg = "#79a8d0" })
				-- hi("Comment", { fg = "#8ca98c" })
				-- hi("String", { fg = "#98bcbd" })
				-- hi("Exception", { fg = "#d96969" })
				-- hi("Identifier", { fg = "#ddbdbf", bold = true })
				-- hi("Keyword", { fg = "#e09b99" })
				-- hi("Statusline", { bg = "#e09b99" })
				-- hi("Statement", { fg = "#98bc99" })
				-- hi("Special", { fg = "#e0bebc" })
				-- hi("Tag", { fg = "#dfdebd" })
				-- hi("Type", { fg = "#ffdddd" })
				-- hi("Include", { fg = "#d3c6ac" })
				-- hi("Delimiter", { fg = "#ad9493" })
			end
			hi("SignColumn", { fg = "#d19972", bg = "NONE" })
			hi("MiniJump", { bold = true, bg = "#d96969", fg = "#dfdebd" })
			hi("MiniPickMatchRanges", { bold = true, bg = "#1c1c1c", fg = "#e09b99" })
			hi("MiniPickMatchCurrent", { bold = true, bg = "#1c1c1c", fg = "#98bc99" })
		end,
	},
	{
		"EdenEast/nightfox.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function(_, opts)
			require("nightfox").setup(opts)
			vim.cmd.colorscheme("nordfox")
		end,
	},
  {
    "catppuccin/nvim",
    name = "catppuccin"
  },
  {
    "rose-pine/nvim",
    name = "rose-pine",
  },
}
