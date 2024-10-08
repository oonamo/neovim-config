-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = ";"
local o, opt = vim.o, vim.opt
vim.o.shada = "'100,<50,s10,:1000,/100,@100,h"

-- Allows for easy telling if pane is a nvim proccess
o.title = true
o.titlestring = "nvim"
opt.completeopt = "menu,menuone,noselect"
o.cmdheight = 1

vim.g.bigfile_size = 1024 * 1024 * 1.5 -- 1.5 MB
vim.o.lazyredraw = true

-- Relative line numbers
opt.nu = true
opt.rnu = true
-- opt.nu = false
-- opt.rnu = false

-- set tab stop at 4
opt.tabstop = 4
opt.softtabstop = 4
opt.expandtab = true

-- autoindent
opt.smartindent = true
opt.shiftwidth = 4

-- smarter breaking
o.breakindent = true

-- better searching
o.inccommand = "split"
o.incsearch = true
o.hlsearch = true
o.ignorecase = true
o.smartcase = true

-- disable wrap
opt.wrap = false

-- better splitting
o.splitkeep = "screen"
o.splitbelow = true
o.splitright = true

-- set completion options
opt.completeopt = { "menu", "menuone", "noselect" }

-- set signcolumn
opt.signcolumn = "yes"

o.emoji = true

-- Editor
o.showmode = false
opt.scrolloff = 8
-- o.updatetime = 300
o.timeoutlen = 500
o.ttimeoutlen = 10
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.wildoptions = "tagfile"
opt.wildmenu = true
o.makeprg = "just"
opt.laststatus = 2 -- Or 3 for global statusline
opt.foldlevel = 99
o.foldmethod = "expr"
o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
o.foldtext = ""
o.list = true
opt.listchars = "trail:∘,nbsp:‼,tab:  ,multispace: "
o.fillchars = [[eob: ,vert:▕,vertleft:🭿,vertright:▕,verthoriz:🭿,horiz:▁,horizdown:▁,horizup:▔]]
o.virtualedit = "block"
o.shortmess = "tacstFOSWCo"
o.formatoptions = "rqnl1j"
o.cmdwinheight = 4
-- credit: https://github.com/nicknisi/dotfiles/blob/1360edda1bbb39168637d0dff13dd12c2a23d095/config/nvim/init.lua#L73
-- if ripgrep installed, use that as a grepper
-- o.grepprg = "rg --vimgrep --color=never --with-filename --line-number --no-heading --smart-case --"
o.grepprg = [[rg --glob "!.git" --no-heading --with-filename --line-number --vimgrep --follow $*]]
o.grepformat = "%f:%l:%c:%m,%f:%l:%m"

vim.g.netrw_banner = 0
vim.g.netrw_mouse = 2

-- o.background = "light"

o.cursorline = false

vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

vim.api.nvim_create_autocmd("User", {
	group = vim.api.nvim_create_augroup("Config", { clear = true }),
	pattern = "VeryLazy",
	callback = function()
		require("config.autocommands")
		require("config.keymaps")
		if vim.g.neovide then
			require("config.gui")
		end
		require("statusline")
	end,
})

---@param client vim.lsp.Client
---@param buffer number
local function on_attach(client, buffer)
	vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, {
		desc = "Preview code actions",
		buffer = buffer,
	})
	-- end
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, {
		desc = "go to buffer definition",
		buffer = buffer,
	})
	vim.keymap.set("n", "gD", function()
		require("mini.extra").pickers.lsp({ scope = "definition" })
	end, { desc = "go to multiple definition", buffer = buffer })
	vim.keymap.set("n", "<leader>vws", function()
		require("mini.extra").pickers.lsp({ scope = "workspace_symbol" })
	end, { desc = "Find workspace_symbol", buffer = buffer })
	vim.keymap.set("n", "<leader>vd", function()
		vim.diagnostic.open_float()
	end, {
		desc = "Open float menu",
		buffer = buffer,
	})
	vim.keymap.set("n", "[d", vim.diagnostic.goto_next, {
		desc = "Got to next diagnostic",
		buffer = buffer,
	})
	vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, {
		desc = "Go to previous diagnostic",
		buffer = buffer,
	})
	vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, {
		desc = "Go to lsp references",
		buffer = buffer,
	})
	vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, {
		desc = "Rename symbol",
		buffer = buffer,
	})
	vim.keymap.set("n", "<leader>vxx", function()
		require("mini.extra").pickers.diagnostic()
	end, { desc = "Find diagnostics", buffer = buffer })
	vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, {
		desc = "Signature help",
		buffer = buffer,
	})
	if client.supports_method("textDocument/inlayHint") then
		vim.keymap.set("n", "<leader>ih", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
		end, { desc = "Inlay Hint" })
	end
	vim.keymap.set("n", "<leader>qf", vim.diagnostic.setqflist, { desc = "Quickfix [L]ist [D]iagnostics" })
	vim.keymap.set("n", "<leader>ld", vim.diagnostic.setloclist, { desc = "Quickfix [L]ist [D]iagnostics" })
	vim.keymap.set("n", "<C-]>", "<C-w><C-]>")

	vim.keymap.set("n", "<leader>ss", function()
		require("config.lsp").request(true)
	end)
end

local defaults = { on_attach = on_attach }
-- Setup lazy.nvim
require("lazy").setup({
	-- Colorscheme
	{
		"ilof2/posterpole.nvim",
		-- lazy = false,
		-- priority = 1000,
		opts = {
			transparent = false,
			-- colorless_bg = false, -- grayscale or not
			dim_inactive = true, -- highlight inactive splits
			brightness = 0, -- negative numbers - darker, positive - lighter
			selected_tab_highlight = true, --highlight current selected tab
			fg_saturation = 10, -- font saturation, gray colors become more brighter
			bg_saturation = 0, -- background saturation
		},
		config = function(_, opts)
			require("posterpole").setup(opts)
			vim.cmd.colorscheme("posterpole")
		end,
	},
	{
		"AstroNvim/astrotheme",
		-- lazy = false,
		-- priority = 1000,
		opts = {
			highlights = {
				global = {
					modify_hl_groups = function(hl, c)
						hl.MiniJump = { bold = true, bg = c.ui.red, fg = c.syntax.text }
					end,
				},
			},
		},
		config = function(_, opts)
			require("astrotheme").setup(opts)
			vim.cmd.colorscheme("astrotheme")
		end,
	},
	{
		"junegunn/seoul256.vim",
		lazy = false,
		priority = 1000,
		config = function()
			local hi = function(name, v)
				vim.api.nvim_set_hl(0, name, v)
			end
			vim.cmd.colorscheme("seoul256")
			hi("Boolean", { fg = "#98bede" })
			hi("Constant", { fg = "#79a8d0" })
			hi("Comment", { fg = "#8ca98c" })
			hi("String", { fg = "#98bcbd" })
			hi("Exception", { fg = "#d96969" })
			hi("Identifier", { fg = "#ddbdbf", bold = true })
			hi("Keyword", { fg = "#e09b99" })
			hi("Statusline", { bg = "#e09b99" })
			hi("Statement", { fg = "#98bc99" })
			hi("Special", { fg = "#e0bebc" })
			hi("Tag", { fg = "#dfdebd" })
			hi("Type", { fg = "#ffdddd" })
			hi("Include", { fg = "#d3c6ac" })
			hi("Delimiter", { fg = "#ad9493" })
			hi("MiniJump", { bold = true, bg = "#d96969", fg = "#dfdebd" })
			hi("MiniPickMatchRanges", { bold = true, bg = "#1c1c1c", fg = "#e09b99" })
			hi("MiniPickMatchCurrent", { bold = true, bg = "#1c1c1c", fg = "#98bc99" })
		end,
	},
	require("plugins.mini"),
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = vim.fn.argc(-1) == 0,
		build = function()
			vim.cmd("TSUpdate")
		end,
		init = function(plugin)
			require("lazy.core.loader").add_to_rtp(plugin)
			require("nvim-treesitter.query_predicates")
		end,
		event = { "BufWritePre", "BufReadPost", "BufNewFile", "VeryLazy" },
		config = function()
			require("nvim-treesitter.query_predicates")
			local config = require("nvim-treesitter.configs")
			config.setup({
				ensure_installed = {
					"lua",
					"javascript",
					"c",
					"norg",
					"rust",
					"vim",
					"vimdoc",
					"markdown",
					"markdown_inline",
					"latex",
					"org",
				},
				auto_install = true,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
					disable = function(_, buf)
						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							return true
						end
					end,
				},
				indent = {
					enable = true,
					disable = function(_, buf)
						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							return true
						end
					end,
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-i>",
						node_incremental = "<CR>",
						scope_incremental = false,
						node_decremental = "<BS>",
					},
				},
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "black" },
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
		"neovim/nvim-lspconfig",
		event = { "BufWritePre", "BufReadPost", "BufNewFile" },
		opts = {
			lua_ls = {
				on_attach = function(client, bufnr)
					on_attach(client, bufnr)
					-- `MiniCompletion` experience
					client.server_capabilities.completionProvider.triggerCharacters = { ".", ":" }
				end,
				handlers = {
					["textDocument/definition"] = function(err, result, ctx, config)
						if type(result) == "table" then
							result = { result[1] }
						end
						vim.lsp.handlers["textDocument/definition"](err, result, ctx, config)
					end,
				},
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = {
							globals = { "vim", "bit" },
							workspaceDelay = -1,
						},
						telemetry = {
							enable = false,
						},
						workspace = {
							library = {
								[vim.fn.expand("$VIMRUNTIME/lua")] = true,
								[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
								[vim.fn.stdpath("config") .. "/lua"] = true,
							},
							ignoreSubmodules = true,
						},
						hint = {
							enable = true,
							setType = false,
							paramType = true,
							paramName = true,
							semicolon = "Disable",
							arrayIndex = "Disable",
						},
					},
				},
			},
			clangd = {
				on_attach = on_attach,
			},
			rust_analyzer = defaults,
			markdown_oxide = {
				on_attach = on_attach,
			},
		},
		config = function(_, opts)
			local lspconfig = require("lspconfig")
			local capabilities = (function()
				return {
					workspace = {},
				}
			end)()
			capabilities.workspace = {
				didChangeWatchedFiles = {
					dynamicRegistration = true,
				},
			}
			for server, settings in pairs(opts) do
				local server_opts = vim.tbl_deep_extend("force", {
					capabilities = vim.deepcopy(capabilities),
				}, settings or {})
				if server_opts.root_dir then
					server_opts.root_dir = lspconfig.util.root_pattern(unpack(server_opts.root_dir))
				end
				lspconfig[server].setup(server_opts)
			end
			local sign_define = vim.fn.sign_define
			sign_define("DiagnosticSignError", { text = "󰅙 ", texthl = "DiagnosticSignError" })
			sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
			sign_define("DiagnosticSignHint", { text = " ", texthl = "DiagnosticSignHint" })
			sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
			local diagnostics_symbols = {
				[vim.diagnostic.severity.ERROR] = "x",
				[vim.diagnostic.severity.WARN] = "!",
				[vim.diagnostic.severity.HINT] = "?",
				[vim.diagnostic.severity.INFO] = "i",
			}
			vim.diagnostic.config({
				underline = true,
				severity_sort = true,
				virtual_text = {
					prefix = function(diag)
						return diagnostics_symbols[diag.severity]
					end,
				},
				float = {
					header = " ",
					border = "rounded",
					source = "if_many",
					title = { { " 󰌶 Diagnostics ", "FloatTitle" } },
				},
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "󰅙 ",
						[vim.diagnostic.severity.WARN] = " ",
						[vim.diagnostic.severity.HINT] = " ",
						[vim.diagnostic.severity.INFO] = " ",
					},
					-- text = signs,
					linehl = {
						[vim.diagnostic.severity.ERROR] = "ErrorMsg",
					},
					numhl = {
						[vim.diagnostic.severity.WARN] = "WarningMsg",
					},
				},
			})
		end,
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = "markdown",
		opts = function()
			local block = "█"
			return {
				render_modes = { "n", "c" },
				quote = { repeat_linebreak = true },
				callout = {
					schedule = { raw = "[!SCHEDULE]", rendered = " Schedule", highlight = "Special" },
					formula = { raw = "[!FORMULA]", rendered = "󰡱 Formula", highlight = "Boolean" },
				},
				win_options = {
					showbreak = { default = "", rendered = "  " },
					breakindent = { default = false, rendered = true },
					breakindentopt = { default = "list:-1", rendered = "" },
				},
				code = {
					width = "block",
					min_width = 45,
					left_pad = 2,
					language_pad = 2,
					border = "thick",
				},
				heading = {
					position = "overlay",
					width = "block",
					sign = false,
					min_width = 40,
					left_pad = 2,
					right_pad = 4,
					border = vim.g.neovide == nil,
					border_virtual = true,
					icons = {
						block .. " ",
						block .. block .. " ",
						block .. block .. block .. " ",
						block .. block .. block .. block .. " ",
						block .. block .. block .. block .. block .. " ",
						block .. block .. block .. block .. block .. block .. " ",
					},
				},
				indent = {
					enabled = true,
					skip_heading = true,
				},
				pipe_table = {
					preset = "round",
					alignment_indicator = "┅",
				},
				latex = { enabled = false },
			}
		end,
	},
	{
		"epwalsh/obsidian.nvim",
		event = {
			"BufReadPre C:/Users/onam7/Desktop/DB/DB/**.md",
			"BufNewFile C:/Users/onam7/Desktop/DB/DB/**.md",
		},
		dependencies = {
			"MeanderingProgrammer/render-markdown.nvim",
			{
				"jbyuki/nabla.nvim",
				keys = {
					{
						"<leader>np",
						function()
							require("nabla").popup()
						end,
						desc = "nabla popup",
					},
					{
						"<leader>nv",
						function()
							require("nabla").toggle_virt({
								autogen = true,
								silent = true,
							})
						end,
						desc = "toggle nabla virtual text",
					},
				},
			},
			"nvim-lua/plenary.nvim",
			"folke/zen-mode.nvim",
		},
		cmd = "GoToNotes",
		config = function()
			local daily_path = "100 dailies/"
			local daily_folder = os.date("%b %Y")
			daily_path = daily_path .. "/" .. daily_folder

			require("obsidian").setup({
				workspaces = {
					{
						name = "DB",
						path = "~/Desktop/DB/DB/",
					},
				},
				completion = {
					-- Set to false to disable completion.
					nvim_cmp = false,
					-- Trigger completion at 2 chars.
					min_chars = 2,
				},

				templates = {
					subdir = "templates",
				},

				daily_notes = {
					folder = daily_path,
					date_format = "%Y-%m-%d",
					alias_format = "%B %d, %Y",
				},

				-- disable_front
				-- disable_frontmatter = true,
				note_id_func = function(title)
					if title ~= nil then
						return title
					else
						local note_title
						vim.ui.input({ prompt = "Title: " }, function(new_title)
							note_title = new_title
						end)
						return note_title
					end
				end,

				note_frontmatter_func = function(note)
					if note.title then
						note:add_alias(note.title)
					end

					local out =
						{ id = note.id, aliases = note.aliases, tags = note.tags, hubs = note.hubs or { "[[]]" } }

					if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
						for k, v in pairs(note.metadata) do
							out[k] = v
						end
					end

					return out
				end,

				notes_subdir = "900 Unordered",
				new_notes_location = "notes_subdir",

				-- For windows only
				follow_url_func = function(url)
					-- Open the URL in the default web browser.
					local local_file = string.match(url, "file://(.*)")
					if local_file ~= nil then
						vim.cmd("e " .. local_file)
					else
						vim.fn.jobstart({ "explorer", url })
					end
				end,
				picker = {
					name = "mini.pick",
					mappings = {
						-- Create a new note from your query.
						new = "<C-x>",
						-- Insert a link to the selected note.
						insert_link = "<C-l>",
					},
				},

				callbacks = {
					enter_note = function()
						vim.schedule(function()
							vim.cmd("SoftWrapMode")
							vim.opt.shiftwidth = 2
						end)
					end,
					post_setup = function()
						if not package.loaded["wrapping"] then
							require("wrapping").soft_wrap_mode()
						else
							vim.cmd.SoftWrapMode()
						end
					end,
				},

				ui = {
					enable = false, -- set to false to disable all additional syntax features
					update_debounce = 200, -- update delay after a text change (in milliseconds)
					-- Define how various check-boxes are displayed
					checkboxes = {
						-- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
						[" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
						["x"] = { char = "", hl_group = "ObsidianDone" },
						[">"] = { char = "", hl_group = "ObsidianRightArrow" },
						["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
					},
					bullets = { char = "•", hl_group = "ObsidianBullet" },
					external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
					-- Replace the above with this if you don't have a patched font:
					-- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
					reference_text = { hl_group = "ObsidianRefText" },
					highlight_text = { hl_group = "ObsidianHighlightText" },
					tags = { hl_group = "ObsidianTag" },
					hl_groups = {
						-- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
						ObsidianTodo = { bold = true, fg = "#f78c6c" },
						ObsidianDone = { bold = true, fg = "#89ddff" },
						ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
						ObsidianTilde = { bold = true, fg = "#ff5370" },
						ObsidianBullet = { bold = true, fg = "#89ddff" },
						ObsidianRefText = { underline = true, fg = "#c792ea" },
						ObsidianExtLinkIcon = { fg = "#c792ea" },
						ObsidianTag = { italic = true, fg = "#89ddff" },
						ObsidianHighlightText = { bg = "#75662e" },
					},
				},
			})
			-- Using ft instead
			-- vim.g.markdown_folding = 1

			vim.keymap.set("n", "<leader>nn", "<cmd>ObsidianTemplate notes<cr>", { desc = "Obisidan note template" })
			vim.keymap.set("n", "<leader>ow", "<cmd>ObsidianWorkspace<CR>", { desc = "[O]bsidian [G]o" })
			vim.keymap.set("n", "<leader>oq", "<cmd>ObsidianQuickSwitch<CR>", { desc = "[O]bsidian [F]ind" })
			vim.keymap.set("n", "<leader>on", function()
				vim.ui.input({ prompt = "Note name (optional): " }, function(name)
					if name == nil then
						return
					end
					local note_title = name:gsub("%s+", "-")
					vim.cmd("ObsidianNew " .. note_title)
				end)
			end, { desc = "[O]bsidian [N]ew" })
			vim.keymap.set("n", "<leader>os", "<cmd>ObsidianSearch<CR>", { desc = "[O]bsidian [S]earch" })
			vim.keymap.set("n", "<leader>ot", "<cmd>ObsidianToday<CR>", { desc = "[O]bsidian [T]oday" })
			vim.keymap.set("n", "<leader>oy", "<cmd>ObsidianYesterday<CR>", { desc = "[O]bsidian [Y]esterday" })
			vim.keymap.set("n", "<leader>oo", "<cmd>ObsidianOpen<CR>", { desc = "[O]bsidian [O]pen" })
			vim.keymap.set("n", "<leader>ol", "<cmd>ObsidianLinks<CR>", { desc = "[O]bsidian [L]inks" })
			vim.keymap.set("n", "<leader>ob", "<cmd>ObsidianBacklinks<CR>", { desc = "[O]bsidian [B]acklinks" })
			vim.keymap.set("n", "<leader>or", "<cmd>ObsidianRename<CR>", { desc = "[O]bsidian [R]ename" })
			vim.keymap.set("n", "<leader>oe", function()
				vim.ui.input({ prompt = "Enter title (optional): " }, function(input)
					vim.cmd("ObsidianExtractNote " .. input)
				end)
			end, { desc = "[O]bsidian [E]xtract" })
			vim.keymap.set("n", "<leader>ol", function()
				vim.cmd("ObsidianLink")
			end, { desc = "[O]bsidian [L]ink" })
			vim.keymap.set("n", "<leader>od", function()
				local day_of_week = os.date("%A")
				print(day_of_week)
				assert(type(day_of_week) == "string")
				local offset_start
				require("onam.fn").switch(day_of_week, {
					["Monday"] = function()
						offset_start = 1
					end,
					["Tuesday"] = function()
						offset_start = 0
					end,
					["Wednesday"] = function()
						offset_start = -1
					end,
					["Thursday"] = function()
						offset_start = -2
					end,
					["Friday"] = function()
						offset_start = -3
					end,
					["Saturday"] = function()
						offset_start = -4
					end,
					["Sunday"] = function()
						offset_start = 2
					end,
				})
				if offset_start ~= nil then
					vim.cmd(string.format("ObsidianDailies %d %d", offset_start, offset_start + 4))
				end
			end, { desc = "[O]bsidian [D]ailies" })

			vim.api.nvim_create_user_command("GoToNotes", function()
				require("mini.sessions").read("Notes")
				vim.o.conceallevel = 2
				if not package.loaded["wrapping"] then
					require("wrapping").soft_wrap_mode()
				else
					vim.cmd.SoftWrapMode()
				end
			end, {})
		end,
	},
	{
		"andrewferrier/wrapping.nvim",
		opts = {
			notify_on_switch = false,
			create_keymaps = false,
			auto_set_mode_filetype_allowlist = {
				"asciidoc",
				"gitcommit",
				"latex",
				"mail",
				"markdown",
				"rst",
				"tex",
				"text",
			},
		},
	},
}, {
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "zenner" } },
	-- automatically check for plugin updates
	checker = { notify = false },
	defaults = {
		lazy = true,
	},
	change_detection = {
		notify = false,
	},
	git = {
		timeout = 1000,
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"2html_plugin",
				"getscript",
				"getscriptPlugin",
				"gzip",
				"logipat",
				"matchit",
				"man",
				"matchparen",
				"tar",
				"tarPlugin",
				"rrhelper",
				"vimball",
				-- "netrw",
				-- "netrwPlugin",
				-- "netrwSettings",
				-- "netrwFileHandlers",
				-- "health",
				-- "shada",
				-- "spellfile",
				"tohtml",
				"tutor",
				"vimballPlugin",
				"zip",
				"zipPlugin",
				"rplugin",
			},
		},
	},
})
