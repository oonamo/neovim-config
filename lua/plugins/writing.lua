return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = "markdown",
		opts = function()
			-- local block = "█"
			return {
				preset = "obsidian",
				-- render_modes = { "n", "c" },
				quote = { repeat_linebreak = true },
				callout = {
					schedule = { raw = "[!SCHEDULE]", rendered = " Schedule", highlight = "Special" },
					formula = { raw = "[!FORMULA]", rendered = "󰡱 Formula", highlight = "Boolean" },
				},
				win_options = {
					-- showbreak = { default = "", rendered = "  " },
					breakindent = { default = true, rendered = true },
					wrap = { default = true, rendered = true },
					-- breakindentopt = { default = "list:-1", rendered = "" },
				},
				code = {
					sign = false,

					-- Obsidian Style
					width = "block",
					min_width = 60,
					left_pad = 3,
					position = "right",
					border = "thick",

					-- Center code blocks
					-- sign = false,
					-- width = "block",
					-- left_margin = 0.5,
					-- left_pad = 0.2,
					-- right_pad = 0.2,
					-- border = "thick",
				},
				heading = {
          border = false,
					border_virtual = true,
          border_prefix = true,
          sign = false,
				},
				pipe_table = {
					preset = "round",
					alignment_indicator = "┅",
				},
				latex = {
					enabled = true,
          top_pad = 1,
          bottom_pad = 1,
					-- converter = {
					-- 	"latex2text",
					-- 	"--code",
					-- },
				},
        signs = {
          enabled = false,
        },
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
      { "mini.pick", dev = true },
			"MeanderingProgrammer/render-markdown.nvim",
			{
				"jmbuhr/otter.nvim",
				opts = {},
				keys = {
					{
						"<leader>oe",
						function()
							require("otter").activate()
						end,
					},
				},
			},
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
			{
				"folke/zen-mode.nvim",
				opts = {
					window = {
						backdrop = 1,
						width = 80,
						height = 0.85,
						options = {
							-- signcolumn = "no", -- disable signcolumn
							number = false, -- disable number column
							relativenumber = false, -- disable relative numbers
              laststatus = 0,
							-- cursorline = false, -- disable cursorline
							-- cursorcolumn = false, -- disable cursor column
							-- foldcolumn = "0", -- disable fold column
							-- list = false, -- disable whitespace characters
						},
					},
				},
				keys = {
					{
						"<leader>xm",
						function()
							require("zen-mode").toggle()
						end,
						desc = "Toggle Zen mode",
					},
				},
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
					local is_pdf = string.sub(url, #url - 2, -1)
					if is_pdf then
						vim.fn.jobstart({
							"sumatrapdf",
							"-reuse-instance",
							local_file,
						})
						return
					end
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
							-- require("wrapping").soft_wrap_mode()
							vim.opt.shiftwidth = 2
						end)
					end,
					post_setup = function()
						-- if not package.loaded["wrapping"] then
						-- 	require("wrapping").soft_wrap_mode()
						-- else
						-- 	vim.cmd.SoftWrapMode()
						-- end
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

			local mdtils = require("tests.mini_pick")
			vim.keymap.set("n", "<leader>gf", function()
				mdtils.current_link()
			end)
			vim.keymap.set("n", "<leader>og", "<cmd>Pick goodnotes<cr>", { desc = "insert goodnotes pdf" })
			vim.keymap.set("n", "<leader>nn", "<cmd>ObsidianTemplate notes<cr>", { desc = "Obisidan note template" })
			vim.keymap.set("n", "<leader>ow", "<cmd>ObsidianWorkspace<CR>", { desc = "[O]bsidian [G]o" })
			vim.keymap.set("n", "<leader>oq", "<cmd>ObsidianQuickSwitch<CR>", { desc = "[O]bsidian [F]ind" })
			vim.keymap.set("n", "<leader>on", function()
				vim.ui.input({ prompt = "Note name (optional): " }, function(name)
					if name == nil then
						return
					end
					vim.cmd("ObsidianNew " .. name)
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

			local writing_group = vim.api.nvim_create_augroup("Writing", { clear = true })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = writing_group,
				pattern = { "*.md", "*.norg", "*.org", "*.tex" },
				callback = function()
					require("mini.trailspace").trim()
					vim.cmd("silent! mkview")
				end,
			})
			vim.api.nvim_create_autocmd({ "BufNew", "BufEnter" }, {
				group = writing_group,
				pattern = { "*.md", "*.norg", "*.org", "*.tex" },
				callback = function()
					vim.schedule(function()
						vim.cmd("silent! loadview")
					end)
				end,
			})
		end,
	},
	{
		"toppair/peek.nvim",
		build = "deno task --quiet build:fast",
		cmd = { "PeekOpen", "PeekClose" },
		opts = {
			-- app = "webview",
			app = { "chromium", "--new-window" },
		},
		config = function(_, opts)
			require("peek").setup(opts)
			vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
			vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
		end,
	},
}
