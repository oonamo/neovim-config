return {
	{
		"epwalsh/obsidian.nvim",
		-- version = "*", -- recommended, use latest release instead of latest commit
		lazy = true,
		cmd = "ObsidianOpen",
		-- cond = function()
		-- 	return string.match(vim.api.nvim_buf_get_name(0), "DB") ~= nil
		-- end,
		event = "BufEnter C:/Users/onam7/Desktop/DB/DB/onam7",
		ft = "markdown",
		dependencies = {
			-- Required.
			"nvim-lua/plenary.nvim",

			-- see below for full list of optional dependencies 👇
			--
			"hrsh7th/nvim-cmp",
			"nvim-treesitter",
			"ibhagwan/fzf-lua",
			-- {
			-- 	"oflisback/obsidian-bridge.nvim",
			-- 	dependencies = { "nvim-telescope/telescope.nvim" },
			-- 	config = true,
			-- },
		},
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

				note_id_func = function(title)
					if title ~= nil then
						return title
					else
						vim.ui.input({ prompt = "Title: " }, function(new_title)
							return new_title
						end)
					end
				end,

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
					name = "fzf-lua",
					mappings = {},
				},

				callbacks = {
					enter_note = function()
						vim.schedule(function()
							vim.cmd("SoftWrapMode")
							vim.opt.shiftwidth = 2
						end)
					end,
					post_setup = function()
						vim.cmd("set spell")
						-- require("grapple").use_scope("obsidian")
					end,
				},

				ui = {
					enable = true, -- set to false to disable all additional syntax features
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
			vim.opt.conceallevel = 1
			vim.g.markdown_folding = 1
			vim.keymap.set({ "n", "v" }, "j", "gj")
			vim.keymap.set({ "n", "v" }, "k", "gk")
		end,
		keys = {
			{ "<leader>ow", "<cmd>ObsidianWorkspace<CR>", desc = "[O]bsidian [G]o" },
			{ "<leader>oq", "<cmd>ObsidianQuickSwitch<CR>", desc = "[O]bsidian [F]ind" },
			{
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
			},
			{ "<leader>os", "<cmd>ObsidianSearch<CR>", desc = "[O]bsidian [S]earch" },
			{ "<leader>ot", "<cmd>ObsidianToday<CR>", desc = "[O]bsidian [T]oday" },
			{ "<leader>oy", "<cmd>ObsidianYesterday<CR>", desc = "[O]bsidian [Y]esterday" },
			{ "<leader>oo", "<cmd>ObsidianOpen<CR>", desc = "[O]bsidian [O]pen" },
			{ "<leader>ol", "<cmd>ObsidianLinks<CR>", desc = "[O]bsidian [L]inks" },
			{ "<leader>ob", "<cmd>ObsidianBacklinks<CR>", desc = "[O]bsidian [B]acklinks" },
			{ "<leader>or", "<cmd>ObsidianRename<CR>", desc = "[O]bsidian [R]ename" },
			{
				"<leader>oe",
				function()
					vim.ui.input({ prompt = "Enter title (optional): " }, function(input)
						vim.cmd("ObsidianExtractNote " .. input)
					end)
				end,
				desc = "[O]bsidian [E]xtract",
			},
			{
				"<leader>ol",
				function()
					vim.cmd("ObsidianLink")
				end,
				desc = "[O]bsidian [L]ink",
			},
			{
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
			},
			{ "<leader>t", require("onam.helpers.obsidian_helpers").find_tasks, desc = "Open" },
			{ "g?", require("onam.helpers.obsidian_helpers").open, desc = "Open" },
		},
	},
	{
		"oflisback/obsidian-bridge.nvim",
		-- dir = "~/projects/obsidian-bridge.nvim/",
		dependencies = { "nvim-telescope/telescope.nvim" },
		cond = function()
			return string.match(vim.api.nvim_buf_get_name(0), "DB") ~= nil
		end,
		opts = { scroll_sync = true },
		ft = "markdown",
	},
}
