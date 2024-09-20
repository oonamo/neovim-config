return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = "markdown",
		opts = {
			render_modes = { "n", "v", "i", "c" },
			quote = { repeat_linebreak = true },
			callout = {
				schedule = { raw = "[!SCHEDULE]", rendered = " Schedule", highlight = "Special" },
				formula = { raw = "[!FORMULA]", rendered = "󰡱 Formula", highlight = "Boolean" },
			},
			win_options = {
				showbreak = { default = "", rendered = "  " },
				breakindent = { default = false, rendered = true },
				breakindentopt = { default = "", rendered = "" },
			},
			code = {
				width = "block",
				min_width = 45,
				left_pad = 2,
				language_pad = 2,
				border = "thick",
			},
			heading = {
				position = "inline",
				width = "block",
				min_width = 40,
			},
			pipe_table = { preset = "heavy" },
		},
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
						return title:gsub("%s+", "-")
					else
						local note_title
						vim.ui.input({ prompt = "Title: " }, function(new_title)
							note_title = new_title:gsub("%s+", "-")
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
					name = "telescope.nvim",
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
			require("config.autocommands").setup_writing_cmds()
			-- vim.g.markdown_folding = 1

			vim.keymap.set("n", "<leader>nn", "<cmd>ObsidianTemplate notes<cr>", { desc = "Obisidan note template" })
			utils.norm_lazy_to_normal({ "<leader>ow", "<cmd>ObsidianWorkspace<CR>", desc = "[O]bsidian [G]o" })
			utils.norm_lazy_to_normal({ "<leader>oq", "<cmd>ObsidianQuickSwitch<CR>", desc = "[O]bsidian [F]ind" })
			utils.norm_lazy_to_normal({
				"<leader>on",
				function()
					vim.ui.input({ prompt = "Note name (optional): " }, function(name)
						if name == nil then
							return
						end
						local note_title = name:gsub("%s+", "-")
						vim.cmd("ObsidianNew " .. note_title)
					end)
				end,
				desc = "[O]bsidian [N]ew",
			})
			utils.norm_lazy_to_normal({ "<leader>os", "<cmd>ObsidianSearch<CR>", desc = "[O]bsidian [S]earch" })
			utils.norm_lazy_to_normal({ "<leader>ot", "<cmd>ObsidianToday<CR>", desc = "[O]bsidian [T]oday" })
			utils.norm_lazy_to_normal({ "<leader>oy", "<cmd>ObsidianYesterday<CR>", desc = "[O]bsidian [Y]esterday" })
			utils.norm_lazy_to_normal({ "<leader>oo", "<cmd>ObsidianOpen<CR>", desc = "[O]bsidian [O]pen" })
			utils.norm_lazy_to_normal({ "<leader>ol", "<cmd>ObsidianLinks<CR>", desc = "[O]bsidian [L]inks" })
			utils.norm_lazy_to_normal({ "<leader>ob", "<cmd>ObsidianBacklinks<CR>", desc = "[O]bsidian [B]acklinks" })
			utils.norm_lazy_to_normal({ "<leader>or", "<cmd>ObsidianRename<CR>", desc = "[O]bsidian [R]ename" })
			utils.norm_lazy_to_normal({
				"<leader>oe",
				function()
					vim.ui.input({ prompt = "Enter title (optional): " }, function(input)
						vim.cmd("ObsidianExtractNote " .. input)
					end)
				end,
				desc = "[O]bsidian [E]xtract",
			})
			utils.norm_lazy_to_normal({
				"<leader>ol",
				function()
					vim.cmd("ObsidianLink")
				end,
				desc = "[O]bsidian [L]ink",
			})
			utils.norm_lazy_to_normal({
				"<leader>od",
				function()
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
				end,
				desc = "[O]bsidian [D]ailies",
			})

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
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		opts = {
			window = {
				backdrop = 1,
				width = 0.85,
				height = 0.95,
				options = {
					signcolumn = "no", -- disable signcolumn
					number = false, -- disable number column
					relativenumber = false, -- disable relative numbers
					cursorline = false, -- disable cursorline
					cursorcolumn = false, -- disable cursor column
					foldcolumn = "0", -- disable fold column
					list = false, -- disable whitespace characters
				},
			},
			plugins = {
				options = {
					enabled = true,
					ruler = false, -- disables the ruler text in the cmd line area
					showcmd = false, -- disables the command in the last line of the screen
					-- you may turn on/off statusline in zen mode by setting 'laststatus'
					-- statusline will be shown only if 'laststatus' == 3
					laststatus = 3, -- turn off the statusline in zen mode
				},
			},
			neovide = {
				enabled = false,
				-- Will multiply the current scale factor by this number
				scale = 1.2,
				-- disable the Neovide animations while in Zen mode
				disable_animations = {
					neovide_animation_length = 0,
					neovide_cursor_animate_command_line = false,
					neovide_scroll_animation_length = 0,
					neovide_position_animation_length = 0,
					neovide_cursor_animation_length = 0,
					neovide_cursor_vfx_mode = "",
				},
			},
			on_open = function()
				vim.g.zen_enabled = true
				_, _, vim.g.old_stl_hl = utils.get_hl("StatusLine")
				vim.api.nvim_set_hl(0, "StatusLine", { link = "Normal" })
				require("heirline").load_colors(function()
					return {}
				end)
			end,
			on_close = function()
				vim.g.zen_enabled = false
				vim.api.nvim_set_hl(0, "StatusLine", vim.g.old_stl_hl)
				require("heirline").load_colors(function()
					return {}
				end)
			end,
		},
		keys = {
			{
				"<leader>fo",
				"<cmd>ZenMode<cr>",
				desc = "Open Zen mode",
			},
		},
	},
	{
		"Myzel394/easytables.nvim",
		config = true,
		keys = {
			{
				"<leader>tn",
				"<cmd>EasyTablesCreateNew<cr>",
				desc = "New Markdown Table",
			},
			{
				"<leader>te",
				"<cmd>EasyTablesImportThisTable<cr>",
				desc = "Edit Markdown Table",
			},
		},
	},
	{
		"k-lar/dynomark.nvim",
		cmd = {
			"Dynomark",
		},
	},
}
