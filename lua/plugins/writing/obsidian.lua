return {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	cmd = "ObsidianOpen",
	ft = "markdown",
	dependencies = {
		-- Required.
		"nvim-lua/plenary.nvim",

		-- see below for full list of optional dependencies 👇
		--
		"hrsh7th/nvim-cmp",
		"nvim-treesitter",
		"ibhagwan/fzf-lua",
	},
	config = function()
		require("obsidian").setup({
			workspaces = {
				{
					name = "DB",
					path = "~/Desktop/DB",
				},
			},
			completion = {
				-- Set to false to disable completion.
				nvim_cmp = true,
				-- Trigger completion at 2 chars.
				min_chars = 2,
			},

			note_id_func = function(title)
				if title ~= nil then
					return title:gsub("%s+", "-")
				else
					local note_title
					vim.ui.input({ prompt = "Title: " }, function(title)
						note_title = title:gsub("%s+", "-")
					end)
					return note_title
				end
			end,

			new_notes_location = "current_dir",
			-- For windows only
			follow_url_func = function(url)
				-- Open the URL in the default web browser.
				local local_file = string.match(url, "file://(.*)")
				if local_file ~= nil then
					vim.cmd("e " .. local_file)
				else
					vim.fn.jobstart({ url })
				end
			end,
			picker = {
				name = "fzf-lua",
				mappings = {},
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
	end,
	keys = {
		{ "<leader>og", "<cmd>ObsidianWorkspace<CR>", desc = "[O]bsidian [G]o" },
		{ "<leader>of", "<cmd>ObsidianQuickSwitch<CR>", desc = "[O]bsidian [F]ind" },
		{ "<leader>on", "<cmd>ObsidianNew<CR>", desc = "[O]bsidian [N]ew" },
		{ "<leader>os", "<cmd>ObsidianSearch<CR>", desc = "[O]bsidian [S]earch" },
		{ "<leader>or", "<cmd>ObsidianRename<CR>", desc = "[O]bsidian [R]ename" },
		{ "g?", require("onam.helpers.obsidian_helpers").open, desc = "Open" },
		{ "<leader>t", require("onam.helpers.obsidian_helpers").find_tasks, desc = "Open" },
	},
}
