return {
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		-- "hrsh7th/cmp-cmdline",
		-- { "hrsh7th/cmp-buffer", cond = vim.bo.ft == "markdown" },
		-- "hrsh7th/cmp-nvim-lsp-signature-help",
		-- load on markdown files only
	},
	config = function()
		local cmp = require("cmp")
		cmp.setup({
			snippet = {
				expand = function(args)
					vim.snippet.expand(args.body)
				end,
			},
			-- fancy window
			window = {
				documentation = cmp.config.window.bordered(),
				-- completion = cmp.config.window.bordered(),
			},
			mapping = cmp.mapping.preset.insert({
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<C-y>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				["<Tab>"] = cmp.mapping(function(fallback)
					if vim.snippet.active({ direction = 1 }) then
						vim.snippet.jump(1)
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if vim.snippet.active({ direction = -1 }) then
						vim.snippet.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
				["<C-k>"] = cmp.mapping.open_docs(),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
			}, {
				{ name = "buffer" },
			}),
		})
		-- cmp.setup.cmdline({ "/", "?" }, {
		-- 	mapping = cmp.mapping.preset.cmdline(),
		-- 	sources = {
		-- 		{ name = "buffer" },
		-- 	},
		-- })
		-- cmp.setup.cmdline(":", {
		-- 	mapping = cmp.mapping.preset.cmdline(),
		-- 	sources = cmp.config.sources({
		-- 		{ name = "path" },
		-- 	}, {
		-- 		-- only use for wilder
		-- 		-- {
		-- 		-- 	name = "cmdline",
		-- 		-- 	option = {
		-- 		-- 		ignore_cmds = { "edit" },
		-- 		-- 	},
		-- 		-- },
		-- 	}),
		-- 	matching = { disallow_symbol_nonprefix_matching = false },
		-- })
	end,
}
