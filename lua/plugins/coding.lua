return {
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter" },
		cond = O.lsp.cmp == true,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			-- "hrsh7th/cmp-cmdline",
			-- { "hrsh7th/cmp-buffer", cond = vim.bo.ft == "markdown" },
			-- "hrsh7th/cmp-nvim-lsp-signature-help",
			-- load on markdown files only
		},
		opts = function()
			local cmp = require("cmp")
			local defaults = require("cmp.config.default")()
			local auto_select = true
			local function confirm(opts)
				opts = vim.tbl_extend("force", {
					select = true,
					behavior = cmp.ConfirmBehavior.insert,
				}, opts or {})
				return function(fallback)
					if cmp.core.view:visible() or vim.fn.pumvisible() == 1 then
						if cmp.confirm(opts) then
							return
						end
					end
					return fallback()
				end
			end
			return {
				completion = {
					completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
				},
				preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = confirm({ select = auto_select }),
					["<C-y>"] = confirm({ select = true }),
					["<S-CR>"] = confirm({ behavior = cmp.ConfirmBehavior.Replace }),
					["<C-e>"] = cmp.mapping.abort(),
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
					{ name = "path" },
				}, {
					{ name = "buffer" },
				}),
				sorting = defaults.sorting,
			}
		end,
	},
	{
		"mini.completion",
		dev = true,
		event = { "InsertEnter" },
		cond = O.lsp.mini == true,
		config = function()
			-- local imap_expr = function(lhs, rhs)
			-- 	vim.keymap.set("i", lhs, rhs, { expr = true })
			-- end
			-- imap_expr("<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]])
			-- imap_expr("<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]])
			require("mini.completion").setup({
				fallback_action = function() end,
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
				cpp = { "clang-format" },
			},
			timeout_ms = 500,
			format_on_save = function()
				if vim.g.disable_autoformat then
					return
				end
				return {
					timeout_ms = 500,
					lsp_fallback = true,
				}
			end,
		},
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			menu = {
				width = vim.api.nvim_win_get_width(0),
			},
			settings = {
				save_on_toggle = true,
			},
		},
		keys = function()
			local harpoon = require("harpoon")
			return {
				utils.vim_to_lazy_map("n", "<leader>a", function()
					harpoon:list():add()
				end, {}),
				utils.vim_to_lazy_map("n", "<leader>ph", function()
					if not MiniPick then
						require("mini.pick").setup()
					end
					local items = harpoon:list().items
					local values = vim.iter(items)
						:enumerate()
						:map(function(i, item)
							return i .. " " .. item.value
						end)
						:totable()
					local old_map = MiniPick.config.mappings.stop
					MiniPick.config.mappings.stop = "<C-e>"
					vim.ui.select(values, {}, function(selection)
						MiniPick.config.mappings.stop = old_map
						if not selection then
							return
						end
						local idx = selection:sub(1, 1)
						harpoon:list():select(tonumber(idx))
					end)
				end, {}),
				utils.vim_to_lazy_map("n", "<C-e>", function()
					harpoon.ui:toggle_quick_menu(harpoon:list())
				end, {}),
				utils.vim_to_lazy_map("n", "<C-h>", function()
					harpoon:list():select(1)
				end, {}),
				utils.vim_to_lazy_map("n", "<C-j>", function()
					harpoon:list():select(2)
				end, {}),
				utils.vim_to_lazy_map("n", "<C-k>", function()
					harpoon:list():select(3)
				end, {}),
				utils.vim_to_lazy_map("n", "<C-l>", function()
					harpoon:list():select(4)
				end, {}),
				utils.vim_to_lazy_map("n", "<leader>5", function()
					harpoon:list():select(5)
				end, {}),
				utils.vim_to_lazy_map("n", "<leader>6", function()
					harpoon:list():select(6)
				end, {}),
				utils.vim_to_lazy_map("n", "<leader>7", function()
					harpoon:list():select(7)
				end, {}),
				utils.vim_to_lazy_map("n", "<leader>8", function()
					harpoon:list():select(8)
				end, {}),
				utils.vim_to_lazy_map("n", "<leader>9", function()
					harpoon:list():select(9)
				end, {}),
				-- Toggle previous & next buffers stored within Harpoon list
				utils.vim_to_lazy_map("n", "<C-S-P>", function()
					harpoon:list():prev()
				end, {}),
				utils.vim_to_lazy_map("n", "<C-S-N>", function()
					harpoon:list():next()
				end, {}),
				harpoon:extend({
					UI_CREATE = function(cx)
						vim.keymap.set("n", "l", function()
							harpoon.ui:select_menu_item()
						end, { buffer = cx.bufnr })
					end,
				}),
			}
		end,
	},
}
