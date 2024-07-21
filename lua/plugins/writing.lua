return {
	{
		"epwalsh/obsidian.nvim",
		event = {
			"BufReadPre C:/Users/onam7/Desktop/DB/DB/**.md",
			"BufNewFile C:/Users/onam7/Desktop/DB/DB/**.md",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"OXY2DEV/markview.nvim",
				branch = "dev",
				opts = function()
					local weird_list = {
						["everforest"] = "everforest/after/syntax/markdown/everforest.vim",
						["edge"] = "edge/after/syntax/markdown/edge.vim",
						["gruvbox-material"] = "gruvbox-material/after/syntax/markdown/gruvbox_material.vim",
					}
					local function set_md_hi(i, bg, tries)
						local hi = "markdownH" .. tostring(i)
						local fg, _, _ = utils.get_hl(hi)
						if not fg then
							fg, _ = utils.get_hl("@markup.heading." .. tostring(i) .. ".markdown")
						end

						if not fg then
							vim.schedule(function()
								set_md_hi(i, bg, tries + 1)
							end)
							return
						end

						vim.api.nvim_set_hl(0, "Markview_h" .. tostring(i), { bg = fg, fg = bg })
						vim.api.nvim_set_hl(0, "Markview_h" .. tostring(i) .. "_inv", { fg = fg, bold = true })
					end
					vim.api.nvim_create_autocmd("Colorscheme", {
						callback = vim.schedule_wrap(function(data)
							if weird_list[data.match] then
								vim.cmd("so " .. vim.fn.stdpath("data") .. "/lazy/" .. weird_list[data.match])
							end
							local _, n_bg = utils.get_hl("Normal")
							n_bg = n_bg or "#000000"
							for i = 1, 6 do
								set_md_hi(i, n_bg, 0)
							end
						end),
					})
					local markview = require("markview")
					local callouts = markview.configuration.block_quotes.callouts

					table.insert(callouts, {
						{
							match_string = "FORMULA",
							aliases = nil,
							-- aliases = { "" },

							callout_preview = "󰿉  Formula",
							callout_preview_hl = nil,

							custom_title = true,
							custom_icon = "󰿉 ",

							border = { "▉", "▊", "▋", "▌" },
							border_hl = "@comment.warning",
						},
					})

					return {
						options = {
							on_enable = {},
							on_disable = {
								conceallevel = 0,
								concealcursor = "",
							},
						},
						code_blocks = {
							enable = true,

							style = "language",
							position = "overlay",

							hl = "markdownCodeBlock",

							min_width = 60,
							pad_amount = 3,

							language_names = {
								{ "py", "python" },
								{ "cpp", "C++" },
							},
							sign = true,

							language_direction = "right",
							sign_hl = nil,
						},
						block_quotes = {
							enable = true,
							default = {
								border = "",
								border_hl = "Comment",
							},
							callouts = callouts,
						},
						headings = {
							shift_width = 0,
							-- heading_1 = {
							-- 	style = "label",
							-- 	hl = "h1",
							-- 	padding_left = " ",
							-- 	padding_right = " ",
							-- },
							-- heading_2 = {
							-- 	style = "label",
							-- 	hl = "h2",
							-- 	padding_left = " ",
							-- 	padding_right = " ",
							-- },
							-- heading_3 = {
							-- 	style = "label",
							-- 	hl = "h3",
							-- 	sign = "",
							-- 	padding_left = " ",
							-- 	padding_right = " ",
							-- },
							-- heading_4 = {
							-- 	style = "label",
							-- 	hl = "h4",
							-- 	sign = "",
							-- 	padding_left = " ",
							-- 	padding_right = " ",
							-- },
							-- heading_5 = {
							-- 	style = "label",
							-- 	hl = "h5",
							-- 	sign = "",
							-- 	padding_left = " ",
							-- 	padding_right = " ",
							-- },
							-- heading_6 = {
							-- 	style = "label",
							-- 	hl = "h6",
							-- 	sign = "",
							-- 	padding_left = " ",
							-- 	padding_right = " ",
							-- },
							heading_1 = {
								style = "label",

								padding_left = " ",
								padding_right = " ",

								corner_right = "",
								corner_right_hl = "h1_inv",

								sign = "",
								hl = "h1",
							},
							heading_2 = {
								style = "label",

								padding_left = " ",
								padding_right = " ",

								corner_right = "",
								corner_right_hl = "h2_inv",

								sign = "",
								hl = "h2",
							},
							heading_3 = {
								style = "label",

								padding_left = " ",
								padding_right = " ",

								corner_right = "",
								corner_right_hl = "h3_inv",

								hl = "h3",
								sign = "",
							},
							heading_4 = {
								style = "label",

								padding_left = " ",
								padding_right = " ",

								corner_right = "",
								corner_right_hl = "h4_inv",

								sign = "",
								hl = "h4",
							},
							heading_5 = {
								style = "label",

								padding_left = " ",
								padding_right = " ",

								corner_right = "",
								corner_right_hl = "h5_inv",

								sign = "",
								hl = "h5",
							},
							heading_6 = {
								style = "label",

								padding_left = " ",
								padding_right = " ",

								corner_right = "",
								corner_right_hl = "h6_inv",

								sign = "",
								hl = "h6",
							},
						},
					}
				end,
			},
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

                -- stylua: ignore
				local out = { id = note.id, aliases = note.aliases, tags = note.tags, hubs = note.hubs or { "[[]]" } }

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
}
