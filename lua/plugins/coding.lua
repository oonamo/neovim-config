return {
	{
		"yioneko/nvim-cmp",
		name = "cmp",
		branch = "perf",
		-- "hrsh7th/nvim-cmp",
		event = { "InsertEnter" },
		cond = O.lsp.cmp == true,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			-- { "hrsh7th/cmp-cmdline", cond = not O.ui.noice },
			{ "hrsh7th/cmp-nvim-lsp-signature-help", cond = O.ui.signature == "cmp" },
			-- load on markdown files only
		},
		opts = function()
			local cmp = require("cmp")
			local icons = require("mini.icons")
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
			local function border(hl_name)
				return {
					{ "╭", hl_name },
					{ "─", hl_name },
					{ "╮", hl_name },
					{ "│", hl_name },
					{ "╯", hl_name },
					{ "─", hl_name },
					{ "╰", hl_name },
					{ "│", hl_name },
				}
			end
			return {
				experimental = {
					ghost_text = true,
				},
				window = {
					completion = {
						scrollbar = false,
					},
					documentation = {
						border = border("CmpDocumentationBorder"),
						winhighlight = "Normal:CmpDocumentation",
					},
				},
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(_, item)
						local kind = item.kind
						item.kind = icons.get("lsp", kind)
						item.menu = kind:gsub("(%l)(%u)", "%1 %2"):lower()
						return item
					end,
				},
				view = {
					docs = {
						auto_open = true,
					},
					entries = {
						follow_cursor = false,
					},
				},
				-- performance = {
				-- 	debounce = 0, -- default = 60ms
				-- 	throttle = 0, -- default = 30ms
				-- },
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
					{ name = "nvim_lsp_signature_help" },
				}, {
					{ name = "buffer" },
				}),
				sorting = defaults.sorting,
				matching = {
					disallow_fuzzy_matching = true,
					disallow_fullfuzzy_matching = true,
					disallow_partial_fuzzy_matching = true,
					disallow_partial_matching = true,
					disallow_prefix_unmatching = true,
				},
			}
		end,
		config = function(_, opts)
			local cmp = require("cmp")
			local entries = { name = "wildmenu", seperator = "|" }
			if O.ui.noice or vim.o.cmdheight == 0 then
				entries = {}
			end
			cmp.setup(opts)
			-- cmp.setup.cmdline("/", {
			-- 	mapping = cmp.mapping.preset.cmdline(),
			-- 	view = {
			-- 		entries = entries,
			-- 	},
			-- })
			-- cmp.setup.cmdline(":", {
			-- 	mapping = cmp.mapping.preset.cmdline(),
			-- 	view = {
			-- 		entries = entries,
			-- 	},
			-- 	sources = cmp.config.sources({
			-- 		{
			-- 			name = "cmdline",
			-- 			option = {
			-- 				ignore_cmds = { "Man", "!" },
			-- 			},
			-- 		},
			-- 	}),
			-- })
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
		"otavioschwanck/arrow.nvim",
		enabled = O.arrow,
		opts = {
			show_icons = true,
			leader_key = "<C-e>", -- Recommended to be a single key
			buffer_leader_key = "<leader>m", -- Per Buffer Mappings
		},
		keys = function()
			local keys = {
				"<C-e>",
				"<leader>m",
				{
					"<leader>a",
					function()
						require("arrow.persist").save(vim.api.nvim_buf_get_name(0))
					end,
				},
			}
			local maps = {
				"<C-h>",
				"<C-j>",
				"<C-k>",
				"<C-l>",
			}
			for i, key in ipairs(maps) do
				table.insert(keys, {
					key,
					function()
						require("arrow.persist").go_to(i)
					end,
					desc = "Go to Arrow File " .. i,
				})
			end

			for i = #maps, 9 do
				table.insert(keys, {
					"<leader>" .. i,
					function()
						require("arrow.persist").go_to(i)
					end,
					desc = "Go to Arrow File " .. i,
				})
			end
			return keys
		end,
	},
	{
		"stevearc/overseer.nvim",
		opts = {
			templates = {
				"builtin",
				"user.cpp_build",
				"user.c_build",
			},
			task_list = {
				bindings = {
					["<C-t>"] = "<cmd>OverseerQuickAction open tab<cr>",
				},
			},
			component_aliases = {
				default = {
					{
						"open_output",
						direction = "horizontal",
						focus = false,
						on_start = "always",
					},
					"on_output_summarize",
					"on_exit_set_status",
					"on_complete_notify",
				},
			},
		},
		cmd = { "OverseerBuild", "OverseerRun" },
		keys = function()
			local function prompt()
				return vim.fn.input({
					prompt = "Compile > ",
					default = vim.g.last_compile_command,
				})
			end
			return {
				{
					"<leader>cp",
					function()
						local command = prompt()
						if command == "" then
							return
						end
						local overseer = require("overseer")
						overseer
							.new_task({
								cmd = command,
							})
							:start()
						vim.g.last_compile_command = command
					end,
					desc = "Compile Project",
				},
				{
					"<leader>ca",
					function()
						local overseer = require("overseer")
						local tasks = overseer.list_tasks({ recent_first = true })
						if vim.tbl_isempty(tasks) then
							local command = prompt()
							if command == "" then
								return
							end
							overseer
								.new_task({
									cmd = command,
									-- components = {
									-- 	{
									-- 		"open_output",
									-- 		direction = "tab",
									-- 		focus = false,
									-- 		on_start = "always",
									-- 	},
									-- },
								})
								:start()
						else
							overseer
								.new_task({
									cmd = vim.g.last_compile_command,
									components = {
										{
											"open_output",
											direction = "tab",
											focus = false,
											on_start = "always",
										},
									},
								})
								:start()
							-- overseer.open()
						end
					end,
					desc = "Compile last task",
				},
			}
		end,
	},
	{
		"nmac427/guess-indent.nvim",
		event = "LazyFile",
		config = true,
	},
	-- {
	-- 	"stevearc/aerial.nvim",
	-- 	event = "LazyFile",
	-- 	opts = function()
	-- 		return {
	-- 			attach_mode = "global",
	-- 			backends = { "lsp", "treesitter", "markdown" },
	-- 			layout = { min_width = 20 },
	-- 			show_guides = true,
	-- 			filter_kind = false,
	-- 			guides = {
	-- 				mid_item = "├ ",
	-- 				last_item = "└ ",
	-- 				nested_top = "│ ",
	-- 				whitespace = "  ",
	-- 			},
	-- 			keymaps = {
	-- 				["[y"] = "actions.prev",
	-- 				["]y"] = "actions.next",
	-- 				["[Y"] = "actions.prev_up",
	-- 				["]Y"] = "actions.next_up",
	-- 				["{"] = false,
	-- 				["}"] = false,
	-- 				["[["] = false,
	-- 				["]]"] = false,
	-- 			},
	-- 			on_attach = function(bufnr)
	-- 				local aerial = require("aerial")
	-- 				vim.keymap.set("n", "[y", function()
	-- 					aerial.next(vim.v.count1)
	-- 				end, { desc = "next symbol", buffer = bufnr })
	-- 				vim.keymap.set("n", "]y", function()
	-- 					aerial.prev(vim.v.count1)
	-- 				end, { desc = "previous symbol", buffer = bufnr })
	-- 				vim.keymap.set("n", "[Y", function()
	-- 					aerial.next_up(vim.v.count1)
	-- 				end, { desc = "next symbol upwards", buffer = bufnr })
	-- 				vim.keymap.set("n", "]Y", function()
	-- 					aerial.prev_up(vim.v.count1)
	-- 				end, { desc = "previous symbol upwards", buffer = bufnr })
	-- 			end,
	-- 		}
	-- 	end,
	-- },
}
