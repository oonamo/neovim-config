return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp", -- lazy = true },
		"hrsh7th/cmp-buffer", -- lazy = true },
		"hrsh7th/cmp-path", -- lazy = true },
		"hrsh7th/cmp-cmdline", -- lazy = true },
		"onsails/lspkind.nvim",
	},
	event = "InsertEnter",
	cond = O.lsp.cmp,
	config = function()
		local C = {}
		local cmp = require("cmp")
		local compare = cmp.config.compare
		local pad_len = 3
		if vim.g.use_custom_snippets then
			C.luasnip = require("luasnip")
		end

		-- IMPORTANT: Run this after setting up mason
		local mason_registry = require("mason-registry")
		M.mason_registry = mason_registry
		local codelldb = mason_registry.get_package("codelldb")
		M.codelldb = codelldb
		local extension_path = codelldb:get_install_path() .. "/extension/"
		M.extension_path = extension_path
		local codelldb_path = extension_path .. "adapter/codelldb"
		M.codelldb_path = codelldb_path
		local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
		M.liblldb_path = liblldb_path

		local function get_lsp_completion_context(completion, source)
			local ok, source_name = pcall(function()
				return source.source.client.config.name
			end)
			if not ok then
				return nil
			end

			if source_name == "tsserver" then
				return completion.detail
			elseif source_name == "pyright" then
				if completion.labelDetails ~= nil then
					return completion.labelDetails.description
				end
			elseif source_name == "clangd" then
				local doc = completion.documentation
				if doc == nil then
					return
				end

				local import_str = doc.value

				local i, j = string.find(import_str, '["<].*[">]')
				if i == nil then
					return
				end

				return string.sub(import_str, i, j)
			end
		end

		cmp.setup({
			view = {
				entries = {
					follow_cursor = true,
				},
			},
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			sorting = {
				comparators = {
					compare.score,
					compare.offset,
					compare.recently_used,
					compare.order,
					compare.exact,
					compare.kind,
					compare.locality,
					compare.length,
					-- copied from TJ Devries; cmp-under
					function(entry1, entry2)
						local _, entry1_under = entry1.completion_item.label:find("^_+")
						local _, entry2_under = entry2.completion_item.label:find("^_+")
						entry1_under = entry1_under or 0
						entry2_under = entry2_under or 0
						if entry1_under > entry2_under then
							return false
						elseif entry1_under < entry2_under then
							return true
						end
					end,
				},
			},
			window = {
				-- completion = cmp.config.window.bordered(),
				-- documentation = cmp.config.window.bordered(),
				documentation = {
					border = tools.ui.cur_border,
					max_height = 75,
					max_width = 75,
				},
				completion = {
					border = tools.ui.cur_border,
					col_offset = 1,
					scrolloff = 10,
				},
			},
			formatting = {
				-- format = lspkind.cmp_format({
				-- 	mode = "symbol_text",
				-- 	menu = {
				-- 		buffer = "[Buffer]",
				-- 		nvim_lsp = "[LSP]",
				-- 		luasnip = "[LuaSnip]",
				-- 		nvim_lua = "[Lua]",
				-- 		latex_symbols = "[Latex]",
				-- 	},
				-- }),
				fields = { "kind", "abbr", "menu" },
				format = function(entry, vim_item)
					local choice = require("lspkind").cmp_format({
						ellipsis_char = "…",
						maxwidth = 25,
						mode = "symbol",
					})(entry, vim_item)

					choice.abbr = vim.trim(choice.abbr)
					choice.menu = ""

					local cmp_ctx = get_lsp_completion_context(entry.completion_item, entry.source)
					if cmp_ctx ~= nil and cmp_ctx ~= "" then
						choice.menu = table.concat({ "  → ", cmp_ctx })
					end

					choice.menu = choice.menu .. string.rep(" ", pad_len)

					return choice
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-i>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<Tab>"] = cmp.mapping(function(fallback)
					if not C.luasnip then
						fallback()
					end
					if C.luasnip.expandable() then
						C.luasnip.expand()
					elseif C.luasnip.locally_jumpable(1) then
						C.luasnip.jump(1)
					elseif cmp.visible() then
						cmp.select_next_item()
					else
						fallback()
					end
				end),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if not C.luasnip then
						fallback()
					end
					if C.luasnip.jumpable(-1) then
						C.luasnip.jump(-1)
					elseif C.luasnip.locally_jumpable(-1) then
						C.luasnip.jump(-1)
					else
						fallback()
					end
				end),
			}),
			sources = cmp.config.sources({
				{
					name = "nvim_lsp",
				},
			}, {
				{ name = "buffer" },
				{ name = "path" },
				{ name = "luasnip" },
			}),
		})
		cmp.setup.filetype("markdown", {
			sources = cmp.config.sources({
				{
					name = "nvim_lsp",
					option = {
						markdown_oxide = {
							keyword_pattern = [[\(\k\| \|\/\|#\)\+]],
						},
					},
				},
				{ name = "obsidian" },
				{ name = "obsidian_new" },
			}, {
				{ name = "buffer" },
				{ name = "path" },
				{ name = "rg" },
				{ name = "luasnip" },
			}),
		})

		cmp.setup.filetype("norg", {
			sources = cmp.config.sources({
				{ name = "neorg" },
				{ name = "rg" },
				{ name = "buffer" },
				{ name = "path" },
			}),
		})

		cmp.setup.filetype("org", {
			sources = cmp.config.sources({
				{ name = "orgmode" },
				{ name = "luasnip" },
				{ name = "rg" },
				{ name = "buffer" },
			}),
		})

		cmp.setup.filetype("latex", {
			sources = cmp.config.sources({
				{ name = "latex_symbols" },
				{ name = "vimtex" },
				{ name = "luasnip" },
			}, {
				{ name = "buffer" },
				{ name = "path" },
				{ name = "rg" },
				{ name = "spell" },
			}),
		})

		cmp.setup.filetype("tex", {
			sources = cmp.config.sources({
				{ name = "latex_symbols" },
				{ name = "vimtex" },
				{ name = "luasnip" },
			}, {
				{ name = "buffer" },
				{ name = "path" },
				{ name = "rg" },
				{ name = "spell" },
			}),
		})

		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline", keyword_length = 3 },
			}),
		})

		for k, v in pairs({
			CmpItemAbbrMatch = "Number",
			CmpItemAbbrMatchFuzzy = "CmpItemAbbrMatch",
			CmpItemKindInterface = "CmpItemKindVariable",
			CmpItemKindText = "CmpItemKindVariable",
			CmpItemKindMethod = "CmpItemKindFunction",
			CmpItemKindProperty = "CmpItemKindKeyword",
			CmpItemKindUnit = "CmpItemKindKeyword",
		}) do
			vim.api.nvim_set_hl(0, k, { link = v })
		end
	end,
}
